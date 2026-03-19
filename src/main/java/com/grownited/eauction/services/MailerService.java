package com.grownited.eauction.services;

import com.grownited.eauction.entity.BidEntity;
import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import java.time.format.DateTimeFormatter;

@Service
public class MailerService {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @Value("${spring.mail.username:}")
    private String fromEmail;

    @Value("${server.port:9999}")
    private String port;

    private final String baseUrl = "http://localhost:" + port;

    /**
     * Send simple email
     */
    public void sendSimpleEmail(String to, String subject, String body) {
        if (mailSender == null || fromEmail.isEmpty()) {
            System.out.println("===== EMAIL NOT CONFIGURED =====");
            System.out.println("To: " + to);
            System.out.println("Subject: " + subject);
            System.out.println("Body: " + body);
            System.out.println("================================");
            return;
        }
        
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            
            mailSender.send(message);
            System.out.println("Email sent successfully to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Send HTML email
     */
    public void sendHtmlEmail(String to, String subject, String htmlBody) {
        if (mailSender == null || fromEmail.isEmpty()) {
            System.out.println("===== HTML EMAIL NOT CONFIGURED =====");
            System.out.println("To: " + to);
            System.out.println("Subject: " + subject);
            System.out.println("HTML Body: " + htmlBody);
            System.out.println("======================================");
            return;
        }
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom(fromEmail);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlBody, true);
            
            mailSender.send(message);
            System.out.println("HTML email sent successfully to: " + to);
        } catch (MessagingException e) {
            System.err.println("Failed to send HTML email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Welcome email for new user
     */
    public void sendWelcomeEmail(UserEntity user) {
        String subject = "Welcome to E-Auction!";
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #667eea; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            ".footer { text-align: center; padding: 20px; color: #666; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Welcome to E-Auction!</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + user.getFirstName() + "!</h2>" +
            "<p>Thank you for registering with E-Auction. We're excited to have you on board!</p>" +
            "<p>With your account, you can:</p>" +
            "<ul>" +
            "<li>Browse thousands of auction items</li>" +
            "<li>Place bids on items you love</li>" +
            "<li>Track your bidding history</li>" +
            "<li>Get notifications on outbid status</li>" +
            "</ul>" +
            "<p>Get started by exploring our active auctions:</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/product/list' class='button'>Browse Auctions</a>" +
            "</p>" +
            "</div>" +
            "<div class='footer'>" +
            "<p>© 2024 E-Auction. All rights reserved.</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(user.getEmail(), subject, htmlBody);
    }

    /**
     * New bid notification to seller
     */
    public void sendNewBidNotification(UserEntity seller, ProductEntity product, BidEntity bid) {
        String subject = "New Bid on Your Product - " + product.getProductName();
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".bid-details { background: white; padding: 20px; border-radius: 5px; margin: 20px 0; }" +
            ".button { background: #28a745; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>New Bid Received!</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + seller.getFirstName() + "!</h2>" +
            "<p>Good news! You've received a new bid on your product.</p>" +
            "<div class='bid-details'>" +
            "<h3>Bid Details:</h3>" +
            "<p><strong>Product:</strong> " + product.getProductName() + "</p>" +
            "<p><strong>Bid Amount:</strong> ₹" + bid.getBidAmount() + "</p>" +
            "<p><strong>Bidder:</strong> " + bid.getUser().getFirstName() + " " + bid.getUser().getLastName() + "</p>" +
            "<p><strong>Time:</strong> " + bid.getBidTime().format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm")) + "</p>" +
            "</div>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/seller/product/view/" + product.getProductId() + "' class='button'>View Product</a>" +
            "</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(seller.getEmail(), subject, htmlBody);
    }

    /**
     * Password reset email
     */
    public void sendPasswordResetEmail(UserEntity user, String token) {
        String subject = "Password Reset Request - E-Auction";
        String resetLink = baseUrl + "/auth/reset-password?token=" + token;
        
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #ffc107; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            ".footer { text-align: center; padding: 20px; color: #666; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Password Reset Request</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + user.getFirstName() + "!</h2>" +
            "<p>We received a request to reset your password for your E-Auction account.</p>" +
            "<p>Click the button below to reset your password:</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + resetLink + "' class='button'>Reset Password</a>" +
            "</p>" +
            "<p><strong>Note:</strong> This link will expire in 24 hours.</p>" +
            "<p>If you didn't request this, please ignore this email or contact support.</p>" +
            "</div>" +
            "<div class='footer'>" +
            "<p>© 2024 E-Auction. All rights reserved.</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(user.getEmail(), subject, htmlBody);
    }

    /**
     * Product approval notification
     */
    public void sendProductApprovalNotification(ProductEntity product) {
        String subject = "Your Product Has Been Approved!";
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #28a745; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Product Approved!</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + product.getSeller().getFirstName() + "!</h2>" +
            "<p>Congratulations! Your product has been approved and is now live on E-Auction.</p>" +
            "<p><strong>Product:</strong> " + product.getProductName() + "</p>" +
            "<p><strong>Starting Price:</strong> ₹" + product.getStartingPrice() + "</p>" +
            "<p>Start promoting your product to get more bids!</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/seller/product/view/" + product.getProductId() + "' class='button'>View Product</a>" +
            "</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(product.getSeller().getEmail(), subject, htmlBody);
    }

    /**
     * Product rejection notification
     */
    public void sendProductRejectionNotification(ProductEntity product, String reason) {
        String subject = "Product Submission Update";
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #dc3545 0%, #c82333 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #dc3545; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Product Submission Update</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + product.getSeller().getFirstName() + "!</h2>" +
            "<p>We regret to inform you that your product has been rejected.</p>" +
            "<p><strong>Product:</strong> " + product.getProductName() + "</p>" +
            "<p><strong>Reason:</strong> " + reason + "</p>" +
            "<p>Please make the necessary changes and resubmit.</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/seller/product/edit/" + product.getProductId() + "' class='button'>Edit Product</a>" +
            "</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(product.getSeller().getEmail(), subject, htmlBody);
    }

    /**
     * Auction won notification
     */
    public void sendAuctionWonNotification(UserEntity winner, ProductEntity product) {
        String subject = "Congratulations! You Won the Auction!";
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #ffc107; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Congratulations!</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + winner.getFirstName() + "!</h2>" +
            "<p>You have won the auction for:</p>" +
            "<p><strong>Product:</strong> " + product.getProductName() + "</p>" +
            "<p><strong>Winning Bid:</strong> ₹" + product.getWinningAmount() + "</p>" +
            "<p>Please complete the payment to claim your item.</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/payment/make/" + product.getProductId() + "' class='button'>Make Payment</a>" +
            "</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(winner.getEmail(), subject, htmlBody);
    }

    /**
     * Product sold notification to seller
     */
    public void sendProductSoldNotification(UserEntity seller, ProductEntity product, BidEntity winningBid) {
        String subject = "Your Product Has Been Sold!";
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #28a745; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>Product Sold!</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<h2>Hello " + seller.getFirstName() + "!</h2>" +
            "<p>Congratulations! Your product has been sold.</p>" +
            "<p><strong>Product:</strong> " + product.getProductName() + "</p>" +
            "<p><strong>Selling Price:</strong> ₹" + winningBid.getBidAmount() + "</p>" +
            "<p><strong>Buyer:</strong> " + winningBid.getUser().getFirstName() + " " + winningBid.getUser().getLastName() + "</p>" +
            "<p>You will receive the payment once the buyer completes the transaction.</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/seller/product/view/" + product.getProductId() + "' class='button'>View Sale</a>" +
            "</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        sendHtmlEmail(seller.getEmail(), subject, htmlBody);
    }

    /**
     * New product notification to admin
     */
    public void sendNewProductNotification(ProductEntity product) {
        String subject = "New Product Pending Approval";
        String htmlBody = "<!DOCTYPE html>" +
            "<html>" +
            "<head>" +
            "<style>" +
            "body { font-family: Arial, sans-serif; }" +
            ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #17a2b8 0%, #138496 100%); color: white; padding: 30px; text-align: center; }" +
            ".content { padding: 30px; background: #f9f9f9; }" +
            ".button { background: #17a2b8; color: white; padding: 12px 30px; text-decoration: none; border-radius: 5px; display: inline-block; }" +
            "</style>" +
            "</head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'>" +
            "<h1>New Product Submitted</h1>" +
            "</div>" +
            "<div class='content'>" +
            "<p>A new product has been submitted for approval:</p>" +
            "<p><strong>Product:</strong> " + product.getProductName() + "</p>" +
            "<p><strong>Seller:</strong> " + product.getSeller().getFirstName() + " " + product.getSeller().getLastName() + "</p>" +
            "<p><strong>Starting Price:</strong> ₹" + product.getStartingPrice() + "</p>" +
            "<p><strong>Description:</strong> " + product.getDescription() + "</p>" +
            "<p style='text-align: center;'>" +
            "<a href='" + baseUrl + "/admin/product/view/" + product.getProductId() + "' class='button'>Review Product</a>" +
            "</p>" +
            "</div>" +
            "</div>" +
            "</body>" +
            "</html>";
        
        // Send to admin email (you can configure this in properties)
        String adminEmail = "admin@eauction.com";
        sendHtmlEmail(adminEmail, subject, htmlBody);
    }
}