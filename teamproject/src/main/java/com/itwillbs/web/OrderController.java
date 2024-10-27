package com.itwillbs.web;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.persistence.OrdersDAO;
import com.itwillbs.persistence.ReceivingDAO;
import com.itwillbs.service.OrdersService;

@Controller
@RequestMapping(value = "/*")
public class OrderController {
	
	@Inject
	private OrdersService orderService;
	
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);


    
//    // http://localhost:8088/order-insert
//    // 등록창 불러오기
//    @RequestMapping(value = "/order-insert", method = RequestMethod.GET)
//    public String insertOrderForm(Model model) {
//    	
//    	
//        
//        return "/order-insert";
//    }
    
    // http://localhost:8088/order-insert
    // 등록창 불러오기
    @RequestMapping(value = "/order-insert", method = RequestMethod.GET)
    public String insertOrderForm(Model model, HttpSession session) {
    	
    	String userId = (String) session.getAttribute("id");
    	String userMemberCode = (String)session.getAttribute("member_code");
    	
    	// 뷰페이지에서 처리 예정
//    	if(id == null) {
//    		return "redirect:/login";
//    	}
    	
    	model.addAttribute("userId", userId);
    	model.addAttribute("userMemberCode", userMemberCode);
    	
    	List<OrdersVO> sListVO = orderService.listSupervisor();
    	List<OrdersVO> pListVO = orderService.listProd();
    	List<OrdersVO> wListVO = orderService.listWarehouse();
    	
    	model.addAttribute("sListVO", sListVO);
    	model.addAttribute("pListVO", pListVO);
    	model.addAttribute("wListVO", wListVO);
    	
    	logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@sListVO : "+sListVO);
    	logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@pListVO : "+pListVO);
    	logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@wListVO : "+wListVO);
    	
    	
        return "/order-insert";
    }
    
    // 등록 처리하기
    @RequestMapping(value = "/order-insert", method = RequestMethod.POST)
    public String insertOrder(OrdersVO ordersVO, RedirectAttributes rttr) {
    	logger.debug("ordersVO = " +ordersVO);
    	
    	orderService.insert(ordersVO);
    	
    	// 결과 확인 값을 전달(1회성)
    	rttr.addFlashAttribute("checkPage", "insertOK");
    	
    	return "redirect:/order-list";
    }
    
    
    
    
    // 목록창 불러오기
    @GetMapping(value = "/order-list")
    public String listOrderGet(Model model, HttpSession session) {
    	
		String userId = (String)session.getAttribute("id");
		String userMemberCode = (String)session.getAttribute("member_code");
		String userPermissionId = (String)session.getAttribute("permission_id");
		    	
    	// 뷰페이지에서 처리 예정
//    	if(id == null) {
//    		return "redirect:/login";
//    	}
		
		model.addAttribute("userId", userId);
		model.addAttribute("userMemberCode", userMemberCode);
		model.addAttribute("userPermissionId", userPermissionId);
    	
    	List<OrdersVO> oListVO = orderService.listOrder();
    	List<OrdersVO> mListVO = orderService.listManager();
    	List<OrdersVO> sListVO = orderService.listSupervisor();
    	List<OrdersVO> pListVO = orderService.listProd();
    	List<OrdersVO> wListVO = orderService.listWarehouse();
    	
    	model.addAttribute("oListVO", oListVO);
    	model.addAttribute("mListVO", mListVO);
    	model.addAttribute("sListVO", sListVO);
    	model.addAttribute("pListVO", pListVO);
    	model.addAttribute("wListVO", wListVO);
    	
    	return "/order-list";
    }
    
    // 거래처 페이지 목록창 불러오기
    @GetMapping(value = "/order-list02")
    public String listOrderGet02(Model model, HttpSession session) {
    	
		String userId = (String)session.getAttribute("id");
		String userMemberCode = (String)session.getAttribute("member_code");
		String userPermissionId = (String)session.getAttribute("permission_id");
		    	
    	// 뷰페이지에서 처리 예정
//    	if(id == null) {
//    		return "redirect:/login";
//    	}
		
		model.addAttribute("userId", userId);
		model.addAttribute("userMemberCode", userMemberCode);
		model.addAttribute("userPermissionId", userPermissionId);
    	
    	List<OrdersVO> oListVO02 = orderService.listOrder02();
    	List<OrdersVO> mListVO = orderService.listManager();
    	List<OrdersVO> sListVO = orderService.listSupervisor();
    	List<OrdersVO> pListVO = orderService.listProd();
    	List<OrdersVO> wListVO = orderService.listWarehouse();
    	
    	model.addAttribute("oListVO02", oListVO02);
    	model.addAttribute("mListVO", mListVO);
    	model.addAttribute("sListVO", sListVO);
    	model.addAttribute("pListVO", pListVO);
    	model.addAttribute("wListVO", wListVO);
    	
    	return "/order-list02";
    }
    
    // 발주 수정하기 / 발주 재요청하기
    @PostMapping(value = "/updateOrder")
	public String updateOrder(OrdersVO ordersVO){
    	
    	System.out.println("@@@@@@@@@@@"+ordersVO);
    	
    	logger.debug("@@@@@@@@@@@@@@@@@@@@원래는 data였음ordersVO : "+ordersVO);
    	
		orderService.updateOrder(ordersVO);
    	
    	return "/order-list";
    }
    
    // 발주 정보 삭제하기
    @PostMapping(value = "/deleteOrder")
    public String deleteOrder(OrdersVO ordersVO) {
    	orderService.deleteOrder(ordersVO);
    	
    	return "/order-list";
    }
    
    // 발주 승인하기
    @PostMapping(value = "/updateOrder03")
    public String updateOrder03(OrdersVO ordersVO) {
    	orderService.updateOrder03(ordersVO);
    	
    	return "/order-list";
    }
    
    // 발주 반려하기
    @PostMapping(value = "/updateOrder02")
    public String updateOrder02(OrdersVO ordersVO) {
    	orderService.updateOrder02(ordersVO);
    	
    	return "/order-list";
    }
    
    // 입고요청으로
    @GetMapping("/processRcvRQ")
    public String processRcvRQ(@RequestParam("ord_number") String ord_number, Model model) {
        // 필요한 데이터 모델에 추가하고 JSP로 포워딩
        model.addAttribute("ord_number", ord_number);
        
        return "rcvRQ";
    }
    
    
}