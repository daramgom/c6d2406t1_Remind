package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

/**
 * 
 * 입고 데이터 저장 객체
 *
 */
@Data
public class ReceivingVO {
	private int RCV_COUNT;
	private String RCV_STATUS;
	private String RCV_NUMBER;
	private String RCV_ID;
	private Timestamp RCV_DATE;
	private int QUANTITY;
	private String RCV_MANAGER_ID;
	private String RCV_SUPERVISOR_ID;
	private String RCV_REMARKS;
	private String ORD_NUMBER;
	private String COMPANY_CODE;
	private String RCV_PRICE;
	private Timestamp ORD_DATE;
	
	
	//private String order_name
	//private String prod_name
	//private Timestamp ord_date

	
	
	
	
}
