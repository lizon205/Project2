package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.zerock.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChatContorller {

	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER','ROLE_USER')")
	@GetMapping("/testchat")
	public void chat(Model model) {
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		
		log.info("==================================");
		log.info("@ChatController, GET Chat / Username : " + user.getUsername());
		
		model.addAttribute("userid", user.getUsername());	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
