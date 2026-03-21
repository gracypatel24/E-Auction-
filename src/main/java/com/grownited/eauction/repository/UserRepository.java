package com.grownited.eauction.repository;

import com.grownited.eauction.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    
    // ========== BASIC FINDER METHODS ==========
    
    // Find user by email (for login)
    Optional<UserEntity> findByEmail(String email);
    
    // Check if email exists
    boolean existsByEmail(String email);
    
    
    // ========== USER TYPE METHODS ==========
    
    // Count users by role (used in AuctionService)
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.userType.userTypeName = :role")
    Long countByRole(@Param("role") String role);
    
    // Find users by user type
    @Query("SELECT u FROM UserEntity u WHERE u.userType.userTypeName = :userType")
    List<UserEntity> findByUserType(@Param("userType") String userType);
    
    // Find all sellers
    @Query("SELECT u FROM UserEntity u WHERE u.userType.userTypeName = 'SELLER'")
    List<UserEntity> findAllSellers();
    
    // Find all buyers (regular users)
    @Query("SELECT u FROM UserEntity u WHERE u.userType.userTypeName = 'USER'")
    List<UserEntity> findAllBuyers();
    
    // Find all admins
    @Query("SELECT u FROM UserEntity u WHERE u.userType.userTypeName = 'ADMIN'")
    List<UserEntity> findAllAdmins();
    
    
    // ========== SEARCH METHODS ==========
    
    // Search users by name or email
    @Query("SELECT u FROM UserEntity u WHERE LOWER(u.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(u.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<UserEntity> searchUsers(@Param("keyword") String keyword);
    
    // Search sellers by name or email
    @Query("SELECT u FROM UserEntity u WHERE u.userType.userTypeName = 'SELLER' AND (LOWER(u.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(u.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')))")
    List<UserEntity> searchSellers(@Param("keyword") String keyword);
    
    
    // ========== STATUS METHODS ==========
    
    // Find active users
    @Query("SELECT u FROM UserEntity u WHERE u.isActive = true")
    List<UserEntity> findActiveUsers();
    
    // Find inactive users
    @Query("SELECT u FROM UserEntity u WHERE u.isActive = false")
    List<UserEntity> findInactiveUsers();
    
    // Find deleted users
    @Query("SELECT u FROM UserEntity u WHERE u.isDeleted = true")
    List<UserEntity> findDeletedUsers();
    
    
    // ========== STATISTICS METHODS ==========
    
    // Count total active users
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.isActive = true")
    Long countActiveUsers();
    
    // Count users registered in last 30 days
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.createdAt >= :date")
    Long countNewUsersSince(@Param("date") java.time.LocalDateTime date);
    
    // Count users by role and active status
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.userType.userTypeName = :role AND u.isActive = :isActive")
    Long countByRoleAndActiveStatus(@Param("role") String role, @Param("isActive") boolean isActive);
    
    
    // ========== VALIDATION METHODS ==========
    
    // Find by email and active status
    Optional<UserEntity> findByEmailAndIsActiveTrue(String email);
    
    // Check if email exists (excluding a specific user ID)
    @Query("SELECT COUNT(u) > 0 FROM UserEntity u WHERE u.email = :email AND u.userId != :userId")
    boolean existsByEmailAndUserIdNot(@Param("email") String email, @Param("userId") Integer userId);
    
    
    // ========== UPDATE METHODS ==========
    
    // Update user active status
    @Query("UPDATE UserEntity u SET u.isActive = :isActive, u.updatedAt = CURRENT_TIMESTAMP WHERE u.userId = :userId")
    void updateActiveStatus(@Param("userId") Integer userId, @Param("isActive") boolean isActive);
    
    
    // ========== ADDITIONAL HELPER METHODS ==========
    
    // Find users by phone number
    Optional<UserEntity> findByPhone(String phone);
    
    // Find users by first name and last name
    List<UserEntity> findByFirstNameAndLastName(String firstName, String lastName);
    
    // Find users created between dates
    List<UserEntity> findByCreatedAtBetween(java.time.LocalDateTime startDate, java.time.LocalDateTime endDate);
    
    
    // ========== DELETE METHODS ==========
    
    // Soft delete (mark as deleted)
    @Query("UPDATE UserEntity u SET u.isDeleted = true, u.isActive = false, u.updatedAt = CURRENT_TIMESTAMP WHERE u.userId = :userId")
    void softDelete(@Param("userId") Integer userId);
    
    // Restore soft-deleted user
    @Query("UPDATE UserEntity u SET u.isDeleted = false, u.isActive = true, u.updatedAt = CURRENT_TIMESTAMP WHERE u.userId = :userId")
    void restoreUser(@Param("userId") Integer userId);
}