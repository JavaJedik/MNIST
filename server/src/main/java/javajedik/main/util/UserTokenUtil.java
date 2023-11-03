package javajedik.main.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.SignatureException;
import io.jsonwebtoken.security.WeakKeyException;

import javax.crypto.SecretKey;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class UserTokenUtil 
{
    private static final Logger logger = LogManager.getLogger(UserTokenUtil.class);
    
    private static final SecretKey SECRET_KEY = RandomKeyGenerator.generateRandomKey();

    public static String generateToken(int player_id) 
    {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime expiration = now.plusHours(24);
        
        logger.info("UserToken generálása...");

        return Jwts.builder()
                .setSubject(Integer.toString(player_id))
                .setIssuedAt(java.util.Date.from(now.atZone(ZoneId.systemDefault()).toInstant()))
                .setExpiration(java.util.Date.from(expiration.atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(SECRET_KEY, SignatureAlgorithm.HS512)
                .compact();
    }

    public static boolean validateToken(String userToken) 
    {
        try 
        {
            Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(userToken);
            logger.info("UserToken is valid");
            return true;
        } catch (ExpiredJwtException | MalformedJwtException | UnsupportedJwtException | SignatureException | WeakKeyException | IllegalArgumentException | io.jsonwebtoken.io.DecodingException e) 
        {
            logger.warn("UserToken is invalid: " + userToken);
            return false;
        }
    }

    public static int getPlayerId(String userToken) 
    {
        try 
        {
            Claims claims = Jwts.parserBuilder().setSigningKey(SECRET_KEY).build().parseClaimsJws(userToken).getBody();
            logger.info("Player_id is: " + claims.getSubject());
            return Integer.parseInt(claims.getSubject());
        } catch (ExpiredJwtException | MalformedJwtException | UnsupportedJwtException | SignatureException | WeakKeyException | IllegalArgumentException | io.jsonwebtoken.io.DecodingException e) 
        {
            logger.error("UserToken is invalid: " + userToken);
            return -1;
        }
    }
    
    public static String getPlayerRole(String userToken) 
    {
        int playerId = getPlayerId(userToken);

        if (playerId != -1) 
        {
            try 
            {
                String sql = "SELECT pr.name " +
                             "FROM player p " +
                             "JOIN player_role pr ON p.player_role_id = pr.id " +
                             "WHERE p.id = ?";

                Map<String, Object> result = StaticJdbcUtil.select(sql, playerId);

                if (result.containsKey("name")) 
                {
                    return result.get("name").toString();
                }
            } 
            catch (Exception e) 
            {
                logger.error("Hiba történt a szerep megszerzésekor: " + e.getMessage());
            }
        }
        
        return "";
    }
}