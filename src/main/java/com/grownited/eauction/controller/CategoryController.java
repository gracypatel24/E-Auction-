package com.grownited.eauction.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.repository.CategoryRepository;

@Controller
public class CategoryController {

    @Autowired
    CategoryRepository categoryRepository;

    @GetMapping("newCategory")
    public String newCategory() {
        return "NewCategory"; // → templates/NewCategory.html
    }

    @PostMapping("saveCategory")
    public String saveCategory(CategoryEntity categoryEntity) {
        categoryEntity.setActive(true);
        categoryRepository.save(categoryEntity);
        return "redirect:/admin-dashboard"; // ✅ CHANGED: redirect after save
    }

    @GetMapping("listCategory")
    public String listCategory(Model model) {
        List<CategoryEntity> categoryList = categoryRepository.findAll();
        model.addAttribute("categoryList", categoryList);
        return "ListCategory"; // → templates/ListCategory.html
    }
}
