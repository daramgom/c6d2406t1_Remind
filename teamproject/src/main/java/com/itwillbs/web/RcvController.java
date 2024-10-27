package com.itwillbs.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.net.http.HttpRequest;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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

import com.itwillbs.domain.MemberVO;
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
    public String requestRcv(Model model) {
    	
        List<OrdersVO> RsList = receivingDAO.getRcvSupervisorInfo();
        model.addAttribute("RsList", RsList);
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
    public String receivingList(@RequestParam(required = false) String rcv_status, Model model) {
        List<ReceivingVO> receivingList;

        // 입고 상태에 따라 리스트를 가져옴
        if (rcv_status == null || rcv_status.isEmpty()) {
        	receivingList = receivingDAO.getAllReceivingRequests();
        } else {
            receivingList = receivingDAO.getReceivingByStatus(rcv_status);
        }

        model.addAttribute("receivingList", receivingList);

        List<OrdersVO> ordersList = receivingDAO.getAllOrderRequests();
        model.addAttribute("ordersList", ordersList); // ordersList를 동일한 모델에 추가

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

    //엑셀 파일 다운로드
    @GetMapping("/downloadExcel")
    public void downloadExcel(
            @RequestParam("rcv_manager_id") String rcvManagerId,
            @RequestParam("rcv_number") String rcvNumber,
            @RequestParam("prod_id") String prodId,
            @RequestParam("prod_category") String prodCategory,
            @RequestParam("prod_name") String prodName,
            @RequestParam("company_code") String companyCode,
            @RequestParam("rcv_quantity") String rcvQuantity,
            @RequestParam("rcv_price") String rcvPrice,
            @RequestParam("rcv_date") String rcvDate,
            @RequestParam("rcv_remarks") String rcvRemarks,
            HttpServletResponse response,HttpServletRequest request) throws IOException {
    	
    	        String filePath = request.getServletContext().getRealPath("/WEB-INF/OrdExcel.xlsx");

    	        // 파일 경로 출력
    	        System.out.println("File path: " + filePath);

    	        // 파일 존재 여부 확인
    	        File file = new File(filePath);
    	        if (!file.exists()) {
    	            throw new FileNotFoundException("파일이 존재하지 않습니다: " + filePath);
    	        }

    	        try (FileInputStream fis = new FileInputStream(filePath);
    	                XSSFWorkbook workbook = new XSSFWorkbook(fis)) {

    	               // 시트 가져오기
    	               Sheet sheet = workbook.getSheet("물품 입고서");
    	               if (sheet == null) {
    	                   throw new IllegalArgumentException("시트가 존재하지 않습니다: 물품 입고서");
    	               }

    	               // E5에 "입고 담당자" 데이터 삽입
    	               int rowIndex = 4; // 5번째 행 (0부터 시작)
    	               int colIndex = 4; // E열 (0부터 시작)

    	               Row row = sheet.getRow(rowIndex); // 5번째 행 가져오기
    	               if (row == null) {
    	                   row = sheet.createRow(rowIndex); // 행이 없으면 생성
    	               }

    	               Cell cell = row.createCell(colIndex); // E5 셀 생성
    	               cell.setCellValue(rcvDate); // 값 설정
    	               
    	               // L5:W5에 "ORD-2024-0001" 삽입
    	               Row headerRow = sheet.getRow(rowIndex); // 5번째 행
    	               if (headerRow == null) {
    	                   headerRow = sheet.createRow(rowIndex); // 행이 없으면 생성
    	               }
    	               
    	               // L5부터 W5까지 "ORD-2024-0001" 삽입
    	               for (int i = 11; i <= 22; i++) { // L(11)부터 W(22)까지
    	                   Cell orderCell = headerRow.createCell(i);
    	                   orderCell.setCellValue(rcvNumber);
    	               }

    	               // C14:E14, F14:G14, J14:L14, M14:N14, O14:R14에 값 삽입
    	               Row dataRow = sheet.getRow(13); // 14번째 행 (0부터 시작)
    	               if (dataRow == null) {
    	                   dataRow = sheet.createRow(13); // 행이 없으면 생성
    	               }

    	               // C14:E14 -> "P-4I4CD2-1004"
    	               for (int i = 2; i <= 4; i++) { // C(2)부터 E(4)까지
    	                   Cell cellCtoE = dataRow.createCell(i);
    	                   cellCtoE.setCellValue(prodId); //제품 식별코드
    	               }

    	               // F14:G14 -> "갤럭시북"
    	               for (int i = 5; i <= 6; i++) { // F(5)부터 G(6)까지
    	                   Cell cellFtoG = dataRow.createCell(i);
    	                   cellFtoG.setCellValue("갤럭시북"); //품목명
    	               }

    	               // J14:L14 -> "23"
    	               for (int i = 9; i <= 11; i++) { // J(9)부터 L(11)까지
    	                   Cell cellJtoL = dataRow.createCell(i);
    	                   cellJtoL.setCellValue(23); // 입고 수량
    	               }

    	               // M14:N14 -> "500"
    	               for (int i = 12; i <= 13; i++) { // M(12)부터 N(13)까지
    	                   Cell cellMtoN = dataRow.createCell(i);
    	                   cellMtoN.setCellValue(500); // 가격(단가)
    	               }

    	               // O14:R14 -> "23"
    	               for (int i = 14; i <= 17; i++) { // O(14)부터 R(17)까지
    	                   Cell cellOtoR = dataRow.createCell(i);
    	                   cellOtoR.setCellValue(23); //비고
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
    	               String encodedFileName = URLEncoder.encode("입고명세서.xlsx", "UTF-8").replaceAll("\\+", "%20");
    	               response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");

    	               // 파일 다운로드
    	               try (OutputStream out = response.getOutputStream()) {
    	                   workbook.write(out);
    	               }
    	           } catch (IOException e) {
    	               e.printStackTrace();
    	               // 예외 처리
    	           }
    	       }
}

    
