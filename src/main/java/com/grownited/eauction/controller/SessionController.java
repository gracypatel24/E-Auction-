package com.grownited.eauction.controller;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;
import com.grownited.eauction.services.MailerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserTypeRepository userTypeRepository;

    @Autowired
    private UserDetailRepository userDetailRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired(required = false)
    private MailerService mailerService;
    
    @GetMapping("/")
    public String root() {
        // Check if user is already logged in
        // You can add logic here if needed
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                       @RequestParam(value = "logout", required = false) String logout,
                       Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid email or password");
        }
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
        return "auth/Login";
    }

    @GetMapping("/signup")
    public String signup(Model model) {
        try {
            List<UserTypeEntity> userTypes = userTypeRepository.findAll();
            model.addAttribute("allUserType", userTypes);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading user types");
            model.addAttribute("allUserType", List.of());
        }
        return "auth/Signup";
    }

    @PostMapping("/register")
    public String register(@RequestParam String firstName,
                          @RequestParam String lastName,
                          @RequestParam String email,
                          @RequestParam String password,
                          @RequestParam("confirmPassword") String confirmPassword,
                          @RequestParam("userTypeId") Integer userTypeId,
                          HttpSession session,
                          RedirectAttributes redirectAttributes,
                          Model model) {
        
        try {
            if (!password.equals(confirmPassword)) {
                model.addAttribute("error", "Passwords do not match");
                model.addAttribute("allUserType", userTypeRepository.findAll());
                return "auth/Signup";
            }
            
            Optional<UserEntity> existingUser = userRepository.findByEmail(email);
            if (existingUser.isPresent()) {
                model.addAttribute("error", "Email already exists");
                model.addAttribute("allUserType", userTypeRepository.findAll());
                return "auth/Signup";
            }
            
            Optional<UserTypeEntity> userTypeOpt = userTypeRepository.findById(userTypeId);
            if (userTypeOpt.isEmpty()) {
                model.addAttribute("error", "User type not found");
                model.addAttribute("allUserType", userTypeRepository.findAll());
                return "auth/Signup";
            }
            UserTypeEntity userType = userTypeOpt.get();
            
            UserEntity user = new UserEntity();
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(password));
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setUserType(userType);
            user.setIsActive(true);
            user.setIsDeleted(false);
            user.setCreatedAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());
            
            UserEntity savedUser = userRepository.save(user);
            
            UserDetailEntity userDetail = new UserDetailEntity();
            userDetail.setFirstName(firstName);
            userDetail.setLastName(lastName);
            userDetail.setEmail(email);
            userDetail.setPhone("");
            userDetail.setAddress("");
            userDetail.setUser(savedUser);
            userDetail.setCreatedAt(LocalDateTime.now());
            userDetail.setUpdatedAt(LocalDateTime.now());
            
            userDetailRepository.save(userDetail);
            
            try {
                if (mailerService != null) {
                    mailerService.sendWelcomeEmail(savedUser);
                }
            } catch (Exception e) {
                System.err.println("Failed to send welcome email: " + e.getMessage());
            }
            
            redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please login.");
            return "redirect:/login";
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            model.addAttribute("allUserType", userTypeRepository.findAll());
            return "auth/Signup";
        }
    }

    @PostMapping("/authenticate")
    public String authenticate(@RequestParam String email,
                              @RequestParam String password,
                              Model model,
                              HttpServletRequest request,
                              RedirectAttributes redirectAttributes) {
        
        System.out.println("========== LOGIN ATTEMPT ==========");
        System.out.println("Email: " + email);
        
        try {
            Optional<UserEntity> userOpt = userRepository.findByEmail(email);
            
            if (userOpt.isPresent()) {
                UserEntity user = userOpt.get();
                System.out.println("User found: " + user.getFirstName() + " " + user.getLastName());
                
                if (!user.getIsActive()) {
                    System.out.println("User is inactive");
                    model.addAttribute("error", "Your account is deactivated");
                    return "auth/Login";
                }
                
                boolean passwordMatches = passwordEncoder.matches(password, user.getPassword());
                System.out.println("Password matches: " + passwordMatches);
                
                if (passwordMatches) {
                    System.out.println("Authentication successful!");
                    
                    HttpSession session = request.getSession(true);
                    
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userType", user.getUserType().getUserTypeName());
                    
                    System.out.println("Session ID: " + session.getId());
                    System.out.println("User role: " + user.getUserType().getUserTypeName());
                    
                    String userRole = user.getUserType().getUserTypeName().toUpperCase();
                    
                    if ("ADMIN".equals(userRole)) {
                        System.out.println("Redirecting to: /admin/dashboard");
                        return "redirect:/admin/dashboard";
                    } else if ("SELLER".equals(userRole)) {
                        System.out.println("Redirecting to: /seller/dashboard");
                        return "redirect:/seller/dashboard";
                    } else {
                        System.out.println("Redirecting to: /user/dashboard");
                        return "redirect:/user/dashboard";
                    }
                } else {
                    System.out.println("Password does not match");
                    model.addAttribute("error", "Invalid email or password");
                }
            } else {
                System.out.println("User not found: " + email);
                model.addAttribute("error", "Invalid email or password");
            }
        } catch (Exception e) {
            System.out.println("Exception: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Login error: " + e.getMessage());
        }
        
        return "auth/Login";
    }
   
    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "auth/ForgotPassword";
    }
    
    @PostMapping("/forgot-password")
    public String forgotPassword(@RequestParam String email,
                                RedirectAttributes redirectAttributes) {
        
        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isPresent()) {
            UserEntity user = userOpt.get();
            String token = UUID.randomUUID().toString();
            
            try {
                if (mailerService != null) {
                    mailerService.sendPasswordResetEmail(user, token);
                }
                redirectAttributes.addFlashAttribute("successMessage", "Password reset link sent to your email");
            } catch (Exception e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("errorMessage", "Failed to send reset email. Please try again.");
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Email not found");
        }
        
        return "redirect:/forgot-password";
    }
    
    @GetMapping("/reset-password")
    public String resetPasswordPage(@RequestParam String token, Model model) {
        model.addAttribute("token", token);
        return "auth/ResetPassword";
    }
    
    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam String token,
                               @RequestParam String password,
                               @RequestParam String confirmPassword,
                               RedirectAttributes redirectAttributes) {
        
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
            return "redirect:/reset-password?token=" + token;
        }
        
        redirectAttributes.addFlashAttribute("successMessage", "Password reset successful! Please login.");
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login?logout=true";
    }
    
    
}