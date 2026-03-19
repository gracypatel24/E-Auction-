package com.grownited.eauction.repository;

import com.grownited.eauction.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {
    
    // ========== BASIC METHODS ==========
    List<ProductEntity> findBySellerId(Integer sellerId);
    Long countBySellerId(Integer sellerId);
    List<ProductEntity> findByStatus(String status);
    
    // ========== SELLER METHODS ==========
    @Query("SELECT p FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'ACTIVE'")
    List<ProductEntity> findActiveBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'SOLD'")
    List<ProductEntity> findSoldBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'PENDING'")
    List<ProductEntity> findPendingBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'ACTIVE'")
    Long countActiveBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'SOLD'")
    Long countSoldBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT COALESCE(SUM(p.winningAmount), 0) FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'SOLD'")
    Double totalEarningsBySellerId(@Param("sellerId") Integer sellerId);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.sellerId = :sellerId AND p.status = 'SOLD'")
    List<ProductEntity> earningsBreakdownBySellerId(@Param("sellerId") Integer sellerId);
    
    // ========== ADMIN METHODS ==========
    @Query("SELECT p FROM ProductEntity p WHERE p.status = 'PENDING'")
    List<ProductEntity> findPendingProducts();
    
    @Query("SELECT p FROM ProductEntity p WHERE p.status = 'ACTIVE'")
    List<ProductEntity> findAllActiveProducts();
    
    @Query("SELECT p FROM ProductEntity p WHERE p.status = 'REJECTED'")
    List<ProductEntity> findRejectedProducts();
    
    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.status = 'PENDING'")
    Long countPendingProducts();
    
    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.status = 'ACTIVE'")
    Long countActiveProducts();
    
    @Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.status = 'SOLD'")
    Long countSoldProducts();
    
    // ========== AUCTION METHODS ==========
    @Query("SELECT p FROM ProductEntity p WHERE p.auctionEndDate > :currentTime AND p.status = 'ACTIVE'")
    List<ProductEntity> findActiveAuctions(@Param("currentTime") LocalDateTime currentTime);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.auctionEndDate > :now AND p.auctionEndDate < :soon AND p.status = 'ACTIVE'")
    List<ProductEntity> findAuctionsEndingSoon(@Param("now") LocalDateTime now, @Param("soon") LocalDateTime soon);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.category = :category AND p.status = 'ACTIVE'")
    List<ProductEntity> findByCategoryAndActive(@Param("category") String category);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.winningUserId = :userId AND p.status = 'SOLD'")
    List<ProductEntity> findWonAuctionsByUser(@Param("userId") Integer userId);
    
    @Query("SELECT p FROM ProductEntity p WHERE LOWER(p.productName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<ProductEntity> searchProducts(@Param("keyword") String keyword);
}