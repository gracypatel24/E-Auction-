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

                if ("ADMIN".equals(dbUser.getRole())) {
                    return "redirect:/admin-dashboard";
                } else {
                    return "redirect:/participant/participant-dashboard";
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
            // Check if email exists
            Optional<UserEntity> existingUser = userRepository.findByEmail(email);
            if (existingUser.isPresent()) {
                model.addAttribute("error", "Email already registered");
                List<UserTypeEntity> allUserType = userTypeRepository.findAll();
                model.addAttribute("allUserType", allUserType);
                return "Signup";
            }
            
            // Create user
            UserEntity user = new UserEntity();
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPassword(passwordEncoder.encode(password));
            user.setContactNum(contactNum);
            user.setBirthYear(birthYear);
            user.setGender(gender);
            
            // Set role based on userTypeId
            if (userTypeId == 1) {
                user.setRole("ADMIN");
            } else {
                user.setRole("PARTICIPANT");
            }
            
            user.setActive(true);
            user.setCreatedAt(LocalDate.now());
            
            UserEntity savedUser = userRepository.save(user);
            
            // Create user details
            UserDetailEntity userDetail = new UserDetailEntity();
            userDetail.setUserId(savedUser.getUserId());
            userDetail.setCity(city);
            userDetail.setState(state);
            userDetail.setCountry(country != null ? country : "India");
            userDetail.setUserTypeId(userTypeId);
            
            userDetailRepository.save(userDetail);
            
            // Auto login
            session.setAttribute("user", savedUser);
            session.setAttribute("userId", savedUser.getUserId());
            session.setAttribute("userRole", savedUser.getRole());
            
            if ("ADMIN".equals(savedUser.getRole())) {
                return "redirect:/admin-dashboard";
            } else {
                return "redirect:/participant/participant-dashboard";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            List<UserTypeEntity> allUserType = userTypeRepository.findAll();
            model.addAttribute("allUserType", allUserType);
            return "Signup";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}