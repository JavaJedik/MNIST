package javajedik.main.util;

import javajedik.main.model.EmailParts;

public class EmailUtil 
{
    public static EmailParts splitEmail(String email) 
    {
        String[] emailParts = email.split("@");
        String emailPrefix = emailParts[0];
        String[] domainParts = emailParts[1].split("\\.");
        String domain = domainParts[0];
        String tld = domainParts[domainParts.length - 1];
        for (int i = 1; i < domainParts.length - 1; i++) 
        {
            domain += "." + domainParts[i];
        }
        return new EmailParts(emailPrefix, domain, tld);
    }

    public static String combineEmail(EmailParts emailParts) 
    {
        return emailParts.getEmailPrefix() + "@" + emailParts.getDomain() + "." + emailParts.getTld();
    }
}
