<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REMIND</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<!-- Fonts and icons -->
<script src="/resources/js/plugin/webfont/webfont.min.js"></script>

<script>
	WebFont.load({
		google : {
			families : [ "Public Sans:300,400,500,600,700" ]
		},
		custom : {
			families : [ "Font Awesome 5 Solid", "Font Awesome 5 Regular",
					"Font Awesome 5 Brands", "simple-line-icons", ],
			urls : [ "/resources/css/fonts.min.css" ],
		},
		active : function() {
			sessionStorage.fonts = true;
		},
	});
</script>

<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />

<style>
	.card-category {
		font-size: 1.5rem;
	}
	
	#cmainProdTable thead th {
		background-color: #6861ce !important;
		color: white;
	}
    
	.table td {
		font-size: 1.2rem !important;
		text-align: center;
		white-space: nowrap;
	}
    
	.table th {
		font-size: 1.25rem !important;
		text-align: center;
		white-space: nowrap;
	}
	
	.numbers {
		display: inline-block;
		transition: transform 0.2s;
	}

	.numbers:hover {
		transform: scale(1.07);
	}
	
	.overview {
		display: inline-block;
		transition: transform 0.2s;
	}

	.overview:hover {
		transform: scale(1.02);
	}
	

</style>

</head>
<body>
<c:if test="${empty sessionScope.id}">
	<c:redirect url="/login"/>
</c:if>
<c:if test="${sessionScope.member_code == 1}">
	<c:redirect url="/main"/>
</c:if>
	
	<div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/companyHeader.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/companySidebar.jsp" />
	
		<!-- Main Content -->
		<div class="container">
			<div class="page-inner">
				<div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
					<div>
						<h3 class="fw-bold mb-3">메인페이지</h3>
						<h6 class="op-7 mb-2">재고관리 시스템 메인페이지</h6>
					</div>
				</div>
	
				<div class="row">
					<div class="col-sm-6 col-md-2 numbers">
						<div class="card card-stats card-round">
							<div class="card-body">
								<div class="row">
									<div class="col-icon">
										<div class="icon-big text-center icon-info bubble-shadow-small">
											<i class="fas fa-shipping-fast"></i>
										</div>
									</div>
									<div class="col col-stats ms-3 ms-sm-0">
										<div>
											<p class="card-category text-info fw-bold">발주 요청</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-3 numbers">
						<div class="card card-stats card-round">
							<div class="card-body">
								<div class="row">
									<div class="col-icon">
										<div class="icon-big text-center icon-warning bubble-shadow-small" style="white-space: nowrap;">
											<i class="fas fa-clipboard-list"></i>
										</div>
									</div>
									<div class="col col-stats ms-3">
										<div>
											<p class="card-category text-warning fw-bold">발주 요청 목록</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-2 numbers">
						<div class="card card-stats card-round">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-icon">
										<div class="icon-big text-center icon-danger bubble-shadow-small">
											<i class="fas fa-clipboard-list"></i>
										</div>
									</div>
									<div class="col col-stats ms-3 ms-sm-0">
										<div>
											<p class="card-category text-danger fw-bold">출고 수락</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				<div class="row">
					<div class="col-md-12 overview">
						<div class="card card-round">
							<div class="card-header">
								<div class="card-head-row">
									<div class="card-title">
									제품목록
									</div>
									<div class="card-tools">
										<a href="#" class="btn btn-label-primary btn-round btn-sm me-2" id="exportImage">
											<span class="btn-label">
												<i class="far fa-image"></i>
											</span>
										Export Image
										</a>
										<a href="#" class="btn btn-label-success btn-round btn-sm me-2" id="exportExcel">
											<span class="btn-label">
												<i class="fas fa-file-excel"></i>
											</span>
										Export Excel
										</a>
									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="table-responsive" 
								style="overflow-x: auto; -webkit-overflow-scrolling: touch;">
									<table id ="cmainProdTable" class="display table table-hover">
										<thead>
											<tr>
												<th>제품식별코드</th>
												<th>제품명</th>
												<th>카테고리</th>
												<th>브랜드</th>
												<th>이미지</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>제품식별코드</th>
												<th>제품명</th>
												<th>카테고리</th>
												<th>브랜드</th>
												<th></th>
											</tr>
										</tfoot>
										<tbody>
										<c:forEach var="cp" items="${cmainListProd}" >
											<tr class="cmainProdTableBody">
												<td style="padding:0 !important;">${cp.prod_id}</td>
												<td style="padding:0 !important;">${cp.prod_name}</td>
												<td style="padding:0 !important;">${cp.prod_category}</td>
												<td style="padding:0 !important;">${cp.prod_brand}</td>
												<td style="padding:0 !important;"><img src="${cp.prod_image}" alt="제품이미지" style="width:75px; height:75px; object-fit: contain;"></td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
	
	<!-- Footer -->
	<jsp:include page="/resources/inc/companyFooter.jsp" />
	</div>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/exceljs/4.3.0/exceljs.min.js"></script>
	
<script type="text/javascript">

$(document).ready(function () {
	
	// 데이터테이블
    $("#cmainProdTable").DataTable({
    	pageLength: 10, // 기본 페이지 길이
    	lengthMenu: [10, 20, 50, 100, 500], // 사용자가 선택할 수 있는 페이지 길이 옵션
    	initComplete: function () {
    		var table = this.api();

            // 필터를 적용할 열 인덱스 배열 (예: 두 번째 열과 세 번째 열)
            var columnsToFilter = [0,1,2,3];

            // 각 열에 대해 필터 추가
            columnsToFilter.forEach(function (index) {
                var column = table.column(index); // 특정 열 선택
                var select = $(
                  '<select class="form-select"><option value=""></option></select>'
            	)
            	.appendTo($(column.footer()).empty())
            	.on("change", function () {
                	var val = $.fn.dataTable.util.escapeRegex($(this).val());

                column
                .search(val ? "^" + val + "$" : "", true, false)
                .draw();
            	});

            	column
                .data()
                .unique()
                .sort()
                .each(function (d, j){
            		select.append(
                		'<option value="' + d + '">' + d + "</option>"
                	);
            	});
              });
            }
        });
 	// 데이터테이블
 	
 	// 테이블 이미지 다운로드
	$('#exportImage').on('click', function() {
		html2canvas($('#cmainProdTable')[0]).then(function(canvas) {
			var imgData = canvas.toDataURL("image/png");
			var downloadLink = document.createElement('a');
			
			downloadLink.href = imgData;
			downloadLink.download = 'REMIND_prod_table.png';
			
			downloadLink.click();
		});
	});
 	// 테이블 이미지 다운로드
 	
 	
 	// 테이블 엑셀 다운로드
 		$('#exportExcel').on('click', function() {
		// 새로운 워크북 생성
		var workbook = new ExcelJS.Workbook();
		var worksheet = workbook.addWorksheet('My Sheet');

		// 테이블의 데이터 가져오기
		var $table = $('#cmainProdTable');

		// 헤더 추가
		$table.find('thead th').each(function(index) {
			if(index != 4){
				worksheet.getCell(1, index + 1).value = $(this).text();
			}
		});

		// 데이터 추가
		$table.find('tbody tr').each(function(rowIndex) {
			$(this).find('td').each(function(cellIndex) {
				if(cellIndex != 4){
					worksheet.getCell(rowIndex + 2, cellIndex + 1).value = $(this).text();
				}
			});
		});

		// 엑셀 파일로 저장
		workbook.xlsx.writeBuffer().then(function(buffer) {
			var blob = new Blob([buffer], { type: 'application/octet-stream' });
			var link = document.createElement('a');
			link.href = window.URL.createObjectURL(blob);
			link.download = 'REMIND_prod_table.xlsx';
			link.click();
		});
	});
 	// 테이블 엑셀 다운로드
 	
 	
});


</script>
</body>
</html>