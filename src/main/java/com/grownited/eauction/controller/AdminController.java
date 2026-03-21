package com.grownited.eauction.controller;

import com.grownited.eauction.entity.BidEntity;
import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.BidRepository;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.services.MailerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private BidRepository bidRepository;  // ADD THIS
    
    @Autowired(required = false)
    private MailerService mailerService;
    
    // Admin authentication check
    private boolean isAdmin(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && user.getUserType() != null && 
               "ADMIN".equalsIgnoreCase(user.getUserType().getUserTypeName());
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Admin Dashboard");
        model.addAttribute("page", "dashboard");
        
        // Statistics
        try {
            model.addAttribute("totalUsers", userRepository.count());
        } catch (Exception e) {
            model.addAttribute("totalUsers", 0L);
        }
        
        try {
            model.addAttribute("totalSellers", userRepository.countByRole("SELLER"));
        } catch (Exception e) {
            model.addAttribute("totalSellers", 0L);
        }
        
        try {
            model.addAttribute("totalBuyers", userRepository.countByRole("USER"));
        } catch (Exception e) {
            model.addAttribute("totalBuyers", 0L);
        }
        
        try {
            model.addAttribute("pendingProducts", productRepository.countPendingProducts());
        } catch (Exception e) {
            model.addAttribute("pendingProducts", 0L);
        }
        
        try {
            model.addAttribute("activeAuctions", productRepository.countActiveProducts());
        } catch (Exception e) {
            model.addAttribute("activeAuctions", 0L);
        }
        
        try {
            model.addAttribute("soldProducts", productRepository.countSoldProducts());
        } catch (Exception e) {
            model.addAttribute("soldProducts", 0L);
        }
        
        try {
            model.addAttribute("totalProducts", productRepository.count());
        } catch (Exception e) {
            model.addAttribute("totalProducts", 0L);
        }
        
        // Add bid statistics to dashboard
        try {
            model.addAttribute("totalBids", bidRepository.count());
        } catch (Exception e) {
            model.addAttribute("totalBids", 0L);
        }
        
        try {
            model.addAttribute("activeBids", bidRepository.countActiveBids());
        } catch (Exception e) {
            model.addAttribute("activeBids", 0L);
        }
        
        try {
            model.addAttribute("recentProducts", productRepository.findPendingProducts());
        } catch (Exception e) {
            model.addAttribute("recentProducts", List.of());
        }
        
        return "admin/AdminDashboard";
    }
    
    // ========== MANAGE PRODUCTS ==========
    @GetMapping("/products")
    public String manageProducts(@RequestParam(required = false) String status, 
                                 HttpSession session, 
                                 Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Manage Products");
        model.addAttribute("page", "products");
        
        try {
            List<ProductEntity> products;
            if (status == null || status.isEmpty()) {
                products = productRepository.findAll();
            } else if ("PENDING".equalsIgnoreCase(status)) {
                products = productRepository.findPendingProducts();
            } else if ("ACTIVE".equalsIgnoreCase(status)) {
                products = productRepository.findAllActiveProducts();
            } else if ("SOLD".equalsIgnoreCase(status)) {
                products = productRepository.findByStatus("SOLD");
            } else if ("REJECTED".equalsIgnoreCase(status)) {
                products = productRepository.findRejectedProducts();
            } else {
                products = productRepository.findByStatus(status.toUpperCase());
            }
            
            model.addAttribute("products", products);
            model.addAttribute("currentStatus", status);
            
            try {
                model.addAttribute("pendingCount", productRepository.countPendingProducts());
            } catch (Exception e) {
                model.addAttribute("pendingCount", 0L);
            }
            
            try {
                model.addAttribute("activeCount", productRepository.countActiveProducts());
            } catch (Exception e) {
                model.addAttribute("activeCount", 0L);
            }
            
            try {
                model.addAttribute("soldCount", productRepository.countSoldProducts());
            } catch (Exception e) {
                model.addAttribute("soldCount", 0L);
            }
            
            try {
                model.addAttribute("totalCount", productRepository.count());
            } catch (Exception e) {
                model.addAttribute("totalCount", 0L);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("products", List.of());
            model.addAttribute("currentStatus", status);
            model.addAttribute("pendingCount", 0L);
            model.addAttribute("activeCount", 0L);
            model.addAttribute("soldCount", 0L);
            model.addAttribute("totalCount", 0L);
        }
        
        return "admin/ManageProducts";
    }
    
    @GetMapping("/product/{id}")
    public String viewProduct(@PathVariable Integer id, HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(id);
        if (productOpt.isPresent()) {
            model.addAttribute("product", productOpt.get());
            model.addAttribute("pageTitle", "View Product: " + productOpt.get().getProductName());
            model.addAttribute("page", "products");
            return "admin/ViewProduct";
        }
        
        return "redirect:/admin/products";
    }
    
    @PostMapping("/product/approve/{id}")
    public String approveProduct(@PathVariable Integer id, 
                                 HttpSession session, 
                                 RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(id);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            product.setStatus("ACTIVE");
            product.setUpdatedAt(LocalDateTime.now());
            productRepository.save(product);
            
            try {
                if (mailerService != null && product.getSeller() != null) {
                    mailerService.sendProductApprovalNotification(product);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            redirectAttributes.addFlashAttribute("successMessage", "Product approved successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
        }
        
        return "redirect:/admin/products?status=PENDING";
    }
    
    @PostMapping("/product/reject/{id}")
    public String rejectProduct(@PathVariable Integer id,
                                @RequestParam(required = false, defaultValue = "Not specified") String reason,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(id);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            product.setStatus("REJECTED");
            product.setUpdatedAt(LocalDateTime.now());
            productRepository.save(product);
            
            try {
                if (mailerService != null && product.getSeller() != null) {
                    mailerService.sendProductRejectionNotification(product, reason);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            redirectAttributes.addFlashAttribute("successMessage", "Product rejected successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
        }
        
        return "redirect:/admin/products?status=PENDING";
    }
    
    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable Integer id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        try {
            productRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting product: " + e.getMessage());
        }
        
        return "redirect:/admin/products";
    }
    
    // ========== MANAGE USERS ==========
    @GetMapping("/users")
    public String manageUsers(@RequestParam(required = false) String role,
                              HttpSession session,
                              Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Manage Users");
        model.addAttribute("page", "users");
        
        try {
            List<UserEntity> users;
            if (role == null || role.isEmpty()) {
                users = userRepository.findAll();
            } else {
                users = userRepository.findByUserType(role.toUpperCase());
            }
            
            model.addAttribute("users", users);
            model.addAttribute("currentRole", role);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("users", List.of());
            model.addAttribute("currentRole", role);
        }
        
        return "admin/ManageUsers";
    }
    
    // ========== CATEGORIES ==========
    @GetMapping("/categories")
    public String manageCategories(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Manage Categories");
        model.addAttribute("page", "categories");
        
        try {
            model.addAttribute("categories", categoryRepository.findAll());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("categories", List.of());
        }
        
        return "admin/ManageCategories";
    }
    
    // ========== ALL BIDS PAGE ==========
    @GetMapping("/bids")
    public String allBids(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "All Bids");
        model.addAttribute("page", "bids");
        
        try {
            // Get all bids ordered by time
            List<BidEntity> bids = bidRepository.findAllByOrderByBidTimeDesc();
            model.addAttribute("bids", bids);
            
            // Add statistics
            model.addAttribute("totalBids", bidRepository.count());
            model.addAttribute("activeBids", bidRepository.countActiveBids());
            model.addAttribute("totalBidAmount", bidRepository.sumAllBids());
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("bids", List.of());
            model.addAttribute("totalBids", 0L);
            model.addAttribute("activeBids", 0L);
            model.addAttribute("totalBidAmount", 0.0);
        }
        
        return "admin/AllBids";
    }
    
    // ========== PAYMENTS PAGE ==========
    @GetMapping("/payments")
    public String payments(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Payments");
        model.addAttribute("page", "payments");
        
        try {
            // You'll need a PaymentRepository for this
            // For now, using placeholder data
            model.addAttribute("payments", List.of());
            model.addAttribute("totalPayments", 0L);
            model.addAttribute("totalRevenue", 0.0);
            model.addAttribute("pendingPayments", 0L);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("payments", List.of());
            model.addAttribute("totalPayments", 0L);
            model.addAttribute("totalRevenue", 0.0);
            model.addAttribute("pendingPayments", 0L);
        }
        
        return "ChargeCreditCard";
    }
 // ========== ADMIN PROFILE PAGE ==========
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "My Profile");
        model.addAttribute("page", "profile");
        
        try {
            UserEntity sessionUser = (UserEntity) session.getAttribute("user");
            Optional<UserEntity> userOpt = userRepository.findById(sessionUser.getUserId());
            
            if (userOpt.isPresent()) {
                model.addAttribute("user", userOpt.get());
            } else {
                model.addAttribute("user", sessionUser);
            }
            
            // You can also add user details if you have a UserDetailRepository
            // Optional<UserDetailEntity> detailOpt = userDetailRepository.findByUser(sessionUser);
            // detailOpt.ifPresent(detail -> model.addAttribute("userDetail", detail));
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("user", session.getAttribute("user"));
        }
        
        return "admin/AdminProfile";  // This will look for /WEB-INF/views/admin/Profile.jsp
    }

 // ========== UPDATE ADMIN PROFILE ==========
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(value = "firstName", required = false) String firstName,
                               @RequestParam(value = "lastName", required = false) String lastName,
                               @RequestParam(value = "phone", required = false) String phone,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
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
                if (phone != null && !phone.trim().isEmpty()) {
                    user.setPhone(phone.trim());
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
        
        return "redirect:/admin/profile";  // Fixed: was redirecting to AdminProfile instead of profile
    }
}