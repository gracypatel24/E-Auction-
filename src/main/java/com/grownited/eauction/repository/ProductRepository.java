package com.grownited.eauction.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.grownited.eauction.entity.ProductEntity;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {
    
    // Find auctions by status
    List<ProductEntity> findByStatus(String status);
    
    // Find auctions by category
    List<ProductEntity> findByCategory(String category);
    
    // Find auctions by status and category
    List<ProductEntity> findByStatusAndCategory(String status, String category);
    
    // Find auctions by seller
    List<ProductEntity> findBySellerId(Integer sellerId);
    
    // Find active auctions (not ended)
    @Query("SELECT p FROM ProductEntity p WHERE p.status = 'ACTIVE' AND p.endDate >= CURRENT_DATE")
    List<ProductEntity> findActiveAuctions();
    
    // Search auctions by title or description
    @Query("SELECT p FROM ProductEntity p WHERE p.title LIKE %:keyword% OR p.description LIKE %:keyword%")
    List<ProductEntity> searchAuctions(@Param("keyword") String keyword);
    
    // Find auctions ending soon (within next 7 days)
    @Query(value = "SELECT * FROM product WHERE status = 'ACTIVE' AND end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)", nativeQuery = true)
    List<ProductEntity> findAuctionsEndingSoon();
    
    // Find auctions ending today
    @Query(value = "SELECT * FROM product WHERE status = 'ACTIVE' AND end_date = CURDATE()", nativeQuery = true)
    List<ProductEntity> findAuctionsEndingToday();
    
    // Find all unique categories
    @Query("SELECT DISTINCT p.category FROM ProductEntity p ORDER BY p.category")
    List<String> findAllCategories();
    
    // Count auctions by status
    long countByStatus(String status);
}