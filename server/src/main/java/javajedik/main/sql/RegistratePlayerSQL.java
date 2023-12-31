package javajedik.main.sql;

import java.sql.PreparedStatement;
import java.sql.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import javajedik.main.model.EmailParts;
import javajedik.main.model.RegisteredPlayer;
import javajedik.main.model.RegistrateData;
import javajedik.main.util.EmailUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Repository
public class RegistratePlayerSQL 
{
    private static final Logger logger = LogManager.getLogger(RegistratePlayerSQL.class);
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private DataSourceTransactionManager transactionManager;

    private int getEmailTypeIdFromDatabase(EmailParts emailParts) 
    {
        final String query = SqlQ.getEmailTypeIdFromDatabase();

        try 
        {
            return jdbcTemplate.queryForObject(query, Integer.class, emailParts.getDomain(), emailParts.getTld());
        } 
        catch (EmptyResultDataAccessException e) 
        {
            return -1;
        }
    }
    
    public int getGenderIdByName(String genderName) 
    {
        final String query = SqlQ.getGenderIdByName();

        try 
        {
            return jdbcTemplate.queryForObject(query, Integer.class, genderName);
        } 
        catch (EmptyResultDataAccessException e) 
        {
            return -1;
        }
    }
    
    public int getLanguageIdByName(String languageName) 
    {
        final String sql = SqlQ.getLanguageIdByName();

        try 
        {
            return jdbcTemplate.queryForObject(sql, Integer.class, languageName);
        } 
        catch (EmptyResultDataAccessException e) 
        {
            return -1;
        }
    }
    
    private int insertPlayerId(int mainLanguageId, int playerRoleId) 
    {
        final String insertSql = SqlQ.insertPlayerId();

        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(connection -> 
        {
            PreparedStatement ps = connection.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, mainLanguageId);
            ps.setInt(2, playerRoleId);
            return ps;
        }, keyHolder);

        Number key = keyHolder.getKey();
        if (key != null) 
        {
            return key.intValue();
        } 
        else 
        {
            return -1;
        }
    }
    
    private boolean insertRegisteredPlayerMinimal(RegisteredPlayer player) 
    {
        final String insertSql = SqlQ.insertRegisteredPlayerMinimal();

        try 
        {
            int rowsAffected = jdbcTemplate.update(insertSql, player.getPlayerId(), player.getName(), player.getGenderId(), player.getEmailPrefix(), player.getEmailTypeId());

            return (rowsAffected > 0);
        } 
        catch (DataAccessException e) 
        {
            return false;
        }
    }
    
    private boolean insertGuestPlayer(int player_id) 
    {
        final String insertSql = SqlQ.insertGuestPlayer();

        int rowsAffected = jdbcTemplate.update(insertSql, player_id);

        return rowsAffected > 0;
    }            

    public List<RegisteredPlayer> getAllRegisteredPlayers() 
    {
        final String sql = SqlQ.getAllRegisteredPlayers();

        List<RegisteredPlayer> players = jdbcTemplate.query(sql, (rs, rowNum) -> 
        {
            RegisteredPlayer player = new RegisteredPlayer();
            player.setPlayerId(rs.getInt("player_id"));
            player.setName(rs.getString("name"));
            player.setGenderId(rs.getInt("gender_id"));
            player.setEmailPrefix(rs.getString("email_prefix"));
            player.setEmailTypeId(rs.getInt("email_type_id"));
            player.setCountryCallingCodeId(rs.getInt("country_calling_code_id"));
            player.setPhoneNetworkId(rs.getInt("phone_network_id"));
            player.setPhone(rs.getInt("phone"));
            return player;
        });

        return players;
    }

    public int tryToRegistratePlayer(RegistrateData registrateData)
    {
        logger.info("Játékos regisztrálásának megkezdése az adatbázisban. Adatok:\n" + registrateData.toString());
        final int player_id;
        EmailParts emailParts = EmailUtil.splitEmail(registrateData.getEmail());
        if(emailParts == null)
        {
            logger.error("Hibás e-mail cím formátum");
            return -1;
        }

        CompletableFuture<Integer> emailTypeFuture = CompletableFuture.supplyAsync(() -> getEmailTypeIdFromDatabase(emailParts));
        CompletableFuture<Integer> genderIdFuture = CompletableFuture.supplyAsync(() -> getGenderIdByName(registrateData.getGender()));
        CompletableFuture<Integer> languageIdFuture = CompletableFuture.supplyAsync(() -> getLanguageIdByName(registrateData.getLanguage()));

        try 
        {
            int email_type_id = emailTypeFuture.get();
            int gender_id = genderIdFuture.get();
            int language_id = languageIdFuture.get();

            if (email_type_id == -1 || gender_id == -1 || language_id == -1) 
            {
                logger.error("Játékos regisztrációja sikertelen. Helytelen e-mail, nem vagy nyelv. Adatok:\n" + registrateData.toString());
                return -1;
            }
            
            logger.info("Játékos adatai a valóságnak megfelelnek. Tranzakció megkezdése. Adatok:\n" + registrateData.toString());
            TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());

            try 
            {
                player_id = insertPlayerId(language_id, 1); // 1 - user role
                
                if(player_id == -1)
                {
                    logger.info("A játékos regisztrálása sikertelen, változások visszavonása");
                    transactionManager.rollback(status);
                    return -1;
                }
                
                logger.info("A generált player_id: " + player_id);
                RegisteredPlayer player = new RegisteredPlayer(player_id, registrateData.getUsername(), gender_id, emailParts.getEmailPrefix(), email_type_id);
                boolean success = insertRegisteredPlayerMinimal(player);

                if (success) 
                {
                    logger.info("A játékos regisztrálása sikeres, tranzakció mentése... Adatok:\n" + registrateData.toString());
                    transactionManager.commit(status);
                } 
                else 
                {
                    logger.error("A játékos regisztrálása sikertelen, változások visszavonása");
                    transactionManager.rollback(status);
                    return -1;
                }
            } 
            catch (TransactionException e) 
            {
                logger.error("A tranzakció közben hiba lépett fel, adatok visszaállítása...");
                transactionManager.rollback(status);
                return -1;
            }

        } 
        catch (InterruptedException | ExecutionException e) 
        {
            logger.error("Hiba történt az adatbázisban történő lekérdezés során.");
            return -1;
        }

        return player_id;
    }
    
    public int registrateGuest()
    {
        final int player_id;
        
        TransactionStatus status = transactionManager.getTransaction(new DefaultTransactionDefinition());
        
        try 
        {
            player_id = insertPlayerId(1, 1); // 1 - user role

            if(player_id == -1)
            {
                logger.info("A játékos regisztrálása sikertelen, változások visszavonása");
                transactionManager.rollback(status);
                return -1;
            }

            logger.info("A generált player_id: " + player_id);
            
            boolean success = insertGuestPlayer(player_id);
            
            if (success) 
            {
                logger.info("A játékos regisztrálása sikeres, tranzakció mentése... Adatok:\n" + player_id);
                transactionManager.commit(status);
            } 
            else 
            {
                logger.error("A játékos regisztrálása sikertelen, változások visszavonása");
                transactionManager.rollback(status);
                return -1;
            }
        } 
        catch (Exception e) 
        {
            logger.error("A tranzakció közben hiba lépett fel, adatok visszaállítása... A hiba: " + e);
            transactionManager.rollback(status);
            return -1;
        } 
        
        return player_id;
    }
}
