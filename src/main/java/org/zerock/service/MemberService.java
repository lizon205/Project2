package org.zerock.service;



import org.zerock.domain.MemberVO;


public interface MemberService {

	//회원가입을 위한 추가
	public void create(MemberVO member);
	
	//아이디 중복 확인을 위한 추가
	public int idCheck(String userid);
	
	//회원 상세 정보
	public MemberVO select(String userid);
	
	//회원 정보 수정
	public void modify(MemberVO member);

}
