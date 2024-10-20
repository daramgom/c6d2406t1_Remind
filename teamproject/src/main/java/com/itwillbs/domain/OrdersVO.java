package com.itwillbs.domain;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

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
	
	private int department_id;
	
	private String member_id;
	private String member_name;
	private String member_tel;
	private String member_email;
	private String department_name;
	private String employee_rank;
	private String member_state;
	private String approval_status;
	
	private String prod_status;
	private String prod_category;
	private String prod_name;
	private String prod_brand;
	
	private String company_name;
	private String company_manager;
	private String company_tel;
	private String company_email;
	private String company_address;
	
	private String wh_code;
	private String wh_name;
	private String wh_location;
	private String wh_admin;
	
	private String common_status;
	private String common_value;
	
	private String permission_id;
	
	
	private String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(timestamp);
    }
	
	// 포맷팅된 날짜를 반환하는 메서드
    public String getFormattedOrdDate() {
        return formatTimestamp(ord_date);
    }
    
    public String getFormattedOrdDateChange() {
        return formatTimestamp(ord_date_change);
    }
	
}
