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
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
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
        width: fit-content;
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
    input, textarea {
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        transition: border-color 0.3s;
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
    
    table {
	    width: 50%;
	    border-collapse: collapse;
    }
        
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    
    th {
        background-color: #f2f2f2;
    }
    
    
    .table-responsive {
        overflow-x: auto; /* 가로 스크롤바 추가 */
    }
    
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		margin: auto;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.5);
     }
     .modal-content {
        top: 0;
    	right: -400px;
    	height: 100%;
	    background: white;
	    box-shadow: -2px 0 10px rgba(0, 0, 0, 0.5);
	    transition: right 0.3s ease;
	    z-index: 1000;
	    padding: 20px;
	    overflow-y: auto;
	    margin: auto;
     }
     
     .modla-content.active{
	 	right: 0; /* 슬라이드가 보일 때 위치 */
     }
     
     .close {
         color: #aaa;
         float: right;
         font-size: 28px;
         font-weight: bold;
     }
     .close:hover,
     .close:focus {
         color: black;
         text-decoration: none;
         cursor: pointer;
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
					<li class="nav-home"><a href="#"> <i class="icon-home"></i>
					</a></li>
					<li class="separator"><i class="icon-arrow-right"></i></li>
					<li class="nav-item"><a href="#">발주관리</a></li>
					<li class="separator"><i class="icon-arrow-right"></i></li>
					<li class="nav-item"><a href="#">발주목록</a></li>
				</ul>
			</div>
			
			<main style="
			    margin-left: 20px;
			    margin-right: 20px;
			    width:100%;">
			<div class="container">
 				<div class="table-responsive">
	 				<div id="basic-datatables_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4">
	        		<h1>발주 목록</h1>
	        		<hr>
	        
	        <div class="row mb-3">
			    <div class="col-sm-12 col-md-6">
			        <select id="status-filter" class="form-control" style="width: 200px;">
			            <option value="">모든 발주상태</option>
			            <option value="발주 기안">발주 기안</option>
			            <option value="발주 반려">발주 반려</option>
			            <option value="발주 결재">발주 결재</option>
			            <option value="거래처 반려">거래처 반려</option>
			            <option value="발주 완료">발주 완료</option>
			            <option value="입고요청완료">입고 요청 완료</option>
			        </select>
			    </div>
			    <div class="col-sm-12 col-md-6">
			        <div id="basic-datatables_filter" class="dataTables_filter">
			            <label>
			                Search:<input type="search" id="search-input" class="form-control form-control-sm" placeholder="" aria-controls="basic-datatables">
			            </label>
			        </div>
			    </div>
			</div>
	        
	        <div class="row">
				
		        <table id="basic-datatables" class="display table table-striped table-hover dataTable" role="grid" aria-describedby="basic-datatables_info">
		            <thead>
		                <tr role="row" style="text-align: center; vertical-align: middle;">
			                <!--     <th>순번</th> -->
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >순번</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >관리번호</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >발주상태</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >담당자</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >승인자</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >제품코드</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >발주단가</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >발주수량</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >기안시간</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >상태별시간</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >거래처코드</th>
			                <th style="color: white; background-color: #6861ce;" tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >입고창고</th>
		                    <!-- <th>비고</th> -->
		                    <!-- <th>삭제 상태</th> -->
		                </tr>
		             </thead>
		             
		             <tbody>
						 	<c:forEach var="o" items="${oListVO }">
		 
							<c:forEach var="m" items="${mListVO }">
								<c:if test="${m.member_id == o.ord_manager_id}">
									<c:set var="manager_member_name" value="${m.member_name }" />
									<c:set var="manager_department_name" value="${m.department_name }" />
									<c:set var="manager_common_status" value="${m.common_status }" />
									<c:set var="manager_member_tel" value="${m.member_tel }" />
								</c:if>
							</c:forEach>
							
							<c:forEach var="m" items="${mListVO }">
								<c:if test="${m.member_id == o.ord_supervisor_id}">
									<c:set var="supervisor_member_name" value="${m.member_name }" />
									<c:set var="supervisor_department_name" value="${m.department_name }" />
									<c:set var="supervisor_common_status" value="${m.common_status }" />
									<c:set var="supervisor_member_tel" value="${m.member_tel }" />
								</c:if>
							</c:forEach>
							
							<c:forEach var="p" items="${pListVO }">
							   <c:if test="${p.prod_id == o.prod_id}">
						           <c:set var="prod_name" value="${p.prod_name}" />
						           <c:set var="prod_category" value="${p.prod_category}" />
						           <c:set var="prod_brand" value="${p.prod_brand}" />
						           <c:set var="company_name" value="${p.company_name}" />
						           <c:set var="company_tel" value="${p.company_tel}" />
						       </c:if>
							</c:forEach>
							
							<c:forEach var="w" items="${wListVO }">
							   <c:if test="${w.wh_number == o.wh_number}">
						           <c:set var="wh_name" value="${w.wh_name}" />
						           <c:set var="wh_location" value="${w.wh_location}" />
						           <c:set var="wh_admin" value="${w.wh_admin}" />
						           <c:set var="wh_member_name" value="${w.member_name}" />
						           <c:set var="wh_member_tel" value="${w.member_tel}" />
						       </c:if>
							</c:forEach>
							
						 	<tr role="row" class="odd" 
						 	onclick="openModal(
						 	'${o.ord_count}', '${o.ord_number}', '${o.common_status }', '${o.ord_status}', 
						 	'${o.ord_manager_id}', '${manager_member_name}', '${manager_department_name}', '${manager_common_status}', '${manager_member_tel}',
						 	'${o.ord_supervisor_id}', '${supervisor_member_name}', '${supervisor_department_name}', '${supervisor_common_status}', '${supervisor_member_tel}',
						 	'${o.prod_id}', '${prod_name }', '${prod_category }', '${prod_brand }', 
						 	'${o.ord_price}', '${o.ord_quantity}', 
						 	'${o.formattedOrdDate}', '${o.formattedOrdDateChange}', 
						 	'${o.company_code }', '${company_name }', '${company_tel }', 
						 	'${o.ord_text}', 
						 	'${o.wh_number}', '${wh_name }', '${wh_location}', '${wh_admin}', '${wh_member_name}', '${wh_member_tel}')">
						 
								<td class="sorting_1">${o.ord_count}</td>
		                        <td>${o.ord_number}</td>
		                        <td>${o.common_status }</td>
		                        <td style="display: none;">${o.ord_status}</td>
		                        <td>${o.ord_manager_id}</td>
		                        <td style="display: none;">${manager_member_name}</td>
		                        <td style="display: none;">${manager_department_name}</td>
		                        <td style="display: none;">${manager_common_status}</td>
		                        <td style="display: none;">${manager_member_tel}</td>
		                        <td>${o.ord_supervisor_id}</td>
		                        <td style="display: none;">${supervisor_member_name}</td>
		                        <td style="display: none;">${supervisor_department_name}</td>
		                        <td style="display: none;">${supervisor_common_status}</td>
		                        <td style="display: none;">${supervisor_member_tel}</td>
		                        <td>${o.prod_id}</td>
		                        <td style="display: none;">${prod_name}</td>
		                        <td style="display: none;">${prod_category}</td>
		                        <td style="display: none;">${prod_brand}</td>
		                        <td>${o.ord_price}</td>
		                        <td>${o.ord_quantity}</td>
		                        <td>${o.formattedOrdDate}</td>
		                        <td>${o.formattedOrdDateChange}</td>
		                        <td>${o.company_code}</td>
		                        <td style="display: none;">${company_name}</td>
		                        <td style="display: none;">${company_tel}</td>
		                        <%-- <td>${o.ord_text}</td> --%>
		                        <td>${o.wh_number}</td>
		                        <td style="display: none;">${wh_name}</td>
		                        <td style="display: none;">${wh_location}</td>
		                        <td style="display: none;">${wh_admin}</td>
		                        <td style="display: none;">${wh_member_name}</td>
		                        <td style="display: none;">${wh_member_tel}</td>
		                        
		                        <%-- <td>${o.ord_delete_status }</td> --%>
		                        
		                    </tr>
		                    
						 </c:forEach>
						 
		 			</tbody>
		 			
		 			
				</table>
				
				<div class="row">
					<div class="col-sm-12 col-md-5">
					</div>
					
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers" id="basic-datatables_paginate">
						<ul class="pagination">
							
						</ul>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>


<script>

$(document).ready(function() {
    var rows = $('#basic-datatables tbody tr');
    var rowsPerPage = 5;
    var currentPage = 1;

    function updateTable() {
        var searchValue = $('#search-input').val().toLowerCase();
        var selectedStatus = $('#status-filter').val();

        var filteredRows = rows.filter(function() {
            var matchesSearch = $(this).text().toLowerCase().indexOf(searchValue) > -1;
            var matchesStatus = selectedStatus ? $(this).find('td:nth-child(3)').text() === selectedStatus : true; // 3번째 열은 발주상태
            return matchesSearch && matchesStatus;
        });

        var totalRows = filteredRows.length;
        var totalPages = Math.ceil(totalRows / rowsPerPage);

        rows.hide();
        filteredRows.slice((currentPage - 1) * rowsPerPage, currentPage * rowsPerPage).show();

        // 페이지네이션 업데이트
        $('#basic-datatables_paginate .pagination').empty();
        $('#basic-datatables_paginate .pagination').append('<li class="paginate_button page-item previous"><a href="#" class="page-link">Previous</a></li>');
        for (var i = 1; i <= totalPages; i++) {
            $('#basic-datatables_paginate .pagination').append('<li class="paginate_button page-item"><a href="#" class="page-link">' + i + '</a></li>');
        }
        $('#basic-datatables_paginate .pagination').append('<li class="paginate_button page-item next"><a href="#" class="page-link">Next</a></li>');

        $('#basic-datatables_paginate .pagination .page-item').removeClass('active');
        $('#basic-datatables_paginate .pagination .page-item').eq(currentPage).addClass('active');

        $('.previous').toggleClass('disabled', currentPage === 1);
        $('.next').toggleClass('disabled', currentPage === totalPages);
    }

    // 페이지네이션 클릭 이벤트
    $('#basic-datatables_paginate').on('click', '.page-link', function(e) {
        e.preventDefault();
        if ($(this).parent().hasClass('previous')) {
            if (currentPage > 1) currentPage--;
        } else if ($(this).parent().hasClass('next')) {
            if (currentPage < Math.ceil(rows.length / rowsPerPage)) currentPage++;
        } else {
            currentPage = parseInt($(this).text());
        }
        updateTable();
    });

    // 검색 기능
    $('#search-input').on('keyup', function() {
        currentPage = 1; // 검색 시 첫 페이지로 리셋
        updateTable();
    });

    // 상태 필터링
    $('#status-filter').on('change', function() {
        currentPage = 1; // 필터 변경 시 첫 페이지로 리셋
        updateTable();
    });

    // 초기 설정
    updateTable();
});
	
</script>

    
</main>
    </div>
    </div>
    <!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
    
</div>



<!-- 모달 -->

<div id="orderModal" class="modal" style="width:auto;">
    <div class="modal-content" style="width: 1200px;">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>발주 상세 정보</h2>
        <form action="" id="orderForm" method="post" name="orderForm">
        
        	<div style="display: flex; gap: 10px;">
         		<label>순번 : </label>
        		<input type="text" id="modalOrdCount" name="ord_count" readonly="readonly" class="form-control" style="width:200px;" />
            	<label>발주 관리 번호 : </label>
            	<input type="text" id="modalOrdNumber" name="ord_number" readonly="readonly" class="form-control" style="width:200px;" />
            	<label>발주 상태 : </label>
            	<input type="text" id="modalCommonStatus" name="common_status" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" /><br>
            	<input type="hidden" id="modalOrdStatus" name="ord_status" readonly="readonly" class="form-control" style="width:200px;" /><br>
        	</div>
        	
           <div style="display: flex; gap: 10px;">
           		<label>발주 담당자:</label>
           </div>
          <div style="display: flex; gap: 10px;">
          	<input type="text" id="modalOrdManagerId" name="ord_manager_id" readonly="readonly" class="form-control" style="width:200px;" /><br>
          	<input type="text" id="modalManagerMemberName" name="manager_member_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	
          	
          	<input type="text" id="modalManagerDepartmentName" name="manager_department_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalManagerCommonStatus" name="manager_common_status" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalManagerMemberTel" name="manager_member_tel" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          </div>
          
          <div style="display: flex; gap: 10px;">
          	<label>발주 승인 담당자:</label>
          </div>
          <div style="display: flex; gap: 10px;">
          	<input type="text" id="modalOrdSupervisorId" name="ord_supervisor_id" readonly="readonly" class="form-control" style="width:200px;" /><br>
          	<input type="text" id="modalSupervisorMemberName" name="supervisor_member_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalSupervisorDepartmentName" name="supervisor_department_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalSupervisorCommonStatus" name="supervisor_common_status" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalSupervisorMemberTel" name="supervisor_member_tel" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          </div>
          
          <div style="display: flex; gap: 10px;">
           <label>제품식별코드 / 제품 이름 / 제품 카테고리 / 제품 브랜드 / 거래처코드 / 거래처 이름 / 거래처 전화번호</label>
          </div>
          <div style="display: flex; gap: 10px;">
           <!-- <input type="text" id="modalProdId" name="prod_id" class="form-control" style="width:200px;" /><br>
           <input type="text" id="modalCompanyCode" name="company_code" class="form-control" style="width:200px;" /><br> -->
           <select id="prod_id" name="prod_id" class="form-select form-control" required="required" style="width:600px;">
			<!-- <option value="" >목록에서 값을 확인 후 선택하세요</option> -->
			<c:forEach var="p" items="${pListVO }">
				<option id="modalProdId" value="${p.prod_id }">${p.prod_id} / ${p.prod_name } / ${p.prod_category } / ${p.prod_brand } / ${p.company_code } / ${p.company_name } / ${p.company_tel }</option>
			</c:forEach>
		</select>
          </div>
          
          <div style="display: flex; gap: 10px;">
          	<label>발주 금액 : </label>
           <input type="text" id="modalOrdPrice" name="ord_price" class="form-control" style="width:200px;" />
           <label>발주 수량 : </label>
           <input type="text" id="modalOrdQuantity" name="ord_quantity" class="form-control" style="width:200px;" />
          </div>
          
          <div style="display: flex; gap: 10px;">
          	<label>발주 최초 기안 시간 : </label>
           <input type="text" id="modalOrdDate" readonly="readonly" name="ord_date" class="form-control" style="width:200px;" />
           <label>발주 상태별 시간 : </label>
           <input type="text" id="modalOrdDateChange" readonly="readonly" name="ord_date_change" class="form-control" style="width:200px;" />
          </div>
          
          <div style="display: flex; gap: 10px;">
          	<label>입고 예정 창고 번호 / 이름 / 위치 / 관리자ID / 관리자 이름 / 관리자 전화번호</label>
          </div>
          <div style="display: flex; gap: 10px;">
           <!-- <input type="text" id="modalWhNumber" name="wh_number" class="form-control" style="width:200px;" />
           <input type="text" id="modalWhName" name="wh_name" readonly="readonly" class="form-control" style="width:200px;" />
           <input type="text" id="modalWhLocation" name="wh_location" readonly="readonly" class="form-control" style="width:200px;" />
           <input type="text" id="modalWhAdmin" name="wh_admin" readonly="readonly" class="form-control" style="width:200px;" />
           <input type="text" id="modalWhMemberName" name="wh_member_name" readonly="readonly" class="form-control" style="width:200px;" />
           <input type="text" id="modalWhMemberTel" name="wh_member_tel" readonly="readonly" class="form-control" style="width:200px;" /><br> -->
           
           <select id="wh_number" name="wh_number" class="form-select form-control" required="required" style="width:500px;">
			<!-- <option value="" >목록에서 값을 확인 후 선택하세요</option> -->
			<c:forEach var="w" items="${wListVO }">
				<option id="modalWhNumber" value="${w.wh_number }">${w.wh_number } / ${w.wh_name } / ${w.wh_location } / ${w.wh_admin } / ${w.member_name } / ${w.member_tel }</option>
			</c:forEach>
		</select>
       </div>    
           
          <label>비고:</label>
          <textarea class="form-control" id="modalOrdText" name="ord_text" class="form-control" style="width:750px;" ></textarea><br>
          <!-- <label>삭제 상태:</label> -->
          <input type="hidden" id="modalOrdDeleteStatus" name="ord_delete_status" /><br>
          
         </form>
         
         <div id="buttonContainer"></div>
         
    </div>
</div>
    
    

<script>

var checkPage = '${checkPage}';

if(checkPage == 'insertOK'){
	alert("발주 정보가 등록 되었습니다.");
}

function openModal(ord_count, ord_number, common_status, ord_status, 
	ord_manager_id, manager_member_name, manager_department_name, manager_common_status, manager_member_tel, 
	ord_supervisor_id, supervisor_member_name, supervisor_department_name, supervisor_common_status, supervisor_member_tel, 
	prod_id, prod_name, prod_category, prod_brand, 
	ord_price, ord_quantity, ord_date, ord_date_change, 
	company_code, company_name, company_tel, 
	ord_text, 
	wh_number, wh_name, wh_location, wh_admin, wh_member_name, wh_member_tel) { 
	    document.getElementById('modalOrdCount').value = ord_count;
	    document.getElementById('modalOrdNumber').value = ord_number;
	    document.getElementById('modalCommonStatus').value = common_status;
	    document.getElementById('modalOrdStatus').value = ord_status;
	    
	    document.getElementById('modalOrdManagerId').value = ord_manager_id;
	    document.getElementById('modalManagerMemberName').value = manager_member_name;
	    document.getElementById('modalManagerDepartmentName').value = manager_department_name;
	    document.getElementById('modalManagerCommonStatus').value = manager_common_status;
	    document.getElementById('modalManagerMemberTel').value = manager_member_tel;
	    
	    document.getElementById('modalOrdSupervisorId').value = ord_supervisor_id;
	    document.getElementById('modalSupervisorMemberName').value = supervisor_member_name;
	    document.getElementById('modalSupervisorDepartmentName').value = supervisor_department_name;
	    document.getElementById('modalSupervisorCommonStatus').value = supervisor_common_status;
	    document.getElementById('modalSupervisorMemberTel').value = supervisor_member_tel;
	    
	    document.getElementById('prod_id').value = prod_id;
// 	    document.getElementById('modalProdId').value = prod_id; // <-- 원인. + id값은 고유한 값인데 반복문에 들어가면 의미없음 삭제요청
	    
	    document.getElementById('modalOrdPrice').value = ord_price;
	    document.getElementById('modalOrdQuantity').value = ord_quantity;
	    document.getElementById('modalOrdDate').value = ord_date;
	    document.getElementById('modalOrdDateChange').value = ord_date_change;
	    /* document.getElementById('modalCompanyCode').value = company_code; */
	    document.getElementById('modalOrdText').value = ord_text;
	    
	    document.getElementById('wh_number').value = wh_number;
// 	    document.getElementById('modalWhNumber').value = wh_number; // <-- 원인. 삭제요청
        
//         document.getElementById('modalWhName').value = wh_name;
//         document.getElementById('modalWhLocation').value = wh_location;
//         document.getElementById('modalWhAdmin').value = wh_admin;
//         document.getElementById('modalWhMemberName').value = wh_member_name;
//         document.getElementById('modalWhMemberTel').value = wh_member_tel;
//         document.getElementById('modalOrdDeleteStatus').value = ord_delete_status;

        // 여기서 ord_status 값을 기반으로 버튼을 렌더링
        renderButtons(ord_status);

        // 모달 표시
        document.getElementById('orderModal').style.display = 'block';
        
    } // openModal
        
    $(document).on('click',function(e){
    	// console.log(e.target); //    <- 삭제요청
    });
    
    // test <-- 삭제요청
        document.getElementById('prod_id').addEventListener('change', function() {
        // 선택된 옵션의 value를 가져옴
        var selectedValue = this.value;
        // console.log으로 출력
        console.log('선택된 값:', selectedValue);
    	});
        document.getElementById('wh_number').addEventListener('change', function() {
            // 선택된 옵션의 value를 가져옴
            var selectedValue2 = this.value;
            // console.log으로 출력
            console.log('선택된 값:', selectedValue2);
        	});
    // test <-- 삭제요청
    
function renderButtons(ord_status) {
    var buttonContainer = document.getElementById('buttonContainer');
    
 	// 각 input과 select 태그 선택
 	var prod_id = document.getElementById('prod_id');
 	var modalOrdPrice = document.getElementById('modalOrdPrice');
 	var modalOrdQuantity = document.getElementById('modalOrdQuantity');
 	var wh_number = document.getElementById('wh_number');
 	
 	// 모달창에서의 manager id와 supervisor id 값 불러오기
 	var ordManagerId = document.getElementById('modalOrdManagerId').value;
 	var ordSupervisorId = document.getElementById('modalOrdSupervisorId').value;
    
    buttonContainer.innerHTML = ''; // 기존 버튼 초기화
	
    // 발주 상태가 요청(01 : 최초)
    if (ord_status === '01') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">요청</button>';
        // 세션 로그인 아이디 == 발주자만 가능
        if('${userId}' === ordManagerId){
	        buttonContainer.innerHTML += '<button id="updateBtn" class="btn btn-success">수정</button>';
	        buttonContainer.innerHTML += '<button id="deleteBtn" class="btn btn-danger">삭제</button>';
        }
        // 승인자만 가능
        if('${userId}' === ordSupervisorId){
	        buttonContainer.innerHTML += '<button id="updateBtn03" class="btn btn-success">발주 처리</button>';
	        buttonContainer.innerHTML += '<button id="updateBtn02" class="btn btn-danger">발주 반려</button>';
        }
     	// input태그 select 태그 활성화
        prod_id.disabled = false;
        modalOrdPrice.readOnly = false;
        modalOrdQuantity.readOnly = false;
        wh_number.disabled = false;
      
    } // if (ord_status === '01')
    	
    	
    // 발주 상태가 반려(02)
    else if (ord_status === '02') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">반려</button>';
     	// 세션 로그인 아이디 == 발주자만 가능
        if('${userId}' === ordManagerId){
	        buttonContainer.innerHTML += '<button id="updateBtn01" class="btn btn-success">재요청</button>';
	        buttonContainer.innerHTML += '<button id="deleteBtn01" class="btn btn-danger">삭제</button>';
        }
     	// input태그 select 태그 활성화
        prod_id.disabled = false;
        modalOrdPrice.readOnly = false;
        modalOrdQuantity.readOnly = false;
        wh_number.disabled = false;
    } // else if (ord_status === '02')
    
    
    // 발주 상태가 승인(03)
    else if (ord_status === '03') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">결재</button>';
        if('${userMemberCode}' !== '1'){
        	buttonContainer.innerHTML += '<button id="updateBtn05" class="btn btn-success">거래처 처리</button>'
       		buttonContainer.innerHTML += '<button id="updateBtn04" class="btn btn-danger">거래처 반려</button>'
        }
        // input태그 select 태그 비활성화
        prod_id.disabled = true;
        modalOrdPrice.readOnly = true;
        modalOrdQuantity.readOnly = true;
        wh_number.disabled = true;
        
    } // else if (ord_status === '03')
    
    
    // 발주 상태가 거래처에서 반려(04)
    else if (ord_status === '04') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">거래처 반려</button>';
     	// input태그 select 태그 비활성화
        prod_id.disabled = true;
        modalOrdPrice.readOnly = true;
        modalOrdQuantity.readOnly = true;
        wh_number.disabled = true;
    } // else if (ord_status === '04')
    
    
    // 발주 상태가 완료 (05 : 결재자도 승인, 거래처에서도 승인)
    else if (ord_status === '05') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">완료</button>';
        // 발주관리번호를 가지고 입고요청으로 이동
        buttonContainer.innerHTML += `<button id="toRcvRq" class="btn btn-success">입고요청으로</button>`;
     	// input태그 select 태그 비활성화
        prod_id.disabled = true;
        modalOrdPrice.readOnly = true;
        modalOrdQuantity.readOnly = true;
        wh_number.disabled = true;
    } // else if (ord_status === '05')
    	
	// 발주 상태가 입고요청완료 (06 : 발주완료에서 입고요청까지 한 상태)
    else if (ord_status === '06') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">입고 요청 완료</button>';
     	// input태그 select 태그 비활성화
        prod_id.disabled = true;
        modalOrdPrice.readOnly = true;
        modalOrdQuantity.readOnly = true;
        wh_number.disabled = true;
    } // else if (ord_status === '06')

    // 버튼에 이벤트 리스너 추가
    addButtonEventListeners();
    
} // renderButtons

function addButtonEventListeners() {
	
	let formData;
	
    document.getElementById('updateBtn')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/updateOrder", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
        	/* alert(formData);
        	console.log(formData);
        	alert('12345'); */
            alert("발주 정보가 수정 되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("수정 중 오류가 발생했습니다.");
        });
    }); // updateBtn

    document.getElementById('deleteBtn')?.addEventListener('click', function(event) {
        event.preventDefault();
        
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/deleteOrder", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("발주 정보가 삭제되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("삭제 중 오류가 발생했습니다.");
        });
    }); // deleteBtn

    document.getElementById('updateBtn03')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/updateOrder03", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("발주 처리 되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("처리 중 오류가 발생했습니다.");
        });
    }); // updateBtn03
        
    document.getElementById('updateBtn02')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/updateOrder02", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("발주 반려 되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("반려 중 오류가 발생했습니다.");
        });
    }); // updateBtn02
        
    document.getElementById('updateBtn01')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/updateOrder", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("발주 정보가 재요청 되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("수정 중 오류가 발생했습니다.");
        });
    }); // updateBtn01
        
    document.getElementById('deleteBtn01')?.addEventListener('click', function(event) {
        event.preventDefault();
        var formData = new FormData(document.getElementById('orderForm'));
        fetch("/deleteOrder", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("발주 정보가 삭제되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("삭제 중 오류가 발생했습니다.");
        });
    }); // deleteBtn01
    
    document.getElementById('updateBtn05')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/updateOrder05", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("거래처 발주 처리 되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("발주 처리 중 오류가 발생했습니다.");
        });
    }); // updateBtn05
    
    document.getElementById('updateBtn04')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        
        formData = new FormData(document.getElementById('orderForm'));
        fetch("/updateOrder04", {
            method: "POST",
            body: formData
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            alert("거래처 반려 되었습니다.");
            location.reload();
        })
        .catch(error => {
            console.error(error);
            alert("반려 중 오류가 발생했습니다.");
        });
    }); // updateBtn04
    
    document.getElementById('toRcvRq')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 동작 방지
        
     	// ord_number를 가져옵니다
        var ord_number = document.getElementById('modalOrdNumber').value;

        // AJAX 요청을 통해 컨트롤러로 ord_number를 전송합니다
        fetch(`/processRcvRQ?ord_number=${ord_number}`, {
            method: "GET"
        })
        .then(response => {
            if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
            return response.text();
        })
        .then(data => {
            // 서버에서 처리 후 페이지 이동
            window.location.href = "rcvRQ"; // 여기서 이동할 페이지를 설정
        })
        .catch(error => {
            console.error(error);
            alert("처리 중 오류가 발생했습니다.");
        });
    }); // toRcvRq

        
} //addButtonEventListeners()

// 모달 외부 클릭 시 닫기
window.addEventListener('click', function(event) {
    var modal = document.getElementById('orderModal');
    if (event.target === modal) {
        closeModal();
    }
});

//ESC 키로 모달 닫기
document.addEventListener("keydown", function(event) {
    // ESC 키 (키 코드 27)
    if (event.key === "Escape" || event.keyCode === 27) {
        closeModal();
    }
});

///////////////////////////////////

function closeModal() {
    document.getElementById('orderModal').style.display = 'none'; // 모달 숨기기
}
    
    

</script>

  </body>
</html>
