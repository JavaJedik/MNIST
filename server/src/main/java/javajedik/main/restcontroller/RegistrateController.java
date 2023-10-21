package javajedik.main.restcontroller;

import javajedik.main.model.RegistrateData;
import javajedik.main.service.RegistrateService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/registrate")
public class RegistrateController 
{
    private static final Logger logger = LogManager.getLogger(RegistrateController.class);
    
    @Autowired
    private RegistrateService registrateService;
    
    @PostMapping("")
    public ResponseEntity<String> registratePlayer(@RequestBody RegistrateData registrateData)
    {
        logger.info("Regisztrációs adatok megérkeztek:\n" + registrateData.toString());
        
        if(registrateService.registratePlayer(registrateData))
        {
            return null;
        }
        
        return null;
    }
}