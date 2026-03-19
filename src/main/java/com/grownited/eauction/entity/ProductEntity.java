package com.grownited.eauction.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "products")
public class ProductEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;
    
    @Column(name = "product_name", nullable = false)
    private String productName;
    
    @Column(name = "description", length = 2000)
    private String description;
    
    @Column(name = "category")
    private String category;
    
    @Column(name = "subcategory")
    private String subcategory;
    
    @Column(name = "starting_price", nullable = false)
    private Double startingPrice;
    
    @Column(name = "current_bid")
    private Double currentBid;
    
    @Column(name = "buy_now_price")
    private Double buyNowPrice;
    
    @Column(name = "bid_count")
    private Integer bidCount;
    
    @Column(name = "view_count")
    private Integer viewCount;
    
    @Column(name = "main_image")
    private String mainImage;
    
    @Column(name = "image1")
    private String image1;
    
    @Column(name = "image2")
    private String image2;
    
    @Column(name = "image3")
    private String image3;
    
    @Column(name = "status")
    private String status;
    
    @Column(name = "auction_end_date")
    private LocalDateTime auctionEndDate;
    
    @ManyToOne
    @JoinColumn(name = "seller_id", nullable = false)
    private UserEntity seller;
    
    // This field maps to the same column, so we need insertable=false, updatable=false
    @Column(name = "seller_id", insertable = false, updatable = false)
    private Integer sellerId;
    
    @Column(name = "winning_bid_id")
    private Integer winningBidId;
    
    @Column(name = "winning_user_id")
    private Integer winningUserId;
    
    @Column(name = "winning_amount")
    private Double winningAmount;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Constructors
    public ProductEntity() {
        this.bidCount = 0;
        this.viewCount = 0;
    }
    
    // Getters and Setters
    public Integer getProductId() {
        return productId;
    }
    
    public void setProductId(Integer productId) {
        this.productId = productId;
    }
    
    public String getProductName() {
        return productName;
    }
    
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getSubcategory() {
        return subcategory;
    }
    
    public void setSubcategory(String subcategory) {
        this.subcategory = subcategory;
    }
    
    public Double getStartingPrice() {
        return startingPrice;
    }
    
    public void setStartingPrice(Double startingPrice) {
        this.startingPrice = startingPrice;
    }
    
    public Double getCurrentBid() {
        return currentBid;
    }
    
    public void setCurrentBid(Double currentBid) {
        this.currentBid = currentBid;
    }
    
    public Double getBuyNowPrice() {
        return buyNowPrice;
    }
    
    public void setBuyNowPrice(Double buyNowPrice) {
        this.buyNowPrice = buyNowPrice;
    }
    
    public Integer getBidCount() {
        return bidCount;
    }
    
    public void setBidCount(Integer bidCount) {
        this.bidCount = bidCount;
    }
    
    public Integer getViewCount() {
        return viewCount;
    }
    
    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }
    
    public String getMainImage() {
        return mainImage;
    }
    
    public void setMainImage(String mainImage) {
        this.mainImage = mainImage;
    }
    
    public String getImage1() {
        return image1;
    }
    
    public void setImage1(String image1) {
        this.image1 = image1;
    }
    
    public String getImage2() {
        return image2;
    }
    
    public void setImage2(String image2) {
        this.image2 = image2;
    }
    
    public String getImage3() {
        return image3;
    }
    
    public void setImage3(String image3) {
        this.image3 = image3;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public LocalDateTime getAuctionEndDate() {
        return auctionEndDate;
    }
    
    public void setAuctionEndDate(LocalDateTime auctionEndDate) {
        this.auctionEndDate = auctionEndDate;
    }
    
    public UserEntity getSeller() {
        return seller;
    }
    
    public void setSeller(UserEntity seller) {
        this.seller = seller;
        if (seller != null) {
            this.sellerId = seller.getUserId();
        }
    }
    
    public Integer getSellerId() {
        return sellerId;
    }
    
    public void setSellerId(Integer sellerId) {
        this.sellerId = sellerId;
    }
    
    public Integer getWinningBidId() {
        return winningBidId;
    }
    
    public void setWinningBidId(Integer winningBidId) {
        this.winningBidId = winningBidId;
    }
    
    public Integer getWinningUserId() {
        return winningUserId;
    }
    
    public void setWinningUserId(Integer winningUserId) {
        this.winningUserId = winningUserId;
    }
    
    public Double getWinningAmount() {
        return winningAmount;
    }
    
    public void setWinningAmount(Double winningAmount) {
        this.winningAmount = winningAmount;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}