package com.grownited.eauction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;

@Controller
public class AdminController {

    @Autowired
    UserRepository userRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    UserTypeRepository userTypeRepository;

    @GetMapping("/admin-dashboard")
    public String dashboard(Model model) {

        // Real data from database
        long totalUsers      = userRepository.count();
        long totalCategories = categoryRepository.count();
        long totalUserTypes  = userTypeRepository.count();

        model.addAttribute("totalUsers",      totalUsers);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalUserTypes",  totalUserTypes);
        model.addAttribute("name", "Gracy Patel");

        return "AdminDashboard";
    }
}