package com.itwillbs.web;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.CordersVO;
import com.itwillbs.service.CordersService;

@Controller
@RequestMapping(value = "/*")
public class CorderController {
	
	@Inject
	private CordersService corderService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(CorderController.class);
	
	// http://localhost:8088/order-insert02
    // 거래처 등록창 불러오기
	@RequestMapping(value = "/order-insert02", method = RequestMethod.GET)
	public String insertOrderForm02(Model model, HttpSession session) {
		
		String userId = (String)session.getAttribute("id");
		String userMemberCode = (String)session.getAttribute("member_code");
		
		model.addAttribute("userId", userId);
		model.addAttribute("userMemberCode", userMemberCode);
		
		List<CordersVO> pListVO02 = corderService.listProd02();
		
		model.addAttribute("pListVO02", pListVO02);
		
		return "/order-insert02";
	}
	
	// 거래처 등록 처리하기
	@RequestMapping(value = "/order-insert02", method = RequestMethod.POST)
	public String insertOrder02(CordersVO cordersVO, HttpSession session) {
		corderService.insert02(cordersVO);
		
		String cord_number = cordersVO.getCord_number();
		
		session.setAttribute("cord_number", cord_number);
		
		return "redirect:/order-insert02";
	}
	
	
	// 거래처 발주 목록창 불러오기
	@GetMapping(value = "/order-list03")
	public String listOrderGet03(Model model, HttpSession session) {
		
		String userId = (String)session.getAttribute("id");
		
		model.addAttribute("userId", userId);
		
		List<CordersVO> oListVO03 = corderService.listOrder03();
		List<CordersVO> pListVO02 = corderService.listProd02();
		List<CordersVO> mListVO02 = corderService.listManager02();
		
		model.addAttribute("oListVO03", oListVO03);
		model.addAttribute("pListVO02", pListVO02);
		model.addAttribute("mListVO02", mListVO02);
		
		return "/order-list03";
	}
	
	// 거래처 발주 수정하기
	@PostMapping(value = "/updateOrderC")
	public String updateOrderC(CordersVO cordersVO) {
		
		corderService.updateOrderC(cordersVO);
		
		return "/order-list03";
	}
	
	// 거래처 발주 삭제하기
	@PostMapping(value = "/deleteOrderC")
	public String deleteOrderC(CordersVO cordersVO) {
		
		corderService.deleteOrderC(cordersVO);
		
		return "/order-list03";
	}
	
}
