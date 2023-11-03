package javajedik.main;

import javajedik.main.config.DataSourceConfig;
import javajedik.main.util.StaticJdbcUtil;
import javax.sql.DataSource;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.scheduling.annotation.EnableAsync;

@EnableAsync
@SpringBootApplication
public class Main 
{   
    public static void main(String[] args) 
    {
        StaticJdbcUtil.initialize
        (new AnnotationConfigApplicationContext(DataSourceConfig.class).getBean(DataSource.class));
        
        SpringApplication.run(Main.class, args);
    }
}
