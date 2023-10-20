/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package javajedik.main.service.imp;

import javajedik.main.model.LoginData;
import javajedik.main.service.LoginService;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImp implements LoginService
{
    @Override
    public boolean isValidLoginData(LoginData logindata) 
    {
        return true;
    }
}
