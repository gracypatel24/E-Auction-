package com.grownited.eauction.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class PaymentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paymentId;

    private Double amount;

    private Integer userId;
    private Integer productId;
    private Integer auctionId;
    private Integer sellerId;

    private String status;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    private Integer orderId;

    private LocalDate paymentDate;

    private String paymentMode;
    private String gateway;
    private String paymentGatewayTransactionId;
    private String paymentGatewayAuthCode;

    // Transient fields (not stored in database)
    @Transient
    private String productName;

    @Transient
    private String productImage;

    @Transient
    private String buyerName; 
    
    @Transient
    private String sellerName;

    public String getSellerName() { return sellerName; }
    public void setSellerName(String sellerName) { this.sellerName = sellerName; }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    // ===== GETTERS & SETTERS =====

    public Integer getPaymentId() { return paymentId; }
    public void setPaymentId(Integer paymentId) { this.paymentId = paymentId; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public Integer getAuctionId() { return auctionId; }
    public void setAuctionId(Integer auctionId) { this.auctionId = auctionId; }

    public Integer getSellerId() { return sellerId; }
    public void setSellerId(Integer sellerId) { this.sellerId = sellerId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public Integer getOrderId() { return orderId; }
    public void setOrderId(Integer orderId) { this.orderId = orderId; }

    public LocalDate getPaymentDate() { return paymentDate; }
    public void setPaymentDate(LocalDate paymentDate) { this.paymentDate = paymentDate; }

    public String getPaymentMode() { return paymentMode; }
    public void setPaymentMode(String paymentMode) { this.paymentMode = paymentMode; }

    public String getGateway() { return gateway; }
    public void setGateway(String gateway) { this.gateway = gateway; }

    public String getPaymentGatewayTransactionId() { return paymentGatewayTransactionId; }
    public void setPaymentGatewayTransactionId(String val) { this.paymentGatewayTransactionId = val; }

    public String getPaymentGatewayAuthCode() { return paymentGatewayAuthCode; }
    public void setPaymentGatewayAuthCode(String val) { this.paymentGatewayAuthCode = val; }

    // Transient fields getters/setters
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductImage() { return productImage; }
    public void setProductImage(String productImage) { this.productImage = productImage; }

    public String getBuyerName() { return buyerName; }  // ✅ ADD THIS
    public void setBuyerName(String buyerName) { this.buyerName = buyerName; }  // ✅ ADD THIS
}