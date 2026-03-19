package com.grownited.eauction.controller.user;

import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.BidRepository;
import com.grownited.eauction.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "dashboard");
        model.addAttribute("pageTitle", "Dashboard");
        model.addAttribute("user", user);
        
        Integer userId = user.getUserId();
        
        // Check if these repository methods exist, otherwise use alternatives
        try {
            model.addAttribute("totalBids", bidRepository.countByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("totalBids", 0);
        }
        
        try {
            model.addAttribute("wonAuctions", bidRepository.countWonByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("wonAuctions", 0);
        }
        
        model.addAttribute("watchlistCount", 0);
        
        try {
            model.addAttribute("activeBids", bidRepository.countActiveByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("activeBids", 0);
        }
        
        try {
            model.addAttribute("recommendedAuctions", productRepository.findActiveAuctions(LocalDateTime.now()));
        } catch (Exception e) {
            model.addAttribute("recommendedAuctions", List.of());
        }
        
        try {
            model.addAttribute("recentBids", bidRepository.findRecentByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("recentBids", List.of());
        }
        
        return "user/UserDashboard";
    }
    
    @GetMapping("/active-auctions")
    public String activeAuctions(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        model.addAttribute("page", "active");
        model.addAttribute("pageTitle", "Active Auctions");
        
        try {
            model.addAttribute("products", productRepository.findActiveAuctions(LocalDateTime.now()));
        } catch (Exception e) {
            model.addAttribute("products", List.of());
        }
        
        try {
            model.addAttribute("categories", categoryRepository.findAll());
        } catch (Exception e) {
            model.addAttribute("categories", List.of());
        }
        
        return "user/ActiveAuctions";
    }
    
    @GetMapping("/my-bids")
    public String myBids(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        model.addAttribute("page", "mybids");
        model.addAttribute("pageTitle", "My Bids");
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        try {
            model.addAttribute("myBids", bidRepository.findByUserIdWithDetails(userId));
        } catch (Exception e) {
            model.addAttribute("myBids", List.of());
        }
        
        return "user/MyBids";
    }
    
    @GetMapping("/won-auctions")
    public String wonAuctions(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        model.addAttribute("page", "won");
        model.addAttribute("pageTitle", "Won Auctions");
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        Integer userId = user.getUserId();
        
        try {
            model.addAttribute("wonAuctions", bidRepository.findWonByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("wonAuctions", List.of());
        }
        
        try {
            model.addAttribute("wonCount", bidRepository.countWonByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("wonCount", 0);
        }
        
        try {
            model.addAttribute("totalSpent", bidRepository.totalSpentByUserId(userId));
        } catch (Exception e) {
            model.addAttribute("totalSpent", 0.0);
        }
        
        return "user/WonAuctions";
    }
    
    @GetMapping("/watchlist")
    public String watchlist(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        model.addAttribute("page", "watchlist");
        model.addAttribute("pageTitle", "My Watchlist");
        // Add empty list for watchlist
        model.addAttribute("watchlist", List.of());
        return "user/Watchlist";
    }
    
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        model.addAttribute("page", "profile");
        model.addAttribute("pageTitle", "My Profile");
        
        UserEntity sessionUser = (UserEntity) session.getAttribute("user");
        Optional<UserEntity> userOpt = userRepository.findById(sessionUser.getUserId());
        
        if (userOpt.isPresent()) {
            model.addAttribute("user", userOpt.get());
        } else {
            model.addAttribute("user", sessionUser);
        }
        
        return "user/Profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(value = "firstName", required = false) String firstName,
                                @RequestParam(value = "lastName", required = false) String lastName,
                                @RequestParam(value = "contactNum", required = false) String contactNum,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            UserEntity sessionUser = (UserEntity) session.getAttribute("user");
            Optional<UserEntity> userOpt = userRepository.findById(sessionUser.getUserId());
            
            if (userOpt.isPresent()) {
                UserEntity user = userOpt.get();
                
                if (firstName != null && !firstName.trim().isEmpty()) {
                    user.setFirstName(firstName.trim());
                }
                if (lastName != null && !lastName.trim().isEmpty()) {
                    user.setLastName(lastName.trim());
                }
                if (contactNum != null && !contactNum.trim().isEmpty()) {
                    user.setPhone(contactNum.trim());
                }
                
                user.setUpdatedAt(LocalDateTime.now());
                UserEntity updatedUser = userRepository.save(user);
                session.setAttribute("user", updatedUser);
                redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "User not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating profile: " + e.getMessage());
        }
        
        return "redirect:/user/profile";
    }
    
    @GetMapping("/product/{productId}")
    public String viewProduct(@PathVariable Integer productId, HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        
        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            
            try {
                model.addAttribute("bids", bidRepository.findByProductIdWithUser(productId));
            } catch (Exception e) {
                model.addAttribute("bids", List.of());
            }
        } else {
            model.addAttribute("errorMessage", "Product not found!");
            return "redirect:/user/active-auctions";
        }
        
        return "user/ViewProduct";
    }
}