package javajedik.main.model;

public class Login
{
    public String authenticateUser(LoginData ld)
    {
        // select a user jelszava és hashe és sója
        PasswordHasher.hashPasswordWithSalt("Alma", "Asd123");
        // hashe-k összehasonltása
        // ha nem jó,akkor return null
        return TokenHandler.generateUserToken(new UserInfo(1,"r"));
    }
}
