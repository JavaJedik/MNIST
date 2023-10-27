package javajedik.main.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class PasswordUtil 
{
    private static final int SALT_LENGTH = 64;
    private static final String HASH_ALGORITHM = "SHA-512";
    private static final Logger logger = LogManager.getLogger(PasswordUtil.class);
    
    public static byte[] generateSalt() 
    {
        byte[] salt = new byte[SALT_LENGTH];
        SecureRandom secureRandom = new SecureRandom();
        secureRandom.nextBytes(salt);
        logger.info("Só generálva");
        return salt;
    }

    public static byte[] generateHash(byte[] salt, byte[] password) 
    {
        try 
        {
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
            digest.reset();
            digest.update(salt);
            byte[] hash = digest.digest(password);
            logger.info("Sóhoz és jelszóhoz tartozó Hash érték generálva");
            return hash;
        } catch (NoSuchAlgorithmException e) 
        {
            return null;
        }
    }
    
    public static boolean validatePassword(byte[] storedSalt, byte[] storedHash, String providedPassword) 
    {
        byte[] providedPasswordBytes = providedPassword.getBytes();
        byte[] computedHash = generateHash(storedSalt, providedPasswordBytes);

        return MessageDigest.isEqual(storedHash, computedHash);
    }
}

