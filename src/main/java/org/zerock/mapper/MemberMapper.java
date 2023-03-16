package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	
	public void create(MemberVO member);
	
	public int idCheck(String userid);
	
	public void create_auth(MemberVO member);
	
	public MemberVO select(String userid);
	
	public void modify(MemberVO member);
}
