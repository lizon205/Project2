package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;


@Data
public class MemberVO {
		private String userid;
		private String userpw;
		private String userName;
		
		private Date regDate;
		private Date updateDate;
		private List<AuthVO> authList;
		
		
		//회원가입 창 구현을 위해 추가!
		private String addr;
		private String phone;
		private String email;
}
