package com.grownited.eauction.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserDetailRepository userDetailRepository;

    @GetMapping("/listUser")
    public String listUser(Model model, HttpSession session) {
        // Check if user is logged in
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            // Get all users
            List<UserEntity> allUser = userRepository.findAll();
            model.addAttribute("userList", allUser);
            
            // Calculate statistics
            long totalUsers = allUser.size();
            long activeUsers = 0;
            long adminCount = 0;
            long participantCount = 0;
            
            for (UserEntity user : allUser) {
                if (user.getActive() != null && user.getActive()) {
                    activeUsers++;
                }
                if ("ADMIN".equals(user.getRole())) {
                    adminCount++;
                } else if ("PARTICIPANT".equals(user.getRole())) {
                    participantCount++;
                }
            }
            
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("activeUsers", activeUsers);
            model.addAttribute("adminCount", adminCount);
            model.addAttribute("participantCount", participantCount);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading users: " + e.getMessage());
        }
        
        return "ListUser";
    }

    @GetMapping("/viewUser")
    public String viewUser(@RequestParam("userId") Integer userId, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<UserEntity> opUser = userRepository.findById(userId);
            
            if (opUser.isPresent()) {
                UserEntity userEntity = opUser.get();
                model.addAttribute("user", userEntity);
                
                Optional<UserDetailEntity> opUserDetail = userDetailRepository.findByUserId(userId);
                if (opUserDetail.isPresent()) {
                    model.addAttribute("userDetail", opUserDetail.get());
                }
                
                return "ViewUser";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "redirect:/listUser";
    }
    
    @GetMapping("/editUser")
    public String editUser(@RequestParam("userId") Integer userId, Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<UserEntity> opUser = userRepository.findById(userId);
        Optional<UserDetailEntity> opUserDetail = userDetailRepository.findByUserId(userId);
        
        if (opUser.isPresent()) {
            model.addAttribute("user", opUser.get());
            model.addAttribute("userDetail", opUserDetail.orElse(new UserDetailEntity()));
            return "EditUser";
        }
        
        return "redirect:/listUser";
    }
    
    @PostMapping("/updateUser")
    public String updateUser(@RequestParam("userId") Integer userId,
                            @RequestParam("firstName") String firstName,
                            @RequestParam("lastName") String lastName,
                            @RequestParam("email") String email,
                            @RequestParam(value = "contactNum", required = false) String contactNum,
                            @RequestParam(value = "gender", required = false) String gender,
                            @RequestParam(value = "birthYear", required = false) Integer birthYear,
                            @RequestParam(value = "active", required = false) Boolean active,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<UserEntity> opUser = userRepository.findById(userId);
            if (opUser.isPresent()) {
                UserEntity user = opUser.get();
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setContactNum(contactNum);
                user.setGender(gender);
                user.setBirthYear(birthYear);
                user.setActive(active != null ? active : false);
                
                userRepository.save(user);
                redirectAttributes.addFlashAttribute("success", "User updated successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update user: " + e.getMessage());
        }
        
        return "redirect:/listUser";
    }
    
    @GetMapping("/toggleUserStatus")
    public String toggleUserStatus(@RequestParam("userId") Integer userId,
                                   @RequestParam("activate") Boolean activate,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<UserEntity> opUser = userRepository.findById(userId);
            if (opUser.isPresent()) {
                UserEntity user = opUser.get();
                user.setActive(activate);
                userRepository.save(user);
                
                String status = activate ? "activated" : "deactivated";
                redirectAttributes.addFlashAttribute("success", "User " + status + " successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update user status: " + e.getMessage());
        }
        
        return "redirect:/listUser";
    }
}