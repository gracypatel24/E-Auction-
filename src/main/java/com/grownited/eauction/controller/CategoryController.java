package com.grownited.eauction.controller;

import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/category")
public class CategoryController {
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("categories", categoryRepository.findAll());
        return "category/list";
    }
    
    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("category", new CategoryEntity());
        return "category/new";
    }
    
    @PostMapping("/save")
    public String save(@ModelAttribute CategoryEntity category, RedirectAttributes ra) {
        categoryRepository.save(category);
        ra.addFlashAttribute("message", "Category saved successfully");
        return "redirect:/category/list";
    }
    
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        model.addAttribute("category", categoryRepository.findById(id).orElse(null));
        return "category/edit";
    }
    
    @PostMapping("/update")
    public String update(@ModelAttribute CategoryEntity category, RedirectAttributes ra) {
        categoryRepository.save(category);
        ra.addFlashAttribute("message", "Category updated successfully");
        return "redirect:/category/list";
    }
    
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes ra) {
        categoryRepository.deleteById(id);
        ra.addFlashAttribute("message", "Category deleted successfully");
        return "redirect:/category/list";
    }
}