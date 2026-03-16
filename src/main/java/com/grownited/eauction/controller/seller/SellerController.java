package com.grownited.eauction.controller.seller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/seller")
public class SellerController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    /**
     * Check if user is seller
     */
    private boolean isSeller(HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("user");
        return user != null && "SELLER".equals(user.getRole());
    }
    
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        // Check if user is seller
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        // Get seller's products - using proper repository methods
        List<ProductEntity> allListings = productRepository.findBySellerId(user.getUserId());
        
        // Filter in Java instead of relying on repository methods that might not exist
        List<ProductEntity> activeListings = allListings.stream()
                .filter(p -> "ACTIVE".equals(p.getStatus()))
                .toList();
        
        List<ProductEntity> soldItems = allListings.stream()
                .filter(p -> "SOLD".equals(p.getStatus()))
                .toList();
        
        // Calculate stats
        double totalRevenue = soldItems.stream()
                .mapToDouble(ProductEntity::getCurrentBid)
                .sum();
        
        int totalBids = allListings.stream()
                .mapToInt(ProductEntity::getBidCount)
                .sum();
        
        model.addAttribute("activeListings", activeListings);
        model.addAttribute("soldItems", soldItems);
        model.addAttribute("allListings", allListings);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalSold", soldItems.size());
        model.addAttribute("totalActive", activeListings.size());
        model.addAttribute("totalListings", allListings.size());
        model.addAttribute("totalBids", totalBids);
        
        return "seller/dashboard";
    }
    
    @GetMapping("/listings")
    public String listings(Model model, HttpSession session) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        List<ProductEntity> listings = productRepository.findBySellerId(user.getUserId());
        
        model.addAttribute("listings", listings);
        return "seller/listings";
    }
    
    @GetMapping("/product/new")
    public String newProduct(Model model, HttpSession session) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        // Add categories for dropdown
        String[] categories = {"Electronics", "Fashion", "Vehicles", "Art", 
                               "Jewelry", "Collectibles", "Real Estate", "Sports"};
        model.addAttribute("categories", categories);
        
        return "seller/new-product";
    }
    
    @PostMapping("/product/save")
    public String saveProduct(
            @RequestParam String title,
            @RequestParam String description,
            @RequestParam Double startingBid,
            @RequestParam String category,
            @RequestParam(required = false) LocalDate endDate,
            @RequestParam(required = false) String imageUrl,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        try {
            ProductEntity product = new ProductEntity();
            product.setTitle(title);
            product.setDescription(description);
            product.setStartingBid(startingBid);
            product.setCurrentBid(startingBid);
            product.setCategory(category);
            product.setSellerId(user.getUserId());
            product.setStatus("ACTIVE");
            product.setCreatedAt(LocalDateTime.now());
            
            // Set end date (default 7 days from now if not provided)
            if (endDate != null) {
                product.setEndDate(endDate);
            } else {
                product.setEndDate(LocalDate.now().plusDays(7));
            }
            
            // Set image URL or default
            if (imageUrl != null && !imageUrl.isEmpty()) {
                product.setImageUrl(imageUrl);
            } else {
                product.setImageUrl("https://via.placeholder.com/300x200/667eea/ffffff?text=" + 
                                   title.substring(0, 1).toUpperCase());
            }
            
            product.setBidCount(0);
            product.setMinBidIncrement(10.0);
            
            productRepository.save(product);
            
            redirectAttributes.addFlashAttribute("success", "Product listed successfully!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to create product: " + e.getMessage());
        }
        
        return "redirect:/seller/listings";
    }
    
    @GetMapping("/product/edit")
    public String editProduct(@RequestParam("id") Integer productId, 
                              Model model, 
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        Optional<ProductEntity> product = productRepository.findById(productId);
        
        if (product.isPresent() && product.get().getSellerId().equals(user.getUserId())) {
            String[] categories = {"Electronics", "Fashion", "Vehicles", "Art", 
                                   "Jewelry", "Collectibles", "Real Estate", "Sports"};
            model.addAttribute("categories", categories);
            model.addAttribute("product", product.get());
            return "seller/edit-product";
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found or you don't have permission!");
            return "redirect:/seller/listings";
        }
    }
    
    @PostMapping("/product/update")
    public String updateProduct(
            @RequestParam Integer productId,
            @RequestParam String title,
            @RequestParam String description,
            @RequestParam Double startingBid,
            @RequestParam String category,
            @RequestParam(required = false) LocalDate endDate,
            @RequestParam(required = false) String imageUrl,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        try {
            Optional<ProductEntity> optProduct = productRepository.findById(productId);
            
            if (optProduct.isPresent() && optProduct.get().getSellerId().equals(user.getUserId())) {
                ProductEntity product = optProduct.get();
                product.setTitle(title);
                product.setDescription(description);
                product.setStartingBid(startingBid);
                product.setCategory(category);
                
                if (endDate != null) {
                    product.setEndDate(endDate);
                }
                
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    product.setImageUrl(imageUrl);
                }
                
                productRepository.save(product);
                
                redirectAttributes.addFlashAttribute("success", "Product updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Product not found!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to update product!");
        }
        
        return "redirect:/seller/listings";
    }
    
    @GetMapping("/product/delete")
    public String deleteProduct(@RequestParam("id") Integer productId,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        try {
            Optional<ProductEntity> product = productRepository.findById(productId);
            
            if (product.isPresent() && product.get().getSellerId().equals(user.getUserId())) {
                productRepository.deleteById(productId);
                redirectAttributes.addFlashAttribute("success", "Product deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Product not found or you don't have permission!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to delete product: " + e.getMessage());
        }
        
        return "redirect:/seller/listings";
    }
    
    @GetMapping("/sales")
    public String sales(Model model, HttpSession session) {
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        List<ProductEntity> allListings = productRepository.findBySellerId(user.getUserId());
        
        List<ProductEntity> soldItems = allListings.stream()
                .filter(p -> "SOLD".equals(p.getStatus()))
                .toList();
        
        double totalRevenue = soldItems.stream()
                .mapToDouble(ProductEntity::getCurrentBid)
                .sum();
        
        model.addAttribute("soldItems", soldItems);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("totalSold", soldItems.size());
        
        return "seller/sales";
    }
    
    @GetMapping("/product/view")
    public String viewProduct(@RequestParam("id") Integer productId,
                              Model model,
                              HttpSession session) {
        
        if (!isSeller(session)) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> product = productRepository.findById(productId);
        
        if (product.isPresent()) {
            model.addAttribute("product", product.get());
            return "seller/view-product";
        }
        
        return "redirect:/seller/listings";
    }
}