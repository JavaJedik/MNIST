package javajedik.main.service.imp;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;

public class LoginServiceImp implements LoginService
{
    @Override
    public String AuthenticateUser(LoginData ld) 
    {
        return login.AuthenticateUser(ld);
    }
    
}
