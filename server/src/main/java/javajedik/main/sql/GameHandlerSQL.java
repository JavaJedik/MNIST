package javajedik.main.sql;

import java.sql.PreparedStatement;
import java.sql.Statement;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

@Repository
public class GameHandlerSQL 
{
    private static final Logger logger = LogManager.getLogger(GameHandlerSQL.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public int insertNewGame(int playerId) 
    {
        final String insertQuery = SqlQ.insertNewGame();
        try 
        {
            KeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(connection -> 
            {
                PreparedStatement ps = connection.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, playerId);
                return ps;
            }, keyHolder);

            Number key = keyHolder.getKey();
            if (key != null) 
            {
                int gameId = key.intValue();
                logger.info("Sikeresen beszúrva új játék az adott player_id részére: " + playerId + ". A game_id: " + gameId);
                return gameId;
            } else 
            {
                logger.error("Nem sikerült új játékot beszúrni");
                return -1;
            }
        } catch (Exception e) 
        {
            logger.error("Nem sikerült új játékot beszúrni: " + e.getMessage());
            return -1;
        }
    }
}
