package com.itwillbs.web;

import javax.inject.Inject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.MemberService;

@Controller
@RequestMapping(value="/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private MemberService mService;
	
	Map<String, String> response = new HashMap<>();;

	@RequestMapping(value = "adminMemberList", method = RequestMethod.GET)
	public void adminMemberListGET(Model model) {
		logger.debug("adminMemberListGET");
		
		List<MemberVO> memberList = mService.memberList("AllList");

		model.addAttribute("memberList", memberList);
	}

	@RequestMapping(value = "/getMemberInfo", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> memberDetails(@RequestBody MemberVO vo) {
		 Map<String, Object> memberInfo = mService.memberInfo(vo.getMember_id());

		 // 결과를 ResponseEntity로 반환
		 return ResponseEntity.ok(memberInfo);
	}
	
	@RequestMapping(value = "/updateMember" , method =RequestMethod.POST )
	public ResponseEntity<Map<String, String>> updateMember(@RequestBody MemberVO vo) {
		response.clear();
		logger.debug("updateMember : " + vo.getMember_id());
		int result = mService.memberUpdate(vo);
		
		logger.debug("성공 했을때. result : " +result);
		if(result == 0) {
			response.put("message", "오류");
			return ResponseEntity.ok(response); 
		}
		response.put("message", "수정");
		return ResponseEntity.ok(response); 
	}
	@RequestMapping(value = "/deleteMember" , method =RequestMethod.POST )
	public ResponseEntity<Map<String, String>> deleteMember(@RequestBody MemberVO vo) {
		response.clear();
		
		logger.debug("updateMember : " + vo.getMember_id());
		int result = mService.memberDelete(vo);
		
		logger.debug("성공 했을때. result : " +result);
		if(result == 0) {
			response.put("message", "오류");
			return ResponseEntity.ok(response); 
		}
		response.put("message", "삭제");
		return ResponseEntity.ok(response); 
	}
	
	@RequestMapping(value = "/admin/signReq" , method = RequestMethod.GET)
	public void memberRequest(Model model) {
		logger.debug("signReq");
		
		List result = mService.memberList("WaitingList");
		logger.debug("result controller : "+ result.get(0));
		logger.debug("result controller : "+ result.get(1));
		logger.debug("result controller : "+ result.get(2));

		
		model.addAttribute("WaitingList", result.get(0));
		model.addAttribute("EmpList", result.get(1));
		model.addAttribute("DeptList", result.get(2));
		
		
		
	}
}
