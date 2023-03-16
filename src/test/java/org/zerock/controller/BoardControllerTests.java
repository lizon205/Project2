package org.zerock.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.domain.MemberVO;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // Contoller 테스트를 위한 어노테이션
@ContextConfiguration({ //스프링 빈 설정을 위한 어노테이션
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx; //WebApplicationContext 사용 위해
	
	private MockMvc mockMvc; //가짜 Mvc
	
	@Before // 매번 모든 테스트 전에 실행되는 메서드를 만들기
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testCreater() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/create")
				.param("userid", "테스트 아이디")
				.param("userpw", "테스트 암호")
				.param("userName", "테스트 이름")
				.param("addr", "테스트 주소")
				.param("phone", "000-0000-000")
				.param("email", "테스트 이메일")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	
	@Test
	public void testIdChk() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/idCheck")
				.param("userid", "테스트 아이디")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
