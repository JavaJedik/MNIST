package javajedik.main.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.WeakKeyException;
import javax.crypto.SecretKey;
import java.time.LocalDateTime;
import java.time.ZoneId;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class GameTokenUtil 
{
    private static final Logger logger = LogManager.getLogger(GameTokenUtil.class);
    private static final SecretKey SECRET_KEY = RandomKeyGenerator.generateRandomKey();

    public static String generateToken(int gameId) 
    {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expiration = now.plusHours(24);

        logger.info("GameToken generálása...");

        return Jwts.builder()
                .setSubject(Integer.toString(gameId))
                .setIssuedAt(java.util.Date.from(now.atZone(ZoneId.systemDefault()).toInstant()))
                .setExpiration(java.util.Date.from(expiration.atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(SECRET_KEY, SignatureAlgorithm.HS512)
                .compact();
    }

    public static boolean validateToken(String gameToken) 
    {
        try 
        {
            Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(gameToken);
            logger.info("GameToken is valid");
            return true;
        } catch (ExpiredJwtException | MalformedJwtException | UnsupportedJwtException | SignatureException | WeakKeyException | IllegalArgumentException e) 
        {
            logger.warn("GameToken is invalid: " + gameToken);
            return false;
        }
    }

    public static int getGameId(String gameToken) 
    {
        try 
        {
            Claims claims = Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(gameToken).getBody();
            logger.info("Game ID is: " + claims.getSubject());
            return Integer.parseInt(claims.getSubject());
        } catch (ExpiredJwtException | MalformedJwtException | UnsupportedJwtException | SignatureException | WeakKeyException | IllegalArgumentException e) 
        {
            logger.error("GameToken is invalid: " + gameToken);
            return -1;
        }
    }
}