package com.itwillbs.web;

import java.io.IOException;
import java.io.OutputStream;
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
    
    
    
 // 엑셀 다운로드
    @GetMapping("/downloadExcel")
    public void downloadExcel(HttpServletResponse response,
                               @RequestParam String rcv_manager_id,
                               @RequestParam String rcv_number,
                               @RequestParam String prod_id,
                               @RequestParam String prod_category,
                               @RequestParam String prod_name,
                               @RequestParam String company_code,
                               @RequestParam String rcv_quantity,
                               @RequestParam String rcv_price,
                               @RequestParam String rcv_date,
                               @RequestParam String rcv_remarks) throws IOException {
        
        logger.debug("downloadExcel() 시작!");

        // Excel 파일 생성
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("입고명세표");

        // 제목 스타일 생성
        CellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        Font titleFont = workbook.createFont();
        titleFont.setBold(true); // 제목 볼드 설정
        titleFont.setFontHeightInPoints((short) 20); // 제목 폰트 크기 증가
        titleStyle.setFont(titleFont);

        // 제목 추가
        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("입고명세표");
        titleCell.setCellStyle(titleStyle);
        
        // 제목 셀 병합
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 1)); // 첫 번째 행의 첫 번째 및 두 번째 열 병합
        sheet.getRow(0).setHeightInPoints(50); // 제목 셀 높이 설정

        // 스타일 생성
        CellStyle borderStyle = workbook.createCellStyle();
        borderStyle.setBorderTop(BorderStyle.THIN);
        borderStyle.setBorderBottom(BorderStyle.THIN);
        borderStyle.setBorderLeft(BorderStyle.THIN);
        borderStyle.setBorderRight(BorderStyle.THIN);
        borderStyle.setAlignment(HorizontalAlignment.CENTER);
        borderStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.cloneStyleFrom(borderStyle);
        Font headerFont = workbook.createFont();
        headerFont.setBold(true); // 헤더 볼드 설정
        headerFont.setFontHeightInPoints((short) 14); // 헤더 폰트 크기 증가
        headerStyle.setFont(headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); // 연한 회색으로 변경
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // 헤더 추가
        Row headerRow = sheet.createRow(1); // 헤더는 1번째 행에 추가
        Cell headerCell1 = headerRow.createCell(0);
        headerCell1.setCellValue("항목");
        headerCell1.setCellStyle(headerStyle);
        
        Cell headerCell2 = headerRow.createCell(1);
        headerCell2.setCellValue("내용");
        headerCell2.setCellStyle(headerStyle);

        // 데이터 추가
        String[][] data = {
            {"입고 담당자", rcv_manager_id},
            {"입고 관리번호", rcv_number},
            {"제품 식별코드", prod_id},
            {"카테고리", prod_category},
            {"품목명", prod_name},
            {"거래처", company_code},
            {"입고 수량", rcv_quantity},
            {"가격(단가)", rcv_price},
            {"입고 날짜", rcv_date},
            {"비고", rcv_remarks}
        };

        for (int i = 0; i < data.length; i++) {
            Row row = sheet.createRow(i + 2); // 데이터는 2번째 행부터 시작
            for (int j = 0; j < data[i].length; j++) {
                Cell cell = row.createCell(j);
                cell.setCellValue(data[i][j]);
                cell.setCellStyle(borderStyle); // 테두리 스타일 적용
            }
        }

        // 열 너비 조정 (수동 설정)
        sheet.setColumnWidth(0, 30 * 256); // 첫 번째 열 너비 설정
        sheet.setColumnWidth(1, 50 * 256); // 두 번째 열 너비 설정

        // 응답 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"입고명세표.xlsx\"");

        // 파일 다운로드
        try (OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        }

        workbook.close();
    }


}

    
