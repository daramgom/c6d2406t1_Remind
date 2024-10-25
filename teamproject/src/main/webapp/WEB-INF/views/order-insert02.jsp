<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="kr">
 <head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>아이티윌 팀프로젝트</title>
<meta
  content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
  name="viewport"
/>
<link
  rel="icon"
  href="/resources/img/kaiadmin/favicon.ico"
  type="image/x-icon"
/>

<!-- Fonts and icons -->
<script src="/resources/js/plugin/webfont/webfont.min.js"></script>
<!-- jQuery Sparkline -->
<script
	src="/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js">
</script>
<script>
WebFont.load({
  google: { families: ["Public Sans:300,400,500,600,700"] },
  custom: {
    families: [
      "Font Awesome 5 Solid",
      "Font Awesome 5 Regular",
      "Font Awesome 5 Brands",
      "simple-line-icons",
    ],
    urls: ["./resources/css/fonts.min.css"],
  },
  active: function () {
    sessionStorage.fonts = true;
  },
});
</script>
    
<style>
  body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #e9ecef;
      margin: 0;
      padding: 20px;
  }
  header {
      background: #001f3f; /* 남색 */
      padding: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: white;
      border-radius: 5px;
  }
  main {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      margin-top: 20px;
      width: 60%;
      margin-left: auto;
      margin-right: auto;
  }
  h2 {
      border-bottom: 2px solid #001f3f; /* 남색 */
      padding-bottom: 10px;
      color: #001f3f; /* 남색 */
  }
  .form-container {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 20px;
  }
  .form-group {
      display: flex;
      flex-direction: column;
  }
  .container-disable{
  	pointer-events: none;
  	background-color: grey;
  }
  label {
      margin-top: 15px;
      font-weight: bold;
      color: #333;
  }
  input {
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
      transition: border-color 0.3s;
      width: 20% !important;
  }
  textarea {
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 4px;
      transition: border-color 0.3s;
      width: 160% !important;
  }
  input:focus, textarea:focus {
      border-color: #001f3f; /* 남색 */
      outline: none;
  }
  button {
      grid-column: span 2; /* 버튼을 두 열에 걸치게 함 */
      margin-top: 20px;
      padding: 10px;
      background: #001f3f; /* 남색 */
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      transition: background 0.3s;
  }
  button:hover {
      background: #001a33; /* 남색의 어두운 색 */
  }
  form{
  	width: 60% !important;
  }
</style>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>발주 요청 페이지</title>
    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="/resources/css/demo.css" />
    
</head>
  	<body>
  	
  	<c:if test="${empty userId}">
		<c:redirect url="/login"/>
	</c:if>
<%-- 	<c:if test="${userMemberCode != '1'}"> --%>
<%-- 		<c:redirect url="/main"/> --%>
<%-- 	</c:if> --%>
  	
    <div class="wrapper">
    
    	<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />
	
		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />
    
    	<div class="container">
        	<div class="page-inner">
        		<div class="page-header">
					<h3 class="fw-bold mb-3">발주관리</h3>
					<ul class="breadcrumbs mb-3">
						<li class="nav-home"><a href="#"> <i class="icon-home"></i>
						</a></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item"><a href="#">발주관리</a></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item"><a href="#">발주요청</a></li>
					</ul>
				</div>

<main>
<h2>발주 요청</h2>
<form action="/order-insert02" method="post" id="orderForm02">


<div class="form-group">
	<div>
		<label for="ord_manager_id" class="col-md-3 col-form-label">발주 담당자</label>
		<input class="form-control input-full" value="${userId }" readonly="readonly" type="text" name="ord_manager_id" required="required" style="width:40% !important">
	</div>
</div>


<div class="form-group">
	<div>
		<label for="prod_id" class="col-md-3 col-form-label">제품<br>제품코드 / 제품 이름 / 카테고리 / 브랜드 </label>
<!-- 		<input class="form-control input-full" type="text" name="prod_id" required="required"> -->
		
		
		<select id="prod_id" name="prod_id" class="form-select form-control" required="required">
		    <option value="">선택하세요</option>
		    <c:forEach var="p" items="${pListVO02 }">
		    	<option value="${p.prod_id}"<%--  data-company-code="${p.company_code}" --%>>${p.prod_id} / ${p.prod_name} / ${p.prod_category} / ${p.prod_brand} </option>
		    </c:forEach>
		</select>
		
	</div>
</div>


		<input type="hidden" id="company_code" value="${userMemberCode }" name="company_code" readonly>


<div class="form-group">
	<div>
		<label for="ord_price" class="col-md-3 col-form-label">발주 금액</label>
		<input class="form-control input-full" type="text" name="ord_price" required="required" style="width: 40% !important">
	</div>
</div>

<div class="form-group">
	<div>
		<label for="ord_quantity" class="col-md-3 col-form-label">발주 수량</label>
		<input class="form-control input-full" type="number" name="ord_quantity" required="required" style="width: 40% !important">
	</div>
</div>

<!-- <div class="form-group"> -->
<!-- 	<div> -->
<!-- 		<label for="company_code" class="col-md-3 col-form-label">거래처 코드</label> -->
<!-- 		<input class="form-control input-full" type="text" name="company_code" required="required"> -->
<!-- 	</div> -->
<!-- </div> -->


<div class="form-group">
	<div>
		<label for="ord_text" class="col-md-3 col-form-label">비고</label>
		<textarea class="form-control" id="ord_text" name="ord_text"></textarea>
	</div>
</div>
        <button type="submit" onclick="submitForm();" class="btn btn-success">발주 요청</button>
        <button type="reset" class="btn btn-danger">리셋</button>
        </form>
        
				</main>
	    	</div>
	    </div>
	    
    <!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	
</div>

<script>
function submitForm(){
	alert("자사의 서비스를 이용해 주셔서 감사합니다 !! \n 발주 요청이 등록되었습니다 !!");
	document.getElementById("orderForm02").submit();
}
</script>



<!--  


<div class="form-group">
    <label for="ord_manager_id">발주 담당자 정보</label>
</div>

<div class="form-container">
    <div class="form-group">
        <label for="ord_supervisor_id">발주 승인 담당자</label>
        <input type="text" id="ord_supervisor_id" placeholder="admin" required  name="ord_supervisor_id" >
    </div>
    
</div>

<div class="form-group">
    <label for="ord_supervisor_id">발주 승인 담당자 정보</label>
</div>

<div class="form-container">
    <div class="form-group">
        <label for="company_code">거래처 코드</label>
        <input type="text" id="company_code" placeholder="거래처 코드를 입력" required  name="company_code" >
    </div>
    
</div>

<div class="form-group">
    <label for="company_code">거래처 정보</label>
</div>


<div class="form-group">
    <label for="prod_id">제품 식별코드</label>
    <input type="text" id="prod_id" placeholder="제품식별 코드를 입력" required name="prod_id">
</div>

<div class="form-group">
    <label for="prod_id">제품 정보</label>
</div>

<div class="form-group">
    <label for="ord_quantity">발주 수량</label>
    <input type="number" id="ord_quantity" required name="ord_quantity">
</div>

<div class="form-group">
    <label for="ord_price">가격(단가)</label>
    <input type="text" id="ord_price" required name="ord_price">
</div>

<div class="form-group">
    <label for="ord_date">입고 희망 날짜</label>
    <input type="date" id="ord_date" required>
</div>

<div class="form-group">
    <label for="wh_number">입고 예정 창고</label>
    <input type="text" id="wh_number" placeholder="입고 예정 창고의 번호를 입력" required name="wh_number">
</div>

<div class="form-group">
    <label for="wh_number">입고 예정 창고 정보</label>
</div>

<div class="form-group">
    <label for="ord_text">비고</label>
    <input type="text" name="ord_text" placeholder="전달할 내용...">
</div>

-->


  </body>
</html>
