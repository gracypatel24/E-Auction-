package com.grownited.eauction.controller.Participant;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.grownited.eauction.entity.BidEntity;
import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.repository.BidRepository;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.services.MailerService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/participant")
public class ParticipantController {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private BidRepository bidRepository;

    @Autowired
    private MailerService mailerService;

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Get active auctions
        List<ProductEntity> activeAuctions = productRepository.findByStatus("ACTIVE");
        
        // Get user's bids
        List<BidEntity> myBids = bidRepository.findByUserId(userId);
        
        // Get winning bids
        List<BidEntity> winningBids = bidRepository.findUserBids(userId).stream()
                .filter(b -> "WINNING".equals(b.getStatus()))
                .toList();
        
        model.addAttribute("activeAuctions", activeAuctions);
        model.addAttribute("myBids", myBids);
        model.addAttribute("winningBids", winningBids);
        model.addAttribute("totalBids", myBids.size());
        
        return "participant/ParticipantDashboard";
    }

    @GetMapping("/my-bids")
    public String myBids(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        List<BidEntity> myBids = bidRepository.findUserBids(userId);
        
        model.addAttribute("bids", myBids);
        return "participant/MyBids";
    }

    @GetMapping("/won-auctions")
    public String wonAuctions(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        List<BidEntity> wonBids = bidRepository.findUserBids(userId).stream()
                .filter(b -> "WON".equals(b.getStatus()))
                .toList();
        
        model.addAttribute("wonAuctions", wonBids);
        return "participant/WonAuctions";
    }

    @PostMapping("/place-bid")
    public String placeBid(@RequestParam("productId") Integer productId,
                          @RequestParam("bidAmount") Double bidAmount,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        String userEmail = (String) session.getAttribute("userEmail");
        
        try {
            // Get product
            ProductEntity product = productRepository.findById(productId).orElse(null);
            if (product == null) {
                redirectAttributes.addFlashAttribute("error", "Product not found");
                return "redirect:/participant/dashboard";
            }
            
            // Check if bid amount is higher than current bid
            if (bidAmount <= product.getCurrentBid()) {
                redirectAttributes.addFlashAttribute("error", "Bid amount must be higher than current bid");
                return "redirect:/viewProduct?productId=" + productId;
            }
            
            // Update previous winning bid to OUTBID
            BidEntity winningBid = bidRepository.findWinningBid(productId);
            if (winningBid != null) {
                winningBid.setStatus("OUTBID");
                bidRepository.save(winningBid);
            }
            
            // Create new bid
            BidEntity bid = new BidEntity();
            bid.setProductId(productId);
            bid.setUserId(userId);
            bid.setBidAmount(bidAmount);
            bid.setStatus("WINNING");
            
            bidRepository.save(bid);
            
            // Update product current bid
            product.setCurrentBid(bidAmount);
            product.setBidCount(product.getBidCount() + 1);
            productRepository.save(product);
            
            // COMMENT OUT OR REMOVE THIS LINE
            // mailerService.sendBidNotification(userEmail, product.getTitle(), bidAmount);
            
            redirectAttributes.addFlashAttribute("success", "Bid placed successfully!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to place bid: " + e.getMessage());
        }
        
        return "redirect:/viewProduct?productId=" + productId;
    } // <-- This closing brace was missing!
}