package com.grownited.eauction.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "bids")
public class BidEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bid_id")
    private Integer bidId;
    
    @Column(name = "product_id")
    private Integer productId;
    
    @Column(name = "user_id")
    private Integer userId;
    
    @Column(name = "bid_amount")
    private Double bidAmount;
    
    @Column(name = "bid_time")
    private LocalDateTime bidTime;
    
    @Column(name = "status", length = 50)
    private String status;
    
    @Transient
    private ProductEntity product; // Not stored in database
    
    public BidEntity() {
        this.bidTime = LocalDateTime.now();
        this.status = "WINNING";
    }
    
    // Getters and Setters
    public Integer getBidId() {
        return bidId;
    }
    
    public void setBidId(Integer bidId) {
        this.bidId = bidId;
    }
    
    public Integer getProductId() {
        return productId;
    }
    
    public void setProductId(Integer productId) {
        this.productId = productId;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public Double getBidAmount() {
        return bidAmount;
    }
    
    public void setBidAmount(Double bidAmount) {
        this.bidAmount = bidAmount;
    }
    
    public LocalDateTime getBidTime() {
        return bidTime;
    }
    
    public void setBidTime(LocalDateTime bidTime) {
        this.bidTime = bidTime;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public ProductEntity getProduct() {
        return product;
    }
    
    public void setProduct(ProductEntity product) {
        this.product = product;
    }
}