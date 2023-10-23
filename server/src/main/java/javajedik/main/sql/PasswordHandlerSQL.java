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
        String query = "insert into password (player_id, salt, password_hash) values (?, ?, ?)";
        try 
        {
            jdbcTemplate.update(query, playerId, salt, passwordHash);
            logger.info(playerId + " player_idhoz tartozó só és hash beszúrva az adatbázisba");
            return true;
        } 
        catch (DataAccessException ex) 
        {
            logger.error(playerId + " player_idhoz tartozó só és hash beszúrása az adatbázisba sikertelen");
            return false;
        }
    }

    public PasswordEntry getPasswordEntry(int playerId) 
    {
        String query = "select salt, password_hash, created_at from password where player_id = ? order by created_at desc limit 1";
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
            logger.warn(playerId + " player_idhez nincs adat");
            return null;
        }
    }
}
