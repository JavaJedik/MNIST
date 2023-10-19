package javajedik.main.model;

public class Login
{
    public String AuthenticateUser(LoginData ld)
    {
        // select a user jelszava
        PasswordSalt ps = new PasswordSalt("alma", "asdf");
        
        return TokenHandler.generateUserToken(new UserInfo(1,"r"));
    }
}
