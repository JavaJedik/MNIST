package javajedik.main.model;

public class LoginData 
{
    private final String name;
    private final String password;

    public LoginData(String name, String password) 
    {
        this.name = name;
        this.password = password;
    }

    public String getName() 
    {
        return name;
    }

    public String getPassword() 
    {
        return password;
    }
}
