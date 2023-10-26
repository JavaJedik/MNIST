package javajedik.main.util;

import java.security.SecureRandom;
import java.util.Base64;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class RandomKeyGenerator 
{
    private static final Logger logger = LogManager.getLogger(RandomKeyGenerator.class);
    
    private static final int KEY_LENGTH = 64;

    public static String generateRandomKey() 
    {
        SecureRandom secureRandom = new SecureRandom();
        byte[] randomBytes = new byte[KEY_LENGTH];
        secureRandom.nextBytes(randomBytes);
        logger.info("Random kulcs generálva");
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
}
