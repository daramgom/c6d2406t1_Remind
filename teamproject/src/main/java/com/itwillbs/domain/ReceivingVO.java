package com.itwillbs.domain;


import java.sql.Date;

import lombok.Data;

/**
 * 
 * 정보 저장
 *
 */
@Data
public class ReceivingVO {

	private String rcv_manager_id;  // 1 입고 매니저 이름
	private String ord_number; // 2 발주관리번호
	private String prod_id;  // 3 제품식별코드
	private String prod_category; // 4 카테고리
	private String prod_name; //5 품목명
	private String company_code; // 6 거래처
	private int rcv_quantity; // 7 입고수량
	private String rcv_price; // 8 가격(단가)
	private Date ord_date; // 9 발주 날짜
	private Date rcv_date; // 10 입고 날짜
	private String rcv_remarks; // 11 비고
	private int rcv_count;
	private String rcv_status;
	private String rcv_number;
	private String rcv_supervisor_id;
	private String rcv_manager_name;	
	private int wh_number;
	private String ord_manager_id;
	private String ord_supervisor_id;
	private String ord_supervisor_name;
	private String member_name;
	
	

	
	
	
	
}
