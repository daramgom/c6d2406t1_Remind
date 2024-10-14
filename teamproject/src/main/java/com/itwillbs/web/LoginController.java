package com.itwillbs.web;


import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.login.SNSLogin;
import com.itwillbs.login.SnsValue;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	Map<String, String> response = new HashMap<>();
	
	@Inject
	private SnsValue naverSns;
	
	@Inject
	private UserService uService;
	
	@Inject
	private MemberService mService;
	
	// session 중복 코드
	private void sessionAdd (HttpSession session, MemberVO result) {
		// 비교해서 member 있으면 -> 해당하는 member 정보로 로그인 -> 메인 페이지
	    session.setAttribute("isFirstVisit", false);
	    session.setAttribute("id", result.getMember_id());
		session.setAttribute("name", result.getMember_name());
		session.setAttribute("member_Status", result.getMember_state());
	}
	
	
	// http://localhost:8088/login
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String snsLogin(Model model) {
		logger.info(" Login page ");
		SNSLogin snsLogin = new SNSLogin(naverSns);
		
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		
		return "login";
	}
	
	// 로그인 
	@RequestMapping( value = "login" , method= RequestMethod.POST )
	public ResponseEntity<Map<String, String>> login(MemberVO vo, HttpSession session) {
		response.clear(); // 메서드 시작 시 초기화
		logger.info("로그인  VO :  " + vo );
		
		MemberVO result = mService.memberLoginCheck(vo);
		logger.info("result :  " + result );
		
		
		if(result == null) {
			// DB 테이블에 등록된 회원이 아님.
			response.put("message", "등록된 회원이 아닙니다!");
			return ResponseEntity.ok(response); // 200 OK 응답  
		}
		if(result.getApproval_status().equals("1")) {
			// 승인되지 않은 회원
			response.put("message", "회원가입 승인 검토중 입니다.");
			return ResponseEntity.ok(response); // 200 OK 응답
		}
		
		// 회원 정상적인 로그인
		sessionAdd(session, result);
		response.put("message", "반갑습니다.");
		return ResponseEntity.ok(response); // 200 OK 응답
	}
	
	
	// SNS 로그인
	@RequestMapping(value = "/auth/naver/callback", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginCallback(@RequestParam String code, HttpSession session) throws Exception {
	    SNSLogin snsLogin = new SNSLogin(naverSns);
	    UserVO snsUser = snsLogin.getUserProfile(code);
	    
	    logger.info("Profile >> " + snsUser);
	    
	    // sns로그인한 사용자의 전화번호를 DB에 있는 member 테이블과 비교함.
	    MemberVO result = uService.getBySns(snsUser.getTel());
	    System.out.println("result : " + snsUser);
	    
	    // 비교해서 member 없으면 -> 회원가입 페이지
	    if (result == null) {
	    	session.setAttribute("isFirstVisit", true);
	    	session.setAttribute("userInfo", snsUser); // 세션에 UserVO 객체 저장
	        return "redirect:/notify"; // notify 페이지로 리다이렉트
	    } 
	    
	    // 비교해서 member 있으면 -> 해당하는 member 정보로 로그인 -> 메인 페이지
	    sessionAdd(session, result);
	    return "redirect:/index"; // 메인 페이지로 리다이렉트
	}
	
	
	// http://localhost:8088/notify
	// sns로그인 -> 회원정보와 없으면  실행되는 중간다리 페이지.
	@RequestMapping(value = "/notify", method = RequestMethod.GET)
	public void notifyGET(Model model, HttpSession session) {
		// 세션에서 UserVO 객체 가져오기
	    UserVO userInfo = (UserVO) session.getAttribute("userInfo");
	    
	    // userInfo를 사용할 수 있습니다.
	    if (userInfo != null) {
	        model.addAttribute("userInfo", userInfo); // 뷰에서 사용하기 위해 다시 모델에 추가
	    }
	}

}
