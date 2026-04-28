package com.grownited.eauction.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "watchlist")
public class WatchlistEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer watchlistId;
    
    @Column(name = "user_id")
    private Integer userId;
    
    @Column(name = "product_id")
    private Integer productId;
    
    @Column(name = "added_date")
    private LocalDateTime addedDate;
    
    // Getters and Setters
    public Integer getWatchlistId() { return watchlistId; }
    public void setWatchlistId(Integer watchlistId) { this.watchlistId = watchlistId; }
    
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    
    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    
    public LocalDateTime getAddedDate() { return addedDate; }
    public void setAddedDate(LocalDateTime addedDate) { this.addedDate = addedDate; }
}
