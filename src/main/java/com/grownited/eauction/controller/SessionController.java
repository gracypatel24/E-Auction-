package com.grownited.eauction.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.entity.UserTypeEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;
import com.grownited.eauction.repository.UserTypeRepository;

@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository; 

	@Autowired
	UserTypeRepository userTypeRepository; 
	
	@Autowired
	UserDetailRepository userDetailRepository;
	
	@GetMapping("/signup")
	public String openSignupPage(Model model) {
		
		List<UserTypeEntity> allUserType = userTypeRepository.findAll(); 
		//userType -> send Signup->
		model.addAttribute("allUserType",allUserType); 
		return "Signup"; // jsp name
	}

	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}

	@GetMapping("/forgetpassword")
	public String openForgetPassword() {
		return "ForgetPassword";
	}

	@PostMapping("/register")
	public String register(UserEntity userEntity, UserDetailEntity userDetailEntity) {
		System.out.println(userEntity.getFirstName());
		System.out.println(userEntity.getLastName());
		System.out.println("Processor => " + Runtime.getRuntime().availableProcessors());
		System.out.println(userDetailEntity.getCountry());
		System.out.println(userDetailEntity.getState());

		
		userEntity.setRole("PARTICIPANT");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		// users insert -> UserRepository
		// new -> X
		userRepository.save(userEntity); //users insert  -> userId 
		userDetailEntity.setUserId(userEntity.getUserId());
		userDetailRepository.save(userDetailEntity);//
		
		 
		return "Login";
	}

}