package javajedik.main.service.imp;

import javajedik.main.service.PlayerGameService;
import javajedik.main.sql.GameHandlerSQL;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import javajedik.main.service.PictureHandlerService;

public class PlayerGameServiceImp implements PlayerGameService
{
    private static final Logger logger = LogManager.getLogger(PictureHandlerService.class);
    
    @Autowired
    private GameHandlerSQL gameHandlerSQL;
    
    @Override
    public int insertNewGame(int player_id) 
    {
        return gameHandlerSQL.insertNewGame(player_id);
    }
    
}
