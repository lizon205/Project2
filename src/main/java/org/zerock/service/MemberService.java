package org.zerock.service;



import org.zerock.domain.MemberVO;


public interface MemberService {

	//ȸ�������� ���� �߰�
	public void create(MemberVO member);
	
	//���̵� �ߺ� Ȯ���� ���� �߰�
	public int idCheck(String userid);
	
	//ȸ�� �� ����
	public MemberVO select(String userid);
	
	//ȸ�� ���� ����
	public void modify(MemberVO member);

}
