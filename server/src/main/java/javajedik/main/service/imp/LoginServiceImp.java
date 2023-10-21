package javajedik.main.service.imp;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImp implements LoginService
{
    private static final Logger logger = LogManager.getLogger(LoginService.class);
    
    @Override
    public boolean isValidLoginData(LoginData logindata) 
    {
        logger.info("Helyes felhasználónév és jelszó");
        return true;
    }
}
