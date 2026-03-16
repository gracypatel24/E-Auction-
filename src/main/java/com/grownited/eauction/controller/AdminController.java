package com.grownited.eauction.controller;

import com.grownited.eauction.entity.*;
import com.grownited.eauction.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalProducts", productRepository.count());
        model.addAttribute("totalCategories", categoryRepository.count());
        model.addAttribute("totalBids", bidRepository.count());
        return "admin/dashboard";
    }
    
    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userRepository.findAll());
        return "admin/users";
    }
    
    @GetMapping("/users/toggle/{id}")
    public String toggleUser(@PathVariable Integer id, RedirectAttributes ra) {
        UserEntity user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setIsActive(!user.getIsActive());
            userRepository.save(user);
            ra.addFlashAttribute("message", "User status updated successfully");
        }
        return "redirect:/admin/users";
    }
}