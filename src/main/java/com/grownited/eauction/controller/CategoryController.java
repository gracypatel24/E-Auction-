package com.grownited.eauction.controller;

import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.repository.CategoryRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
public class CategoryController {
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @GetMapping("/listCategory")
    public String listCategories(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("page", "categories");
        model.addAttribute("pageTitle", "Categories");
        
        List<CategoryEntity> categories = categoryRepository.findAll();
        model.addAttribute("categories", categories);
        
        return "category/Categories";  // Points to /WEB-INF/views/category/Categories.jsp
    }
    
    @GetMapping("/newCategory")
    public String showAddForm(HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("page", "categories");
        model.addAttribute("pageTitle", "Add Category");
        model.addAttribute("category", new CategoryEntity());
        
        List<CategoryEntity> parentCategories = categoryRepository.findMainCategories(); // You need this method
        model.addAttribute("parentCategories", parentCategories);
        
        return "category/Categories";  // You might want to create a separate AddCategory.jsp
    }
    
    @PostMapping("/saveCategory")
    public String saveCategory(@ModelAttribute CategoryEntity category,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            category.setCreatedAt(LocalDateTime.now());
            category.setUpdatedAt(LocalDateTime.now());
            
            categoryRepository.save(category);
            redirectAttributes.addFlashAttribute("success", "Category saved successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error saving category: " + e.getMessage());
        }
        
        return "redirect:/listCategory";
    }
    
    @GetMapping("/editCategory")
    public String showEditForm(@RequestParam("id") Integer id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<CategoryEntity> categoryOpt = categoryRepository.findById(id);
        if (categoryOpt.isPresent()) {
            model.addAttribute("page", "categories");
            model.addAttribute("pageTitle", "Edit Category");
            model.addAttribute("category", categoryOpt.get());
            
            List<CategoryEntity> parentCategories = categoryRepository.findMainCategories();
            model.addAttribute("parentCategories", parentCategories);
            
            return "category/Categories";  // You might want to create a separate EditCategory.jsp
        } else {
            redirectAttributes.addFlashAttribute("error", "Category not found!");
            return "redirect:/listCategory";
        }
    }
    
    @GetMapping("/deleteCategory")
    public String deleteCategory(@RequestParam("id") Integer id,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        try {
            categoryRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Category deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Cannot delete category as it may be in use");
        }
        
        return "redirect:/listCategory";
    }
}