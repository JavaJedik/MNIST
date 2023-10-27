package javajedik.main.service;

import javajedik.main.model.LoginData;

public interface LoginService 
{
    public int getPlayerIdFromLoginData(LoginData logindata);
    public boolean isValidPasswordFromPlayerID(int player_id, String providedPassword);
}
