package com.grownited.eauction.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;

@Controller
public class SessionController {
    
    @Autowired
    UserRepository userRepository;
    
    @Autowired
    UserDetailRepository userDetailRepository;

    @GetMapping("/signup")
    public String openSignupPage() {
        return "Signup"; // jsp name
    }

    @GetMapping("/login")
    public String openLoginPage() {
        return "Login";
    }

    @GetMapping("/forgetpassword")
    public String openForgetPassword() {
        return "ForgetPassword";
    }

    @PostMapping("/register")
    public String register(UserEntity userEntity, UserDetailEntity userDetailEntity) {
        System.out.println(userEntity.getFirstName());
        System.out.println(userEntity.getLastName());
        System.out.println("Processor => " + Runtime.getRuntime().availableProcessors());
        System.out.println(userDetailEntity.getCountry());
        System.out.println(userDetailEntity.getState());

        // Set user properties
        userEntity.setRole("PARTICIPANT");
        userEntity.setActive(true);
        userEntity.setCreatedAt(LocalDate.now());
        
        // Save user first
        UserEntity savedUser = userRepository.save(userEntity);
        
        // Set the relationship and save user details
        userDetailEntity.setUserEntity(savedUser);
        userDetailRepository.save(userDetailEntity);
        
        return "Login";
    }
}