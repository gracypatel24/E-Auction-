package com.grownited.eauction.repository;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDetailRepository extends JpaRepository<UserDetailEntity, Integer> {
    
    // Find user details by user
    UserDetailEntity findByUser(UserEntity user);
}