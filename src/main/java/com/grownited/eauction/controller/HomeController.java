package com.grownited.eauction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home() {
        return "redirect:/login";  // This should redirect to /login, not /auth/login
    }
}