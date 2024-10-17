package com.itwillbs.service;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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
	public MemberVO memberLoginCheck(MemberVO vo) {
		logger.debug("(●'◡'●) 컨트롤러가 호출 -> DAO 호출");
		MemberVO storedMember = mdao.loginMember(vo);
	        
        if (storedMember != null && BCrypt.checkpw(vo.getMember_pw(), storedMember.getMember_pw())) {
            return storedMember; // 비밀번호 일치
        }
        return null; // 로그인 실패
	}
	
	
	@Override
	public MemberVO memberIdCheck(String member_id) {
		logger.debug("(●'◡'●) memberInfo(String member_id) 실행 " + member_id);
		return mdao.getMember(member_id);
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
	public List<MemberVO> memberList(String action) {
		logger.debug("memberList() 실행 ");	
		
		return mdao.getMemberList(action);
	}
	
	
}
