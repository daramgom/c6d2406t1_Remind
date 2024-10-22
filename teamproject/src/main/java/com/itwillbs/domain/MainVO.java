package com.itwillbs.domain;

import lombok.Data;

@Data
public class MainVO {
	private int prod_all_qty;
	private int month_ord;
	private int month_rcv;
	private int month_shp;
	private String date;
	private int day_ord;
	private int day_rcv;
	private int day_shp;
}
