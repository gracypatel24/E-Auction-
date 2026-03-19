package com.grownited.eauction.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "user_types")
public class UserTypeEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_type_id")  // Make sure this matches your DB column
    private Integer userTypeId;
    
    @Column(name = "user_type_name", nullable = false, length = 50)
    private String userTypeName;
    
    @Column(name = "description", length = 200)
    private String description;
    
    @Column(name = "is_active")
    private Boolean isActive;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Constructors
    public UserTypeEntity() {
    }
    
    // Getters and Setters
    public Integer getUserTypeId() {
        return userTypeId;
    }
    
    public void setUserTypeId(Integer userTypeId) {
        this.userTypeId = userTypeId;
    }
    
    public String getUserTypeName() {
        return userTypeName;
    }
    
    public void setUserTypeName(String userTypeName) {
        this.userTypeName = userTypeName;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Boolean getIsActive() {
        return isActive;
    }
    
    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
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
    
    @Override
    public String toString() {
        return "UserTypeEntity{" +
                "userTypeId=" + userTypeId +
                ", userTypeName='" + userTypeName + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}