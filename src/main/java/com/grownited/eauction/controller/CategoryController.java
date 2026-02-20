package com.grownited.eauction.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.eauction.entity.CategoryEntity;
import com.grownited.eauction.repository.CategoryRepository;


//JPA -> specification  

@Controller
public class CategoryController {

	@Autowired // inject 
	CategoryRepository categoryRepository; 
	
	@GetMapping("newCategory")
	public String newCategory() {
		return "NewCategory";
	}

	@PostMapping("saveCategory")
	public String saveCategory(CategoryEntity categoryEntity) {

		categoryEntity.setActive(true);
		//insert 
		categoryRepository.save(categoryEntity); 
		return "AdminDashboard";
	}
	
	public CategoryRepository getCategoryRepository() {
		return categoryRepository;
	}

	public void setCategoryRepository(CategoryRepository categoryRepository) {
		this.categoryRepository = categoryRepository;
	}

	@GetMapping("listCategory")
	public String listCategory(Model model) {
		//select * from categories ; 
		//1
		//2
		//3
		//4
		//List<Entity> 
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList",categoryList);//
		
		return "ListCategory";
	}
		

}