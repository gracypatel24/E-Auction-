package com.grownited.eauction.controller;

import java.util.List;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.repository.CategoryRepository;

@Controller
public class CategoryController {

    @Autowired
    CategoryRepository categoryRepository;

    @GetMapping("newCategory")
    public String newCategory() {
        return "NewCategory";
    }

    @PostMapping("saveCategory")
    public String saveCategory(CategoryEntity categoryEntity) {
        categoryEntity.setActive(true);
        categoryRepository.save(categoryEntity);
        return "redirect:/admin-dashboard";
    }

    @GetMapping("listCategory")
    public String listCategory(Model model) {
        List<CategoryEntity> categoryList = categoryRepository.findAll();
        model.addAttribute("categoryList", categoryList);
        return "ListCategory";
    }
    
    @GetMapping("/editCategory")
    public String editCategory(@RequestParam("id") Integer id, Model model) {
        Optional<CategoryEntity> category = categoryRepository.findById(id);
        if (category.isPresent()) {
            model.addAttribute("category", category.get());
            return "EditCategory";
        }
        return "redirect:/listCategory";
    }
    
    @PostMapping("/updateCategory")
    public String updateCategory(@RequestParam("categoryId") Integer categoryId,
                                @RequestParam("categoryName") String categoryName,
                                @RequestParam(value = "active", required = false) Boolean active,
                                RedirectAttributes redirectAttributes) {
        try {
            Optional<CategoryEntity> op = categoryRepository.findById(categoryId);
            if (op.isPresent()) {
                CategoryEntity category = op.get();
                category.setCategoryName(categoryName);
                category.setActive(active != null ? active : false);
                categoryRepository.save(category);
                redirectAttributes.addFlashAttribute("success", "Category updated successfully!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update category: " + e.getMessage());
        }
        return "redirect:/listCategory";
    }
    
    @PostMapping("/deleteCategory")
    public String deleteCategory(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            // Check if category exists before deleting
            if (categoryRepository.existsById(id)) {
                categoryRepository.deleteById(id);
                redirectAttributes.addFlashAttribute("success", "Category deleted successfully!");
            } else {
                redirectAttributes.addFlashAttribute("error", "Category not found!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cannot delete category as it may be in use. Error: " + e.getMessage());
        }
        return "redirect:/listCategory";
    }
}
