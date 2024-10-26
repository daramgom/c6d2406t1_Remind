<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />

<style>
		
	#multi-filter-select thead th {
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

</style>

</head>
<body>
<c:if test="${empty sessionScope.id}">
	<c:redirect url="/login"/>
</c:if>
<c:if test="${sessionScope.member_code != 1}">
	<c:redirect url="/cmain"/>
</c:if>
	<div class="wrapper">
	
		<!-- Header -->
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/sidebar.jsp" />

		<!-- Main Content -->
		<div class="container">
          <div class="page-inner">
            <div class="page-header">
              <h3 class="fw-bold mb-3">제품관리</h3>
              <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                  <a href="#">
                    <i class="icon-home"></i>
                  </a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">제품관리</a>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  <a href="#">제품이동내역</a>
                </li>
              </ul>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <h3 class="card-title">제품이동내역</h3>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive" style="overflow-x: auto; -webkit-overflow-scrolling: touch;">
                      <table
                        id="multi-filter-select"
                        class="display table table-hover"
                      >
                        <thead>
                        <tr>
                            <th>제품식별코드</th>
                            <th>출발창고</th>
                            <th>도착창고</th>
                            <th>이동수량</th>
                            <th>작업자</th>
                            <th>작업일시</th>
                            <th>재고이동사유</th>
                            <th>승인자</th>
                            <th>승인일시</th>
                        </tr>
                        </thead>
                        <tfoot>
						<tr>
							<th>제품식별코드</th>
							<th>출발창고</th>
							<th>도착창고</th>
							<th>이동수량</th>
							<th>작업자</th>
							<th>작업일시</th>
							<th>재고이동사유</th>
							<th>승인자</th>
							<th>승인일시</th>
						</tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="m" items="${moveList}">
							<tr>
								<td style="padding:0 !important;">${m.prod_id}<br> ${m.prod_name}<br> ${m.prod_brand}<br> ${m.company_code}</td>
								<td style="padding:0 !important;">${m.wh_number}<br> ${m.wh_name}<br> ${m.wh_location}<br> ${m.wh_dt_location}</td>
								<td style="padding:0 !important;">${m.stock_wh}<br> ${m.wh_name2}<br> ${m.wh_location2}<br> ${m.wh_dt_location2}<br></td>
								<td style="padding:0 !important;">${m.stock_qty}</td>
								<td style="padding:0 !important;">${m.prod_regname}<br>(${m.prod_reguser})</td>
								<td style="padding:0 !important;">${m.formatted_regdate}</td>
								<td style="padding:0 !important;">${m.move_reason}</td>
								<c:choose>
									<c:when test="${!empty m.prod_updname}">
									<td style="padding:0 !important;">${m.prod_updname}<br>(${m.prod_upduser})</td>
									</c:when>
									<c:otherwise>
									<td></td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${!empty m.formatted_upddate}">
									<td style="padding:0 !important;">${m.formatted_upddate}</td>
									</c:when>
									<c:otherwise>
									<td></td>
									</c:otherwise>
								</c:choose>
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
           
		
		<!-- Footer -->
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/footer.jsp" />
	</div>

	
<script type="text/javascript">
$(document).ready(function () {
	let prodImage;
		
	// 데이터테이블
	$("#multi-filter-select").DataTable({
		pageLength: 10,
		lengthMenu: [10, 20, 50, 100, 500],
		initComplete: function () {
			var table = this.api();

			var columnsToFilter = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

			columnsToFilter.forEach(function (index) {
				var column = table.column(index);
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
					.each(function (d, j) {
						select.append(
							'<option value="' + d + '">' + d + "</option>"
						);
					});
			});
		}
	});
	// 데이터테이블
	
	
});//jquery DOM 준비
</script>

	
	
</body>
</html>