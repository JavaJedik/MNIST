package javajedik.main.restcontroller;

import javajedik.main.util.UserTokenUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/check")
public class TokenCheckController 
{    
    private static final Logger logger = LogManager.getLogger(RegistrateController.class);
    
    @RequestMapping(value = "/userToken", method = {RequestMethod.GET, RequestMethod.POST})
    public ResponseEntity<String> checkUserToken(@RequestHeader("userToken") String userToken)
    {
        logger.info("Egy userToken érkezett, validáció megkezdése...");
        if(UserTokenUtil.validateToken(userToken))
        {
            logger.info("A userToken valid válasz küldése, player_id: " + UserTokenUtil.getPlayerId(userToken));
            return ResponseEntity.status(HttpStatus.OK).build();
        }
        
        logger.warn("A userToken érvénytelen, http 401 küldése: " + userToken);
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("A userToken érvénytelen");
    }
}
