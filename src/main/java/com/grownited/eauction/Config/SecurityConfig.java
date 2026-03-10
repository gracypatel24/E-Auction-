package com.grownited.eauction.Config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/", "/login", "/signup", "/register", "/forgetpassword", 
                               "/assets/**", "/css/**", "/js/**", "/images/**").permitAll()
                .anyRequest().permitAll() // For development - change in production
            )
            .csrf(csrf -> csrf.disable());
        return http.build();
    }
}