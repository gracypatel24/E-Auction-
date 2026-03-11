package com.grownited.eauction;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.cloudinary.Cloudinary;

@SpringBootApplication
@EntityScan(basePackages = "com.grownited.eauction.entity")
@EnableJpaRepositories(basePackages = "com.grownited.eauction.repository")
@ComponentScan(basePackages = {
    "com.grownited.eauction.controller",
    "com.grownited.eauction.controller.participant",  // CRITICAL: Add this line
    "com.grownited.eauction.config", 
    "com.grownited.eauction.services"
})
public class EauctionApplication {

    public static void main(String[] args) {
        SpringApplication.run(EauctionApplication.class, args);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public Cloudinary cloudinary() {
        Map<String, String> config = new HashMap<>();
        config.put("cloud_name", "dqwes5eev");
        config.put("api_key", "781758332318518");
        config.put("api_secret", "hr2hMchu6JApgB9ECnaoCfUZ_0I");
        config.put("secure", "true");
        return new Cloudinary(config);
    }
}