package com.grownited.eauction.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.eauction.entity.UserTypeEntity;

@Repository
public interface UserTypeRepository extends JpaRepository<UserTypeEntity, Integer>{

}