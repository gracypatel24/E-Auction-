package com.grownited.eauction.controller;

import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserTypeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/user-type")
public class UserTypeController {
    
    @Autowired
    private UserTypeRepository userTypeRepository;
    
    @GetMapping("/list")
    public String listUserTypes(Model model) {
        List<UserTypeEntity> userTypes = userTypeRepository.findAll();
        model.addAttribute("userTypes", userTypes);
        return "admin/ListUserTypes";
    }
    
    @GetMapping("/new")
    public String showNewForm(Model model) {
        model.addAttribute("userType", new UserTypeEntity());
        return "admin/NewUserType";
    }
    
    @PostMapping("/save")
    public String saveUserType(@ModelAttribute UserTypeEntity userType, RedirectAttributes ra) {
        userTypeRepository.save(userType);
        ra.addFlashAttribute("message", "User type saved successfully");
        return "redirect:/user-type/list";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteUserType(@PathVariable Integer id, RedirectAttributes ra) {
        try {
            userTypeRepository.deleteById(id);
            ra.addFlashAttribute("message", "User type deleted successfully");
        } catch (Exception e) {
            ra.addFlashAttribute("error", "Cannot delete user type as it is being used");
        }
        return "redirect:/user-type/list";
    }
}