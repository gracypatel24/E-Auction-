package com.grownited.eauction.controller;

import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserTypeRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
public class UserTypeController {
    
    @Autowired
    private UserTypeRepository userTypeRepository;
    
    @GetMapping("/newUserType")
    public String showNewForm(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        model.addAttribute("userType", new UserTypeEntity());
        return "admin/NewUserType";  // Points to /WEB-INF/views/admin/NewUserType.jsp
    }
    
    @PostMapping("/saveUserType")
    public String saveUserType(@ModelAttribute UserTypeEntity userType, 
                               HttpSession session,
                               RedirectAttributes ra) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        userType.setCreatedAt(LocalDateTime.now());
        userType.setUpdatedAt(LocalDateTime.now());
        userTypeRepository.save(userType);
        ra.addFlashAttribute("success", "User type saved successfully");
        return "redirect:/listUserType";
    }
    
    @GetMapping("/listUserType")
    public String listUserTypes(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        List<UserTypeEntity> userTypes = userTypeRepository.findAll();
        model.addAttribute("userTypes", userTypes);
        return "admin/ListUserTypes";  // You need to create this JSP
    }
    
    @GetMapping("/deleteUserType")
    public String deleteUserType(@RequestParam Integer id, 
                                 HttpSession session,
                                 RedirectAttributes ra) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            userTypeRepository.deleteById(id);
            ra.addFlashAttribute("success", "User type deleted successfully");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Cannot delete user type as it is being used");
        }
        return "redirect:/listUserType";
    }
}