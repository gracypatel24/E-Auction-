package com.grownited.eauction.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;

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
    
    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;
    
    @Column(name = "bid_amount", precision = 10, scale = 2, nullable = false)
    private BigDecimal bidAmount;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "bid_time")
    private Date bidTime;
    
    @Column(name = "is_winning")
    private Boolean isWinning = false;
    
    @PrePersist
    protected void onCreate() {
        bidTime = new Date();
    }
    
    public BidEntity() {}
    
    // Getters and Setters
    public Integer getBidId() { return bidId; }
    public void setBidId(Integer bidId) { this.bidId = bidId; }
    
    public ProductEntity getProduct() { return product; }
    public void setProduct(ProductEntity product) { this.product = product; }
    
    public UserEntity getUser() { return user; }
    public void setUser(UserEntity user) { this.user = user; }
    
    public BigDecimal getBidAmount() { return bidAmount; }
    public void setBidAmount(BigDecimal bidAmount) { this.bidAmount = bidAmount; }
    
    public Date getBidTime() { return bidTime; }
    public void setBidTime(Date bidTime) { this.bidTime = bidTime; }
    
    public Boolean getIsWinning() { return isWinning; }
    public void setIsWinning(Boolean isWinning) { this.isWinning = isWinning; }
}