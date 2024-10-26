package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import com.itwillbs.domain.CompanyVO;
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
	
	// 거래처 회원가입
	public String insertCompanyMember(MemberVO vo);
	
	// 로그인 
	public MemberVO loginMember(MemberVO vo);
	
	public MemberVO getMemberIdEmailSearch(MemberVO vo);
	
	// 사용자 정보조회 (로그인 했다고 가정.);
	public MemberVO getMember(String member_id);
	
	
	// 사용자의 이메일이 있는지 없는지.
	public MemberVO getMemberEmail(String email);
	
	// 사용자 정보수정
	public int updateMember(MemberVO uvo);
	
	// 사용자 정보수정
	public MemberVO updateMemberName(MemberVO uvo);
	public MemberVO updateMemberTel(MemberVO uvo);
	
	// 사용자 정보삭제
	public Integer deleteMember(MemberVO dvo);
	
	
	
	// 사용자 전화번호 조회 (중복 체크)
	public MemberVO getMemberTel(String tel);
	
	// admin(전용) 사용자 정보 조회
	public Map<String, Object> getMemberDetails(String member_id);
	
	// admin(전용) 사용자 정보 목록 조회
	public List<MemberVO> getMemberList(String member_id);
	
	// admin(전용) 회원가입 신청 정보 목록 조회
	public List<MemberVO> getSignupRequestList();
	
	// admin(전용) 회원가입 신청 승인
	public int updateMembers(List<MemberVO> memberList);
	
	// admin(전용) 회원가입 신청 목록 삭제
	public Integer deleteMembers(List<MemberVO> memberList);
	
	// admin(전용)
	public int updatePermission(MemberVO vo);
	
	public Map<String, Object> getInfo();

	public MemberVO memberCodeCheck(CompanyVO vo);
	
	public int updatePw(MemberVO vo);
	
	public int UpdatePwMember(MemberVO vo); 
	
	
}
