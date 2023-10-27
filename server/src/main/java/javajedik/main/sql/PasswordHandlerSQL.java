package javajedik.main.sql;

import javajedik.main.model.PasswordEntry;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PasswordHandlerSQL 
{
    private static final Logger logger = LogManager.getLogger(PasswordHandlerSQL.class);
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public boolean storePassword(int playerId, byte[] salt, byte[] passwordHash) 
    {
        final String query = SqlQ.storePassword();
        try 
        {
            jdbcTemplate.update(query, playerId, salt, passwordHash);
            logger.info(playerId + " player_id-hoz tartozó só és hash beszúrva az adatbázisba");
            return true;
        } 
        catch (DataAccessException ex) 
        {
            logger.error(playerId + " player_id-hoz tartozó só és hash beszúrása az adatbázisba sikertelen");
            return false;
        }
    }

    public PasswordEntry getPasswordEntry(int playerId) 
    {
        final String query = SqlQ.getPasswordEntry();
        try 
        {
            PasswordEntry entry = jdbcTemplate.queryForObject(query, (rs, rowNum) -> new PasswordEntry
            (
                rs.getBytes("salt"),
                rs.getBytes("password_hash"),
                rs.getTimestamp("created_at")
            ), playerId);

            logger.info(playerId + " jelszóadatai lekérve az adatbázisból");

            return entry;
        } 
        catch (DataAccessException ex) 
        {
            logger.warn(playerId + " player_id-hez nincs adat");
            return null;
        }
    }
}
