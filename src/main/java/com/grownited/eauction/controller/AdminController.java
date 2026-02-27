package com.grownited.eauction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;

@Controller
public class AdminController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private UserTypeRepository userTypeRepository;
    
    @Autowired
    private ProductRepository productRepository;

    @GetMapping("/admin-dashboard")
    public String dashboard(Model model) {
        
        // Get real data from database
        long totalUsers = userRepository.count();
        long totalCategories = categoryRepository.count();
        long totalProducts = productRepository.count();
        long totalUserTypes = userTypeRepository.count();
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalUserTypes", totalUserTypes);
        model.addAttribute("activeAuctions", 42); // You can calculate this based on your logic
        
        return "AdminDashboard";
    }
}
