package com.grownited.eauction.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.eauction.entity.ProductEntity;
import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.ProductRepository;
import com.grownited.eauction.repository.UserTypeRepository;


@Controller
public class ProductController {

	@Autowired
	ProductRepository productRepository;

	@Autowired
	UserTypeRepository userTypeRepository;

	@GetMapping("newProduct")
	public String newHackathon(Model model) {
		List<UserTypeEntity> allUserType = userTypeRepository.findAll();
		model.addAttribute("allUserType", allUserType);
		return "NewProduct";
	}

	@PostMapping("saveProduct")
	public String saveProduct(ProductEntity productEntity) {
		productRepository.save(productEntity);
		return "redirect:/listProduct";
	}

	@GetMapping("listProduct")
	public String listproduct(Model model) {
		// BUG #1 FIX: Variable was named 'allHackthon' but model.addAttribute used
		//             '__allProduct__' (wrong name + placeholder syntax). Fixed to use
		//             the correct local variable name 'allProduct' consistently.
		List<ProductEntity> allProduct = productRepository.findAll();
		model.addAttribute("allProduct", allProduct);
		return "ListProduct";
	}

	@GetMapping("deleteProduct")
	public String deleteHackathon(
			// BUG #2 FIX: @RequestParam was missing. Without it, Spring cannot bind
			//             the 'productId' query parameter from the URL to this argument.
			//             e.g. /deleteProduct?productId=5 would silently pass null,
			//             causing a NullPointerException in deleteById().
			@RequestParam Integer productId) {

		productRepository.deleteById(productId);

		// BUG #3 FIX: URL was "redirect:/listproduct" (lowercase 'p') but the
		//             correct mapping is "listProduct" (camelCase). This would cause
		//             a 404 after every delete since no route named 'listproduct' exists.
		return "redirect:/listProduct";
	}

}