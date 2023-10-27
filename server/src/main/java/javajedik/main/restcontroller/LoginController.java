package javajedik.main.restcontroller;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;
import javajedik.main.util.UserTokenUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;

@RestController
@RequestMapping("/login")
public class LoginController 
{
    private static final Logger logger = LogManager.getLogger(LoginController.class);
    
    @Autowired
    private LoginService loginService;

    @PostMapping("")
    public ResponseEntity<String> loginUser(@RequestBody LoginData loginData) 
    {
        logger.info("Bejelentkezési adatok megérkeztek: username: " + loginData.getUsername());
        
        final int player_id = loginService.getPlayerIdFromLoginData(loginData);
        
        if(player_id == -1)
        {
            logger.warn("Bejelentkezés elutasítva, http 401 küldése, username: " + loginData.getUsername());
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Az adatok érvénytelenek.");
        }
        
        if(loginService.isValidPasswordFromPlayerID(player_id, loginData.getPassword()))
        {
            final String userToken = UserTokenUtil.generateToken(player_id);
            logger.info("Bejelentkezés elfogadva, token elküldve: username: " + loginData.getUsername());
            return ResponseEntity.ok(userToken);
        }
        
        logger.warn("Bejelentkezés elutasítva, http 401 küldése, username: " + loginData.getUsername());
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Az adatok érvénytelenek.");
    }
}
