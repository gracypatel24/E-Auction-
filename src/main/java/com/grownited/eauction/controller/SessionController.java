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
    
    @Autowired
    private MailerService mailerService;

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
    
    @GetMapping("/generate-password")
    @ResponseBody
    public String generatePassword(@RequestParam String password) {
        return passwordEncoder.encode(password);
    }
    
    @GetMapping("/fix-passwords")
    @ResponseBody
    public String fixPasswords() {
        List<UserEntity> users = userRepository.findAll();
        int fixed = 0;
        
        for (UserEntity user : users) {
            String currentPassword = user.getPassword();
            if (currentPassword != null && !currentPassword.startsWith("$2a$")) {
                String hashedPassword = passwordEncoder.encode(currentPassword);
                user.setPassword(hashedPassword);
                userRepository.save(user);
                fixed++;
                System.out.println("Fixed password for: " + user.getEmail());
            }
        }
        
        return "Fixed " + fixed + " passwords. Total users: " + users.size();
    }
    
    @GetMapping("/test-password")
    @ResponseBody
    public String testPassword(@RequestParam String email, @RequestParam String password) {
        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isEmpty()) {
            return "User not found with email: " + email;
        }
        
        UserEntity user = userOpt.get();
        boolean matches = passwordEncoder.matches(password, user.getPassword());
        
        return "User: " + user.getEmail() + "<br>" +
               "Stored hash: " + user.getPassword() + "<br>" +
               "Password matches: " + matches + "<br>" +
               "User active: " + user.getIsActive() + "<br>" +
               "User role: " + user.getUserType().getUserTypeName();
    }
    
    @GetMapping("/hash-password")
    @ResponseBody
    public String hashPassword(@RequestParam String password) {
        return "Password: " + password + "<br>Hash: " + passwordEncoder.encode(password);
    }
    
    @GetMapping("/debug-session")
    @ResponseBody
    public String debugSession(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) {
            return "No user in session. Session ID: " + session.getId();
        }
        return "User: " + user.getFirstName() + " " + user.getLastName() + 
               "<br>Role: " + user.getUserType().getUserTypeName() +
               "<br>User ID: " + user.getUserId() +
               "<br>Session ID: " + session.getId();
    }
    
    @GetMapping("/check-session")
    @ResponseBody
    public String checkSession(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        StringBuilder sb = new StringBuilder();
        
        sb.append("Session ID: ").append(session.getId()).append("<br>");
        sb.append("Session creation time: ").append(new java.util.Date(session.getCreationTime())).append("<br>");
        sb.append("Session last accessed: ").append(new java.util.Date(session.getLastAccessedTime())).append("<br>");
        sb.append("Session max inactive interval: ").append(session.getMaxInactiveInterval()).append(" seconds<br>");
        sb.append("<br>");
        
        if (user == null) {
            sb.append("<b>No user in session!</b><br>");
            java.util.Enumeration<String> attributeNames = session.getAttributeNames();
            sb.append("Session attributes:<br>");
            while (attributeNames.hasMoreElements()) {
                String name = attributeNames.nextElement();
                sb.append(" - ").append(name).append(": ").append(session.getAttribute(name)).append("<br>");
            }
        } else {
            sb.append("<b>User in session:</b><br>");
            sb.append(" - User ID: ").append(user.getUserId()).append("<br>");
            sb.append(" - Name: ").append(user.getFirstName()).append(" ").append(user.getLastName()).append("<br>");
            sb.append(" - Email: ").append(user.getEmail()).append("<br>");
            sb.append(" - Role: ").append(user.getUserType().getUserTypeName()).append("<br>");
        }
        
        return sb.toString();
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
                mailerService.sendWelcomeEmail(savedUser);
            } catch (Exception e) {
                System.err.println("Failed to send welcome email: " + e.getMessage());
            }
            
            redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
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
        System.out.println("Password received: " + password);
        
        try {
            Optional<UserEntity> userOpt = userRepository.findByEmail(email);
            
            if (userOpt.isPresent()) {
                UserEntity user = userOpt.get();
                System.out.println("User found: " + user.getFirstName() + " " + user.getLastName());
                System.out.println("Stored password hash: " + user.getPassword());
                System.out.println("User active: " + user.getIsActive());
                System.out.println("User role: " + user.getUserType().getUserTypeName());
                
                if (!user.getIsActive()) {
                    System.out.println("User is inactive");
                    model.addAttribute("error", "Your account is deactivated");
                    return "auth/Login";
                }
                
                boolean passwordMatches = passwordEncoder.matches(password, user.getPassword());
                System.out.println("Password matches: " + passwordMatches);
                
                if (passwordMatches) {
                    System.out.println("Authentication successful!");
                    
                    // Create new session
                    HttpSession session = request.getSession(true);
                    
                    // Set session attributes - THIS IS CRITICAL
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("userType", user.getUserType().getUserTypeName());
                    
                    // Force session to be saved
                    session.setAttribute("test", "test");
                    
                    System.out.println("Session ID: " + session.getId());
                    System.out.println("User attribute set: " + session.getAttribute("user"));
                    System.out.println("User ID attribute: " + session.getAttribute("userId"));
                    System.out.println("User type attribute: " + session.getAttribute("userType"));
                    
                    String userRole = user.getUserType().getUserTypeName().toUpperCase();
                    System.out.println("User role: " + userRole);
                    
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
                mailerService.sendPasswordResetEmail(user, token);
                redirectAttributes.addFlashAttribute("success", "Password reset link sent to your email");
            } catch (Exception e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("error", "Failed to send reset email. Please try again.");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Email not found");
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
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/reset-password?token=" + token;
        }
        
        redirectAttributes.addFlashAttribute("success", "Password reset successful! Please login.");
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletRequest response) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login?logout=true";
    }
    @GetMapping("/debug-urls")
    @ResponseBody
    public String debugUrls(org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping handlerMapping) {
        StringBuilder sb = new StringBuilder();
        sb.append("<h2>All Available URLs (60 mappings):</h2>");
        sb.append("<ul>");
        
        handlerMapping.getHandlerMethods().forEach((key, value) -> {
            sb.append("<li>").append(key).append(" → ").append(value).append("</li>");
        });
        
        sb.append("</ul>");
        return sb.toString();
        
    }
    @GetMapping("/list-all-urls")
    @ResponseBody
    public String listAllUrls(org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping handlerMapping) {
        StringBuilder sb = new StringBuilder();
        sb.append("<html><head><title>All URLs</title>");
        sb.append("<style>body{font-family:Arial;padding:20px;} li{margin:5px;} .url{color:#0066cc;} .method{color:#008800;}</style>");
        sb.append("</head><body>");
        sb.append("<h2>All Registered URLs (Total: " + handlerMapping.getHandlerMethods().size() + ")</h2>");
        sb.append("<ul>");
        
        handlerMapping.getHandlerMethods().forEach((key, value) -> {
            sb.append("<li>");
            sb.append("<span class='method'>").append(key).append("</span>");
            sb.append(" → ");
            sb.append("<span class='url'>").append(value).append("</span>");
            sb.append("</li>");
        });
        
        sb.append("</ul>");
        sb.append("</body></html>");
        return sb.toString();
    }
}