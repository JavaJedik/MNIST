package javajedik.main.util;

import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.util.Map;
import org.springframework.dao.EmptyResultDataAccessException;

public final class StaticJdbcUtil 
{
    private static JdbcTemplate jdbcTemplate;
    
    private StaticJdbcUtil() {}

    public static void initialize(DataSource dataSource) 
    {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public static <T> T select(String sql, Object... args) 
    {
        if (jdbcTemplate == null) 
        {
            throw new IllegalStateException("StaticJdbcUtil is not initialized. Call StaticJdbcUtil.initialize(DataSource) first.");
        }

        try 
        {
            Map<String, Object> result = jdbcTemplate.queryForMap(sql, args);
            return (T) result;
        } catch (EmptyResultDataAccessException e) 
        {
            return null;
        }
    }
}
