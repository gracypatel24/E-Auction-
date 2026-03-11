package com.grownited.eauction.controller.participant;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
        System.out.println("========== PARTICIPANT DASHBOARD CALLED ==========");
        System.out.println("Trying to load: /WEB-INF/views/participant/ParticipantDashboard.jsp");
        
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            
            List<ProductEntity> activeAuctions = productRepository.findByStatus("ACTIVE");
            List<BidEntity> myBids = bidRepository.findByUserId(userId);
            
            List<BidEntity> winningBids = bidRepository.findUserBids(userId).stream()
                    .filter(b -> "WINNING".equals(b.getStatus()))
                    .toList();
            
            long endingSoon = productRepository.findAuctionsEndingSoon().size();
            
            model.addAttribute("activeAuctions", activeAuctions);
            model.addAttribute("myBids", myBids);
            model.addAttribute("winningBids", winningBids);
            model.addAttribute("totalBids", myBids.size());
            model.addAttribute("endingSoon", endingSoon);
            model.addAttribute("wonCount", winningBids.size());
            
            return "participant/ParticipantDashboard";
            
        } catch (Exception e) {
            e.printStackTrace();
            return "participant/ParticipantDashboard";
        }
    }

    @GetMapping("/my-bids")
    public String myBids(Model model, HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        List<BidEntity> myBids = bidRepository.findUserBids(userId);
        
        model.addAttribute("bids", myBids);
        model.addAttribute("totalBids", myBids.size());
        
        return "participant/My-Bids";
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
        model.addAttribute("wonCount", wonBids.size());
        
        return "participant/Won-auctions";
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
        
        try {
            ProductEntity product = productRepository.findById(productId).orElse(null);
            if (product == null) {
                redirectAttributes.addFlashAttribute("error", "Product not found");
                return "redirect:/participant/dashboard";
            }
            
            if (bidAmount <= product.getCurrentBid()) {
                redirectAttributes.addFlashAttribute("error", "Bid amount must be higher than current bid");
                return "redirect:/viewProduct?productId=" + productId;
            }
            
            BidEntity winningBid = bidRepository.findWinningBid(productId);
            if (winningBid != null) {
                winningBid.setStatus("OUTBID");
                bidRepository.save(winningBid);
            }
            
            BidEntity bid = new BidEntity();
            bid.setProductId(productId);
            bid.setUserId(userId);
            bid.setBidAmount(bidAmount);
            bid.setStatus("WINNING");
            bidRepository.save(bid);
            
            product.setCurrentBid(bidAmount);
            product.setBidCount(product.getBidCount() + 1);
            productRepository.save(product);
            
            redirectAttributes.addFlashAttribute("success", "Bid placed successfully!");
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Failed to place bid: " + e.getMessage());
        }
        
        return "redirect:/viewProduct?productId=" + productId;
    }

    @GetMapping("/test")
    @ResponseBody
    public String test() {
        return "ParticipantController is WORKING!";
    }
}