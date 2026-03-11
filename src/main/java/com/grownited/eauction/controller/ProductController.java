package com.grownited.eauction.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.eauction.entity.BidEntity;
import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.repository.BidRepository;
import com.grownited.eauction.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private BidRepository bidRepository;

    @GetMapping("/newProduct")
    public String showAddAuctionForm(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        String[] categories = {"Electronics", "Fashion", "Vehicles", "Art", "Jewelry", "Collectibles", "Real Estate", "Sports", "Books", "Music", "Toys", "Other"};
        model.addAttribute("categories", categories);
        
        return "NewProduct";
    }

    @PostMapping("/saveProduct")
    public String saveAuction(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("category") String category,
            @RequestParam("startingBid") Double startingBid,
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate,
            @RequestParam(value = "imageUrl", required = false) String imageUrl,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            if (session.getAttribute("user") == null) {
                return "redirect:/login";
            }
            
            if (description.length() > 5000) {
                description = description.substring(0, 4997) + "...";
            }
            
            Integer sellerId = (Integer) session.getAttribute("userId");
            
            ProductEntity auction = new ProductEntity();
            auction.setTitle(title);
            auction.setDescription(description);
            auction.setCategory(category);
            auction.setStartingBid(startingBid);
            auction.setCurrentBid(startingBid);
            auction.setStartDate(startDate);
            auction.setEndDate(endDate);
            
            if (imageUrl != null && !imageUrl.isEmpty()) {
                auction.setImageUrl(imageUrl);
            } else {
                auction.setImageUrl("https://via.placeholder.com/300x200/667eea/ffffff?text=" + title.substring(0, 1).toUpperCase());
            }
            
            auction.setSellerId(sellerId);
            auction.setBidCount(0);
            auction.setStatus("ACTIVE");
            auction.setCreatedAt(LocalDateTime.now());
            
            productRepository.save(auction);
            
            redirectAttributes.addFlashAttribute("success", "Auction created successfully!");
            return "redirect:/listProduct";
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to create auction: " + e.getMessage());
            return "redirect:/newProduct";
        }
    }

    @GetMapping("/listProduct")
    public String listAuctions(
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "search", required = false) String search,
            Model model, 
            HttpSession session) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            List<ProductEntity> allAuctions;
            List<ProductEntity> activeAuctions;
            List<ProductEntity> completedAuctions;
            
            // Apply filters
            if (status != null && !status.isEmpty() && category != null && !category.isEmpty()) {
                // Filter by both status and category
                allAuctions = productRepository.findByStatusAndCategory(status, category);
            } else if (status != null && !status.isEmpty()) {
                // Filter by status only
                allAuctions = productRepository.findByStatus(status);
            } else if (category != null && !category.isEmpty()) {
                // Filter by category only
                allAuctions = productRepository.findByCategory(category);
            } else if (search != null && !search.isEmpty()) {
                // Search by title or description
                allAuctions = productRepository.searchAuctions(search);
            } else {
                // No filters - show all
                allAuctions = productRepository.findAll();
            }
            
            // Get active and completed for stats
            activeAuctions = productRepository.findByStatus("ACTIVE");
            completedAuctions = productRepository.findByStatus("COMPLETED");
            
            // Get auctions ending soon
            List<ProductEntity> endingSoon = productRepository.findAuctionsEndingSoon();
            
            // Get all unique categories for filter dropdown
            List<String> allCategories = productRepository.findAllCategories();
            
            model.addAttribute("allAuctions", allAuctions);
            model.addAttribute("activeAuctions", activeAuctions);
            model.addAttribute("completedAuctions", completedAuctions);
            model.addAttribute("endingSoon", endingSoon);
            model.addAttribute("allCategories", allCategories);
            model.addAttribute("totalAuctions", allAuctions.size());
            model.addAttribute("selectedStatus", status);
            model.addAttribute("selectedCategory", category);
            model.addAttribute("searchKeyword", search);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error loading auctions: " + e.getMessage());
        }
        
        return "ListProduct";
    }

    @GetMapping("/viewProduct")
    public String viewAuction(@RequestParam("productId") Integer productId, 
                             Model model, 
                             HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<ProductEntity> auction = productRepository.findById(productId);
            
            if (auction.isPresent()) {
                ProductEntity product = auction.get();
                List<BidEntity> bids = bidRepository.findByProductIdOrderByBidAmountDesc(productId);
                
                // Get seller information
                Integer sellerId = product.getSellerId();
                // You can add seller details if you have UserRepository
                
                model.addAttribute("auction", product);
                model.addAttribute("bids", bids);
                model.addAttribute("bidCount", bids.size());
                
                // Check if auction is active
                boolean isActive = "ACTIVE".equals(product.getStatus()) && 
                                   !product.getEndDate().isBefore(LocalDate.now());
                model.addAttribute("isActive", isActive);
                
                // Check if current user is the seller
                Integer currentUserId = (Integer) session.getAttribute("userId");
                model.addAttribute("isSeller", currentUserId.equals(sellerId));
                
                return "ViewProduct";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "redirect:/listProduct";
    }
 // EDIT PRODUCT - Display edit form
    @GetMapping("/editProduct")
    public String editProduct(@RequestParam("productId") Integer productId, 
                              Model model, 
                              HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<ProductEntity> auction = productRepository.findById(productId);
            
            if (auction.isPresent()) {
                ProductEntity product = auction.get();
                
                // Check if user is authorized to edit (admin or seller)
                Integer currentUserId = (Integer) session.getAttribute("userId");
                String userRole = (String) session.getAttribute("userRole");
                
                if ("ADMIN".equals(userRole) || currentUserId.equals(product.getSellerId())) {
                    String[] categories = {"Electronics", "Fashion", "Vehicles", "Art", "Jewelry", 
                                          "Collectibles", "Real Estate", "Sports", "Books", "Music", 
                                          "Toys", "Other"};
                    model.addAttribute("categories", categories);
                    model.addAttribute("auction", product);
                    return "EditProduct";
                } else {
                    return "redirect:/listProduct";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "redirect:/listProduct";
    }

    // UPDATE PRODUCT - Process the form submission
    @PostMapping("/updateProduct")
    public String updateProduct(
            @RequestParam("productId") Integer productId,
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam("category") String category,
            @RequestParam("startingBid") Double startingBid,
            @RequestParam("startDate") LocalDate startDate,
            @RequestParam("endDate") LocalDate endDate,
            @RequestParam(value = "imageUrl", required = false) String imageUrl,
            @RequestParam("status") String status,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<ProductEntity> opAuction = productRepository.findById(productId);
            
            if (opAuction.isPresent()) {
                ProductEntity auction = opAuction.get();
                
                // Check if user is authorized to edit
                Integer currentUserId = (Integer) session.getAttribute("userId");
                String userRole = (String) session.getAttribute("userRole");
                
                if ("ADMIN".equals(userRole) || currentUserId.equals(auction.getSellerId())) {
                    
                    auction.setTitle(title);
                    auction.setDescription(description);
                    auction.setCategory(category);
                    auction.setStartingBid(startingBid);
                    
                    // Only update current bid if starting bid is higher
                    if (startingBid > auction.getCurrentBid()) {
                        auction.setCurrentBid(startingBid);
                    }
                    
                    auction.setStartDate(startDate);
                    auction.setEndDate(endDate);
                    auction.setStatus(status);
                    
                    if (imageUrl != null && !imageUrl.isEmpty()) {
                        auction.setImageUrl(imageUrl);
                    }
                    
                    productRepository.save(auction);
                    
                    redirectAttributes.addFlashAttribute("success", "Auction updated successfully!");
                } else {
                    redirectAttributes.addFlashAttribute("error", "You don't have permission to edit this auction!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to update auction: " + e.getMessage());
        }
        
        return "redirect:/listProduct";
    }

        
      
    @GetMapping("/deleteProduct")
    public String deleteAuction(@RequestParam("productId") Integer productId, 
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Optional<ProductEntity> auction = productRepository.findById(productId);
            
            if (auction.isPresent()) {
                Integer sellerId = auction.get().getSellerId();
                Integer currentUserId = (Integer) session.getAttribute("userId");
                String userRole = (String) session.getAttribute("userRole");
                
                if ("ADMIN".equals(userRole) || sellerId.equals(currentUserId)) {
                    // First delete all bids for this product
                    List<BidEntity> bids = bidRepository.findByProductIdOrderByBidAmountDesc(productId);
                    bidRepository.deleteAll(bids);
                    
                    // Then delete the product
                    productRepository.deleteById(productId);
                    redirectAttributes.addFlashAttribute("success", "Auction deleted successfully!");
                } else {
                    redirectAttributes.addFlashAttribute("error", "You don't have permission to delete this auction!");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to delete auction: " + e.getMessage());
        }
        
        return "redirect:/listProduct";
    }
    
    @GetMapping("/myAuctions")
    public String myAuctions(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer sellerId = (Integer) session.getAttribute("userId");
        List<ProductEntity> myAuctions = productRepository.findBySellerId(sellerId);
        
        model.addAttribute("allAuctions", myAuctions);
        model.addAttribute("totalAuctions", myAuctions.size());
        
        return "ListProduct";
    }
}