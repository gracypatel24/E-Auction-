package com.grownited.eauction.services;

import com.grownited.eauction.entity.BidEntity;
import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.BidRepository;
import com.grownited.eauction.repository.CategoryRepository;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class AuctionService {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private BidRepository bidRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired(required = false)
    private MailerService mailerService;
    
    // ========== PRODUCT METHODS ==========
    
    public List<ProductEntity> getAllProducts() {
        return productRepository.findAll();
    }
    
    public List<ProductEntity> getActiveAuctions() {
        LocalDateTime now = LocalDateTime.now();
        return productRepository.findActiveAuctions(now);
    }
    
    public List<ProductEntity> getEndingSoonAuctions() {
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime soon = now.plusHours(24);
        return productRepository.findAuctionsEndingSoon(now, soon);
    }
    
    public Optional<ProductEntity> getProductById(Integer id) {
        return productRepository.findById(id);
    }
    
    public List<ProductEntity> getProductsBySellerId(Integer sellerId) {
        return productRepository.findBySellerId(sellerId);
    }
    
    public List<ProductEntity> getProductsBySeller(UserEntity seller) {
        return productRepository.findBySellerId(seller.getUserId());
    }
    
    public List<ProductEntity> searchProducts(String keyword) {
        return productRepository.searchProducts(keyword);
    }
    
    public List<ProductEntity> getProductsByCategory(String category) {
        return productRepository.findByCategoryAndActive(category);
    }
    
    public List<ProductEntity> getWonAuctionsByUser(Integer userId) {
        return productRepository.findWonAuctionsByUser(userId);
    }
    
    @Transactional
    public ProductEntity createProduct(ProductEntity product, UserEntity seller) {
        product.setSeller(seller);
        product.setSellerId(seller.getUserId());
        product.setCreatedAt(LocalDateTime.now());
        product.setUpdatedAt(LocalDateTime.now());
        product.setCurrentBid(product.getStartingPrice());
        product.setBidCount(0);
        product.setViewCount(0);
        product.setStatus("PENDING");
        
        ProductEntity savedProduct = productRepository.save(product);
        
        try {
            if (mailerService != null) {
                mailerService.sendNewProductNotification(savedProduct);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return savedProduct;
    }
    
    @Transactional
    public ProductEntity updateProduct(ProductEntity product) {
        product.setUpdatedAt(LocalDateTime.now());
        return productRepository.save(product);
    }
    
    @Transactional
    public void approveProduct(Integer productId) {
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            product.setStatus("ACTIVE");
            productRepository.save(product);
            
            try {
                if (mailerService != null) {
                    mailerService.sendProductApprovalNotification(product);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    @Transactional
    public void rejectProduct(Integer productId, String reason) {
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            product.setStatus("REJECTED");
            productRepository.save(product);
            
            try {
                if (mailerService != null) {
                    mailerService.sendProductRejectionNotification(product, reason);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    @Transactional
    public void deleteProduct(Integer id) {
        productRepository.deleteById(id);
    }
    
    @Transactional
    public void incrementViewCount(Integer productId) {
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            product.setViewCount(product.getViewCount() + 1);
            productRepository.save(product);
        }
    }
    
    // ========== BID METHODS ==========
    
    @Transactional
    public BidEntity placeBid(Integer productId, UserEntity bidder, Double amount) {
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        
        if (productOpt.isEmpty()) {
            throw new RuntimeException("Product not found");
        }
        
        ProductEntity product = productOpt.get();
        
        // Validate bid
        if (!"ACTIVE".equals(product.getStatus())) {
            throw new RuntimeException("Auction is not active");
        }
        
        // FIXED: Changed from getEndDate() to getAuctionEndDate()
        LocalDateTime auctionEndDate = product.getAuctionEndDate();
        if (auctionEndDate == null) {
            throw new RuntimeException("Auction end date is not set");
        }
        
        if (auctionEndDate.isBefore(LocalDateTime.now())) {
            throw new RuntimeException("Auction has ended on: " + auctionEndDate);
        }
        
        if (amount <= product.getCurrentBid()) {
            throw new RuntimeException("Bid amount must be higher than current bid: " + product.getCurrentBid());
        }
        
        if (bidder.getUserId().equals(product.getSellerId())) {
            throw new RuntimeException("You cannot bid on your own product");
        }
        
        // Update previous winning bid status
        List<BidEntity> topBids = bidRepository.findTopBidsForProduct(productId);
        if (!topBids.isEmpty()) {
            BidEntity previousTop = topBids.get(0);
            previousTop.setIsWinningBid(false);
            previousTop.setStatus("OUTBID");
            bidRepository.save(previousTop);
        }
        
        // Create new bid
        BidEntity bid = new BidEntity();
        bid.setProduct(product);
        bid.setProductId(productId);
        bid.setUser(bidder);
        bid.setUserId(bidder.getUserId());
        bid.setBidAmount(amount);
        bid.setBidTime(LocalDateTime.now());
        bid.setIsWinningBid(true);
        bid.setStatus("ACTIVE");
        
        // Update product
        product.setCurrentBid(amount);
        product.setBidCount(product.getBidCount() + 1);
        productRepository.save(product);
        
        BidEntity savedBid = bidRepository.save(bid);
        
        // Notify seller about new bid
        try {
            if (mailerService != null && product.getSeller() != null) {
                mailerService.sendNewBidNotification(product.getSeller(), product, savedBid);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return savedBid;
    }
    
    public List<BidEntity> getBidsForProduct(Integer productId) {
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            return bidRepository.findByProductId(productId);
        }
        return List.of();
    }
    
    public List<BidEntity> getBidsByUser(UserEntity user) {
        return bidRepository.findByUserId(user.getUserId());
    }
    
    public Optional<Double> getHighestBidForProduct(Integer productId) {
        return bidRepository.findHighestBidForProduct(productId);
    }
    
    public List<BidEntity> getUserBidsForProduct(Integer productId, UserEntity user) {
        return bidRepository.findByProductIdAndUserId(productId, user.getUserId());
    }
    
    public List<BidEntity> getWinningBidsByUser(UserEntity user) {
        return bidRepository.findByUserIdAndIsWinningBidTrue(user.getUserId());
    }
    
    @Transactional
    public void completeAuction(Integer productId) {
        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            ProductEntity product = productOpt.get();
            
            // FIXED: Changed from getEndDate() to getAuctionEndDate()
            LocalDateTime auctionEndDate = product.getAuctionEndDate();
            if (auctionEndDate != null && auctionEndDate.isBefore(LocalDateTime.now()) && "ACTIVE".equals(product.getStatus())) {
                
                List<BidEntity> bids = bidRepository.findTopBidsForProduct(productId);
                
                if (!bids.isEmpty()) {
                    BidEntity winningBid = bids.get(0);
                    winningBid.setIsWinningBid(true);
                    winningBid.setStatus("WON");
                    bidRepository.save(winningBid);
                    
                    product.setWinningBidId(winningBid.getBidId());
                    product.setWinningUserId(winningBid.getUserId());
                    product.setWinningAmount(winningBid.getBidAmount());
                    product.setStatus("SOLD");
                    
                    // Notify winner and seller
                    try {
                        if (mailerService != null) {
                            UserEntity winner = userRepository.findById(winningBid.getUserId()).orElse(null);
                            if (winner != null) {
                                mailerService.sendAuctionWonNotification(winner, product);
                            }
                            if (product.getSeller() != null) {
                                mailerService.sendProductSoldNotification(product.getSeller(), product, winningBid);
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    product.setStatus("UNSOLD");
                }
                
                productRepository.save(product);
            }
        }
    }
    
    // ========== CATEGORY METHODS ==========
    
    public List<CategoryEntity> getAllCategories() {
        return categoryRepository.findAll();
    }
    
    public List<CategoryEntity> getActiveCategories() {
        return categoryRepository.findActiveCategories();
    }
    
    public Optional<CategoryEntity> getCategoryById(Integer id) {
        return categoryRepository.findById(id);
    }
    
    public Optional<CategoryEntity> getCategoryByName(String name) {
        return categoryRepository.findByCategoryName(name);
    }
    
    public List<CategoryEntity> getMainCategories() {
        return categoryRepository.findMainCategories();
    }
    
    public List<CategoryEntity> getSubCategories(Integer parentId) {
        return categoryRepository.findByParentCategoryId(parentId);
    }
    
    @Transactional
    public CategoryEntity createCategory(CategoryEntity category) {
        category.setCreatedAt(LocalDateTime.now());
        category.setUpdatedAt(LocalDateTime.now());
        category.setIsActive(true);
        return categoryRepository.save(category);
    }
    
    @Transactional
    public CategoryEntity updateCategory(CategoryEntity category) {
        category.setUpdatedAt(LocalDateTime.now());
        return categoryRepository.save(category);
    }
    
    @Transactional
    public void deleteCategory(Integer id) {
        categoryRepository.deleteById(id);
    }
    
    // ========== USER STATISTICS ==========
    
    public Long getTotalUsers() {
        return userRepository.count();
    }
    
    public Long getTotalSellers() {
        return userRepository.countByRole("SELLER");
    }
    
    public Long getTotalBuyers() {
        return userRepository.countByRole("USER");
    }
    
    public Long getTotalActiveAuctions() {
        LocalDateTime now = LocalDateTime.now();
        return (long) productRepository.findActiveAuctions(now).size();
    }
    
    public Long getTotalPendingProducts() {
        return (long) productRepository.findByStatus("PENDING").size();
    }
    
    public Double getTotalRevenue() {
        return productRepository.findAll().stream()
                .filter(p -> "SOLD".equals(p.getStatus()) && p.getWinningAmount() != null)
                .mapToDouble(ProductEntity::getWinningAmount)
                .sum();
    }
    
    public Double getSellerEarnings(Integer sellerId) {
        return productRepository.findAll().stream()
                .filter(p -> "SOLD".equals(p.getStatus()) && p.getWinningAmount() != null && p.getSellerId().equals(sellerId))
                .mapToDouble(ProductEntity::getWinningAmount)
                .sum();
    }
}