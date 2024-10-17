package com.itwillbs.web;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

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


   
    // http://localhost:8088/order-insert
    @RequestMapping(value = "/order-insert", method = RequestMethod.GET)
    public String insertOrderForm() {
        
        return "/order-insert";
    }

    @RequestMapping(value = "/order-insert", method = RequestMethod.POST)
    public String insertOrder(OrdersVO ordersVO) {
    	logger.debug("ordersVO = " +ordersVO);
    	
    	orderService.insert(ordersVO);
    	
    	
    	return "/order-insert";
    }
    
    @GetMapping(value = "/order-list")
    public void listOrderGet(Model model) {
    	
    	List<OrdersVO> oListVO = orderService.listOrder();
    	
    	model.addAttribute("oListVO", oListVO);
    	
    }
    
    
    @PostMapping(value = "/updateOrder")
	public String updateOrder(OrdersVO ordersVO){
		orderService.updateOrder(ordersVO);
    	
    	logger.debug("@@@@@@@@@@@@@@@@@@@@원래는 data였음ordersVO : "+ordersVO);
    	
    	return "/order-list";
    }
    
    @PostMapping(value = "/deleteOrder")
    public String deleteOrder(OrdersVO ordersVO) {
    	orderService.deleteOrder(ordersVO);
    	
    	return "/order-list";
    }
    
    @PostMapping(value = "/updateOrder03")
    public String updateOrder03(OrdersVO ordersVO) {
    	orderService.updateOrder03(ordersVO);
    	
    	return "/order-list";
    }
    
    @PostMapping(value = "/updateOrder02")
    public String updateOrder02(OrdersVO ordersVO) {
    	orderService.updateOrder02(ordersVO);
    	
    	return "/order-list";
    }
    
    
}