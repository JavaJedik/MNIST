package javajedik.main.restcontroller;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;
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
    @Autowired
    private LoginService loginService;
    
    private static final Logger logger = LogManager.getLogger(LoginController.class);
    private static final String userToken = "EzIttAUserToken"; // Konstans userToken

    @PostMapping("")
    public ResponseEntity<String> loginUser(@RequestBody LoginData loginData) 
    {
        logger.info("Bejelentkezési adatok megérkeztek: username: " + loginData.getUsername());
        
        if(loginService.isValidLoginData(loginData))
        {
            logger.info("Bejelentkezés elfogadva, token elküldve: username: " + loginData.getUsername());
            return ResponseEntity.ok(userToken);
        }
        
        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    }
}
