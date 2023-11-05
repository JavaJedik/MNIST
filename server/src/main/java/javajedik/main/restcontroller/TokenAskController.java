package javajedik.main.restcontroller;

import javajedik.main.service.PlayerGameService;
import javajedik.main.util.GameTokenUtil;
import javajedik.main.util.UserTokenUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/askToken")
public class TokenAskController 
{    
    private static final Logger logger = LogManager.getLogger(RegistrateController.class);
    
    @Autowired
    PlayerGameService playerGameService;
    
    @RequestMapping(value = "/gameToken", method = {RequestMethod.GET, RequestMethod.POST})
    public ResponseEntity<String> askGameToken(@RequestHeader("userToken") String userToken)
    {   
        logger.info("Egy userToken érkezett játékkérelemmel, validáció megkezdése...");
        final int player_id = UserTokenUtil.getPlayerId(userToken);
        
        if(player_id == -1)
        {
            logger.warn("A userToken érvénytelen, http 401 küldése: " + userToken);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("A userToken érvénytelen");
        }
        
        logger.info("A userToken valid játéktoken küldése, player_id: " + player_id);
        
        final int game_id = playerGameService.insertNewGame(player_id);
        
        if(game_id == -1)
        {
            logger.error("A játék eltárolásában hiba lépett fel, http 507 küldése...");
            return ResponseEntity.status(HttpStatus.INSUFFICIENT_STORAGE).body("Hiba lépett fel a játék regisztrálása során");
        }
        
        return ResponseEntity.status(HttpStatus.OK).body(game_id + "");
    }
}
