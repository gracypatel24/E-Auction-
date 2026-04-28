package com.grownited.eauction.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "bids")
public class BidEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bid_id")
    private Integer bidId;
    
    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private ProductEntity product;
    
    @Column(name = "product_id", insertable = false, updatable = false)
    private Integer productId;  // Add this field
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;
    
    @Column(name = "user_id", insertable = false, updatable = false)
    private Integer userId;  // Add this field
    
    @Column(name = "bid_amount", nullable = false)
    private Double bidAmount;
    
    @Column(name = "bid_time")
    private LocalDateTime bidTime;
    
    @Column(name = "status")
    private String status;
    
    @Column(name = "is_winning_bid")
    private Boolean isWinningBid;
    
    // Constructors
    public BidEntity() {
        this.isWinningBid = false;
    }
    
    // Getters and Setters
    public Integer getBidId() {
        return bidId;
    }
    
    public void setBidId(Integer bidId) {
        this.bidId = bidId;
    }
    
    public ProductEntity getProduct() {
        return product;
    }
    
    public void setProduct(ProductEntity product) {
        this.product = product;
        if (product != null) {
            this.productId = product.getProductId();
        }
    }
    
    public Integer getProductId() {
        return productId;
    }
    
    public void setProductId(Integer productId) {
        this.productId = productId;
    }
    
    public UserEntity getUser() {
        return user;
    }
    
    public void setUser(UserEntity user) {
        this.user = user;
        if (user != null) {
            this.userId = user.getUserId();
        }
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
    
    public Boolean getIsWinningBid() {
        return isWinningBid;
    }
    
    public void setIsWinningBid(Boolean isWinningBid) {
        this.isWinningBid = isWinningBid;
    }
}