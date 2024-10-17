package com.itwillbs.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrdersVO {
	private int ord_count;
	private String ord_number;
	private String ord_status;
	private String ord_manager_id;
	private String ord_supervisor_id;
	private String prod_id;
	private int ord_price;
	private int ord_quantity;
	private Timestamp ord_date;
	private Timestamp ord_date_change;
	private String company_code;
	private String ord_text;
	private int wh_number;
	private String ord_delete_status;
}
