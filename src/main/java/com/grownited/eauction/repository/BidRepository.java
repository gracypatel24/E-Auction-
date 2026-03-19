package com.grownited.eauction.repository;

import com.grownited.eauction.entity.BidEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BidRepository extends JpaRepository<BidEntity, Integer> {
    
    // Find bids by product ID
    List<BidEntity> findByProductId(Integer productId);
    
    // Find bids by user ID
    List<BidEntity> findByUserId(Integer userId);
    
    // Find bids by product and user
    List<BidEntity> findByProductIdAndUserId(Integer productId, Integer userId);
    
    // Find winning bids by user
    List<BidEntity> findByUserIdAndIsWinningBidTrue(Integer userId);
    
    // Find top bids for a product
    @Query("SELECT b FROM BidEntity b WHERE b.productId = :productId ORDER BY b.bidAmount DESC")
    List<BidEntity> findTopBidsForProduct(@Param("productId") Integer productId);
    
    // Find highest bid amount for a product
    @Query("SELECT MAX(b.bidAmount) FROM BidEntity b WHERE b.productId = :productId")
    Optional<Double> findHighestBidForProduct(@Param("productId") Integer productId);
    
    // Count bids by user
    @Query("SELECT COUNT(b) FROM BidEntity b WHERE b.userId = :userId")
    Integer countByUserId(@Param("userId") Integer userId);
    
    // Count won auctions by user
    @Query("SELECT COUNT(b) FROM BidEntity b WHERE b.userId = :userId AND b.isWinningBid = true AND b.status = 'WON'")
    Integer countWonByUserId(@Param("userId") Integer userId);
    
    // Count active bids by user
    @Query("SELECT COUNT(b) FROM BidEntity b WHERE b.userId = :userId AND b.status = 'ACTIVE'")
    Integer countActiveByUserId(@Param("userId") Integer userId);
    
    // Find recent bids by user
    @Query("SELECT b FROM BidEntity b WHERE b.userId = :userId ORDER BY b.bidTime DESC")
    List<BidEntity> findRecentByUserId(@Param("userId") Integer userId);
    
    // ========== NEW METHODS FOR SELLER CONTROLLER ==========
    
    // Find recent bids by seller ID (bids on seller's products)
    @Query("SELECT b FROM BidEntity b WHERE b.product.sellerId = :sellerId ORDER BY b.bidTime DESC")
    List<BidEntity> findRecentBySellerId(@Param("sellerId") Integer sellerId);
    
    // Find all bids on seller's products
    @Query("SELECT b FROM BidEntity b WHERE b.product.sellerId = :sellerId ORDER BY b.bidTime DESC")
    List<BidEntity> findBySellerId(@Param("sellerId") Integer sellerId);
    
    // Find bids with product and user details for seller
    @Query("SELECT b, p, u FROM BidEntity b JOIN ProductEntity p ON b.productId = p.productId JOIN UserEntity u ON b.userId = u.userId WHERE p.sellerId = :sellerId ORDER BY b.bidTime DESC")
    List<Object[]> findBySellerIdWithDetails(@Param("sellerId") Integer sellerId);
    
    // Count total bids on seller's products
    @Query("SELECT COUNT(b) FROM BidEntity b WHERE b.product.sellerId = :sellerId")
    Long countBySellerId(@Param("sellerId") Integer sellerId);
    
    // Count active bids on seller's products
    @Query("SELECT COUNT(b) FROM BidEntity b WHERE b.product.sellerId = :sellerId AND b.status = 'ACTIVE'")
    Long countActiveBySellerId(@Param("sellerId") Integer sellerId);
    
    // Find bids by product ID with user details
    @Query("SELECT b, u FROM BidEntity b JOIN UserEntity u ON b.userId = u.userId WHERE b.productId = :productId ORDER BY b.bidAmount DESC")
    List<Object[]> findByProductIdWithUser(@Param("productId") Integer productId);
    
    // Find bids by user ID with product details
    @Query("SELECT b, p FROM BidEntity b JOIN ProductEntity p ON b.productId = p.productId WHERE b.userId = :userId ORDER BY b.bidTime DESC")
    List<Object[]> findByUserIdWithDetails(@Param("userId") Integer userId);
    
    // Find won bids by user with product details
    @Query("SELECT b, p FROM BidEntity b JOIN ProductEntity p ON b.productId = p.productId WHERE b.userId = :userId AND b.isWinningBid = true AND b.status = 'WON'")
    List<Object[]> findWonByUserId(@Param("userId") Integer userId);
    
    // Total spent by user
    @Query("SELECT COALESCE(SUM(b.bidAmount), 0) FROM BidEntity b WHERE b.userId = :userId AND b.isWinningBid = true AND b.status = 'WON'")
    Double totalSpentByUserId(@Param("userId") Integer userId);
    
    // Check if user has bid on product
    boolean existsByProductIdAndUserId(Integer productId, Integer userId);
    
    // Count bids by product
    Long countByProductId(Integer productId);
    
    // Delete methods
    void deleteByProductId(Integer productId);
    void deleteByUserId(Integer userId);
}