package com.grownited.eauction.services;

import com.grownited.eauction.entity.*;
import com.grownited.eauction.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Service
public class AuctionService {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    @Scheduled(fixedDelay = 60000) // Check every minute
    @Transactional
    public void endExpiredAuctions() {
        Date now = new Date();
        List<ProductEntity> activeAuctions = productRepository.findByStatus("ACTIVE");
        int endedCount = 0;
        
        for (ProductEntity product : activeAuctions) {
            if (product.getAuctionEndDate() != null && product.getAuctionEndDate().before(now)) {
                product.setStatus("ENDED");
                productRepository.save(product);
                endedCount++;
                System.out.println("✅ Auction ended for product: " + product.getTitle());
            }
        }
        
        if (endedCount > 0) {
            System.out.println("✅ " + endedCount + " auctions ended automatically");
        }
    }
    
    @Transactional
    public BidEntity placeBid(ProductEntity product, UserEntity user, BigDecimal bidAmount) {
        // Validate bid
        if (bidAmount.compareTo(product.getCurrentPrice()) <= 0) {
            throw new RuntimeException("Bid amount must be higher than current price");
        }
        
        if (!product.getStatus().equals("ACTIVE")) {
            throw new RuntimeException("Auction is not active");
        }
        
        if (product.getAuctionEndDate() != null && product.getAuctionEndDate().before(new Date())) {
            throw new RuntimeException("Auction has already ended");
        }
        
        // Update previous bids
        List<BidEntity> allBids = bidRepository.findByProductOrderByBidAmountDesc(product);
        for (BidEntity bid : allBids) {
            bid.setIsWinning(false);
            bidRepository.save(bid);
        }
        
        // Create new bid
        BidEntity newBid = new BidEntity();
        newBid.setProduct(product);
        newBid.setUser(user);
        newBid.setBidAmount(bidAmount);
        newBid.setIsWinning(true);
        
        BidEntity savedBid = bidRepository.save(newBid);
        
        // Update product price
        product.setCurrentPrice(bidAmount);
        productRepository.save(product);
        
        System.out.println("✅ Bid placed: " + bidAmount + " on product: " + product.getTitle());
        return savedBid;
    }
    
    public boolean isUserHighestBidder(Integer productId, Integer userId) {
        return bidRepository.findWinningBid(productId)
            .map(bid -> bid.getUser().getUserId().equals(userId))
            .orElse(false);
    }
}