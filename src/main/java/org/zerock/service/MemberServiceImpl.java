package org.zerock.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_= @Autowired)
	private MemberMapper mapper;
	
	
	@Transactional
	@Override
	public void create(MemberVO member) {
		
		log.info("create......................");
		
		mapper.create(member);
		mapper.create_auth(member);
		
	}
	
	@Override
	public int idCheck(String userid) {
		
		log.info("Id Check......................");
		
		int result = mapper.idCheck(userid);
		
		return result;
		
	}
	
	@Override
	public MemberVO select(String userid) {
		
		log.info("select(find) id informatin.............");
		
		MemberVO result = mapper.select(userid);
		
		return result;
	}
	
	@Override
	public void modify(MemberVO member) {
		
		log.info("modify..........." + member);
		
		mapper.modify(member);
		
	}

}
