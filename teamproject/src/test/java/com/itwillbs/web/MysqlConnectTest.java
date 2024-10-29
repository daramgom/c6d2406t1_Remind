package com.itwillbs.web;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;


public class MysqlConnectTest {
	
	// 디비연결정보.
	private static String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static String URL = "jdbc:mysql://localhost:3306/springdb";
	private static String DBID = "root";
	private static String DBPW = "1234";
	
	@Test
	public void dbConnectTest() {
		
		
		//디비 연결
		try {
			// 1. 드라이버 로드
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// try-with 구문 : try()있는 객체의 자원을 자동으로 해제
		//     JDK 1.7이상 사용   (AutoClosable 인터페이스를 상속한 객체만)
		try (Connection con = DriverManager.getConnection(URL,DBID,DBPW);) {
			// 2. 디비 연결
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	

}
