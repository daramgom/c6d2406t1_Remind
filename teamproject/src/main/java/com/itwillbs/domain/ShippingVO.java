package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

/**
 * 출고 정보 저장
 */
@Data
public class ShippingVO {

    private int shp_count;
    private String shp_status; 
    private String shp_number; // 출고 관리 번호
    private String prod_id; // 제품 식별 코드
    private String prod_category; // 카테고리
    private String shp_price; // 가격(단가)		
    private Date shp_date; // 출고 날짜 
    private Date cord_date; // 발주 날짜
    private int shp_quantity; // 출고 수량
    private String shp_manager_id; // 출고 요청자 ID
    private String shp_supervisor_id; // 출고 승인자 ID
    private String shp_supervisor_name; // 출고 승인자 ID
    private String shp_remarks; // 비고
    private String prod_name;  // 제품명
    private String company_code; // 거래처
    private int wh_number; // 창고
    private String cord_number; // 발주 관리 번호 추가
    private String shp_manager_name; // 출고 요청자 ID
    private Date cord_date_change;
    private String cord_status;
    
}
