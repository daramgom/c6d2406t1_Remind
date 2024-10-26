  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
엑셀로 다운로드를 해보자  <br>
<form id="ExcelForm" name="ExcelForm">
	<!-- 엑셀파일로 다운로드 받을 날짜를 입력받았다고 가정해보자 ! -->
	<input type="hidden" id="day1" name="day1" value="2021-05-01" /> 
	<input type="hidden" id="day2" name="day2" value="2021-05-30" />   		
</form>
<button onclick='javascript:poiExcel()'>엑셀 다운</button>
</body>

<script src="https://code.jquery.com/jquery-2.2.1.js"></script>
<script type="text/javascript">
function poiExcel() {
	var formObj = $('#ExcelForm');
	formObj.attr('action', '/poiExcel');
	formObj.attr('method', 'post');
	formObj.submit();
	
}
</script>
</html>