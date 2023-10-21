package javajedik.main.model;

public class RegistrateData 
{
    String username;
    String email;
    String password;
    String language;
    String gender;
    String country;

    public String getUsername() 
    {
        return username;
    }

    public String getEmail() 
    {
        return email;
    }

    public String getPassword() 
    {
        return password;
    }

    public String getLanguage() 
    {
        return language;
    }

    public String getGender() 
    {
        return gender;
    }

    public String getCountry() 
    {
        return country;
    }
    
    @Override
    public String toString() 
    {
        return "username: " + (username != null ? username : "?") +
               ", email: " + (email != null ? email : "?") +
               ", password: " + (password != null ? "?" : "?") +
               ", language: " + (language != null ? language : "?") +
               ", gender: " + (gender != null ? gender : "?") +
               ", country: " + (country != null ? country : "?");
    }
}
