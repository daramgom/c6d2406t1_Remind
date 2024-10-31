package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.itwillbs.service.EmailService;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.MySessionListener;
import com.itwillbs.service.UserService;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	Map<String, String> response = new HashMap<>();
	
	@Inject
	private MemberService mService;
	
    @Autowired
    private EmailService emailService;

	
	// 아이디 찾기 페이지
 	@RequestMapping(value = "idInquiry" , method = RequestMethod.GET)
 	public void idInquiryGet() {
 	};
 	

 	// 아이디 찾기 페이지
 	@RequestMapping(value = "idInquiry" , method = RequestMethod.POST)
 	public ResponseEntity<Map<String, String>> idInquiryPost(@RequestBody MemberVO vo) {
 		response.clear(); // 메서드 시작 시 초기화
 		
 		MemberVO result = mService.memberNameEmailSearch(vo);
  		
  		if(result == null ) {
  			response.put("result", "false");
  			response.put("message", "등록된 회원정보와  다릅니다.");
  			return ResponseEntity.ok(response);
  		}
  		
  		response.put("result", "true");
  		response.put("message", "요청하신 회원 ID입니다.");
  		response.put("id", result.getMember_id());
  		return ResponseEntity.ok(response);
 	};
	 	
 	// 비밀번호 찾기 페이지
 	@RequestMapping(value = "pwInquiry" , method = RequestMethod.GET)
 	public void pwInquiryGet() {
 	};
	 	
	 	
 	// 비밀번호 찾기 페이지
  	@RequestMapping(value = "pwInquiry" , method = RequestMethod.POST)
  	public ResponseEntity<Map<String, String>> pwInquiryPost(@RequestBody MemberVO vo) {
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
  	
  	// id 찾기에 사용되는 메서드
    @PostMapping("/findMemberInfo")
    public ResponseEntity<Map<String, String>> findMemberInfo(@RequestBody MemberVO vo) {
		response.clear(); // 메서드 시작 시 초기화
		MemberVO result = mService.memberIdEmailSearch(vo);
		
		
		if(result == null) {
			response.put("message", "등록된 정보와 다릅니다.");
			response.put("result", "false");
			return	ResponseEntity.ok(response); // 200 응답
		}
		
		emailService.sendVerificationCode(result.getMember_email()); 
		
		response.put("result", "true");
		response.put("message", "인증 코드가 이메일로 전송되었습니다!");
		return ResponseEntity.ok(response); // 200 OK 응답  		
    }
  	
  	// 비밀번호 찾기에 사용되는 메서드
    @PostMapping("/sendEmailCode")
    public ResponseEntity<Map<String, String>> sendEmailCode(@RequestBody MemberVO vo) {
    	response.clear(); // 메서드 시작 시 초기화
    	
		try {
			emailService.sendVerificationCode(vo.getMember_email());
		    response.put("message", "인증 코드가 이메일로 전송되었습니다!");
	        response.put("result", "true");
	        return ResponseEntity.ok(response); // 200 OK 응답
		} catch (Exception e) {
	        response.put("message", "인증 코드 전송에 실패했습니다. 다시 시도해주세요.");
	        response.put("result", "false");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response); // 500 Internal Server Error 응답
		}
    }


	@PostMapping("/postInfo")
    public ResponseEntity<Map<String, Object>> postInfo() {
    	
    	Map<String, Object> result	= mService.getInfo();
    	
        return ResponseEntity.ok(result);
    }


    @PostMapping("/updateMemberInfo")
    public ResponseEntity<String> updateMemberInfo(@RequestBody Map<String, String> request , HttpSession session) {
        // 요청 본문에서 데이터를 추출
        String member_id = (String)session.getAttribute("id"); 
        String field = request.get("field");
        String newValue = request.get("new_value");

        // 여기서 id, field, newValue를 사용하여 데이터베이스를 업데이트하는 로직을 추가합니다.
        
        MemberVO result = mService.memberUpdateInfo(member_id , field, newValue);
        if(result.getMember_id() == null) {
        	return ResponseEntity.ok("{\"success\": false }");
        }
        session.setAttribute("name", result.getMember_name());
		session.setAttribute("tel", result.getMember_tel());

        // 예시 응답
        return ResponseEntity.ok("{\"success\": true }");
    }
    
}
