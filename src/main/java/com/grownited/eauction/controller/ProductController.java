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
    
    @GetMapping("/listProduct")
    public String listProducts(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        String userRole = user.getUserType().getUserTypeName();
        
        if ("ADMIN".equalsIgnoreCase(userRole)) {
            model.addAttribute("products", productRepository.findAll());
            return "admin/ManageProducts";  // ✅ CHANGE THIS from "product/ManageProducts"
        } else {
            model.addAttribute("products", productRepository.findActiveAuctions(LocalDateTime.now()));
            return "user/ActiveAuctions";  // ✅ This is correct
        }
    }
    
    @GetMapping("/newProduct")
    public String showAddForm(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        String userRole = user.getUserType().getUserTypeName();
        
        if (!"ADMIN".equalsIgnoreCase(userRole) && !"SELLER".equalsIgnoreCase(userRole)) {
            return "redirect:/user/dashboard";
        }
        
        model.addAttribute("pageTitle", "Add Product");
        model.addAttribute("product", new ProductEntity());
        
        try {
            List<CategoryEntity> categories = categoryRepository.findAll();
            model.addAttribute("categories", categories);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("categories", List.of());
        }
        
        // Return seller view for sellers
        if ("SELLER".equalsIgnoreCase(userRole)) {
            return "product/AddProduct";  // or "seller/AddNewProduct" based on your file name
        } else {
            return "admin/AddProduct";
        }
    }
    
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
            
            product.setSeller(seller);
            product.setSellerId(seller.getUserId());
            product.setCreatedAt(LocalDateTime.now());
            product.setUpdatedAt(LocalDateTime.now());
            product.setBidCount(0);
            product.setViewCount(0);
            
            if (product.getStatus() == null || product.getStatus().isEmpty()) {
                product.setStatus("PENDING");
            }
            
            if (product.getCurrentBid() == null) {
                product.setCurrentBid(product.getStartingPrice());
            }
            
            productRepository.save(product);
            
            redirectAttributes.addFlashAttribute("successMessage", "Product added successfully!");
            
            if ("SELLER".equalsIgnoreCase(userRole)) {
                return "redirect:/seller/products";
            } else {
                return "redirect:/listProduct";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error adding product: " + e.getMessage());
            return "redirect:/newProduct";
        }
    }
    
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
            
            product.setViewCount(product.getViewCount() + 1);
            productRepository.save(product);
            
            model.addAttribute("product", product);
            
            try {
                model.addAttribute("bids", bidRepository.findByProductIdWithUser(id));
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("bids", List.of());
            }
            
            UserEntity user = (UserEntity) session.getAttribute("user");
            String userRole = user.getUserType().getUserTypeName();
            
            // ✅ THESE ARE ALREADY CORRECT
            if ("ADMIN".equalsIgnoreCase(userRole)) {
                return "admin/ViewProduct";     // ✅ Create this file in admin folder
            } else if ("SELLER".equalsIgnoreCase(userRole)) {
                return "seller/ViewProduct";    // ✅ Already exists
            } else {
                return "user/ViewProduct";      // ✅ Already exists
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
            return "redirect:/listProduct";
        }
    }
    
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
            
            UserEntity user = (UserEntity) session.getAttribute("user");
            String userRole = user.getUserType().getUserTypeName();
            
            if (!"ADMIN".equalsIgnoreCase(userRole) && 
                !product.getSellerId().equals(user.getUserId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "You don't have permission to edit this product!");
                
                if ("SELLER".equalsIgnoreCase(userRole)) {
                    return "redirect:/seller/products";
                } else {
                    return "redirect:/listProduct";
                }
            }
            
            model.addAttribute("pageTitle", "Edit Product");
            model.addAttribute("product", product);
            
            try {
                model.addAttribute("categories", categoryRepository.findAll());
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("categories", List.of());
            }
            
            return "product/EditProduct";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
            return "redirect:/listProduct";
        }
    }
    
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
                
                UserEntity user = (UserEntity) session.getAttribute("user");
                String userRole = user.getUserType().getUserTypeName();
                
                if (!"ADMIN".equalsIgnoreCase(userRole) && 
                    !existingProduct.getSellerId().equals(user.getUserId())) {
                    redirectAttributes.addFlashAttribute("errorMessage", "You don't have permission to update this product!");
                    
                    if ("SELLER".equalsIgnoreCase(userRole)) {
                        return "redirect:/seller/products";
                    } else {
                        return "redirect:/listProduct";
                    }
                }
                
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
                redirectAttributes.addFlashAttribute("successMessage", "Product updated successfully!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating product: " + e.getMessage());
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        if ("SELLER".equalsIgnoreCase(user.getUserType().getUserTypeName())) {
            return "redirect:/seller/products";
        } else {
            return "redirect:/listProduct";
        }
    }
    
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
                
                UserEntity user = (UserEntity) session.getAttribute("user");
                String userRole = user.getUserType().getUserTypeName();
                
                if (!"ADMIN".equalsIgnoreCase(userRole) && 
                    !product.getSellerId().equals(user.getUserId())) {
                    redirectAttributes.addFlashAttribute("errorMessage", "You don't have permission to delete this product!");
                    
                    if ("SELLER".equalsIgnoreCase(userRole)) {
                        return "redirect:/seller/products";
                    } else {
                        return "redirect:/listProduct";
                    }
                }
                
                Long bidCount = bidRepository.countByProductId(id);
                if (bidCount > 0) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Cannot delete product with existing bids!");
                    
                    if ("SELLER".equalsIgnoreCase(userRole)) {
                        return "redirect:/seller/products";
                    } else {
                        return "redirect:/listProduct";
                    }
                }
                
                productRepository.deleteById(id);
                redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Product not found!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting product: " + e.getMessage());
        }
        
        UserEntity user = (UserEntity) session.getAttribute("user");
        if ("SELLER".equalsIgnoreCase(user.getUserType().getUserTypeName())) {
            return "redirect:/seller/products";
        } else {
            return "redirect:/listProduct";
        }
    }
}