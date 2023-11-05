package javajedik.main.config;

import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CorsConfig 
{
    @Bean
    public CorsConfigurationSource corsConfigurationSource() 
    {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.addAllowedOrigin("*"); // Ezen eredet engedélyezve van, de ajánlott beállítani a konkrét eredeteket
        configuration.addAllowedMethod("*"); // Az összes HTTP metódus engedélyezve van
        configuration.addAllowedHeader("*"); // Az összes HTTP fejléc engedélyezve van

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration); // Az összes út engedélyezve van

        return source;
    }

    @Bean
    public CorsFilter corsFilter() 
    {
        CorsFilter corsFilter = new CorsFilter(corsConfigurationSource());
        return corsFilter;
    }
}
