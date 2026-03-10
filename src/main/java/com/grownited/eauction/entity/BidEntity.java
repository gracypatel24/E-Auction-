package com.grownited.eauction.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "bids")
public class BidEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer bidId;
    
    private Integer productId;
    private Integer userId;
    private Double bidAmount;
    private LocalDateTime bidTime;
    private String status; // WINNING, OUTBID, WON, LOST
    
    public BidEntity() {
        this.bidTime = LocalDateTime.now();
        this.status = "WINNING";
    }
    
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
}