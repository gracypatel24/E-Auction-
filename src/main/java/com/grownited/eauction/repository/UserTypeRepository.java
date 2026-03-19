package com.grownited.eauction.repository;

import com.grownited.eauction.entity.UserTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserTypeRepository extends JpaRepository<UserTypeEntity, Integer> {
    
    // Find by user type name
    Optional<UserTypeEntity> findByUserTypeName(String userTypeName);
    
    // Find only active user types
    List<UserTypeEntity> findByIsActiveTrue();
}