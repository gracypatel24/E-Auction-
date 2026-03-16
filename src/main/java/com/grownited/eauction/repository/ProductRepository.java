package com.grownited.eauction.repository;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.CategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Date;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {
    
    List<ProductEntity> findByStatus(String status);
    
    List<ProductEntity> findBySeller(UserEntity seller);
    
    List<ProductEntity> findByCategory(CategoryEntity category);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.status = 'ACTIVE' AND p.auctionEndDate > :currentDate")
    List<ProductEntity> findActiveAuctions(@Param("currentDate") Date currentDate);
    
    @Query("SELECT p FROM ProductEntity p WHERE p.status = 'ACTIVE' AND p.category.categoryId = :categoryId")
    List<ProductEntity> findActiveByCategory(@Param("categoryId") Integer categoryId);
    
    @Query("SELECT p FROM ProductEntity p WHERE LOWER(p.title) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(p.description) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<ProductEntity> searchProducts(@Param("keyword") String keyword);
}