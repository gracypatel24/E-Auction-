package com.grownited.eauction.controller;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.Date;
import java.util.List;

@Controller
public class HomeController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @GetMapping("/")
    public String home(Model model) {
        List<ProductEntity> activeAuctions = productRepository.findActiveAuctions(new Date());
        List<CategoryEntity> categories = categoryRepository.findAll();
        
        model.addAttribute("products", activeAuctions.size() > 8 ? activeAuctions.subList(0, 8) : activeAuctions);
        model.addAttribute("categories", categories);
        model.addAttribute("totalAuctions", activeAuctions.size());
        return "index";
    }
    
    @GetMapping("/dashboard")
    public String dashboard() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().iterator().next().getAuthority();
        
        if (role.equals("ADMIN")) {
            return "redirect:/admin/dashboard";
        } else if (role.equals("SELLER")) {
            return "redirect:/product/list";
        } else {
            return "redirect:/user/dashboard";
        }
    }
}