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
        System.out.println("\n✅ E-Auction System Started Successfully!");
        System.out.println("📌 Access the application at: http://localhost:8080/");
        System.out.println("📌 Login with admin@eauction.com / admin123 (after creating admin)");
    }
}