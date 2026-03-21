package com.grownited.eauction.repository;

import com.grownited.eauction.entity.CategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryEntity, Integer> {
    
    // Find category by name
    Optional<CategoryEntity> findByCategoryName(String categoryName);
    
    // Find active categories
    @Query("SELECT c FROM CategoryEntity c WHERE c.isActive = true")
    List<CategoryEntity> findActiveCategories();
    
    // Find main categories (parent category is null)
    @Query("SELECT c FROM CategoryEntity c WHERE c.parentCategoryId IS NULL")
    List<CategoryEntity> findMainCategories();
    
    // Find subcategories by parent ID
    List<CategoryEntity> findByParentCategoryId(Integer parentId);
    
    // Check if category name exists
    boolean existsByCategoryName(String categoryName);
    
    // Find categories with product count
    @Query("SELECT c, COUNT(p) FROM CategoryEntity c LEFT JOIN ProductEntity p ON c.categoryName = p.category WHERE c.isActive = true GROUP BY c")
    List<Object[]> findCategoriesWithProductCount();
    
    // Count active categories
    @Query("SELECT COUNT(c) FROM CategoryEntity c WHERE c.isActive = true")
    Long countActiveCategories();
    
    // Search categories by name
    @Query("SELECT c FROM CategoryEntity c WHERE LOWER(c.categoryName) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<CategoryEntity> searchCategories(@Param("keyword") String keyword);
    
    // Find categories by name containing
    List<CategoryEntity> findByCategoryNameContainingIgnoreCase(String keyword);
}