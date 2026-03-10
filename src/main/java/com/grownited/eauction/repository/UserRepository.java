package com.grownited.eauction.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.grownited.eauction.entity.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {
    
    // Find user by email (used in login)
    Optional<UserEntity> findByEmail(String email);
    
    // That's it! No custom methods needed
}