package com.itwillbs.service;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.itwillbs.domain.CompanyVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.persistence.MemberDAO;
import org.springframework.stereotype.Service;

// @Service : 서비스 영역(비지니스 로직 영역) 에서의 동작을 구현하도록 설정
//            root-context.xml에 빈(MemberService)으로 등록 사용.

/**
 * 
 * 비즈니스 영역, Action페이지, pro.jsp 동작을 처리하는 공간.
 * => 컨트롤러와 DAO를 연결다리(접착제) / 완충영역
 * => 고객사마다 유연한 대처가 가능.
 */
@Service
public class MemberServiceImpl implements MemberService{
	
	// MemberDAO 객체 주입
	@Inject
	private MemberDAO mdao;

	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Override
	public String memberJoin(MemberVO vo) {
		logger.debug("(●'◡'●) 컨트롤러 -> 서비스 ");
		logger.debug("(●'◡'●) 회원가입 메서드 memberJoin(MemberVO vo) 실행 ");
		
		String hashedPassword = BCrypt.hashpw(vo.getMember_pw(), BCrypt.gensalt());
        vo.setMember_pw(hashedPassword);
		
		return mdao.insertMember(vo);
		
	}
	
	@Override
	public String companyMemberJoin(MemberVO vo) {
		logger.debug("(●'◡'●) 컨트롤러 -> 서비스 ");
		logger.debug("(●'◡'●) 거래처 회원가입 메서드 memberJoin(MemberVO vo) 실행 ");
		
		String hashedPassword = BCrypt.hashpw(vo.getMember_pw(), BCrypt.gensalt());
        vo.setMember_pw(hashedPassword);
		
		return mdao.insertCompanyMember(vo);
	}
	
	
	
	@Override
	public MemberVO memberLoginCheck(MemberVO vo) {
	   logger.debug("(●'◡'●) 컨트롤러가 호출 -> DAO 호출");
	    MemberVO storedMember = mdao.loginMember(vo);

	    if (storedMember == null) {
	        return null; // 아이디가 없음
	    }
	    
	    // 아이디가 존재하는 경우 storeMember가 있음.
	    
	    // 비밀번호 확인 -> 비밀번호가 맞으면
	    logger.debug("이거 실행되니? ");
	    if (BCrypt.checkpw(vo.getMember_pw(), storedMember.getMember_pw())) {
	    	logger.debug("이거 실행되니? ");
	    	// 로그인 성공
	    	return storedMember; // 비밀번호 일치
	    }

	    logger.debug("비밀번호 맞는지 ");
	    logger.debug("(●'◡'●) 컨트롤러가 호출 -> DAO 호출 비밀번호 틀림" );
	    return new MemberVO(); // 빈 MemberVO 객체 반환 (비밀번호 틀림)
	}
	
	
	@Override
	public MemberVO memberIdCheck(String member_id) {
		logger.debug("(●'◡'●) memberInfo(String member_id) 실행 " + member_id);
		return mdao.getMember(member_id);
	}
	
	
	@Override
	public MemberVO memberIdEmailSearch(MemberVO vo) {
		logger.debug("(●'◡'●)  memberIdEmailSearch (MemberVO vo)  실행 ");
		
		
		return mdao.getMemberIdEmailSearch(vo);
	}
	
	
	
	@Override
	public MemberVO memberEmailSearch(String email) {
		logger.debug("memberEmailSearch");
		return mdao.getMemberEmail(email);
	}
	
	@Override
	public int memberUpdate(MemberVO uvo) {
		logger.debug("(●'◡'●)  memberUpdate(MemberVO vo) 실행 " + uvo);
		
		
		return mdao.updateMember(uvo);
	}
	
	@Override
	public int memberPermissionUpdate(MemberVO vo) {
		logger.debug("(●'◡'●)  memberUpdate(MemberVO vo) 실행 " + vo);
		
		return mdao.updatePermission(vo);
	}
	
	@Override
	public MemberVO memberCodeCheck(CompanyVO vo) {
		return mdao.memberCodeCheck(vo);
	}
	
	
	
	@Override
	public Integer memberDelete(MemberVO vo) {
		
		logger.debug("(●'◡'●) memberDelete(MemberVO vo ) 실행 " + vo);
		
		return mdao.deleteMember(vo); 
		
	}
	
	
	@Override
	public MemberVO memberInfoTel(String tel) {
		logger.debug("(●'◡'●) memberInfoTel(String Tel) 실행 " + tel);
		return mdao.getMemberTel(tel);
	}
	
	@Override
	public Map<String,Object> memberInfo(String member_id) {
		logger.debug("(●'◡'●) memberInfoTel(String member_id) 실행 " + member_id);
		return mdao.getMemberDetails(member_id);
	}
	// admin 전용 특정 사용자 조회
	@Override
	public List<MemberVO> memberList(String id) {
		logger.debug("memberList() 실행 ");	
		
		return mdao.getMemberList(id);
	}
	
	// admin 전용 회원가입 신청 멤버 목록
	@Override
	public List<MemberVO> signupRequestList() {
	
		return  mdao.getSignupRequestList();
	}
	
	// admin 전용 회원가입 신청 멤버 승인.
	@Override
	public int membersUpdate(List<MemberVO> memberList) {
		
		return mdao.updateMembers(memberList); 
	}
	
	// admin 전용 회원가입 신청 멤버 삭제.
	@Override
	public Integer membersDelete(List<MemberVO> vo) {
		return mdao.deleteMembers(vo);
	}
	
	@Override
	public Map<String, Object> getInfo() {
		return mdao.getInfo();
	}
	
	@Override
	public MemberVO memberUpdateInfo(String id, String span, String newValue) {
		logger.debug("memberSerive 실행");
		MemberVO member = new MemberVO();
		member.setMember_id(id);
		
		if(span.equals("userName")) {
			logger.debug("userName 실행");
			member.setMember_name(newValue);
			return mdao.updateMemberName(member);
		}
		logger.debug("userTel 실행");
		member.setMember_tel(newValue);
		return mdao.updateMemberTel(member);
	}
	
	
	@Override
	public int memberUpdatePw(MemberVO vo) {
		String hashedPassword = BCrypt.hashpw(vo.getMember_pw(), BCrypt.gensalt());
        vo.setMember_pw(hashedPassword);
		
		return mdao.UpdatePwMember(vo);
	}
	
	
	
}
