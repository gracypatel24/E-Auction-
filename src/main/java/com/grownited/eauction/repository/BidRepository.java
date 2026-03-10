package com.grownited.eauction.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.eauction.entity.BidEntity;

@Repository
public interface BidRepository extends JpaRepository<BidEntity, Integer> {
    
    List<BidEntity> findByProductIdOrderByBidAmountDesc(Integer productId);
    
    List<BidEntity> findByUserId(Integer userId);
    
    @Query("SELECT b FROM BidEntity b WHERE b.userId = :userId ORDER BY b.bidTime DESC")
    List<BidEntity> findUserBids(@Param("userId") Integer userId);
    
    @Query("SELECT b FROM BidEntity b WHERE b.productId = :productId AND b.status = 'WINNING'")
    BidEntity findWinningBid(@Param("productId") Integer productId);
    
    @Query("SELECT COUNT(b) FROM BidEntity b WHERE b.productId = :productId")
    Integer countBidsByProduct(@Param("productId") Integer productId);
    
    @Query("SELECT MAX(b.bidAmount) FROM BidEntity b WHERE b.productId = :productId")
    Double findHighestBid(@Param("productId") Integer productId);
}