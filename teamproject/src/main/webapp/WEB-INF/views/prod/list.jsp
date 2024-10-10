<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />
	
<style>
    /* 테이블 헤더 배경색 */
    #multi-filter-select thead th {
        background-color: #0d6efd; /* 원하는 색상으로 변경 */
        color: white;
    }
</style>

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
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/plugins.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/kaiadmin.min.css" />


</head>
<body>
	<div class="wrapper">

		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />

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
                  <a href="#">제품목록</a>
                </li>
              </ul>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <h4 class="card-title">제품목록</h4>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive">
                      <table
                        id="multi-filter-select"
                        class="display table table-hover"
                      >
                        <thead>
                          <tr>
                            <th>제품식별코드</th>
                            <th>제품명</th>
                            <th>카테고리</th>
                            <th>수량</th>
                            <th>입고가</th>
                            <th>거래처</th>
                            <th>제품이미지</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>제품식별코드</th>
                            <th>제품명</th>
                            <th>카테고리</th>
                            <th>수량</th>
                            <th>입고가</th>
                            <th>거래처</th>
                            <th>제품이미지</th>
                          </tr>
                        </tfoot>
                        <tbody>
                      <c:forEach var="p" items="${plistVO}">
                        <tr>
					        <td>${p.prod_id}</td>
					        <td>${p.prod_name}</td>
					        <td>${p.prod_category}</td>
					        <td>${p.prod_qty}</td>
					        <td>${p.prod_price}</td>
					        <td>${p.company_code}</td>
					        <td><img src="${p.prod_image}" alt="제품이미지" style="width:75px; height:75px; object-fit: contain;"></td>
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
		<jsp:include page="/resources/inc/footer.jsp" />
	</div>

	<!--   Core JS Files   -->
	<script src="/resources/js/core/jquery-3.7.1.min.js?ver=1.0"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<!-- jQuery Scrollbar -->
	<script
		src="/resources/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<!-- Chart JS -->
	<script src="/resources/js/plugin/chart.js/chart.min.js"></script>

	<!-- jQuery Sparkline -->
	<script
		src="/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

	<!-- Chart Circle -->
	<script src="/resources/js/plugin/chart-circle/circles.min.js"></script>

	<!-- Datatables -->
	<script src="/resources/js/plugin/datatables/datatables.min.js"></script>

	<!-- Bootstrap Notify -->
	<script
		src="/resources/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

	<!-- jQuery Vector Maps -->
	<script src="/resources/js/plugin/jsvectormap/jsvectormap.min.js"></script>
	<script src="/resources/js/plugin/jsvectormap/world.js"></script>

	<!-- Sweet Alert -->
	<script src="/resources/js/plugin/sweetalert/sweetalert.min.js"></script>

	<!-- Kaiadmin JS -->
	<script src="/resources/js/kaiadmin.min.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function () {
        $("#multi-filter-select").DataTable({
        	pageLength: 5, // 기본 페이지 길이
        	lengthMenu: [20, 50, 100, 500], // 사용자가 선택할 수 있는 페이지 길이 옵션
        	initComplete: function () {
        		this.api()
        		.columns()
        		.every(function () {
	                var column = this;
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
          },
       });

      });//jquery DOM 준비
    </script>
  
	
	
</body>
</html>