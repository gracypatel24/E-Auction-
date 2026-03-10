package com.grownited.eauction.controller;

import java.util.List;
import java.util.Optional;  // MISSING IMPORT

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.UserDetailEntity;  // MISSING IMPORT
import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;
import com.grownited.eauction.repository.UserDetailRepository;  // MISSING IMPORT

import jakarta.servlet.http.HttpSession;

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
    
    @Autowired
    private UserDetailRepository userDetailRepository;  // MISSING AUTOWIRED

    @GetMapping("/admin-dashboard")
    public String dashboard(Model model) {
        
        // Get real data from database
        long totalUsers = userRepository.count();
        long totalCategories = categoryRepository.count();
        long totalProducts = productRepository.count();
        long totalUserTypes = userTypeRepository.count();
        
        // Get active auctions count
        List<ProductEntity> activeAuctionsList = productRepository.findActiveAuctions();
        long activeAuctions = activeAuctionsList.size();
        
        // Get recent auctions (last 5)
        List<ProductEntity> allAuctions = productRepository.findAll();
        List<ProductEntity> recentAuctions = allAuctions.stream()
                .sorted((a1, a2) -> a2.getCreatedAt().compareTo(a1.getCreatedAt()))
                .limit(5)
                .toList();
        
        // Get recent users (last 5)
        List<UserEntity> allUsers = userRepository.findAll();
        List<UserEntity> recentUsers = allUsers.stream()
                .sorted((u1, u2) -> u2.getCreatedAt().compareTo(u1.getCreatedAt()))
                .limit(5)
                .toList();
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalCategories", totalCategories);
        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalUserTypes", totalUserTypes);
        model.addAttribute("activeAuctions", activeAuctions);
        model.addAttribute("recentAuctions", recentAuctions);
        model.addAttribute("recentUsers", recentUsers);
        
        return "AdminDashboard";
    }
    
    @GetMapping("/admin/profile")
    public String adminProfile(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        Optional<UserEntity> user = userRepository.findById(userId);
        Optional<UserDetailEntity> userDetail = userDetailRepository.findByUserId(userId);
        
        if (user.isPresent()) {
            model.addAttribute("user", user.get());
            model.addAttribute("userDetail", userDetail.orElse(null));
            return "AdminProfile";
        }
        
        return "redirect:/admin-dashboard";
    }
}