package com.grownited.eauction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/admin")
    public String home(Model model) {
        model.addAttribute("title", "Bootstrap Demo");
        model.addAttribute("message", "Welcome to Spring Boot + Bootstrap!");
        return "index";
    }
    
    @GetMapping("/about")
    public String about(Model model) {
        model.addAttribute("title", "About Page");
        return "about";
    }
}