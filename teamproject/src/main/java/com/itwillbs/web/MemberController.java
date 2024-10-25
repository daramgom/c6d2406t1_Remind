package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	Map<String, String> response = new HashMap<>();
	
	@Inject
	private MemberService mService;
	
	@Inject
	private SnsValue naverSns;
	
	@Inject
	private UserService uService;
	
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
	
	
	
	@PostMapping("/postInfo")
    public ResponseEntity<Map<String, Object>> postInfo() {
    	
    	Map<String, Object> result	= mService.getInfo();
    	logger.debug("result : " + result);
    	
        return ResponseEntity.ok(result);
    }
    
    @PostMapping("/logout")
    public ResponseEntity<Map<String, String>> logout(HttpSession session) {
    	response.clear(); // 메서드 시작 시 초기화
    	logger.debug("로그아웃 실행됨");
    	// 로그 아웃
    	session.invalidate();
    	logger.debug("로그아웃 실행됨");
    	
    	
	    response.put("message", "로그아웃이 정상적으로 실행되었습니다.");
    	    
	    return ResponseEntity.ok(response); // 200 OK와 함께 JSON 응답
    }
    
    @PostMapping("/updateMemberInfo")
    public ResponseEntity<String> updateMemberInfo(@RequestBody Map<String, String> request , HttpSession session) {
        // 요청 본문에서 데이터를 추출
        String member_id = (String)session.getAttribute("id"); 
        String field = request.get("field");
        String newValue = request.get("new_value");

        // 여기서 id, field, newValue를 사용하여 데이터베이스를 업데이트하는 로직을 추가합니다.
        System.out.println("ID: " + member_id + ", field: " + field + ", New Value: " + newValue);
        
        MemberVO result = mService.memberUpdateInfo(member_id , field, newValue);
        logger.debug("result 컨트롤러 : "+result);
        if(result.getMember_id() == null) {
        	return ResponseEntity.ok("{\"success\": false }");
        }
        session.setAttribute("name", result.getMember_name());
		session.setAttribute("tel", result.getMember_tel());

        // 예시 응답
        return ResponseEntity.ok("{\"success\": true }");
    }
    ///////////////////////////////////////////// 회원가입 ////////////////////////////////////////////// 
    ///////////////////////////////////////////// 회원가입 ////////////////////////////////////////////// 
 // http://localhost:8088/signup
 	@RequestMapping(value ="signup" , method=RequestMethod.GET)
 	public void signupGet(  Model model , UserVO uvo) {
 		
 		logger.info("signupPage get 실행 ");
 		logger.info("uvo  : " + uvo);
 		
 		model.addAttribute("member" , uvo);
 	}
 	
 	// http://localhost:8088/signup
 	@RequestMapping(value ="signup" , method=RequestMethod.POST)
 	public void signupPOST(HttpSession session ,UserVO vo, Model model) {
 		logger.debug("vo : " + vo);
 		model.addAttribute("member",vo );
 		session.removeAttribute("userInfo");
 	}
 	
 	
 	// http://localhost:8088/membersignup
 	@RequestMapping(value ="membersignup" , method=RequestMethod.POST)
 	public ResponseEntity<Map<String, String>> memberSignUpPost(@RequestBody MemberVO vo) {
 		response.clear();

 		String result = mService.memberJoin(vo);

 		// 중복 체크에 대한 메시지를 매핑
 		Map<String, String> messageMap = new HashMap<>();
 		messageMap.put("아이디 중복", "이미 등록된 아이디입니다.");
 		messageMap.put("이메일 중복", "이미 등록된 이메일입니다.");
 		messageMap.put("전화번호 중복", "이미 등록된 전화번호입니다.");

 		if (messageMap.containsKey(result)) {
 		    response.put("message", messageMap.get(result));
 		    return ResponseEntity.ok(response); // 200 OK 응답
 		}

 		// 회원가입 실행
 		response.put("message", "회원가입이 성공적으로 완료되었습니다!");
 		return ResponseEntity.ok(response); // 200 OK 응답
 	}
 	
 	@RequestMapping(value ="/checkUserId" , method=RequestMethod.POST)
 	public ResponseEntity<Map<String, String>> memberIdcheck(@RequestBody MemberVO vo) {
 		response.clear();
 		
 		
 		logger.info("memberId 중복검사 : "+vo.getMember_id() );
 		String member_id = vo.getMember_id();
 		
 		MemberVO result =  mService.memberIdCheck(member_id);
 		logger.debug("result" + result);
 		
 		
 		if(result == null) {
 			response.put("message", "사용가능한 아이디 입니다!");
 			return ResponseEntity.ok(response); // 200 OK 응답  
     	}
     	
 		response.put("message", "이미 등록된 아이디 입니다! 다른 아이디를 입력해주세요.");
 		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);// 400 BAD REQUEST 응답  
         
 	}
 	///////////////////////////////////////////// 회원가입 ////////////////////////////////////////////// 
 	///////////////////////////////////////////// 회원가입 ////////////////////////////////////////////// 
 	
 	
 	
 	///////////////////////////////////////////// 로그인 , 비밀번호 찾기  ////////////////////////////////////////////// 
 	///////////////////////////////////////////// 로그인 , 비밀번호 찾기  ////////////////////////////////////////////// 
 // http://localhost:8088/login
 	@RequestMapping(value = "/login", method = RequestMethod.GET)
 	public String snsLogin(Model model) {
 		logger.info(" Login page ");
 		/*
 		 * SNSLogin snsLogin = new SNSLogin(naverSns);
 		 * 
 		 * model.addAttribute("naver_url", snsLogin.getNaverAuthURL());
 		 */
 		
 		return "login";
 	}
 	
 	// 로그인 
 	@RequestMapping( value = "login" , method= RequestMethod.POST )
 	public ResponseEntity<Map<String, String>> login(@RequestBody MemberVO vo, HttpSession session) {
 		response.clear(); // 메서드 시작 시 초기화
 		logger.info("로그인  VO :  " + vo );
 		
 		MemberVO result = mService.memberLoginCheck(vo);
 		logger.info("result :  " + result );
 		
 		
 	
 		if (result == null) {
 		    // 아이디가 존재하지 않음
 		    response.put("code", "NOT_REGISTERED");
 		    response.put("message", "등록된 회원이 아닙니다!");
 		} else if (result.getMember_pw() == null) {
 		    // 비밀번호 틀림
 		    response.put("code", "INVALID_PASSWORD");
 		    response.put("message", "비밀번호가 일치하지 않습니다.");
 		} else {
 		    // 로그인 성공
 			response.put("code", "SUCCESS");
 		    response.put("message", "로그인 성공");
 		    // 세션 설정 등 추가 로직
 		    sessionAdd(session, result);
 		}

 		return ResponseEntity.ok(response);
 	}
 	
 	
 	// SNS 로그인
 	@RequestMapping(value = "/auth/naver/callback", method = {RequestMethod.GET, RequestMethod.POST})
 	public String loginCallback(@RequestParam String code, HttpSession session, RedirectAttributes rttr) throws Exception {
 	    SNSLogin snsLogin = new SNSLogin(naverSns);
 	    UserVO snsUser = snsLogin.getUserProfile(code);
 	    
 	    logger.info("Profile >> " + snsUser);
 	    
 	    // sns로그인한 사용자의 전화번호를 DB에 있는 member 테이블과 비교함.
 	    MemberVO result = uService.getBySns(snsUser.getTel());
 	    System.out.println("result : " + snsUser);
 	    
 	    // 비교해서 member 없으면 -> 회원가입 페이지
 	    if (result == null) {
 	    	rttr.addFlashAttribute("isFirstVisit", "SNS"); // => 이걸 1회성인 model 객체임. 
 	    	session.setAttribute("userInfo", snsUser); // 세션에 UserVO 객체 저장 
 	        return "redirect:/notify"; // notify 페이지로 리다이렉트
 	    } 
 	    
 	    // 비교해서 member 있으면 -> 해당하는 member 정보로 로그인 -> 메인 페이지
 	    sessionAdd(session, result);
 	    return "redirect:/main"; // 메인 페이지로 리다이렉트
 	};
 	
 	
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
 	};
 	
 	// 비밀번호 찾기 페이지
 	@RequestMapping(value = "pwInquiry" , method = RequestMethod.GET)
 	public void pwInquiryGet() {
 		logger.info("pwInquiry");
 		
 		
 	};
 	
 	// 비밀번호 찾기 페이지
  	@RequestMapping(value = "pwInquiry" , method = RequestMethod.POST)
  	public ResponseEntity<Map<String, String>> pwInquiryPost(@RequestBody MemberVO vo) {
  		logger.info("pwInquiry POST" + vo);
  		response.clear(); // 메서드 시작 시 초기화
  		
  		int result = mService.memberUpdatePw(vo);
  		
  		if(result == 0) {
  			response.put("result", "false");
  			response.put("message", "비밀번호 변경중 오류가 발생하였습니다.");
  			
  		}
  		
  		response.put("result", "true");
  		response.put("message", "비밀번호가 변경되었습니다.");
  		return ResponseEntity.ok(response);
  		
  	};
 	
 	
 	
 	///////////////////////////////////////////// 로그인 , 비밀번호 찾기  ////////////////////////////////////////////// 
 	///////////////////////////////////////////// 로그인 , 비밀번호 찾기  ////////////////////////////////////////////// 
    
}
