package com.grownited.eauction.controller;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
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
    
    @Autowired(required = false)
    private MailerService mailerService;
    
    // Admin authentication check
    private boolean isAdmin(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && "ADMIN".equalsIgnoreCase(user.getUserType().getUserTypeName());
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Admin Dashboard");
        model.addAttribute("page", "dashboard");
        
        // Statistics
        model.addAttribute("totalUsers", userRepository.count());
        model.addAttribute("totalSellers", userRepository.countByUserType("SELLER"));
        model.addAttribute("totalBuyers", userRepository.countByUserType("USER"));
        model.addAttribute("pendingProducts", productRepository.countPendingProducts());
        model.addAttribute("activeAuctions", productRepository.countActiveProducts());
        model.addAttribute("soldProducts", productRepository.countSoldProducts());
        model.addAttribute("totalProducts", productRepository.count());
        
        // Recent products
        model.addAttribute("recentProducts", productRepository.findPendingProducts());
        
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
        
        // Statistics for cards
        model.addAttribute("pendingCount", productRepository.countPendingProducts());
        model.addAttribute("activeCount", productRepository.countActiveProducts());
        model.addAttribute("soldCount", productRepository.countSoldProducts());
        model.addAttribute("totalCount", productRepository.count());
        
        return "product/ManageProducts";
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
        
        return "redirect:/products";
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
            
            // Send notification email
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
        
        return "redirect:/products?status=PENDING";
    }
    
    @PostMapping("/product/reject/{id}")
    public String rejectProduct(@PathVariable Integer id,
                                @RequestParam String reason,
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
            
            // Send rejection email
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
        
        List<UserEntity> users;
        if (role == null || role.isEmpty()) {
            users = userRepository.findAll();
        } else {
            users = userRepository.findByUserType(role.toUpperCase());
        }
        
        model.addAttribute("users", users);
        model.addAttribute("currentRole", role);
        
        return "admin/ManageUsers";
    }
    
    @GetMapping("/categories")
    public String manageCategories(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("pageTitle", "Manage Categories");
        model.addAttribute("page", "categories");
        model.addAttribute("categories", categoryRepository.findAll());
        
        return "admin/ManageCategories";
    }
}