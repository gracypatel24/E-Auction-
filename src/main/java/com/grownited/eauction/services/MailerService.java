package com.grownited.eauction.services;

import org.springframework.stereotype.Service;
import com.grownited.eauction.entity.UserEntity;

@Service
public class MailerService {

    // You can implement email sending here later
    // For now this is a placeholder so the project compiles
    public void sendWelcomeMail(UserEntity userEntity) {
        System.out.println("Welcome mail sent to: " + userEntity.getEmail());
    }
}