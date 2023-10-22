package javajedik.main.service.imp;

import java.util.concurrent.ExecutionException;
import java.util.logging.Level;
import javajedik.main.model.RegistrateData;
import javajedik.main.service.RegistrateService;
import javajedik.main.sql.RegistratePlayerSQL;
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
    
    @Override
    public int registratePlayer(RegistrateData registrateData) 
    {
        int player_id = registratePlayerSQL.tryToRegistratePlayer(registrateData);
        
        return player_id;      
    }
    
}
