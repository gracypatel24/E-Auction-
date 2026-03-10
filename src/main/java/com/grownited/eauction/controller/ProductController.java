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
        
        String[] categories = {"Electronics", "Fashion", "Vehicles", "Art", "Jewelry", "Collectibles", "Real Estate", "Sports"};
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

    // FIXED: Single method with optional parameter
    @GetMapping("/listProduct")
    public String listAuctions(@RequestParam(value = "status", required = false) String status, 
                              Model model, 
                              HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        List<ProductEntity> allAuctions;
        List<ProductEntity> activeAuctions;
        
        if (status != null && !status.isEmpty()) {
            // Filter by status if provided
            allAuctions = productRepository.findByStatus(status);
            activeAuctions = productRepository.findByStatus("ACTIVE");
        } else {
            // Show all auctions
            allAuctions = productRepository.findAll();
            activeAuctions = productRepository.findByStatus("ACTIVE");
        }
        
        // Get auctions ending soon (within next 7 days)
        List<ProductEntity> endingSoon = productRepository.findAuctionsEndingSoon();
        
        model.addAttribute("allAuctions", allAuctions);
        model.addAttribute("activeAuctions", activeAuctions);
        model.addAttribute("endingSoon", endingSoon);
        model.addAttribute("totalAuctions", allAuctions.size());
        
        return "ListProduct";
    }

    @GetMapping("/viewProduct")
    public String viewAuction(@RequestParam("productId") Integer productId, 
                             Model model, 
                             HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<ProductEntity> auction = productRepository.findById(productId);
        
        if (auction.isPresent()) {
            List<BidEntity> bids = bidRepository.findByProductIdOrderByBidAmountDesc(productId);
            model.addAttribute("auction", auction.get());
            model.addAttribute("bids", bids);
            return "ViewProduct";
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
        
        String userRole = (String) session.getAttribute("userRole");
        
        try {
            Optional<ProductEntity> auction = productRepository.findById(productId);
            
            if (auction.isPresent()) {
                Integer sellerId = auction.get().getSellerId();
                Integer currentUserId = (Integer) session.getAttribute("userId");
                
                if ("ADMIN".equals(userRole) || sellerId.equals(currentUserId)) {
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
}