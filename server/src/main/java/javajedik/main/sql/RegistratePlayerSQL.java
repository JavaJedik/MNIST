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
import org.springframework.jdbc.support.rowset.SqlRowSet;
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
        String query = "select email_type.id " +
                       "from email_tld " +
                       "join email_type ON email_type.tld_id = email_tld.id " +
                       "where email_type.domain = ? " +
                       "and email_tld.tld = ?";

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
        String query = "select gender.id " +
                       "from gender " +
                       "inner join gender_name on gender.id = gender_name.gender_id " +
                       "where gender_name.name = ? " +
                       "limit 1";

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
        String sql = "select language.id " +
                     "from language " +
                     "inner join language_name ON language_name.language_id = language.id " +
                     "where language_name.name = ? " +
                     "limit 1";

        try 
        {
            return jdbcTemplate.queryForObject(sql, Integer.class, languageName);
        } 
        catch (EmptyResultDataAccessException e) 
        {
            return -1;
        }
    }
    
    public int insertPlayerId(int mainLanguageId, int playerRoleId) 
    {
        String insertSql = "insert into player_id (main_language_id, player_role_id) values (?, ?)";

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
    
    public boolean insertRegisteredPlayerMinimal(RegisteredPlayer player) 
    {
        String insertSql = "insert into registered_player (player_id, name, gender_id, email_prefix, email_type_id) values (?, ?, ?, ?, ?)";

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


    public List<RegisteredPlayer> getAllRegisteredPlayers() 
    {
        String sql = "select * from registered_player";

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
        int player_id;
        EmailParts emailParts = EmailUtil.splitEmail(registrateData.getEmail());

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
                logger.info("Játékos regisztrációja sikertelen. Helytelen e-mail, nem vagy nyelv. Adatok:\n" + registrateData.toString());
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
                    logger.info("A játékos regisztrálása sikertelen, változások visszavonása");
                    transactionManager.rollback(status);
                }
            } 
            catch (TransactionException e) 
            {
                logger.info("A tranzakció közben hiba lépett fel, adatok visszaállítása...");
                transactionManager.rollback(status);
                return -1;
            }

        } 
        catch (InterruptedException | ExecutionException e) 
        {
            logger.info("Hiba történt az adatbázisban történő lekérdezés során.");
            return -1;
        }

        return player_id;
    }
}
