package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserVO;
import com.itwillbs.login.SNSLogin;
import com.itwillbs.login.SnsValue;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.MySessionListener;

@Controller
public class LoginController {

	Map<String, String> response = new HashMap<>();
	
	@Inject
	private MemberService mService;
	
	@Inject
	private SnsValue naverSns;
	
	@Autowired
 	private MySessionListener mySessionListener;
	
	// session 중복 코드
	private void sessionAdd (HttpSession session, MemberVO result) {
		// 비교해서 member 있으면 -> 해당하는 member 정보로 로그인 -> 메인 페이지
	    session.setAttribute("id", result.getMember_id());
		session.setAttribute("permission_id", result.getPermission_id());
		session.setAttribute("name", result.getMember_name());
		session.setAttribute("tel", result.getMember_tel());
		session.setAttribute("email", result.getMember_email());
		session.setAttribute("employee_rank", result.getEmployee_rank());
		session.setAttribute("department_id", result.getDepartment_id());
		session.setAttribute("member_state", result.getMember_state());
		session.setAttribute("member_code", result.getMember_code());
		
		// 밑에 있는걸로 변경할거임/
		/* session.setAttribute("resultMemberVO",result); */
	}
	
	// 로그인 페이지 Get 요청
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String snsLogin(Model model) {
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
		return "login";
	}
	
	// 로그인 페이지 Post 요청
 	@RequestMapping( value = "/login" , method= RequestMethod.POST )
 	public ResponseEntity<Map<String, String>> login(@RequestBody MemberVO vo, HttpSession session) {
 		response.clear(); // 메서드 시작 시 초기화
 		MemberVO result = mService.memberLoginCheck(vo);
 		if (result == null) {
 		    // 아이디가 존재하지 않음
 		    response.put("code", "NOT_REGISTERED");
 		    response.put("message", "등록된 회원이 아닙니다.");
 		} else if (result.getMember_pw() == null) {
 		    // 비밀번호 틀림
 		    response.put("code", "INVALID_PASSWORD");
 		    response.put("message", "비밀번호가 일치하지 않습니다.");
 		} else if(result.getApproval_status().equals("01")) {
 		   response.put("code", "REGISTRATION_PENDING"); // "회원가입 승인 대기 중"
 		    response.put("message", "회원가입 승인이 대기 중입니다.");
 		} else {
 			String sessionCheckKey = UUID.randomUUID().toString(); // 랜덤 키 생성
 			mySessionListener.addSession(result.getMember_id(),sessionCheckKey);
 			
 	        // 세션 추가
 			sessionAdd(session, result);

 		    // 로그인 성공
 			response.put("sessionCheckKey", sessionCheckKey); // 키 넘김
 			response.put("code", "SUCCESS");
 		    response.put("message", "로그인 성공");
 		}

 		return ResponseEntity.ok(response);
 	}

 	// sns로그인 -> 회원정보와 없으면  실행되는 중간다리 페이지.
 	@RequestMapping(value = "/notify", method = RequestMethod.GET)
 	public void notifyGET(Model model, HttpSession session) {
 		// 세션에서 UserVO 객체 가져오기
 	    UserVO userInfo = (UserVO) session.getAttribute("userInfo");
 	   session.removeAttribute("result_code");
 	    
 	    // userInfo를 사용할 수 있습니다.
 	    if (userInfo != null) {
 	        model.addAttribute("userInfo", userInfo); // 뷰에서 사용하기 위해 다시 모델에 추가
 	    }
 	};
 	
  	// sns로그인 -> 회원정보가 승인되지 않았다면  실행되는 중간다리 페이지.
  	@RequestMapping(value = "/pending", method = RequestMethod.GET)
  	public void pendingGET(Model model, HttpSession session) {
  		// 세션에서 UserVO 객체 가져오기
  	    model.addAttribute("snsCode" , "REGISTRATION_PENDING");
  	    session.removeAttribute("result_code");
  	};
  	
  	
	
	@PostMapping("/logout")
	public ResponseEntity<Map<String, String>> logout(HttpSession session) {
		response.clear();
		
	    String userId = (String) session.getAttribute("id");
	    if (userId != null) {
	        mService.logout(userId); // 세션 종료 시 사용자 ID 제거
	    }
	
	    // 세션 무효화
	    session.invalidate();
	    response.put("message", "로그아웃이 정상적으로 실행되었습니다.");
	    return ResponseEntity.ok(response); // 200 OK와 함께 JSON 응답
	}
	
	@RequestMapping( value ="/getSessionCheck" , method = RequestMethod.POST)
 	public ResponseEntity<Map<String, String>> getSessionCheck(@RequestBody Map<String, String> request, HttpSession session) {
 		String userId = (String) session.getAttribute("id");
 		String sessionCheckKey = request.get("sessionCheckKey");
 		
 		if(mySessionListener.validateSessionKey(userId, sessionCheckKey)) {
 			response.put("result", "true");
 		}else {
 			response.put("result", "false");
 		}
 		
 		// result_code가 세션에 존재하는지 확인하고 제거
 	    if (session.getAttribute("result_code") != null) {
 	        session.removeAttribute("result_code");
 	    }
 	    
 	    // result_code가 세션에 존재하는지 확인하고 제거
 	    if (session.getAttribute("sessionCheckKey") != null) {
 	        session.removeAttribute("sessionCheckKey");
 	    }
 	    
 		return ResponseEntity.ok(response);
 	}
}
