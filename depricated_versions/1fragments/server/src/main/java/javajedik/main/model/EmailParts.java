package javajedik.main.model;

public class EmailParts 
{
    private final String emailPrefix;
    private final String domain;
    private final String tld;

    public EmailParts(String emailPrefix, String domain, String tld) 
    {
        this.emailPrefix = emailPrefix;
        this.domain = domain;
        this.tld = tld;
    }

    public String getEmailPrefix() 
    {
        return emailPrefix;
    }

    public String getDomain() 
    {
        return domain;
    }

    public String getTld() 
    {
        return tld;
    }
}
