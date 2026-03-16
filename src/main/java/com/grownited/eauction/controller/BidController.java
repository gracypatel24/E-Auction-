package com.grownited.eauction.controller;

import com.grownited.eauction.entity.*;
import com.grownited.eauction.repository.*;
import com.grownited.eauction.services.AuctionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.math.BigDecimal;

@Controller
@RequestMapping("/bid")
public class BidController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private AuctionService auctionService;
    
    @PostMapping("/place")
    public String placeBid(@RequestParam Integer productId,
                           @RequestParam BigDecimal bidAmount,
                           RedirectAttributes ra) {
        
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String email = auth.getName();
            
            UserEntity user = userRepository.findByEmail(email).orElse(null);
            ProductEntity product = productRepository.findById(productId).orElse(null);
            
            if (user != null && product != null) {
                auctionService.placeBid(product, user, bidAmount);
                ra.addFlashAttribute("message", "Bid placed successfully!");
            }
        } catch (Exception e) {
            ra.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/product/view/" + productId;
    }
}