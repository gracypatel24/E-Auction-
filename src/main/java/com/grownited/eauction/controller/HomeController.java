package com.grownited.eauction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // ✅ When someone visits http://localhost:9999/
    // redirect them to the login page
    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }
}