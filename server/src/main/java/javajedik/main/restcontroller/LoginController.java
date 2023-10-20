package javajedik.main.restcontroller;

import javajedik.main.model.LoginData;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@RestController
@RequestMapping("/login")
public class LoginController 
{
    private static final Logger logger = LogManager.getLogger(LoginController.class);
    private static final String userToken = "EzIttAUserToken"; // Konstans userToken

    @PostMapping("")
    public ResponseEntity<String> loginUser(@RequestBody LoginData loginData) 
    {
        logger.info("Login data arrived: username: " + loginData.getUsername());
        
        logger.info("Login accepted, token sent: username: " + loginData.getUsername());
        return ResponseEntity.ok(userToken);
    }
}
