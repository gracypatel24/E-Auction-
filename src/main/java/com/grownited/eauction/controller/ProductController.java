package com.grownited.eauction.controller;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.repository.BidRepository;
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
public class ProductController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    // ========== LIST PRODUCTS (for Admin and Users) ==========
    @GetMapping("/listProduct")
    public String listProducts(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        String userRole = user.getUserType().getUserTypeName();
        
        // For admin, show all products
        if ("ADMIN".equalsIgnoreCase(userRole)) {
            model.addAttribute("products", productRepository.findAll());
            return "admin/ManageProducts";
        } 
        // For users/bidders, show all active products (using existing method from UserController)
        else {
            model.addAttribute("products", productRepository.findActiveAuctions(LocalDateTime.now()));
            return "user/ActiveAuctions";
        }
    }
    
    // ========== SHOW ADD PRODUCT FORM ==========
    @GetMapping("/newProduct")
    public String showAddForm(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        
        // Only allow ADMIN and SELLER to add products
        String userRole = user.getUserType().getUserTypeName();
        if (!"ADMIN".equalsIgnoreCase(userRole) && !"SELLER".equalsIgnoreCase(userRole)) {
            return "redirect:/user/dashboard";
        }
        
        model.addAttribute("pageTitle", "Add Product");
        model.addAttribute("product", new ProductEntity());
        
        // Get categories for dropdown
        List<CategoryEntity> categories = categoryRepository.findAll();
        model.addAttribute("categories", categories);
        
        return "product/AddProduct";
    }
    
    // ========== SAVE PRODUCT ==========
    @PostMapping("/saveProduct")
    public String saveProduct(@ModelAttribute ProductEntity product,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            UserEntity seller = (UserEntity) session.getAttribute("user");
            String userRole = seller.getUserType().getUserTypeName();
            
            // Set seller information
            product.setSeller(seller);
            product.setSellerId(seller.getUserId());
            
            // Set timestamps
            product.setCreatedAt(LocalDateTime.now());
            product.setUpdatedAt(LocalDateTime.now());
            
            // Initialize counters
            product.setBidCount(0);
            product.setViewCount(0);
            
            // Set default status if not provided
            if (product.getStatus() == null || product.getStatus().isEmpty()) {
                product.setStatus("ACTIVE");
            }
            
            // Set current bid to starting price initially
            if (product.getCurrentBid() == null) {
                product.setCurrentBid(product.getStartingPrice());
            }
            
            productRepository.save(product);
            
            redirectAttributes.addFlashAttribute("success", "Product added successfully!");
            
            // Redirect based on user role
            if ("SELLER".equalsIgnoreCase(userRole)) {
                return "redirect:/seller/products";
            } else {
                return "redirect:/listProduct";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error adding product: " + e.getMessage());
            return "redirect:/newProduct";
        }
    }
    
    // ========== VIEW PRODUCT ==========
    @GetMapping("/viewProduct")
    public String viewProduct(@RequestParam("productId") Integer id, 
                              HttpSession session, 
                              Model model, 
                              RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(id);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            
            // Increment view count
            product.setViewCount(product.getViewCount() + 1);
            productRepository.save(product);
            
            model.addAttribute("product", product);
            
            // Get bids for this product
            model.addAttribute("bids", bidRepository.findByProductIdWithUser(id));
            
            // Determine which view to return based on user role
            UserEntity user = (UserEntity) session.getAttribute("user");
            String userRole = user.getUserType().getUserTypeName();
            
            if ("ADMIN".equalsIgnoreCase(userRole)) {
                return "admin/ViewProduct";
            } else if ("SELLER".equalsIgnoreCase(userRole)) {
                return "seller/ViewProduct";
            } else {
                return "user/ViewProduct";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found!");
            return "redirect:/listProduct";
        }
    }
    
    // ========== EDIT PRODUCT FORM ==========
    @GetMapping("/editProduct")
    public String showEditForm(@RequestParam("productId") Integer id, 
                               HttpSession session, 
                               Model model, 
                               RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> productOpt = productRepository.findById(id);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            
            // Check if user has permission to edit (admin or owner)
            UserEntity user = (UserEntity) session.getAttribute("user");
            if (!"ADMIN".equalsIgnoreCase(user.getUserType().getUserTypeName()) && 
                !product.getSellerId().equals(user.getUserId())) {
                redirectAttributes.addFlashAttribute("error", "You don't have permission to edit this product!");
                
                String userRole = user.getUserType().getUserTypeName();
                if ("SELLER".equalsIgnoreCase(userRole)) {
                    return "redirect:/seller/products";
                } else {
                    return "redirect:/listProduct";
                }
            }
            
            model.addAttribute("pageTitle", "Edit Product");
            model.addAttribute("product", product);
            model.addAttribute("categories", categoryRepository.findAll());
            
            return "product/AddProduct"; // Reuse the same form for editing
        } else {
            redirectAttributes.addFlashAttribute("error", "Product not found!");
            return "redirect:/listProduct";
        }
    }
    
    // ========== UPDATE PRODUCT ==========
    @PostMapping("/updateProduct")
    public String updateProduct(@ModelAttribute ProductEntity product,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<ProductEntity> existingProductOpt = productRepository.findById(product.getProductId());
            
            if (existingProductOpt.isPresent()) {
                ProductEntity existingProduct = existingProductOpt.get();
                
                // Check permission
                UserEntity user = (UserEntity) session.getAttribute("user");
                if (!"ADMIN".equalsIgnoreCase(user.getUserType().getUserTypeName()) && 
                    !existingProduct.getSellerId().equals(user.getUserId())) {
                    redirectAttributes.addFlashAttribute("error", "You don't have permission to update this product!");
                    
                    String userRole = user.getUserType().getUserTypeName();
                    if ("SELLER".equalsIgnoreCase(userRole)) {
                        return "redirect:/seller/products";
                    } else {
                        return "redirect:/listProduct";
                    }
                }
                
                // Update fields
                existingProduct.setProductName(product.getProductName());
                existingProduct.setDescription(product.getDescription());
                existingProduct.setCategory(product.getCategory());
                existingProduct.setSubcategory(product.getSubcategory());
                existingProduct.setStartingPrice(product.getStartingPrice());
                existingProduct.setBuyNowPrice(product.getBuyNowPrice());
                existingProduct.setAuctionEndDate(product.getAuctionEndDate());
                existingProduct.setMainImage(product.getMainImage());
                existingProduct.setImage1(product.getImage1());
                existingProduct.setImage2(product.getImage2());
                existingProduct.setImage3(product.getImage3());
                existingProduct.setStatus(product.getStatus());
                existingProduct.setUpdatedAt(LocalDateTime.now());
                
                productRepository.save(existingProduct);
                redirectAttributes.addFlashAttribute("success", "Product updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Product not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error updating product: " + e.getMessage());
        }
        
        // Redirect based on user role
        UserEntity user = (UserEntity) session.getAttribute("user");
        if ("SELLER".equalsIgnoreCase(user.getUserType().getUserTypeName())) {
            return "redirect:/seller/products";
        } else {
            return "redirect:/listProduct";
        }
    }
    
    // ========== DELETE PRODUCT ==========
    @GetMapping("/deleteProduct")
    public String deleteProduct(@RequestParam("productId") Integer id,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<ProductEntity> productOpt = productRepository.findById(id);
            
            if (productOpt.isPresent()) {
                ProductEntity product = productOpt.get();
                
                // Check permission
                UserEntity user = (UserEntity) session.getAttribute("user");
                if (!"ADMIN".equalsIgnoreCase(user.getUserType().getUserTypeName()) && 
                    !product.getSellerId().equals(user.getUserId())) {
                    redirectAttributes.addFlashAttribute("error", "You don't have permission to delete this product!");
                    
                    String userRole = user.getUserType().getUserTypeName();
                    if ("SELLER".equalsIgnoreCase(userRole)) {
                        return "redirect:/seller/products";
                    } else {
                        return "redirect:/listProduct";
                    }
                }
                
                // Check if product has bids
                Long bidCount = bidRepository.countByProductId(id);
                if (bidCount > 0) {
                    redirectAttributes.addFlashAttribute("error", "Cannot delete product with existing bids!");
                    
                    String userRole = user.getUserType().getUserTypeName();
                    if ("SELLER".equalsIgnoreCase(userRole)) {
                        return "redirect:/seller/products";
                    } else {
                        return "redirect:/listProduct";
                    }
                }
                
                productRepository.deleteById(id);
                redirectAttributes.addFlashAttribute("success", "Product deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Product not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error deleting product: " + e.getMessage());
        }
        
        // Redirect based on user role
        UserEntity user = (UserEntity) session.getAttribute("user");
        if ("SELLER".equalsIgnoreCase(user.getUserType().getUserTypeName())) {
            return "redirect:/seller/products";
        } else {
            return "redirect:/listProduct";
        }
    }
}