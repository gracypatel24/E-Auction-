package com.grownited.eauction.services;

// Comment out these imports
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.mail.SimpleMailMessage;
// import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.grownited.eauction.entity.UserEntity;

@Service
public class MailerService {

    // Comment out this field completely
    // @Autowired
    // private JavaMailSender mailSender;

    public void sendWelcomeMail(UserEntity user) {
        // Just print to console instead of sending email
        System.out.println("=== WELCOME EMAIL ===");
        System.out.println("To: " + user.getEmail());
        System.out.println("Subject: Welcome to E-Auction!");
        System.out.println("Body: Dear " + user.getFirstName() + ", welcome to E-Auction!");
        System.out.println("====================");
    }

    public void sendPasswordResetMail(String email, String token) {
        // Just print to console instead of sending email
        System.out.println("=== PASSWORD RESET EMAIL ===");
        System.out.println("To: " + email);
        System.out.println("Subject: Password Reset Request - E-Auction");
        System.out.println("Token: " + token);
        System.out.println("Reset Link: http://localhost:9999/reset-password?token=" + token);
        System.out.println("============================");
    }

    public void sendBidNotification(String email, String productName, Double amount) {
        // Just print to console instead of sending email
        System.out.println("=== BID NOTIFICATION EMAIL ===");
        System.out.println("To: " + email);
        System.out.println("Subject: Bid Update - E-Auction");
        System.out.println("Message: Your bid of $" + amount + " on " + productName + " has been placed successfully.");
        System.out.println("==============================");
    }
}