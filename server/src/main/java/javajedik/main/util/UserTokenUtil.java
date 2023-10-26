package javajedik.main.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import io.jsonwebtoken.security.WeakKeyException;

import javax.crypto.SecretKey;
import java.time.LocalDateTime;
import java.time.ZoneId;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class UserTokenUtil 
{
    private static final Logger logger = LogManager.getLogger(UserTokenUtil.class);
    
    private static final String SECRET_KEY = RandomKeyGenerator.generateRandomKey();

    public static String generateToken(int playerId) 
    {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expiration = now.plusHours(24);
        SecretKey key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
        
        logger.info("UserToken generálása...");

        return Jwts.builder()
                .setSubject(Integer.toString(playerId))
                .setIssuedAt(java.util.Date.from(now.atZone(ZoneId.systemDefault()).toInstant()))
                .setExpiration(java.util.Date.from(expiration.atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    public static boolean validateToken(String userToken) 
    {
        try 
        {
            SecretKey key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
            Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(userToken);
            logger.info("UserToken is valid: " + userToken);
            return true;
        } catch (ExpiredJwtException | MalformedJwtException | UnsupportedJwtException | SignatureException | WeakKeyException | IllegalArgumentException e) 
        {
            logger.warn("UserToken is invalid: " + userToken);
            return false;
        }
    }

    public static int getPlayerId(String userToken) 
    {
        SecretKey key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());
        Claims claims = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(userToken).getBody();
        logger.info("Player_id is: " + claims.getSubject());
        return Integer.parseInt(claims.getSubject());
    }
}

