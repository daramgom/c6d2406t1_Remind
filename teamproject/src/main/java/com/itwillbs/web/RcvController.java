package com.itwillbs.web;

import java.net.http.HttpRequest;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ReceivingVO;
import com.itwillbs.persistence.ReceivingDAO;


@Controller
public class RcvController {

    private static final Logger logger = LoggerFactory.getLogger(RcvController.class);

    @Autowired
    private ReceivingDAO receivingDAO; 


    //http://localhost:8088/rcvRQ
    // GET 요청 처리
    @GetMapping("/rcvRQ")
    public String requestRcv() {
        logger.debug("requestRcv() 페이지 로드");
        return "rcvRQ"; // JSP 페이지 이동
    }

    // POST 요청 처리
    @PostMapping("/rcvRQ")
    public void receiveRequest(@ModelAttribute ReceivingVO receivingVO , HttpSession session) {
        logger.debug("입고요청 완료");
        receivingVO.setRcv_manager_id((String)session.getAttribute("id"));
        receivingDAO.insertRcv(receivingVO); 
    }

    // 발주 관리번호로 제품 정보 가져오기
    @GetMapping("/getProductByOrderNumber")
    @ResponseBody // JSON 응답을 위해 추가
    public OrdersVO getProductByOrderNumber(@RequestParam("ord_number") String ord_number) {
        logger.debug("getProductByOrderNumber() 호출, ord_number: {}", ord_number);
        OrdersVO result = receivingDAO.getReceivingByOrderNumber(ord_number);
        logger.debug("result:"+result.getOrd_date());
        logger.debug("****************************************ord_supervisor_id: {}", result.getOrd_supervisor_id());
        return result;
    }
    
    //http://localhost:8088/rcvList2
    // 입고 목록,출고 목록
    @GetMapping("/rcvList2")
    public String receivingList(Model model, Model model2) {
        List<ReceivingVO> receivingList = receivingDAO.getAllReceivingRequests();
        model.addAttribute("receivingList", receivingList);
        
        List<OrdersVO> ordersList = receivingDAO.getAllOrderRequests();
        model2.addAttribute("ordersList", ordersList); // 각 모델에 데이터 추가

        return "rcvList2"; // JSP 파일 이름
    }
    
    //슬라이드 패널(발주 요청자,승인자)
    @PostMapping("/receiveOname")
    public ResponseEntity<OrdersVO> ordersname(@RequestBody OrdersVO vo){
    logger.info("1444"+vo);
    OrdersVO OnameList =  receivingDAO.getOrdersName(vo.getOrd_number());
    	 return ResponseEntity.ok(OnameList);
    }
    

    //입고 업데이트(승인)
    @PostMapping("/updateReceiving")
    @ResponseBody
    public ResponseEntity<?> updateReceiving(@RequestBody ReceivingVO receiving) {
        try {
            // 1. 기존 입고 요청 정보 업데이트
            receivingDAO.updateReceiving(receiving);
            
            // 2. 재고 정보 업데이트, 
            receivingDAO.insertIntoStock(receiving); // 이 메서드를 DAO에 추가해야 함

            return ResponseEntity.ok().body("업데이트 및 재고 추가 성공");
        } catch (Exception e) {
            logger.error("업데이트 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 실패");
        }
  
    }
    
    //입고반려
    @PostMapping("/rejectReceiving")
    @ResponseBody
    public ResponseEntity<?> rejectReceiving(@RequestBody Map<String, String> request) {
        try {
            String rcvNumber = request.get("rcv_number");
            receivingDAO.rejectReceiving(rcvNumber);
            return ResponseEntity.ok().body("입고가 반려되었습니다.");
        } catch (Exception e) {
            logger.error("반려 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("반려 실패");
        } 
    }
  
    
	 // 입고 수정
    
    @PostMapping("/editReceiving")
    @ResponseBody
    public ResponseEntity<?> editReceiving(@RequestBody ReceivingVO receiving) {
        try {
            receivingDAO.editReceiving(receiving);
            return ResponseEntity.ok().body("수정 완료");
        } catch (Exception e) {
            logger.error("수정 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패");
        }
    }
    
    // 입고 삭제
    @PostMapping("/deleteReceiving")
    @ResponseBody
    public ResponseEntity<?> deleteReceiving(@RequestBody Map<String, String> request) {
        try {
            String rcvNumber = request.get("rcv_number");
            logger.debug("입고 정보 삭제 시작, rcv_count: {}", rcvNumber);
            receivingDAO.deleteReceiving(rcvNumber);
            return ResponseEntity.ok().body("입고 정보가 삭제되었습니다.");
        } catch (Exception e) {
            logger.error("삭제 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }
    
    
    //입고 검색
    @GetMapping("/searchReceiving")
    public String searchReceiving(@RequestParam(required = false) String rcv_status, Model model) {
        List<ReceivingVO> receivingList;
        
        List<OrdersVO> ordersList = receivingDAO.getAllOrderRequests();
        model.addAttribute("ordersList", ordersList); // 각 모델에 데이터 추가

        if (rcv_status != null && !rcv_status.isEmpty()) {
            receivingList = receivingDAO.getReceivingByStatus(rcv_status);
        } else {
            receivingList = receivingDAO.getAllReceivingRequests();
        }

        model.addAttribute("receivingList", receivingList);
        return "rcvList2"; // JSP 파일 이름
    }

    
}