package com.grownited.eauction.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "product")
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productId;
    
    private String title;
    
    @Column(length = 5000) // Increase description length
    private String description;
    
    private String category;
    private Double startingBid;
    private Double currentBid;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status; // ACTIVE, COMPLETED, CANCELLED
    
    @Column(length = 500)
    private String imageUrl;
    
    private Integer sellerId; // User ID of seller
    private Integer bidCount;
    private LocalDateTime createdAt;
    
    // Constructors
    public ProductEntity() {
        this.bidCount = 0;
        this.currentBid = 0.0;
        this.createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Integer getProductId() {
        return productId;
    }
    
    public void setProductId(Integer productId) {
        this.productId = productId;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
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
    
    public Double getStartingBid() {
        return startingBid;
    }
    
    public void setStartingBid(Double startingBid) {
        this.startingBid = startingBid;
    }
    
    public Double getCurrentBid() {
        return currentBid;
    }
    
    public void setCurrentBid(Double currentBid) {
        this.currentBid = currentBid;
    }
    
    public LocalDate getStartDate() {
        return startDate;
    }
    
    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
    
    public LocalDate getEndDate() {
        return endDate;
    }
    
    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public Integer getSellerId() {
        return sellerId;
    }
    
    public void setSellerId(Integer sellerId) {
        this.sellerId = sellerId;
    }
    
    public Integer getBidCount() {
        return bidCount;
    }
    
    public void setBidCount(Integer bidCount) {
        this.bidCount = bidCount;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}