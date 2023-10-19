/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package javajedik.main.service;

import javajedik.main.model.Login;
import javajedik.main.model.LoginData;

public interface LoginService
{
    Login login = new Login();
    
    public String AuthenticateUser(LoginData ld);
}
