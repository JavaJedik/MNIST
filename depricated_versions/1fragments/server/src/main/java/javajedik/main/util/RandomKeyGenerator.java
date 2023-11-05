package javajedik.main.util;

import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class RandomKeyGenerator 
{
    private static final Logger logger = LogManager.getLogger(RandomKeyGenerator.class);
    
    private static final int KEY_LENGTH = 64;

    public static String generateRandomString() 
    {
        SecureRandom secureRandom = new SecureRandom();
        byte[] randomBytes = new byte[KEY_LENGTH];
        secureRandom.nextBytes(randomBytes);
        logger.info("Random kulcs generálva");
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
    
    public static SecretKey generateRandomKey() 
    {
        SecureRandom secureRandom = new SecureRandom();
        byte[] randomBytes = new byte[KEY_LENGTH];
        secureRandom.nextBytes(randomBytes);

        SecretKey key = new SecretKeySpec(randomBytes, "HmacSHA512");

        return key;
    }
}
