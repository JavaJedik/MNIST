package javajedik.main.model;

public class UserInfo
{
    private final int userId;
    private final String userType;

    public UserInfo(int userId, String userType) 
    {
        this.userId = userId;
        this.userType = userType;
    }

    public int getUserId() 
    {
        return userId;
    }

    public String getUserType() 
    {
        return userType;
    }
}
