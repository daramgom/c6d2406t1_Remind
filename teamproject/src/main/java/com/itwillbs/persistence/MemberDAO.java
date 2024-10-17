package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.MemberVO;

/**
 * 
 *	tbl_member 테이블의 데이터를 활용하는 동작을 정의 
 *  
 */
public interface MemberDAO {
	
	// 디비서버 시간 조회
	
	// 1. DAO 로직 작성.
	// 2. MemberDAOImpl, DAO를 구현한 클래스에서 오버라이딩.
	// 3. Mapper에서 SQL 쿼리 작성.
	// 4. 오버라이딩된 클래스 완성.
	
	// 회원가입
	public String insertMember(MemberVO vo);
	
	// 로그인
	public MemberVO loginMember(MemberVO vo);
	
	// 로그인
	public MemberVO loginMember(String userid, String userpw);
	
	
	// 사용자 정보조회 (로그인 했다고 가정.);
	public MemberVO getMember(String member_id);
	
	
	// 사용자의 이메일이 있는지 없는지.
	public MemberVO getMemberEmail(String email);
	
	// 사용자 정보수정
	public int updateMember(MemberVO uvo);
	
	// 사용자 정보삭제
	public Integer deleteMember(MemberVO dvo);
	
	
	
	// 사용자 전화번호 조회 (중복 체크)
	public MemberVO getMemberTel(String tel);
	
	// admin(전용) 사용자 정보 조회
	public Map<String, Object> getMemberDetails(String member_id);
	
	// admin(전용) 사용자 정보 목록 조회
	public List<MemberVO> getMemberList(String action);
	

	
}
