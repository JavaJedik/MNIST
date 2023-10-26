package javajedik.main.util;

import javajedik.main.model.EmailParts;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class EmailUtil 
{
    private static final Logger logger = LogManager.getLogger(EmailUtil.class);
    
    public static EmailParts splitEmail(String email) 
    {
        try
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
            logger.info("Email fragmentálása sikeres");
            return new EmailParts(emailPrefix, domain, tld);
        }
        catch (Exception ex)
        {
            logger.error("Email fragmentálása sikertelen");
            return null;
        }
    }

    public static String combineEmail(EmailParts emailParts) 
    {
        logger.info("Email defragmentálása");
        return emailParts.getEmailPrefix() + "@" + emailParts.getDomain() + "." + emailParts.getTld();
    }
}
