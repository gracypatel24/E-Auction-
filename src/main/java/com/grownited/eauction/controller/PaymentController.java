package com.grownited.eauction.controller;
	
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PaymentController {
	
	//input
	@GetMapping("/charge")
	public String charge() {
		return "ChargeCreditCard";
	}
	@PostMapping("charge")
	public String ChargeCreditCard() {
		return "/dashboard";
	}
}
