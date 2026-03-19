package com.grownited.eauction.controller;

import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.services.AuctionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/bid")
public class BidController {
    
    @Autowired
    private AuctionService auctionService;
    
    @PostMapping("/place/{productId}")
    public String placeBid(@PathVariable Integer productId,
                          @RequestParam Double amount,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        if (user == null) {
            return "redirect:/auth/login";
        }
        
        try {
            auctionService.placeBid(productId, user, amount);
            redirectAttributes.addFlashAttribute("success", "Bid placed successfully!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        
        return "redirect:/product/view/" + productId;
    }
}