package com.grownited.eauction.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "user_types")
public class UserTypeEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_type_id")
    private Integer userTypeId;
    
    @Column(name = "user_type_name", unique = true, nullable = false, length = 50)
    private String userTypeName;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    private Date updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = new Date();
        updatedAt = new Date();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = new Date();
    }
    
    public UserTypeEntity() {}
    
    public UserTypeEntity(String userTypeName) {
        this.userTypeName = userTypeName;
    }
    
    // Getters and Setters
    public Integer getUserTypeId() { return userTypeId; }
    public void setUserTypeId(Integer userTypeId) { this.userTypeId = userTypeId; }
    
    public String getUserTypeName() { return userTypeName; }
    public void setUserTypeName(String userTypeName) { this.userTypeName = userTypeName; }
    
    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
    
    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}