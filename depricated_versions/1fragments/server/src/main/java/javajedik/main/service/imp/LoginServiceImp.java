package javajedik.main.service.imp;

import javajedik.main.model.LoginData;
import javajedik.main.model.PasswordEntry;
import javajedik.main.service.LoginService;
import javajedik.main.sql.PasswordHandlerSQL;
import javajedik.main.sql.PlayerDataSQL;
import javajedik.main.util.PasswordUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImp implements LoginService
{
    private static final Logger logger = LogManager.getLogger(LoginService.class);
    
    @Autowired
    private PasswordHandlerSQL passwordHandlerSQL;
    
    @Autowired
    private PlayerDataSQL playerDataSQL;
    
    @Override
    public int getPlayerIdFromLoginData(LoginData loginData) 
    {
        final int player_id = playerDataSQL.getPlayerIdByName(loginData.getUsername());
        
        if(player_id == -1)
        {
            logger.info("Az adott játékosnévhez nem létezik player_id: " + loginData.getUsername());
            return -1;
        }
                
        logger.info("Helyes felhasználónév. Név: " + loginData.getUsername() + ", player_id: " + player_id);
        return player_id;
    }

    @Override
    public boolean isValidPasswordFromPlayerID(int player_id, String providedPassword) 
    {
        PasswordEntry entry = passwordHandlerSQL.getPasswordEntry(player_id);
        if(entry == null)
        {
            return false;
        }
        return (PasswordUtil.validatePassword(entry.getSalt(), entry.getPasswordHash(), providedPassword));        
    }
}
