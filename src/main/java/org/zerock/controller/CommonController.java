package org.zerock.controller;

import org.springframework.security.core.Authentication;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		log.info("error: " + error);
		log.info("logout: " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logoutGET() {
		
		log.info("custom logout");
	}
	
	@GetMapping("/notUser")
	public String notUser(Model model) {
		
		model.addAttribute("msg", "없는 아이디입니다.");
		System.out.println("없는 아이디입니다.");
		
		return "/customLogin";
	}
	
	@GetMapping("/badUser")
	public String badUser(Model model) {
		
		model.addAttribute("msg", "잘못된 비밀번호(계정)입니다.");
		System.out.println("잘못된 비밀번호(계정)입니다.");
		
		return "/customLogin";
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
