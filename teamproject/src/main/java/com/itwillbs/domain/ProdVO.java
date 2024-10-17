package com.itwillbs.domain;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import jdk.jfr.DataAmount;
import lombok.Data;

/**
 * 	VO (Value Object) : 데이터 저장 객체 (값을 저장하는 동작 이외의 동작O)
 *	DTO (Data Transfer Object) : 데이터 전송 객체 (값을 저장하는 동작 이외의 동작X)
 *
 *	prod 테이블 정보를 저장하는 객체
 *
 */

@Data
public class ProdVO {
	
	private String prod_status;
	private String prod_id;
	private String prod_name;
	private Timestamp prod_regdate;
	private String prod_reguser;
	private Timestamp prod_upddate;
	private String prod_upduser;
	private String prod_category;
	private String prod_brand;
	private int prod_stock;
	private String prod_image;
	private String temp_image;
	private MultipartFile uploadfile;
	private String company_code;
	private int wh_number;
	private int stock_wh;
	private String wh_code;
	private String wh_name;
	private String wh_location;
	private int prod_qty;
	private int stock_qty;
	private String prod_remarks;
	private String formatted_regdate;
	private String formatted_upddate;

}