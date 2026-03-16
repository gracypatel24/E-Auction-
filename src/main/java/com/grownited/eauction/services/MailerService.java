package com.grownited.eauction.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailerService {
    
    @Autowired(required = false)
    private JavaMailSender mailSender;
    
    public void sendEmail(String to, String subject, String body) {
        if (mailSender == null) {
            System.out.println("📧 Email not configured. Would send to: " + to);
            System.out.println("   Subject: " + subject);
            System.out.println("   Body: " + body);
            return;
        }
        
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            message.setFrom("noreply@eauction.com");
            mailSender.send(message);
            System.out.println("✅ Email sent to: " + to);
        } catch (Exception e) {
            System.out.println("❌ Email sending failed: " + e.getMessage());
        }
    }
    
    public void sendWelcomeEmail(String to, String name) {
        String subject = "Welcome to E-Auction!";
        String body = String.format(
            "Dear %s,\n\n" +
            "Welcome to E-Auction! Your account has been successfully created.\n\n" +
            "You can now start bidding on exciting items.\n\n" +
            "Best regards,\n" +
            "The E-Auction Team", name);
        sendEmail(to, subject, body);
    }
    
    public void sendBidConfirmation(String to, String productName, Double bidAmount) {
        String subject = "Bid Placed Successfully";
        String body = String.format(
            "Your bid of ₹%.2f has been placed successfully for '%s'.\n\n" +
            "We'll notify you if you're outbid.\n\n" +
            "Good luck!\n" +
            "The E-Auction Team", bidAmount, productName);
        sendEmail(to, subject, body);
    }
}