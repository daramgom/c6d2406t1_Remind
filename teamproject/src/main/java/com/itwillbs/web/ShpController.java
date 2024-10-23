package com.itwillbs.web;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ShippingVO;
import com.itwillbs.persistence.ShippingDAO;

@Controller
public class ShpController {

    private static final Logger logger = LoggerFactory.getLogger(ShpController.class);

    @Autowired
    private ShippingDAO shippingDAO;

    // http://localhost:8088/shpRQ
    // 출고 요청 페이지
    @GetMapping("/shpRQ")
    public String requestShipping() {
        logger.debug("requestShipping() 페이지 로드");
        return "shpRQ"; // JSP 페이지 이동
    }

    // POST 요청 처리: 출고 요청 저장
    @PostMapping("/shpRQ")
    public String shippingRequest(@ModelAttribute ShippingVO shippingVO) {
        logger.debug("출고 요청 완료");
        shippingDAO.insertShippingRequest(shippingVO);
        return "redirect:/shpRQ"; // 출고 요청 후 페이지 리다이렉트
    }

    // 발주 관리번호로 제품 정보 가져오기
    @GetMapping("/getShippingProductByOrderNumber")
    @ResponseBody
    public OrdersVO getShippingProductByOrderNumber(@RequestParam("ord_number") String ord_number) {
        logger.debug("getShippingProductByOrderNumber() 호출, ord_number: {}", ord_number);
        OrdersVO result = shippingDAO.getShippingInfoByOrderNumber(ord_number);
        if (result != null) {
            logger.debug("제품 정보: {}", result);
        } else {
            logger.debug("해당 발주 관리번호에 대한 정보가 없습니다.");
        }
        return result;
    }
    // http://localhost:8088/shpList2
    // 출고 목록 조회
    @GetMapping("/shpList2")
    public String shippingList(Model model,Model model2) {
  
        List<ShippingVO> shippingList = shippingDAO.getAllShippingRequests();
        model.addAttribute("shippingList", shippingList);
        
        List<OrdersVO> ordersList = shippingDAO.getAllOrderRequests();
        model2.addAttribute("ordersList", ordersList); // 각 모델에 데이터 추가
 

        return "shpList2"; // 수정된 JSP 파일 이름
    }
    
 
    
    //슬라이드 패널(발주 요청자,승인자)
    @PostMapping("/receiveOnameS")
    public ResponseEntity<OrdersVO> ordersname(@RequestBody OrdersVO vo){
    logger.info("1444"+vo);
    OrdersVO OnameList =  shippingDAO.getOrdersName(vo.getOrd_number());
    	 return ResponseEntity.ok(OnameList);
    }
  
    
    

    // 출고 업데이트 (승인)
    @PostMapping("/updateShipping")
    @ResponseBody
    public ResponseEntity<?> updateShipping(@RequestBody ShippingVO shipping) {
        try {
            shippingDAO.updateShipping(shipping);
            shippingDAO.updateStockForShipping(shipping);
            
            return ResponseEntity.ok().body("출고 업데이트 및 재고 감소 성공!");

            
        } catch (Exception e) {
            logger.error("출고 요청 업데이트 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("출고 요청 업데이트 실패");
        }
    }

    // 출고 반려
    @PostMapping("/rejectShipping")
    @ResponseBody
    public ResponseEntity<?> rejectShipping(@RequestBody Map<String, String> request) {
        try {
            String shpNumber = request.get("shp_number");
            shippingDAO.rejectShipping(shpNumber);
            return ResponseEntity.ok().body("출고가 반려되었습니다.");
        } catch (Exception e) {
            logger.error("출고 반려 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("출고 반려 실패");
        }
    }

    // 출고 수정
    @PostMapping("/editShipping")
    @ResponseBody
    public ResponseEntity<?> editShipping(@RequestBody ShippingVO shipping) {
        try {
            shippingDAO.editShipping(shipping);
            return ResponseEntity.ok().body("출고 수정 완료");
        } catch (Exception e) {
            logger.error("출고 수정 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("출고 수정 실패");
        }
    }

    // 출고 삭제
    @PostMapping("/deleteShipping")
    @ResponseBody
    public ResponseEntity<?> deleteShipping(@RequestBody Map<String, String> request) {
        try {
            String shpNumber = request.get("shp_number");
            shippingDAO.deleteShipping(shpNumber);
            return ResponseEntity.ok().body("출고 정보가 삭제되었습니다.");
        } catch (Exception e) {
            logger.error("출고 삭제 실패: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("출고 삭제 실패");
        }
    }

    // 출고 검색
    @GetMapping("/searchShipping")
    public String searchShipping(@RequestParam(required = false) String shp_status, Model model) {
        List<ShippingVO> shippingList;
        
        List<OrdersVO> ordersList = shippingDAO.getAllOrderRequests();
        model.addAttribute("ordersList", ordersList); // 각 모델에 데이터 추가

        if (shp_status != null && !shp_status.isEmpty()) {
            shippingList = shippingDAO.getShippingByStatus(shp_status);
        } else {
            shippingList = shippingDAO.getAllShippingRequests();
        }

        model.addAttribute("shippingList", shippingList);
        return "shpList2"; // 수정된 JSP 파일 이름
    }
 
    
    
}
   
