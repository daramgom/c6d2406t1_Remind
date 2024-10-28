package com.itwillbs.web;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

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
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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

import com.itwillbs.domain.CordersVO;
import com.itwillbs.domain.OrdersVO;
import com.itwillbs.domain.ProdVO;
import com.itwillbs.domain.ReceivingVO;
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
    public String requestShipping(Model model) {
        List<OrdersVO> SsList = shippingDAO.getShpSupervisorInfo();
        model.addAttribute("SsList", SsList);
        logger.debug("requestShipping() 페이지 로드");
        return "shpRQ"; // JSP 페이지 이동
    }

    // POST 요청 처리: 출고 요청 저장
    @PostMapping("/shpRQ")
    public void shippingRequest(@ModelAttribute ShippingVO shippingVO, HttpSession session) {
        logger.debug("출고 요청 완료");
        shippingVO.setShp_manager_id((String)session.getAttribute("id"));
        shippingDAO.insertShippingRequest(shippingVO);

    }

    
    //거래처 발주 관리번호로 제품 정보 가져오기
    @GetMapping("/getShippingProductByCorderNumber")
    @ResponseBody
    public CordersVO getShippingProductByCorderNumber(@RequestParam("cord_number") String cord_number) {
        logger.debug("getShippingProductByCorderNumber() 호출, cord_number: {}", cord_number);
        CordersVO result = shippingDAO.getShippingInfoByCorderNumber(cord_number);
        if (result != null) {
            logger.debug("제품 정보: {}", result);
        } else {
            logger.debug("해당 발주 관리번호에 대한 정보가 없습니다.");
        }
        return result;
    }
    
    
    @GetMapping("/getwhNumberFromStock")
    @ResponseBody
    public List<ProdVO> getWhNumberFromStock(@RequestParam("prodId") String prodId) {
        logger.debug("getWhNumberFromStock() 호출 prodId:{}", prodId);
        List<ProdVO> result = shippingDAO.getwhNumberFromStock(prodId);
        return result;
    }

    // http://localhost:8088/shpList2
    // 출고 목록 조회+검색기능!
    @GetMapping("/shpList2")
    public String shippingList(@RequestParam(required = false) String shp_status, Model model ) {
  
        List<ShippingVO> shippingList;

        
        if(shp_status == null || shp_status.isEmpty()) {
        	shippingList = shippingDAO.getAllShippingRequests();
          
        } else {
        	
        	shippingList = shippingDAO.getShippingByStatus(shp_status);
        }
        
        model.addAttribute("shippingList", shippingList);
        logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+shippingList);
       

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

 
    @GetMapping("/downloadExcel2")
    public void downloadExcel2(
            @RequestParam("shpManagerId") String shpManagerId,
            @RequestParam("shpNumber") String shpNumber,
            @RequestParam("prodId") String prodId,
            @RequestParam("prodName") String prodName,
            @RequestParam("shpQuantity") String shpQuantity,
            @RequestParam("shpPrice") String shpPrice,
            @RequestParam("companyCode") String companyCode,
            @RequestParam("shpDate") String shpDate,
            @RequestParam("shpRemarks") String shpRemarks,
            HttpServletResponse response) throws IOException {

        logger.debug("downloadExcel2() 시작!");

        // Excel 파일 생성
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("출고 명세서");

        // 제목 스타일 생성
        CellStyle titleStyle = workbook.createCellStyle();
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 20);
        titleStyle.setFont(titleFont);

        // 제목 추가
        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("출고 명세서");
        titleCell.setCellStyle(titleStyle);
        
        // 제목 셀 병합
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 1));
        sheet.getRow(0).setHeightInPoints(50);

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
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short) 14);
        headerStyle.setFont(headerFont);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // 헤더 추가
        Row headerRow = sheet.createRow(1);
        String[] headers = {"항목", "내용"};
        for (int i = 0; i < headers.length; i++) {
            Cell headerCell = headerRow.createCell(i);
            headerCell.setCellValue(headers[i]);
            headerCell.setCellStyle(headerStyle);
        }

        // 데이터 추가
        String[][] data = {
            {"출고 담당자", shpManagerId},
            {"출고 관리번호", shpNumber},
            {"제품 식별코드", prodId},
            {"품목명", prodName},
            {"출고 수량", shpQuantity},
            {"가격(단가)", shpPrice},
            {"거래처", companyCode},
            {"출고 날짜", shpDate},
            {"비고", shpRemarks}
        };

        for (int i = 0; i < data.length; i++) {
            Row row = sheet.createRow(i + 2);
            for (int j = 0; j < data[i].length; j++) {
                Cell cell = row.createCell(j);
                cell.setCellValue(data[i][j]);
                cell.setCellStyle(borderStyle);
            }
        }

        // 열 너비 조정
        sheet.setColumnWidth(0, 30 * 256);
        sheet.setColumnWidth(1, 50 * 256);

        // 응답 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"출고명세서.xlsx\"");

        // 파일 다운로드
        try (OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        }

        workbook.close();
    }
    
    //거래처 요청 목록 페이지 로드!
    // http://localhost:8088/cordList2
    @GetMapping("/cordList2")
    public String requestCord(Model model) {
    	  List<CordersVO> cordersList = shippingDAO.getAllCordersRequests();
          model.addAttribute("cordersList",cordersList);
        logger.debug(" requestCord() 페이지 로드");
        logger.debug("cordersList"+cordersList);
        return "cordList2"; // JSP 페이지 이동
        
    }

    
    
    
    // 거래처 발주 목록 검색
    @GetMapping("/searchCorders")
    public String searchCorders(@RequestParam(required = false) String cord_status, Model model) {
        
        List<CordersVO> cordersList = shippingDAO.getAllCordersRequests();
        model.addAttribute("ordersList", cordersList); 

        if (cord_status != null && !cord_status.isEmpty()) {
        	cordersList = shippingDAO.getCordersByStatus(cord_status);
        } else {
        	cordersList = shippingDAO.getAllCordersRequests();
        }

        model.addAttribute("cordersList", cordersList);
        return "cordList2"; // 수정된 JSP 파일 이름
    }
    


}
    
    
   
