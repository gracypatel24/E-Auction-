package com.grownited.eauction.repository;

import com.grownited.eauction.entity.CategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryEntity, Integer>
{
    
    // Find category by name
    Optional<CategoryEntity> findByCategoryName(String categoryName);
    
    // Find active categories
    @Query("SELECT c FROM CategoryEntity c WHERE c.isActive = true")
    List<CategoryEntity> findActiveCategories();
    
    // Find categories where parent is null (main categories) - FIXED
    @Query("SELECT c FROM CategoryEntity c WHERE c.parentCategoryId IS NULL")
    List<CategoryEntity> findMainCategories();
    
    List<CategoryEntity> findByIsActiveTrue();
    
    // Find categories by parent ID - FIXED (use parentCategoryId instead of parentCategory)
    List<CategoryEntity> findByParentCategoryId(Integer parentCategoryId);
    
    // Find categories with product count
    @Query("SELECT c, (SELECT COUNT(p) FROM ProductEntity p WHERE p.category = c.categoryName) as productCount FROM CategoryEntity c")
    List<Object[]> findAllWithProductCount();
    
    // Check if category name exists
    boolean existsByCategoryName(String categoryName);
    
    // Check if category name exists excluding ID
    @Query("SELECT CASE WHEN COUNT(c) > 0 THEN true ELSE false END FROM CategoryEntity c WHERE c.categoryName = :categoryName AND c.categoryId != :categoryId")
    boolean existsByCategoryNameAndIdNot(@Param("categoryName") String categoryName, @Param("categoryId") Integer categoryId);
    
    // Find all with parent info
    @Query("SELECT c, p.categoryName as parentName FROM CategoryEntity c LEFT JOIN CategoryEntity p ON c.parentCategoryId = p.categoryId")
    List<Object[]> findAllWithParentInfo();
    
    // Find categories with products
    @Query("SELECT DISTINCT c FROM CategoryEntity c WHERE EXISTS (SELECT p FROM ProductEntity p WHERE p.category = c.categoryName)")
    List<CategoryEntity> findCategoriesWithProducts();
}