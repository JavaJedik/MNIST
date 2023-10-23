package javajedik.main.model;

import java.sql.Timestamp;

public class PasswordEntry 
{
    private byte[] salt;
    private byte[] passwordHash;
    private Timestamp createdAt;

    public PasswordEntry(byte[] salt, byte[] passwordHash, Timestamp createdAt) 
    {
        this.salt = salt;
        this.passwordHash = passwordHash;
        this.createdAt = createdAt;
    }

    public byte[] getSalt() 
    {
        return salt;
    }

    public void setSalt(byte[] salt) 
    {
        this.salt = salt;
    }

    public byte[] getPasswordHash() 
    {
        return passwordHash;
    }

    public void setPasswordHash(byte[] passwordHash) 
    {
        this.passwordHash = passwordHash;
    }

    public Timestamp getCreatedAt() 
    {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) 
    {
        this.createdAt = createdAt;
    }
}