package javajedik.main.model;

public class RegisteredPlayer 
{
    private int playerId;
    private String name;
    private int genderId;
    private String emailPrefix;
    private int emailTypeId;
    private int countryCallingCodeId;
    private int phoneNetworkId;
    private int phone;

    public RegisteredPlayer(){};
    
    public RegisteredPlayer(int playerId, String name, int genderId, String emailPrefix, int emailTypeId) 
    {
        this.playerId = playerId;
        this.name = name;
        this.genderId = genderId;
        this.emailPrefix = emailPrefix;
        this.emailTypeId = emailTypeId;
    }

    public int getPlayerId() 
    {
        return playerId;
    }

    public void setPlayerId(int playerId) 
    {
        this.playerId = playerId;
    }

    public String getName() 
    {
        return name;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public int getGenderId() 
    {
        return genderId;
    }

    public void setGenderId(int genderId) 
    {
        this.genderId = genderId;
    }

    public String getEmailPrefix() 
    {
        return emailPrefix;
    }

    public void setEmailPrefix(String emailPrefix) 
    {
        this.emailPrefix = emailPrefix;
    }

    public int getEmailTypeId() 
    {
        return emailTypeId;
    }

    public void setEmailTypeId(int emailTypeId) 
    {
        this.emailTypeId = emailTypeId;
    }

    public int getCountryCallingCodeId() 
    {
        return countryCallingCodeId;
    }

    public void setCountryCallingCodeId(int countryCallingCodeId) 
    {
        this.countryCallingCodeId = countryCallingCodeId;
    }

    public int getPhoneNetworkId() 
    {
        return phoneNetworkId;
    }

    public void setPhoneNetworkId(int phoneNetworkId) 
    {
        this.phoneNetworkId = phoneNetworkId;
    }

    public int getPhone() 
    {
        return phone;
    }

    public void setPhone(int phone) 
    {
        this.phone = phone;
    }
}
