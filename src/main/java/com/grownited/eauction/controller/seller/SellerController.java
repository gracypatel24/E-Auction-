package com.grownited.eauction.controller.seller;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.BidRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.CategoryRepository;
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
@RequestMapping("/seller")
public class SellerController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    // Seller authentication check
    private boolean isSeller(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && "SELLER".equalsIgnoreCase(user.getUserType().getUserTypeName());
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("pageTitle", "Seller Dashboard");
        model.addAttribute("page", "dashboard");
        
        Integer userId = user.getUserId();
        
        // Add statistics with null checks
        try {
            model.addAttribute("totalProducts", productRepository.countBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("totalProducts", 0L);
        }
        
        try {
            model.addAttribute("activeAuctions", productRepository.countActiveBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("activeAuctions", 0L);
        }
        
        try {
            model.addAttribute("soldItems", productRepository.countSoldBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("soldItems", 0L);
        }
        
        try {
            model.addAttribute("totalEarnings", productRepository.totalEarningsBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("totalEarnings", 0.0);
        }
        
        try {
            model.addAttribute("recentActivities", bidRepository.findRecentBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("recentActivities", List.of());
        }
        
        return "seller/SellerDashboard";
    }
    
    // ========== MY PRODUCTS PAGE ==========
    @GetMapping("/products")
    public String products(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "products");
        model.addAttribute("pageTitle", "My Products");
        
        Integer userId = user.getUserId();
        List<ProductEntity> products = productRepository.findBySellerId(userId);
        model.addAttribute("products", products);
        
        return "seller/MyProducts";
    }
    
    // ========== ADD PRODUCT PAGE ==========
    @GetMapping("/products/add")
    public String addProductForm(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        model.addAttribute("page", "products");
        model.addAttribute("pageTitle", "Add New Product");
        model.addAttribute("product", new ProductEntity());
        model.addAttribute("categories", categoryRepository.findAll());
        
        return "seller/AddProduct";
    }
    
    @PostMapping("/products/add")
    public String addProduct(@ModelAttribute ProductEntity product,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        try {
            UserEntity seller = (UserEntity) session.getAttribute("user");
            
            product.setSeller(seller);
            product.setSellerId(seller.getUserId());
            product.setCreatedAt(LocalDateTime.now());
            product.setUpdatedAt(LocalDateTime.now());
            product.setCurrentBid(product.getStartingPrice());
            product.setBidCount(0);
            product.setViewCount(0);
            product.setStatus("PENDING");
            
            productRepository.save(product);
            
            redirectAttributes.addFlashAttribute("successMessage", "Product added successfully! It will be reviewed by admin.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error adding product: " + e.getMessage());
        }
        
        return "redirect:/seller/products";
    }
    
    // ========== EDIT PRODUCT ==========
    @GetMapping("/products/edit/{id}")
    public String editProductForm(@PathVariable Integer id, HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity seller = (UserEntity) session.getAttribute("user");
        Optional<ProductEntity> productOpt = productRepository.findById(id);
        
        if (productOpt.isPresent() && productOpt.get().getSellerId().equals(seller.getUserId())) {
            model.addAttribute("page", "products");
            model.addAttribute("pageTitle", "Edit Product");
            model.addAttribute("product", productOpt.get());
            model.addAttribute("categories", categoryRepository.findAll());
            return "seller/EditProduct";
        }
        
        return "redirect:/seller/products";
    }
    
    @PostMapping("/products/edit")
    public String editProduct(@ModelAttribute ProductEntity product,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        try {
            UserEntity seller = (UserEntity) session.getAttribute("user");
            Optional<ProductEntity> existingProductOpt = productRepository.findById(product.getProductId());
            
            if (existingProductOpt.isPresent() && existingProductOpt.get().getSellerId().equals(seller.getUserId())) {
                ProductEntity existingProduct = existingProductOpt.get();
                
                // Only allow editing if product is pending or rejected
                if ("PENDING".equals(existingProduct.getStatus()) || "REJECTED".equals(existingProduct.getStatus())) {
                    existingProduct.setProductName(product.getProductName());
                    existingProduct.setDescription(product.getDescription());
                    existingProduct.setCategory(product.getCategory());
                    existingProduct.setSubcategory(product.getSubcategory());
                    existingProduct.setStartingPrice(product.getStartingPrice());
                    existingProduct.setBuyNowPrice(product.getBuyNowPrice());
                    existingProduct.setAuctionEndDate(product.getAuctionEndDate());
                    existingProduct.setMainImage(product.getMainImage());
                    existingProduct.setUpdatedAt(LocalDateTime.now());
                    
                    productRepository.save(existingProduct);
                    redirectAttributes.addFlashAttribute("successMessage", "Product updated successfully!");
                } else {
                    redirectAttributes.addFlashAttribute("errorMessage", "Cannot edit product that is already " + existingProduct.getStatus());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating product: " + e.getMessage());
        }
        
        return "redirect:/seller/products";
    }
    
    // ========== ACTIVE AUCTIONS PAGE ==========
    @GetMapping("/active-auctions")
    public String activeAuctions(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "active");
        model.addAttribute("pageTitle", "Active Auctions");
        
        Integer userId = user.getUserId();
        List<ProductEntity> products = productRepository.findActiveBySellerId(userId);
        model.addAttribute("products", products);
        
        return "seller/ActiveAuctions";
    }
    
    // ========== SOLD ITEMS PAGE ==========
    @GetMapping("/sold-items")
    public String soldItems(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "sold");
        model.addAttribute("pageTitle", "Sold Items");
        
        Integer userId = user.getUserId();
        List<ProductEntity> products = productRepository.findSoldBySellerId(userId);
        model.addAttribute("products", products);
        
        return "seller/SoldItems";
    }
    
    // ========== BIDS RECEIVED PAGE ==========
    @GetMapping("/bids-received")
    public String bidsReceived(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "bids");
        model.addAttribute("pageTitle", "Bids Received");
        
        Integer userId = user.getUserId();
        
        try {
            model.addAttribute("bids", bidRepository.findBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("bids", List.of());
        }
        
        return "seller/BidsReceived";
    }
    
    // ========== EARNINGS PAGE ==========
    @GetMapping("/earnings")
    public String earnings(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "earnings");
        model.addAttribute("pageTitle", "Earnings");
        
        Integer userId = user.getUserId();
        
        try {
            model.addAttribute("earnings", productRepository.earningsBreakdownBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("earnings", List.of());
        }
        
        try {
            model.addAttribute("totalEarnings", productRepository.totalEarningsBySellerId(userId));
        } catch (Exception e) {
            model.addAttribute("totalEarnings", 0.0);
        }
        
        return "seller/Earnings";
    }
    
    // ========== PROFILE PAGE ==========
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        model.addAttribute("page", "profile");
        model.addAttribute("pageTitle", "My Profile");
        
        Optional<UserEntity> userOpt = userRepository.findById(user.getUserId());
        userOpt.ifPresent(value -> model.addAttribute("user", value));
        
        return "seller/Profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String firstName,
                                @RequestParam String lastName,
                                @RequestParam String phone,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        try {
            UserEntity sessionUser = (UserEntity) session.getAttribute("user");
            Optional<UserEntity> userOpt = userRepository.findById(sessionUser.getUserId());
            
            if (userOpt.isPresent()) {
                UserEntity user = userOpt.get();
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setPhone(phone);
                user.setUpdatedAt(LocalDateTime.now());
                
                userRepository.save(user);
                session.setAttribute("user", user);
                redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating profile: " + e.getMessage());
        }
        
        return "redirect:/seller/profile";
    }
}