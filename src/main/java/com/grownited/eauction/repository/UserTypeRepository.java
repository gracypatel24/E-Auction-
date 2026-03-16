package com.grownited.eauction.repository;

import com.grownited.eauction.entity.UserTypeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserTypeRepository extends JpaRepository<UserTypeEntity, Integer> {
    Optional<UserTypeEntity> findByUserTypeName(String userTypeName);
}