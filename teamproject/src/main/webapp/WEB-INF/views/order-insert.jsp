<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>REMIND</title>
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
    <link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />
    <!-- jQuery Sparkline -->
	<script
		src="/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>
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
        padding: 0px;
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
<title>REMIND</title>
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
	<c:if test="${userMemberCode != '1'}">
		<c:redirect url="/cmain"/>
	</c:if>
  	
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
						<li class="nav-home"> <i class="icon-home"></i>
						</li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item">발주관리</li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item">발주요청</li>
					</ul>
				</div>

<main>
<h2>발주 요청</h2>
<form action="/order-insert" method="post">


<div class="form-group">
	<div>
		<label for="ord_manager_id" class="col-md-3 col-form-label">발주 담당자</label>
		<input class="form-control input-full" value="${userId }" readonly="readonly" type="text" name="ord_manager_id" required="required" style="width:40% !important">
	</div>
</div>

<div class="form-group">
	<div>
		<label for="ord_supervisor_id" class="col-md-3 col-form-label">발주 승인 담당자<br>아이디 / 이름 / 부서 이름 / 직급 / 전화번호</label>
<!-- 		<input class="form-control input-full" type="text" name="ord_supervisor_id" required="required"> -->
		
		
		
		<select id="ord_supervisor_id" name="ord_supervisor_id" class="form-select form-control" required="required">
			<option value="" >선택하세요</option>
			<c:forEach var="s" items="${sListVO }">
				<option value="${s.member_id}<%-- ,${s.member_name},${s.department_name},${s.common_status},${s.member_tel} --%>">${s.member_id} / ${s.member_name} / ${s.department_name} / ${s.common_status} / ${s.member_tel }</option>
			</c:forEach>
		</select>
		
		
		
	</div>
</div>



<script>
	function updateInput() {
	    const select = document.getElementById("prod_id");
	    const selectedOption = select.options[select.selectedIndex];
		
	    // data-company-code 속성을 사용하여 company_code를 가져옵니다.
	    const companyCode = selectedOption.getAttribute("data-company-code");
		
	    // 입력 필드에 company_code를 설정합니다.
	    document.getElementById("company_code").value = companyCode || "";
	}
</script>



<div class="form-group">
	<div>
		<label for="prod_id" class="col-md-3 col-form-label">제품<br>제품코드 / 제품 이름 / 카테고리 / 브랜드 / 거래처코드 / 거래처 이름 / 거래처 전화번호</label>
<!-- 		<input class="form-control input-full" type="text" name="prod_id" required="required"> -->
		
		
		<select id="prod_id" name="prod_id" class="form-select form-control" required="required" onchange="updateInput()">
		    <option value="">선택하세요</option>
		    <c:forEach var="p" items="${pListVO }">
		    	<option value="${p.prod_id}" data-company-code="${p.company_code}">${p.prod_id} / ${p.prod_name} / ${p.prod_category} / ${p.prod_brand} / ${p.company_code} / ${p.company_name} / ${p.company_tel}</option>
		    </c:forEach>
		</select>

<input type="hidden" id="company_code" name="company_code" readonly>
		
	</div>
</div>

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
		<label for="wh_number" class="col-md-3 col-form-label">입고 예정 창고<br>창고 번호 / 창고 이름 / 창고 위치 / 창고 관리자 ID / 관리자 이름 / 관리자 전화번호</label>
		
		<select id="wh_number" name="wh_number" class="form-select form-control" required="required">
			<option value="" >선택하세요</option>
			<c:forEach var="w" items="${wListVO }">
				<option value="${w.wh_number }">${w.wh_number } / ${w.wh_name } / ${w.wh_location } / ${w.wh_admin } / ${w.member_name } / ${w.member_tel }</option>
			</c:forEach>
		</select>
		
	</div>
</div>


<div class="form-group">
	<div>
		<label for="ord_text" class="col-md-3 col-form-label">비고</label>
		<textarea class="form-control" id="ord_text" name="ord_text"></textarea>
	</div>
</div>
        <button type="submit" onclick="" class="btn btn-secondary">발주 요청</button>
        <button type="reset" class="btn btn-danger">리셋</button>
        </form>
        
				</main>
	    	</div>
	    </div>
	    
    <!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	
</div>



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
