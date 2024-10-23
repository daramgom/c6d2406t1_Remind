package com.itwillbs.web;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.MemberService;

@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	Map<String, String> response = new HashMap<>();
	
	@Inject
	private MemberService mService;
	
	
	
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
        
        session.setAttribute("name", result.getMember_name());
		session.setAttribute("tel", result.getMember_tel());
		session.setAttribute("email", result.getMember_email());

        // 예시 응답
        return ResponseEntity.ok("{\"success\": true ");
    }
    
}
