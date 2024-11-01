package com.itwillbs.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
    
    @PostMapping(value = "/updateOrder05")
    public String updateOrder05(OrdersVO ordersVO) {
    	logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ordersVO"+ordersVO);
    	orderService.updateOrder05(ordersVO);
    	
    	return "/order-list02";
    }
    
    @PostMapping(value = "/updateOrder04")
    public String updateOrder04(OrdersVO ordersVO) {
    	orderService.updateOrder04(ordersVO);
    	
    	return "/order-list02";
    }
    
    // 입고요청으로
    @GetMapping("/processRcvRQ")
    public String processRcvRQ(@RequestParam("ord_number") String ord_number, Model model) {
        // 필요한 데이터 모델에 추가하고 JSP로 포워딩
        model.addAttribute("ord_number", ord_number);
        
        return "rcvRQ";
    }
    
    // 엑셀 파일 다운로드
    @GetMapping("/downloadOrdExcel")
    public void downloadExcel(
            @RequestParam("ord_manager_id") String ordManagerId,
            @RequestParam("ord_number") String ordNumber,
            @RequestParam("prod_id") String prodId,
            @RequestParam("prod_category") String prodCategory,
            @RequestParam("prod_name") String prodName,
            @RequestParam("company_code") String companyCode,
            @RequestParam("ord_quantity") String ordQuantity,
            @RequestParam("ord_price") String ordPrice,
            @RequestParam("ord_date") String ordDate,
            @RequestParam("ord_remarks") String ordRemarks,
            HttpServletResponse response,HttpServletRequest request) throws IOException {
       
           logger.debug("ord_manager_id: {}", ordManagerId);
           logger.debug("prod_id: {}", prodId);
           logger.debug("prod_category: {}", prodCategory);
           logger.debug("ord_number: {}", ordNumber);
           logger.debug("prod_name: {}", prodName);
           logger.debug("company_code: {}", companyCode);
           logger.debug("ord_quantity: {}", ordQuantity);
           logger.debug("ord_price: {}", ordPrice);
           logger.debug("ord_date: {}", ordDate);
           logger.debug("ord_remarks: {}", ordRemarks);
           
           String filePath = request.getServletContext().getRealPath("/WEB-INF/PurchaseOrder.xlsx");

        // 파일 경로 출력

        // 파일 존재 여부 확인
        File file = new File(filePath);
        if (!file.exists()) {
            throw new FileNotFoundException("파일이 존재하지 않습니다: " + filePath);
        }

        try (FileInputStream fis = new FileInputStream(filePath);
                XSSFWorkbook workbook = new XSSFWorkbook(fis)) {

            // 시트 가져오기
            Sheet sheet = workbook.getSheet("제품 발주서");
            if (sheet == null) {
                throw new IllegalArgumentException("시트가 존재하지 않습니다: 제품 발주서");
            }

            // E5에 ordDate 데이터 삽입
            Row row5 = sheet.getRow(4); // 5번째 행 (0부터 시작)
            if (row5 == null) {
                row5 = sheet.createRow(4); // 행이 없으면 생성
            }
            for (int i = 4; i <= 6; i++) { // E(4)부터 G(6)까지
                Cell cellEtoG = row5.createCell(i);
                cellEtoG.setCellValue(ordDate); // 값 설정
            }

            // L5:W5에 ordNumber 삽입
            Row row5Header = sheet.getRow(4); // 5번째 행
            if (row5Header == null) {
                row5Header = sheet.createRow(4); // 행이 없으면 생성
            }
            for (int i = 11; i <= 22; i++) { // L(11)부터 W(22)까지
                Cell orderCell = row5Header.createCell(i);
                orderCell.setCellValue(ordNumber);
            }

            // L6:O6에 ordManagerId 삽입
            Row row6 = sheet.getRow(5); // 6번째 행 (0부터 시작)
            if (row6 == null) {
                row6 = sheet.createRow(5); // 행이 없으면 생성
            }
            for (int i = 11; i <= 14; i++) { // L(11)부터 O(14)까지
                Cell cellLtoO = row6.createCell(i);
                cellLtoO.setCellValue(ordManagerId); // ord_manager_id
            }

            // L7:O7에 companyCode 삽입
            Row row7 = sheet.getRow(6); // 7번째 행 (0부터 시작)
            if (row7 == null) {
                row7 = sheet.createRow(6); // 행이 없으면 생성
            }
            for (int i = 11; i <= 14; i++) { // L(11)부터 O(14)까지
                Cell cellLtoO = row7.createCell(i);
                cellLtoO.setCellValue(companyCode); // companyCode
            }

            // C14:E14에 prodId 삽입
            Row dataRow = sheet.getRow(13); // 14번째 행 (0부터 시작)
            if (dataRow == null) {
                dataRow = sheet.createRow(13); // 행이 없으면 생성
            }
            for (int i = 2; i <= 4; i++) { // C(2)부터 E(4)까지
                Cell cellCtoE = dataRow.createCell(i);
                cellCtoE.setCellValue(prodId); // 제품 식별코드
            }

            // F14:G14에 prodName 삽입
            for (int i = 5; i <= 6; i++) { // F(5)부터 G(6)까지
                Cell cellFtoG = dataRow.createCell(i);
                cellFtoG.setCellValue(prodName); // 품목명
            }

            // H14:L14에 prodCategory 삽입
            for (int i = 7; i <= 11; i++) { // H(7)부터 L(11)까지
                Cell cellHtoL = dataRow.createCell(i);
                cellHtoL.setCellValue(prodCategory); // 제품 카테고리
            }

            // M14:N14에 ordQuantity 삽입
            for (int i = 12; i <= 13; i++) { // M(12)부터 N(13)까지
                Cell cellMtoN = dataRow.createCell(i);
                cellMtoN.setCellValue(ordQuantity); // 입고 수량
            }

            // O14:R14에 ordPrice 삽입
            for (int i = 14; i <= 17; i++) { // O(14)부터 R(17)까지
                Cell cellOtoR = dataRow.createCell(i);
                cellOtoR.setCellValue(ordPrice); // 가격(단가)
            }

            // S14:U14에 ordRemarks 삽입
            for (int i = 18; i <= 20; i++) { // S(18)부터 U(20)까지
                Cell cellStoU = dataRow.createCell(i);
                cellStoU.setCellValue(ordRemarks); // 비고
            }

            // 인쇄 영역 설정: A1:W31
            int sheetIndex = workbook.getSheetIndex(sheet);
            workbook.setPrintArea(sheetIndex, 0, 22, 0, 30); // A1부터 W31까지 (열: 0~22, 행: 0~30)

            // 엑셀 파일 저장
            try (FileOutputStream fos = new FileOutputStream(filePath)) {
                workbook.write(fos);
            }

            // 응답 설정
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            String encodedFileName = URLEncoder.encode("발주명세서.xlsx", "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

            // 파일 다운로드
            try (OutputStream out = response.getOutputStream()) {
                workbook.write(out);
            }
        } catch (IOException e) {
            e.printStackTrace();
            // 예외 처리
        }  

    } // 엑셀 파일 다운로드
    
    
}