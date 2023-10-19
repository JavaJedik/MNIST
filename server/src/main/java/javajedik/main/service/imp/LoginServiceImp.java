package javajedik.main.service.imp;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImp implements LoginService
{
    @Override
    public String authenticateUser(LoginData ld) 
    {
        return login.authenticateUser(ld);
    }
    
}
