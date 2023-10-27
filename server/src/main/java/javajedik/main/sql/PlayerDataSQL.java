package javajedik.main.sql;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PlayerDataSQL 
{
    private static final Logger logger = LogManager.getLogger(PlayerDataSQL.class);
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int getPlayerIdByName(String playerName) 
    {
        final String query = SqlQ.getPlayerIdByName();

        try 
        {
            int playerId = jdbcTemplate.queryForObject(query, new Object[]{playerName}, Integer.class);
            logger.info("A player_id és név -> " + playerName + ": " + playerId);
            return playerId;
        } 
        catch (DataAccessException ex) 
        {
            logger.error("A player_id meghatározása nem sikerült az alábbi névhez: " + playerName);
            return -1;
        }
    }
}
