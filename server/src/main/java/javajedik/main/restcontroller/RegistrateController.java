package javajedik.main.restcontroller;

import javajedik.main.model.RegistrateData;
import javajedik.main.service.RegistrateService;
import javajedik.main.util.UserTokenUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
        
        int player_id = registrateService.registratePlayer(registrateData);
        
        if(player_id == -1)
        {
            logger.warn("Játékos regisztrálása sikertelen, http 400 küldése. Adatok:\n" + registrateData.toString());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Az adatok érvénytelenek.");
        }
        
        logger.info("A generált player_id: " + player_id);
        
        final String userToken = UserTokenUtil.generateToken(player_id);
        
        logger.info("A userToken generálva, küldése a válaszban, player_id: " + player_id);
        
        return ResponseEntity.ok(userToken);
    }
    
    @GetMapping("/guest")
    public ResponseEntity<String> registratePlayer()
    {
        logger.info("Regisztrációs adatok megérkeztek a vendég játékoshoz");
        
        int player_id = registrateService.registrateGuest();
        
        if(player_id == -1)
        {
            logger.warn("Vendég játékos regisztrálása sikertelen, http 400 küldése");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Az adatok érvénytelenek.");
        }
        
        logger.info("A generált player_id: " + player_id);
        
        final String userToken = UserTokenUtil.generateToken(player_id);
        
        logger.info("A userToken generálva, küldése a válaszban, player_id: " + player_id);
        
        return ResponseEntity.ok(userToken);
    }
}
