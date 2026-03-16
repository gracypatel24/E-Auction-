package com.grownited.eauction.controller.user;

import com.grownited.eauction.entity.*;
import com.grownited.eauction.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserDetailRepository userDetailRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        UserEntity user = userRepository.findByEmail(email).orElse(null);
        
        if (user != null) {
            model.addAttribute("myBids", bidRepository.findByUserOrderByBidTimeDesc(user).size());
            model.addAttribute("recentBids", bidRepository.findByUserOrderByBidTimeDesc(user).stream().limit(5).toList());
        }
        return "user/dashboard";
    }
    
    @GetMapping("/profile")
    public String profile(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        UserEntity user = userRepository.findByEmail(email).orElse(null);
        
        if (user != null) {
            UserDetailEntity userDetail = userDetailRepository.findByUser(user).orElse(new UserDetailEntity());
            model.addAttribute("user", user);
            model.addAttribute("userDetail", userDetail);
        }
        return "user/profile";
    }
    
    @GetMapping("/profile/edit")
    public String editProfile(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        UserEntity user = userRepository.findByEmail(email).orElse(null);
        
        if (user != null) {
            UserDetailEntity userDetail = userDetailRepository.findByUser(user).orElse(new UserDetailEntity());
            userDetail.setUser(user);
            model.addAttribute("userDetail", userDetail);
        }
        return "user/edit-profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute UserDetailEntity userDetail, RedirectAttributes ra) {
        userDetailRepository.save(userDetail);
        ra.addFlashAttribute("message", "Profile updated successfully");
        return "redirect:/user/profile";
    }
    
    @GetMapping("/my-bids")
    public String myBids(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        UserEntity user = userRepository.findByEmail(email).orElse(null);
        
        if (user != null) {
            model.addAttribute("bids", bidRepository.findByUserOrderByBidTimeDesc(user));
        }
        return "user/my-bids";
    }
}