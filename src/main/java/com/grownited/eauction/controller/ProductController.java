package com.grownited.eauction.controller;

import com.grownited.eauction.entity.*;
import com.grownited.eauction.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/list")
    public String list(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        UserEntity user = userRepository.findByEmail(email).orElse(null);
        
        if (user != null) {
            model.addAttribute("products", productRepository.findBySeller(user));
        }
        return "product/list";
    }
    
    @GetMapping("/active")
    public String active(Model model) {
        model.addAttribute("products", productRepository.findActiveAuctions(new java.util.Date()));
        return "product/active";
    }
    
    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("product", new ProductEntity());
        model.addAttribute("categories", categoryRepository.findAll());
        return "product/new";
    }
    
    @PostMapping("/save")
    public String save(@ModelAttribute ProductEntity product, RedirectAttributes ra) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        UserEntity seller = userRepository.findByEmail(email).orElse(null);
        
        if (seller != null) {
            product.setSeller(seller);
            product.setStatus("ACTIVE");
            productRepository.save(product);
            ra.addFlashAttribute("message", "Product listed successfully");
        }
        return "redirect:/product/list";
    }
    
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model) {
        ProductEntity product = productRepository.findById(id).orElse(null);
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryRepository.findAll());
        return "product/edit";
    }
    
    @PostMapping("/update")
    public String update(@ModelAttribute ProductEntity product, RedirectAttributes ra) {
        productRepository.save(product);
        ra.addFlashAttribute("message", "Product updated successfully");
        return "redirect:/product/list";
    }
    
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id, RedirectAttributes ra) {
        productRepository.deleteById(id);
        ra.addFlashAttribute("message", "Product deleted successfully");
        return "redirect:/product/list";
    }
    
    @GetMapping("/view/{id}")
    public String view(@PathVariable Integer id, Model model) {
        ProductEntity product = productRepository.findById(id).orElse(null);
        model.addAttribute("product", product);
        return "product/view";
    }
}