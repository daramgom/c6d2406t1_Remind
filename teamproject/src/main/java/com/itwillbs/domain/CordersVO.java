package com.itwillbs.domain;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class CordersVO {
	private int cord_count;
	private String cord_number;
	private String cord_status;
	private String cord_manager_id;
	private String cprod_id;
	private int cord_price;
	private int cord_quantity;
	
	private Timestamp cord_date;
	private Timestamp cord_date_change;
	
	private String ccompany_code;
	private String cord_text;
	private String cord_delete_status;
	
	private int department_id;
	
	private String member_id;
	private String member_name;
	private String member_tel;
	private String member_email;
	private String department_name;
	private String employee_rank;
	private String member_state;
	private String approval_status;
	
	private String prod_id;
	private String prod_status;
	private String prod_category;
	private String prod_name;
	private String prod_brand;
	
	private String company_name;
	private String company_manager;
	private String company_tel;
	private String company_email;
	private String company_address;
	
	private String common_status;
	private String common_value;
	
	private String permission_id;

    private String cord_manager_name;
	
	
	private String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(timestamp);
    }
	
	// 포맷팅된 날짜를 반환하는 메서드
    public String getFormattedOrdDate() {
        return formatTimestamp(cord_date);
    }
    
    public String getFormattedOrdDateChange() {
        return formatTimestamp(cord_date_change);
    }
}
