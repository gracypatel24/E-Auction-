package com.grownited.eauction.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;
import com.grownited.eauction.services.CloudinaryService;
import com.grownited.eauction.services.MailerService;

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
    private CloudinaryService cloudinaryService;

    @Autowired
    private MailerService mailerService;

    @GetMapping("/signup")
    public String openSignupPage(Model model) {
        List<UserTypeEntity> allUserType = userTypeRepository.findAll();
        model.addAttribute("allUserType", allUserType);
        return "Signup";
    }

    @GetMapping("/login")
    public String openLoginPage() {
        return "Login";
    }

    @PostMapping("/authenticate")
    public String authenticate(@RequestParam String email, 
                              @RequestParam String password, 
                              Model model, 
                              HttpSession session) {
        
        Optional<UserEntity> op = userRepository.findByEmail(email);

        if (op.isPresent()) {
            UserEntity dbUser = op.get();
            
            if (passwordEncoder.matches(password, dbUser.getPassword())) {
                session.setAttribute("user", dbUser);
                session.setAttribute("userId", dbUser.getUserId());
                session.setAttribute("userRole", dbUser.getRole());
                session.setAttribute("userEmail", dbUser.getEmail());

                if ("ADMIN".equals(dbUser.getRole())) {
                    return "redirect:/admin-dashboard";
                } else {
                    return "redirect:/participant/dashboard";
                }
            }
        }

        model.addAttribute("error", "Invalid Credentials");
        return "Login";
    }

    @PostMapping("/register")
    public String register(@RequestParam String firstName,
                          @RequestParam String lastName,
                          @RequestParam String email,
                          @RequestParam String password,
                          @RequestParam(required = false) String contactNum,
                          @RequestParam(required = false) Integer birthYear,
                          @RequestParam(required = false) String gender,
                          @RequestParam Integer userTypeId,
                          @RequestParam(required = false) String city,
                          @RequestParam(required = false) String state,
                          @RequestParam(required = false) String country,
                          @RequestParam(required = false) MultipartFile profilePic,
                          HttpSession session,
                          Model model) {
        
        try {
            Optional<UserEntity> existingUser = userRepository.findByEmail(email);
            if (existingUser.isPresent()) {
                model.addAttribute("error", "Email already registered");
                List<UserTypeEntity> allUserType = userTypeRepository.findAll();
                model.addAttribute("allUserType", allUserType);
                return "Signup";
            }
            
            UserEntity user = new UserEntity();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(password));
            user.setContactNum(contactNum);
            user.setBirthYear(birthYear);
            user.setGender(gender);
            
            if (userTypeId == 1) {
                user.setRole("ADMIN");
            } else {
                user.setRole("PARTICIPANT");
            }
            
            user.setActive(true);
            user.setCreatedAt(LocalDate.now());
            
            // Upload profile picture if provided
            if (profilePic != null && !profilePic.isEmpty()) {
                String profilePicUrl = cloudinaryService.uploadImage(profilePic);
                user.setProfilePicURL(profilePicUrl);
            }
            
            UserEntity savedUser = userRepository.save(user);
            
            UserDetailEntity userDetail = new UserDetailEntity();
            userDetail.setUserId(savedUser.getUserId());
            userDetail.setCity(city);
            userDetail.setState(state);
            userDetail.setCountry(country != null ? country : "India");
            userDetail.setUserTypeId(userTypeId);
            
            userDetailRepository.save(userDetail);
            
            // COMMENT OUT OR REMOVE THIS LINE
            // mailerService.sendWelcomeMail(savedUser);
            
            // Auto login
            session.setAttribute("user", savedUser);
            session.setAttribute("userId", savedUser.getUserId());
            session.setAttribute("userRole", savedUser.getRole());
            session.setAttribute("userEmail", savedUser.getEmail());
            
            if ("ADMIN".equals(savedUser.getRole())) {
                return "redirect:/admin-dashboard";
            } else {
                return "redirect:/participant/dashboard";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            List<UserTypeEntity> allUserType = userTypeRepository.findAll();
            model.addAttribute("allUserType", allUserType);
            return "Signup";
        }
    }

    @GetMapping("/forgetpassword")
    public String openForgetPassword() {
        return "ForgetPassword";
    }

    @PostMapping("/forgetpassword")
    public String processForgetPassword(@RequestParam String email, Model model) {
        Optional<UserEntity> user = userRepository.findByEmail(email);
        
        String token = "reset-token-" + System.currentTimeMillis();
        
        if (user.isPresent()) {
            user.get().setOtp(token);
            userRepository.save(user.get());
            // COMMENT OUT THIS LINE
            // mailerService.sendPasswordResetMail(email, token);
        }
        
        model.addAttribute("successMessage", 
            "If an account exists with this email, you will receive password reset instructions shortly.");
        
        return "ForgetPassword";
    }

    // REMOVED: Duplicate admin profile method - this is now handled by AdminController
    
    // Admin Mail
    @GetMapping("/admin/mail")
    public String adminMail(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "AdminMail";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    // User Profile (for participants)
    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        Optional<UserEntity> user = userRepository.findById(userId);
        Optional<UserDetailEntity> userDetail = userDetailRepository.findByUserId(userId);
        
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
            model.addAttribute("userDetail", userDetail.orElse(null));
            return "Profile";
        }
        
        return "redirect:/dashboard";
    }
}