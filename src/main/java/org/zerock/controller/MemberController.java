package org.zerock.controller;

import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.security.domain.CustomUser;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	private MemberService service;
	private PasswordEncoder pwdEncoder;
	
	
	@GetMapping("/create")
	public void create(){
		
		log.info("create page");
		
		
	}
	
	
	
	
	@PostMapping("/create")
	public String create(MemberVO member, RedirectAttributes rttr) {
		
		
		//비밀번호 암호화
		String userpw = pwdEncoder.encode(member.getUserpw());
		member.setUserpw(userpw);
		
		//회원가입할 때 아이디 중복확인을 위해서
		int idResult  = service.idCheck(member.getUserid());
		
		try {
			// 아이디 중복 여부 이상 없음 
			if(idResult == 0) {
				service.create(member);
				log.info("Sign Up Success....." + member);
				return "redirect:/customLogin";
			}
			// 아이디 중복 
			else if(idResult == 1) {
				log.info("Sing Up Fail......" + member);
				return "/board/create";
			}
			
		} catch(Exception e) {
			throw new RuntimeException();
		}
		
		
		//log.info("create new account");
		
		//service.create(member);
		
		//log.info("new account log :" + member );
		
		return "redirect:/customLogin";
	}
	
	
	
	@PostMapping(value = "/idCheck", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody //데이터 자체를 전달하기 위한 용도
	public int idCheck(MemberVO member) {	
		
		log.info("checking id,,,,,,," + member.getUserid());
		
		int result = service.idCheck(member.getUserid());
		
		log.info("Checking Id Result : " + result);
		
		return result;
	}
	
	
	
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER','ROLE_USER')")
	@GetMapping("/goModifyPage")
	public String GoInformation(Model model) {
		
		log.info("회원 정보 게시판으로 이동");
		
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		model.addAttribute("member", service.select(user.getUsername()));
		
		return "member/information";
	}
	
	
	@PostMapping("/modify")
	public String modify(MemberVO member, RedirectAttributes rttr) {
		
		log.info("do modify");
		
		//비밀번호 암호화
		String userpw = pwdEncoder.encode(member.getUserpw());
		member.setUserpw(userpw);
		
		service.modify(member);
		
		log.info("modify Success");
				
		return "redirect:/customLogin";
	}
	
	
	
	
	
	
	
	
	
}
