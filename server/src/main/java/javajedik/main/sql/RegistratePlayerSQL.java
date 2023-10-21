package javajedik.main.sql;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.List;
import javajedik.main.model.EmailParts;
import javajedik.main.model.RegisteredPlayer;
import javajedik.main.model.RegistrateData;
import javajedik.main.util.EmailUtil;
import org.springframework.dao.EmptyResultDataAccessException;

@Repository
public class RegistratePlayerSQL 
{
    @Autowired
    private JdbcTemplate jdbcTemplate;

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


    public List<RegisteredPlayer> getAllRegisteredPlayers() 
    {
        String sql = "SELECT * FROM registered_player";

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
        EmailParts emailParts = EmailUtil.splitEmail(registrateData.getEmail());
        
        int email_type_id = getEmailTypeIdFromDatabase(emailParts);
        
        if(email_type_id == -1)
        {
            return -1;
        }
        
        int gender_id = getGenderIdByName(registrateData.getGender());
        
        if(gender_id == -1)
        {
            return -1;
        }
        
        return -1;
    }
}
