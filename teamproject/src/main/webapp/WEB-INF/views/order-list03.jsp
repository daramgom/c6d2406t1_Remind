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
    
<%--     <c:if test="${empty userId}"> --%>
<%-- 		<c:redirect url="/login"/> --%>
<%-- 	</c:if> --%>
	<!-- 일단은 빼둠 -->
    
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
			
			<main>
			<div class="container">
 				<div class="table-responsive">
	 				<div id="basic-datatables_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4">
	        		<h1>발주 목록</h1>
	        		<hr>
	        
	        <div class="row mb-3">
	        	<div class="col-sm-12 col-md-6">
			        <select id="status-filter" class="form-control" style="width: 200px;">
			            <option value="">모든 발주상태</option>
			            <option value="발주 완료">발주 완료</option>
			            <option value="출고 완료">출고 완료</option>
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
		                <tr role="row">
			                <!--     <th>순번</th> -->
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >순번</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >관리번호</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >발주상태</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >담당자</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >제품코드</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >발주단가</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >발주수량</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >기안시간</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >상태별시간</th>
			                <th tabindex="0" aria-controls="basic-datatables" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" >거래처코드</th>
		                </tr>
		             </thead>
		             
		             <tbody>
						 	<c:forEach var="co" items="${oListVO03 }">
		 
							<c:forEach var="m" items="${mListVO02 }">
								<c:if test="${m.member_id == co.cord_manager_id}">
									<c:set var="manager_member_name" value="${m.member_name }" />
									<c:set var="manager_department_name" value="${m.department_name }" />
									<c:set var="manager_common_status" value="${m.common_status }" />
									<c:set var="manager_member_tel" value="${m.member_tel }" />
								</c:if>
							</c:forEach>
							
							<c:forEach var="p" items="${pListVO02 }">
							   <c:if test="${p.prod_id == co.cprod_id}">
						           <c:set var="prod_name" value="${p.prod_name}" />
						           <c:set var="prod_category" value="${p.prod_category}" />
						           <c:set var="prod_brand" value="${p.prod_brand}" />
						       </c:if>
							</c:forEach>
							
<%-- 							<c:forEach var="c" items="${cListVO02 }"> --%>
<%-- 							   <c:if test="${c.company_code == co.ccompany_code}"> --%>
<%-- 						           <c:set var="company_name" value="${c.company_name}" /> --%>
<%-- 						           <c:set var="company_tel" value="${c.company_tel}" /> --%>
<%-- 						       </c:if> --%>
<%-- 							</c:forEach> --%>
							
						 	<tr role="row" class="odd" 
						 	onclick="openModal(
						 	'${co.cord_count}', '${co.cord_number}', '${co.common_status }', '${co.cord_status}', 
						 	'${co.cord_manager_id}', '${manager_member_name}', '${manager_department_name}', '${manager_common_status}', '${manager_member_tel}',
						 	'${co.cprod_id}', '${prod_name }', '${prod_category }', '${prod_brand }', 
						 	'${co.cord_price}', '${co.cord_quantity}', 
						 	'${co.formattedOrdDate}', '${co.formattedOrdDateChange}', 
						 	'${co.ccompany_code }', 
						 	'${co.cord_text}' )">
						 
								<td class="sorting_1">${co.cord_count}</td>
		                        <td>${co.cord_number}</td>
		                        <td>${co.common_status }</td>
		                        <td style="display: none;">${co.cord_status}</td>
		                        <td>${co.cord_manager_id}</td>
		                        <td style="display: none;">${manager_member_name}</td>
		                        <td style="display: none;">${manager_department_name}</td>
		                        <td style="display: none;">${manager_common_status}</td>
		                        <td style="display: none;">${manager_member_tel}</td>
		                        <td>${co.cprod_id}</td>
		                        <td style="display: none;">${prod_name}</td>
		                        <td style="display: none;">${prod_category}</td>
		                        <td style="display: none;">${prod_brand}</td>
		                        <td>${co.cord_price}</td>
		                        <td>${co.cord_quantity}</td>
		                        <td>${co.formattedOrdDate}</td>
		                        <td>${co.formattedOrdDateChange}</td>
		                        <td>${co.ccompany_code}</td>
<%-- 		                        <td style="display: none;">${company_name}</td> --%>
<%-- 		                        <td style="display: none;">${company_tel}</td> --%>
		                        
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
        <form action="" id="orderFormC" method="post" name="orderFormC">
        	<div style="display: flex; gap: 10px;">
         		<label>순번 : </label>
        		<input type="text" id="modalCOrdCount" name="cord_count" readonly="readonly" class="form-control" style="width:200px;" />
            	<label>발주 관리 번호 : </label>
            	<input type="text" id="modalCOrdNumber" name="cord_number" readonly="readonly" class="form-control" style="width:200px;" />
            	<label>발주 상태 : </label>
            	<input type="text" id="modalCCommonStatus" name="ccommon_status" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" /><br>
            	<input type="hidden" id="modalCOrdStatus" name="cord_status" readonly="readonly" class="form-control" style="width:200px;" /><br>
        	</div>
           
           <div style="display: flex; gap: 10px;">
           		<label>발주 담당자:</label>
           </div>
          <div style="display: flex; gap: 10px;">
          	<input type="text" id="modalCOrdManagerId" name="cord_manager_id" readonly="readonly" class="form-control" style="width:200px;" /><br>
          	<input type="text" id="modalCManagerMemberName" name="cmanager_member_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalCManagerDepartmentName" name="cmanager_department_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalCManagerCommonStatus" name="cmanager_common_status" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          	<input type="text" id="modalCManagerMemberTel" name="cmanager_member_tel" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" />
          </div>
          
          
          <div style="display: flex; gap: 10px;">
           		<label>거래처 코드:</label>
           </div>
          <div style="display: flex; gap: 10px;">
          	<input type="text" id="modalCCompanyCode" name="ccompany_code" readonly="readonly" class="form-control" style="width:200px;" /><br>
<!--           	<input type="text" id="modalCCompanyName" name="company_name" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" /> -->
<!--           	<input type="text" id="modalCCompanyTel" name="company_tel" disabled="disabled" readonly="readonly" class="form-control" style="width:200px;" /> -->
          </div>
          
          
          <div style="display: flex; gap: 10px;">
           <label>제품식별코드 / 제품 이름 / 제품 카테고리 / 제품 브랜드 / 거래처코드 / 거래처 이름 / 거래처 전화번호</label>
          </div>
          <div style="display: flex; gap: 10px;">
           <!-- <input type="text" id="modalProdId" name="prod_id" class="form-control" style="width:200px;" /><br>
           <input type="text" id="modalCompanyCode" name="company_code" class="form-control" style="width:200px;" /><br> -->
           <select id="cprod_id" name="cprod_id" class="form-select form-control" required="required" style="width:600px;">
			<!-- <option value="" >목록에서 값을 확인 후 선택하세요</option> -->
			<c:forEach var="p" items="${pListVO02 }">
				<option id="modalCProdId" value="${p.prod_id }">${p.prod_id} / ${p.prod_name } / ${p.prod_category } / ${p.prod_brand } </option>
			</c:forEach>
		</select>
          </div>
          
          <div style="display: flex; gap: 10px;">
          	<label>발주 금액 : </label>
           <input type="text" id="modalCOrdPrice" name="cord_price" class="form-control" style="width:200px;" />
           <label>발주 수량 : </label>
           <input type="text" id="modalCOrdQuantity" name="cord_quantity" class="form-control" style="width:200px;" />
          </div>
          
          <div style="display: flex; gap: 10px;">
          	<label>발주 최초 기안 시간 : </label>
           <input type="text" id="modalCOrdDate" readonly="readonly" name="cord_date" class="form-control" style="width:200px;" />
           <label>발주 상태별 시간 : </label>
           <input type="text" id="modalCOrdDateChange" readonly="readonly" name="cord_date_change" class="form-control" style="width:200px;" />
          </div>
          
          <label>비고:</label>
          <textarea class="form-control" id="modalCOrdText" name="cord_text" class="form-control" style="width:750px;" ></textarea><br>
          <!-- <label>삭제 상태:</label> -->
          <input type="hidden" id="modalCOrdDeleteStatus" name="cord_delete_status" /><br>
         </form>
         
         <div id="buttonContainer"></div>
         
    </div>
</div>
    
    

<script>

var checkPage = '${checkPage}';

if(checkPage == 'insertOK'){
	alert("발주 정보가 등록 되었습니다.");
}

function openModal(cord_count, cord_number, ccommon_status, cord_status, 
	cord_manager_id, cmanager_member_name, cmanager_department_name, cmanager_common_status, cmanager_member_tel, 
	cprod_id, cprod_name, cprod_category, cprod_brand, 
	cord_price, cord_quantity, cord_date, cord_date_change, 
 	ccompany_code, 
	cord_text ) { 
	    document.getElementById('modalCOrdCount').value = cord_count;
	    document.getElementById('modalCOrdNumber').value = cord_number;
	    document.getElementById('modalCCommonStatus').value = ccommon_status;
	    document.getElementById('modalCOrdStatus').value = cord_status;
	    
	    document.getElementById('modalCOrdManagerId').value = cord_manager_id;
	    document.getElementById('modalCManagerMemberName').value = cmanager_member_name;
	    document.getElementById('modalCManagerDepartmentName').value = cmanager_department_name;
	    document.getElementById('modalCManagerCommonStatus').value = cmanager_common_status;
	    document.getElementById('modalCManagerMemberTel').value = cmanager_member_tel;
	    
	    
	    document.getElementById('cprod_id').value = cprod_id;
// 	    document.getElementById('modalProdId').value = prod_id; // <-- 원인. + id값은 고유한 값인데 반복문에 들어가면 의미없음 삭제요청
	    
	    document.getElementById('modalCOrdPrice').value = cord_price;
	    document.getElementById('modalCOrdQuantity').value = cord_quantity;
	    document.getElementById('modalCOrdDate').value = cord_date;
	    document.getElementById('modalCOrdDateChange').value = cord_date_change;
	    document.getElementById('modalCCompanyCode').value = ccompany_code;
// 	    document.getElementById('modalCCompanyName').value = company_name;
// 	    document.getElementById('modalCCompanyTel').value = company_tel;
	    
	    document.getElementById('modalCOrdText').value = cord_text;
	    

        // 여기서 cord_status 값을 기반으로 버튼을 렌더링
        renderButtons(cord_status);

        // 모달 표시
        document.getElementById('orderModal').style.display = 'block';
        
    } // openModal
        
    $(document).on('click',function(e){
    	// console.log(e.target); //    <- 삭제요청
    });
    
    // test <-- 삭제요청
        document.getElementById('cprod_id').addEventListener('change', function() {
        // 선택된 옵션의 value를 가져옴
        var selectedValue = this.value;
        // console.log으로 출력
        console.log('선택된 값:', selectedValue);
    	});
        
    // test <-- 삭제요청
    
function renderButtons(cord_status) {
    var buttonContainer = document.getElementById('buttonContainer');
    
 	// 각 input과 select 태그 선택
 	var cprod_id = document.getElementById('cprod_id');
 	var modalCOrdPrice = document.getElementById('modalCOrdPrice');
 	var modalCOrdQuantity = document.getElementById('modalCOrdQuantity');
 	
 	// 모달창에서의 manager id 값 불러오기
 	var cOrdManagerId = document.getElementById('modalCOrdManagerId').value;
    
    buttonContainer.innerHTML = ''; // 기존 버튼 초기화
	
    // 발주 상태가 요청(01 : 거래처의 발주 완료)
    if (cord_status === '01') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">발주 완료</button>';
        // 세션 로그인 아이디 == 발주자만 가능
        if('${userId}' === cOrdManagerId){
	        buttonContainer.innerHTML += '<button id="updateBtnC" class="btn btn-success">수정</button>';
	        buttonContainer.innerHTML += '<button id="deleteBtnC" class="btn btn-danger">삭제</button>';
        }
        
     	// input태그 select 태그 활성화
        cprod_id.disabled = false;
        modalCOrdPrice.readOnly = false;
        modalCOrdQuantity.readOnly = false;
      
    } // if (cford_status === '01')
    	
    	
    // 발주 상태가 반려(02 : 거래처의 발주가 출고 완료됨)
    else if (cord_status === '02') {
    	// 발주 상태 안내
        buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="btn btn-default">출고 완료</button>';
     	
     	// input태그 select 태그 활성화
        cprod_id.disabled = true;
        modalCOrdPrice.readOnly = true;
        modalCOrdQuantity.readOnly = true;
    } // else if (cord_status === '02')

    	
    // 버튼에 이벤트 리스너 추가
    addButtonEventListeners();
    
} // renderButtons

function addButtonEventListeners() {
	
	let formData;
	
    document.getElementById('updateBtnC')?.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지
        
        formData = new FormData(document.getElementById('orderFormC'));
        fetch("/updateOrderC", {
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

    document.getElementById('deleteBtnC')?.addEventListener('click', function(event) {
        event.preventDefault();
        
        formData = new FormData(document.getElementById('orderFormC'));
        fetch("/deleteOrderC", {
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
