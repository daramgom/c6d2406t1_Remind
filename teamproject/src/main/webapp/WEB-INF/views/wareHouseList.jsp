<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 목록</title>

<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

<style>
    /* 테이블 헤더 배경색 */
    #multi-filter-select thead th {
        background-color: #0d6efd; /* 원하는 색상으로 변경 */
        color: white;
    }
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
    }
    .pagination a {
        margin: 0 5px;
        padding: 8px 16px;
        border: 1px solid #0d6efd;
        color: #0d6efd;
        text-decoration: none;
        border-radius: 4px;
    }
    .pagination a.active {
        background-color: #0d6efd;
        color: white;
    }
    .pagination a.disabled {
        color: #ccc;
        pointer-events: none;
        border-color: #ccc;
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
			families : [ "Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands", "simple-line-icons" ],
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
              <h3 class="fw-bold mb-3">창고 목록</h3>
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
                  <a href="#">창고 목록</a>
                </li>
              </ul>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="card-title">창고 목록</h4>
                    <!-- 항상 보이는 창고 추가 버튼 -->
                    <a href="${pageContext.request.contextPath}/warehouse/wareHouseInsert" class="btn btn-primary">창고 추가</a>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive">
                      <table id="multi-filter-select" class="display table table-hover">
                        <thead>
                          <tr>
                            <th>번호</th>
                            <th>창고 이름</th>
                            <th>위치</th>
                            <th>등록 사용자</th>
                            <th>수정 사용자</th>
                          </tr>
                        </thead>
                        <tfoot>
                         <tr>
                            <th>번호</th>
                            <th>창고 이름</th>
                            <th>위치</th>
                            <th>등록 사용자</th>
                            <th>수정 사용자</th>
                          </tr>
                        </tfoot>
                        <tbody id="warehouse-table-body">
                          <c:forEach var="warehouse" items="${warehouseList}">
                            <tr class="warehouse-row">
                              <td>${warehouse.wh_number}</td>
                              <td>
                                <a href="${pageContext.request.contextPath}/warehouse/view?wh_number=${warehouse.wh_number}">
                                  ${warehouse.wh_name}
                                </a>
                              </td>
                              <td>${warehouse.wh_location}</td>
                              <td>${warehouse.wh_reguser}</td>
                              <td>${warehouse.wh_updateuser}</td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                    <div class="pagination" id="pagination">
                      <a href="#" class="prev-page" id="prevPage">이전</a>
                      <div id="pageNumbers"></div>
                      <a href="#" class="next-page" id="nextPage">다음</a>
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

	<!-- Core JS Files -->
	<script src="/resources/js/core/jquery-3.7.1.min.js?ver=1.0"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

	<!-- jQuery Scrollbar -->
	<script src="/resources/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<script>
		$(document).ready(function() {
			const rowsPerPage = 3; // 한 페이지에 표시할 행 수
			const rows = $(".warehouse-row").length; // 전체 행 수
			const pageCount = Math.ceil(rows / rowsPerPage); // 페이지 수
			let currentPage = 1; // 현재 페이지 번호

			// 페이지네이션 생성
			function generatePagination() {
				$("#pageNumbers").empty(); // 기존 페이지 번호 삭제
				for (let i = 1; i <= pageCount; i++) {
					$("#pageNumbers").append(`<a href="#" class="page-link" data-page="${i}">${i}</a>`);
				}
				updatePaginationButtons(); // 버튼 상태 업데이트
			}

			function updatePaginationButtons() {
				$("#prevPage").toggle(currentPage > 1); // 이전 버튼 표시 여부
				$("#nextPage").toggle(currentPage < pageCount); // 다음 버튼 표시 여부
			}
			<script type="text/javascript">
			$(document).ready(function () {
				let prodImage;
				
				// 데이터테이블
		        $("#multi-filter-select").DataTable({
		        	pageLength: 10, // 기본 페이지 길이
		        	lengthMenu: [10, 20, 50, 100, 500], // 사용자가 선택할 수 있는 페이지 길이 옵션
		        	initComplete: function () {
		        		var table = this.api();

		                // 필터를 적용할 열 인덱스 배열 (예: 두 번째 열과 세 번째 열)
		                var columnsToFilter = [0,1,2,3,4,5];

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
			                .each(function (d, j) {
		                		select.append(
		                    		'<option value="' + d + '">' + d + "</option>"
		                    	);
		                	});
		                  });
		                }
		            });
		     	// 데이터테이블
			// 페이지 전환
			function showPage(page) {
				const start = (page - 1) * rowsPerPage;
				const end = start + rowsPerPage;

				$(".warehouse-row").hide(); // 모든 행 숨기기
				$(".warehouse-row").slice(start, end).show(); // 현재 페이지의 행만 표시
				currentPage = page; // 현재 페이지 업데이트
				updatePaginationButtons(); // 버튼 상태 업데이트
				$(".page-link").removeClass("active"); // 모든 페이지 링크에서 active 클래스 제거
				$(`.page-link[data-page="${page}"]`).addClass("active"); // 현재 페이지 링크에 active 클래스 추가
			}

			// 초기 페이지 표시
			showPage(1);
			generatePagination(); // 페이지네이션 생성

			// 페이지 링크 클릭 이벤트
			$(document).on("click", ".page-link", function(e) {
				e.preventDefault();
				const page = $(this).data("page");
				showPage(page);
			});

			// 이전 페이지 버튼 클릭 이벤트
			$("#prevPage").click(function(e) {
				e.preventDefault();
				if (currentPage > 1) {
					showPage(currentPage - 1);
				}
			});

			// 다음 페이지 버튼 클릭 이벤트
			$("#nextPage").click(function(e) {
				e.preventDefault();
				if (currentPage < pageCount) {
					showPage(currentPage + 1);
				}
			});
		});
	</script>
</body>
</html>
