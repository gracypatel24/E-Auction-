package com.grownited.eauction.controller;

import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;
import com.grownited.eauction.services.MailerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/auth")
public class AuthController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserTypeRepository userTypeRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private MailerService mailerService;
    
    @GetMapping("/login")
    public String login(@RequestParam(required = false) String error,
                        @RequestParam(required = false) String logout,
                        Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
        return "auth/login";
    }
    
    @GetMapping("/signup")
    public String signup(Model model) {
        model.addAttribute("user", new UserEntity());
        return "auth/signup";
    }
    
    @PostMapping("/register")
    public String register(@ModelAttribute UserEntity user,
                           @RequestParam String confirmPassword,
                           RedirectAttributes ra) {
        
        if (!user.getPassword().equals(confirmPassword)) {
            ra.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/auth/signup";
        }
        
        if (userRepository.existsByEmail(user.getEmail())) {
            ra.addFlashAttribute("error", "Email already registered");
            return "redirect:/auth/signup";
        }
        
        UserTypeEntity userType = userTypeRepository.findByUserTypeName("USER")
            .orElseThrow(() -> new RuntimeException("User type not found"));
        
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setUserType(userType);
        user.setIsActive(true);
        
        UserEntity savedUser = userRepository.save(user);
        
        mailerService.sendWelcomeEmail(savedUser.getEmail(), savedUser.getEmail());
        
        ra.addFlashAttribute("message", "Registration successful! Please login.");
        return "redirect:/auth/login";
    }
    
    @GetMapping("/forgot-password")
    public String forgotPassword() {
        return "auth/forgot-password";
    }
    
    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam String email,
                                        RedirectAttributes ra) {
        
        if (userRepository.findByEmail(email).isPresent()) {
            String resetLink = "http://localhost:8080/auth/reset-password?email=" + email;
            mailerService.sendEmail(email, 
                "Password Reset Request", 
                "Click the link to reset your password:\n" + resetLink);
            ra.addFlashAttribute("message", "Password reset link sent to your email");
        } else {
            ra.addFlashAttribute("error", "Email not found");
        }
        
        return "redirect:/auth/forgot-password";
    }
}