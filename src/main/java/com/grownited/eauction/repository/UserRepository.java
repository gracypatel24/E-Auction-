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
    
    Optional<UserEntity> findByEmail(String email);
    
    @Query("SELECT COUNT(u) FROM UserEntity u WHERE u.userType.userTypeName = :userType")
    Long countByUserType(@Param("userType") String userType);
    
    @Query("SELECT u FROM UserEntity u WHERE u.userType.userTypeName = :userType")
    List<UserEntity> findByUserType(@Param("userType") String userType);
}