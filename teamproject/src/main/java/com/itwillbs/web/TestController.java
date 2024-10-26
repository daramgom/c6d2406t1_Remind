package com.itwillbs.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {

    // http://localhost:8080/web/rcv
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String home() {
        return "test";
    }

    @RequestMapping(value = "/poiExcel", method = RequestMethod.POST)
    public void poiTest(HttpServletResponse response, HttpServletRequest request) throws Exception {
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
               cell.setCellValue("입고 담당자"); // 값 설정
               
               // L5:W5에 "ORD-2024-0001" 삽입
               Row headerRow = sheet.getRow(rowIndex); // 5번째 행
               if (headerRow == null) {
                   headerRow = sheet.createRow(rowIndex); // 행이 없으면 생성
               }
               
               // L5부터 W5까지 "ORD-2024-0001" 삽입
               String orderNumber = "ORD-2024-0001";
               for (int i = 11; i <= 22; i++) { // L(11)부터 W(22)까지
                   Cell orderCell = headerRow.createCell(i);
                   orderCell.setCellValue(orderNumber);
               }

               // C14:E14, F14:G14, J14:L14, M14:N14, O14:R14에 값 삽입
               Row dataRow = sheet.getRow(13); // 14번째 행 (0부터 시작)
               if (dataRow == null) {
                   dataRow = sheet.createRow(13); // 행이 없으면 생성
               }

               // C14:E14 -> "P-4I4CD2-1004"
               for (int i = 2; i <= 4; i++) { // C(2)부터 E(4)까지
                   Cell cellCtoE = dataRow.createCell(i);
                   cellCtoE.setCellValue("P-4I4CD2-1004"); //제품 식별코드
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
