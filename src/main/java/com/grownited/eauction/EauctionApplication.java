package com.grownited.eauction;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
@EntityScan(basePackages = "com.grownited.eauction.entity")
@EnableJpaRepositories(basePackages = "com.grownited.eauction.repository")
@ComponentScan(basePackages = {"com.grownited.eauction.controller", "com.grownited.eauction.config", "com.grownited.eauction.services"})
public class EauctionApplication {

    public static void main(String[] args) {
        SpringApplication.run(EauctionApplication.class, args);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}