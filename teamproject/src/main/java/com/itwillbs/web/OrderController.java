package com.itwillbs.web;

import java.sql.Timestamp;
import java.util.List;

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


   
    // http://localhost:9161/web/order-insert
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
    public ResponseEntity<String> updateOrder(@RequestBody OrdersVO ordersVO){
    	orderService.updateOrder(ordersVO);
    	
    	return ResponseEntity.ok("발주정보가 수정되었습니다.");
    }
    
    
    
}