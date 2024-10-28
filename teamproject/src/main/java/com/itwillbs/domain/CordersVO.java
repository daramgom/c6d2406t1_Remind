package com.itwillbs.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class CordersVO {
	
	private int cord_count;
	private String cord_number;
	private String cord_manager_id;
	private String cprod_id;
	private int cord_price;
	private int cord_quantity;
	private Date cord_date;
	private String ccompany_code;
	private String cord_text;
	private String cord_delete_status;
	private String cprod_name;
	private String cprod_category;

}
