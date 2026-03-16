package com.grownited.eauction.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;

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

    @GetMapping("/login")
    public String login() {
        return "auth/login";
    }

    @GetMapping("/signup")
    public String signup(Model model) {
        List<UserTypeEntity> userTypes = userTypeRepository.findAll();
        model.addAttribute("allUserType", userTypes);
        return "auth/signup";
    }

    @PostMapping("/register")
    public String register(@RequestParam String firstName,
                          @RequestParam String lastName,
                          @RequestParam String email,
                          @RequestParam String password,
                          @RequestParam Integer userTypeId,
                          HttpSession session,
                          RedirectAttributes redirectAttributes,
                          Model model) {
        
        try {
            // Check if email exists
            if (userRepository.findByEmail(email).isPresent()) {
                model.addAttribute("error", "Email already exists");
                model.addAttribute("allUserType", userTypeRepository.findAll());
                return "auth/signup";
            }
            
            // Get UserType
            UserTypeEntity userType = userTypeRepository.findById(userTypeId)
                .orElseThrow(() -> new RuntimeException("User type not found"));
            
            // Create user
            UserEntity user = new UserEntity();
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(password));
            user.setUserType(userType);
            user.setIsActive(true);
            user.setCreatedAt(new Date());
            user.setUpdatedAt(new Date());
            
            UserEntity savedUser = userRepository.save(user);
            
            // Create user details
            UserDetailEntity userDetail = new UserDetailEntity();
            userDetail.setFirstName(firstName);
            userDetail.setLastName(lastName);
            userDetail.setUser(savedUser);
            userDetail.setCreatedAt(new Date());
            userDetail.setUpdatedAt(new Date());
            
            userDetailRepository.save(userDetail);
            
            // Auto login
            session.setAttribute("user", savedUser);
            session.setAttribute("userId", savedUser.getUserId());
            session.setAttribute("userType", savedUser.getUserType().getUserTypeName());
            
            redirectAttributes.addFlashAttribute("success", "Registration successful!");
            
            if ("ADMIN".equals(savedUser.getUserType().getUserTypeName())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/user/dashboard";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            model.addAttribute("allUserType", userTypeRepository.findAll());
            return "auth/signup";
        }
    }

    @PostMapping("/authenticate")
    public String authenticate(@RequestParam String email,
                              @RequestParam String password,
                              Model model,
                              HttpSession session) {
        
        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isPresent()) {
            UserEntity user = userOpt.get();
            
            if (passwordEncoder.matches(password, user.getPassword())) {
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userType", user.getUserType().getUserTypeName());
                
                if ("ADMIN".equals(user.getUserType().getUserTypeName())) {
                    return "redirect:/admin/dashboard";
                } else {
                    return "redirect:/user/dashboard";
                }
            }
        }
        
        model.addAttribute("error", "Invalid email or password");
        return "auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}