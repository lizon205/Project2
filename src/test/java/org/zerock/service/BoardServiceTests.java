package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		assertNotNull(service);
	}
	
//	@Test
//	public void testCreater() {
//		MemberVO member = new MemberVO();
//		member.setUserid("test id");
//		member.setUserpw("test pw");
//		member.setUserName("홍길동");
//		member.setAddr("test addr");
//		member.setPhone("000-0000-0000");
//		member.setEmail("abcd@google.com");
//		
//		service.create(member);
//		
//		log.info("생성된 계정의 소유자" + member.getUserName());
//	}
	
//	@Test
//	public void testCheck() {
//		MemberVO member = new MemberVO();
//		member.setUserid("test1");
//		
//		service.idCheck(member.getUserid());
//		
//	}
}
