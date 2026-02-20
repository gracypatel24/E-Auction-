package com.grownited.eauction.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.eauction.entity.UserDetailEntity;
import com.grownited.eauction.entity.UserEntity;
import com.grownited.eauction.repository.UserDetailRepository;
import com.grownited.eauction.repository.UserRepository;

@Controller
public class UserController {

	@Autowired
	UserRepository userRepository;

	@Autowired
	UserDetailRepository userDetailRepository;

	@GetMapping("listUser")
	public String listUser(Model model) {

		List<UserEntity> allUser = userRepository.findAll();
		model.addAttribute("userList", allUser);
		return "ListUser";
	}

	@GetMapping("viewUser")
	public String viewUser(Integer userId, Model model) {
		// read userId
		// select * from users where userId = rock?
		Optional<UserEntity> opUser = userRepository.findById(userId);// Optional
		Optional<UserDetailEntity> opUserDetail = userDetailRepository.findByUserId(userId);
		if (opUser.isEmpty()) {
			// error set
			// list redirect
			return "";
		} else {

			UserEntity userEntity = opUser.get();
			UserDetailEntity userDetailEntity = opUserDetail.get();

			model.addAttribute("user", userEntity);
			model.addAttribute("userDetail", userDetailEntity);
			return "ViewUser";
		}

	}

}