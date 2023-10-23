package javajedik.main.service.imp;

import javajedik.main.model.RegistrateData;
import javajedik.main.service.RegistrateService;
import javajedik.main.sql.PasswordHandlerSQL;
import javajedik.main.sql.RegistratePlayerSQL;
import javajedik.main.util.PasswordUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RegistrateServiceImp implements RegistrateService
{
    private static final Logger logger = LogManager.getLogger(RegistrateService.class);
    
    @Autowired
    private RegistratePlayerSQL registratePlayerSQL;
    
    @Autowired
    private PasswordHandlerSQL passwordHandlerSQL;
    
    @Override
    public int registratePlayer(RegistrateData registrateData) 
    {
        int player_id = registratePlayerSQL.tryToRegistratePlayer(registrateData);
        
        if(player_id == -1)
        {
            logger.error("Játékos regisztrálása sikertelen. Adatok:\n" + registrateData.toString());
            return player_id;
        }
        
        logger.info("A generált player_id: " + player_id);
        
        byte[] salt = PasswordUtil.generateSalt();
        byte[] passwordHash = PasswordUtil.generateHash(salt, registrateData.getPassword().getBytes());
        
        logger.info("Só és hash generálása sikeres a következő player_id-hez: " + player_id);
        
        passwordHandlerSQL.storePassword(player_id, salt, passwordHash);
        
        return player_id;      
    }
}