package com.grownited.eauction;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class EauctionApplication extends SpringBootServletInitializer {
    
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(EauctionApplication.class);
    }
    
    public static void main(String[] args) {
        SpringApplication.run(EauctionApplication.class, args);
        System.out.println("=====================================");
        System.out.println("✅ E-AUCTION WEBSITE STARTED");
        System.out.println("🌐 http://localhost:9999");
        System.out.println("=====================================");
    }
}