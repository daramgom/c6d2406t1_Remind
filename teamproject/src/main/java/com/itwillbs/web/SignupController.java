package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;

import javax.crypto.SecretKey;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.pass.EncryptionUtil;
import com.itwillbs.service.MemberService;

@Controller
public class SignupController {
	
	private static final Logger logger = LoggerFactory.getLogger(SignupController.class);
	
	Map<String, String> response = new HashMap<>();;
	
	private static SecretKey secretKey;
	
	static {
        try {
            secretKey = EncryptionUtil.generateKey(); // 비밀 키 생성
        } catch (Exception e) {
            e.printStackTrace(); // 예외 처리
            // 예외 발생 시 로그를 남기거나 기본 키를 설정하는 등의 추가 조치를 취할 수 있습니다.
        }
    }
	
	@Inject
	private MemberService service;
	
	// http://localhost:8088/signup
	@RequestMapping(value ="signup" , method=RequestMethod.GET)
	public void signupGet( HttpSession session , Model model , UserVO uvo) {
		
		logger.info("signupPage get 실행 ");
		logger.info("uvo  : " + uvo);
		
		model.addAttribute("member" , uvo);
		session.setAttribute("isFirstVisit", false );
	}
	
	// http://localhost:8088/signup
		@RequestMapping(value ="signup" , method=RequestMethod.POST)
		public void signupPOST(UserVO vo, Model model) {
			logger.debug("vo : " + vo);
			model.addAttribute("member",vo );
		}
	
	
	// http://localhost:8088/membersignup
	@RequestMapping(value ="membersignup" , method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> memberSignUpPost(@RequestBody MemberVO vo) {
		response.clear();
		logger.info("memberSignUpPost POST 실행 " + vo.getMember_tel());
		
		MemberVO result = service.memberInfoTel(vo.getMember_tel());
		logger.debug("result = :: "+ result);
		
		if(result != null) {
			response.put("message", "이미 등록된 전화번호 입니다.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);// 400 BAD REQUEST 응답  
		}
		try {
			String encryptedInput = EncryptionUtil.encrypt(vo.getMember_pw(), secretKey);
			vo.setMember_pw(encryptedInput); // 암호화된 비밀번호를 설정	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 회원가입 실행.
		service.memberJoin(vo);
		
		response.put("message", "회원가입이 성공적으로 완료되었습니다!");
		return ResponseEntity.ok(response); // 200 OK 응답  
	}
	
	@RequestMapping(value ="/checkUserId" , method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> memberIdcheck(@RequestBody MemberVO vo) {
		
		
		logger.info("memberId 중복검사 : "+vo.getMember_id() );
		String member_id = vo.getMember_id();
		
		MemberVO result =  service.memberIdCheck(member_id);
		logger.debug("result" + result);
		
		
		if(result == null) {
			response.put("message", "사용가능한 아이디 입니다!");
			return ResponseEntity.ok(response); // 200 OK 응답  
    	}
    	
		response.put("message", "이미 등록된 아이디 입니다! 다른 아이디를 입력해주세요.");
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);// 400 BAD REQUEST 응답  
        
	}
	
}
