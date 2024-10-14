<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품목록</title>

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
    
    .table td {
    	font-size: 1.15rem !important;
    	text-align: center;
    }
    
    .table th {
    	font-size: 1.25rem !important;
    	text-align: center;
    }
    
    .modal-dialog {
    	--bs-modal-width: 1200px;
    }
    
    .modal-content {
            height: 90vh; /* 최대 높이 설정 */
            overflow-y: auto; /* 세로 스크롤 */
            overflow-x: hidden; /* 가로 스크롤 숨김 */
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
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />


</head>
<body>
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
                            <th>입고처</th>
                            <th>등록일시</th>
                            <th>제품이미지</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>제품식별코드</th>
                            <th>제품명</th>
                            <th>카테고리</th>
                            <th>수량</th>
                            <th>입고처</th>
                            <th>등록일시</th>
                          </tr>
                        </tfoot>
                        <tbody>
                      <c:forEach var="p" items="${plistVO}">
                        <tr class="prod_detail">
					        <td>${p.prod_id}</td>
					        <td>${p.prod_name}</td>
					        <td>${p.prod_category}</td>
					        <td>${p.prod_qty}</td>
					        <td>${p.company_code}</td>
					        <td>${p.formatted_upddate}</td>
					        <td><img src="${p.prod_image}" alt="제품이미지" style="width:75px; height:75px; object-fit: contain;"></td>
                        </tr>
                      </c:forEach>
                        </tbody>
                      </table>
                      
					<!-- Modal -->
                    <div
                      class="modal fade"
                      id="prodModal"
                      tabindex="-1"
                      role="dialog"
                      aria-hidden="true"
                    >
                      <div class="modal-dialog" role="document" style="width:1200px">
                        <div class="modal-content">
                          <div class="modal-header border-0">
                            <h5 class="modal-title">
                              <span class="fw-mediumbold"> 제품상세정보 </span>
                            </h5>
                            <button
                              type="button"
                              class="close"
                              data-bs-dismiss="modal"
                              aria-label="Close"
                            >
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <form action="/prod/update" id="prodUpdateForm" method="post" enctype="multipart/form-data">
                              <div class="row">
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품식별코드</label>
                                    <input
                                      id="prod_id"
                                      name="prod_id"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품식별코드"
                                      readonly="readonly"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품이름</label>
                                    <input
                                      id="prod_name"
                                      name="prod_name"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품이름"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품카테고리</label>
                                    <input
                                      id="prod_category"
                                      name="prod_category"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품카테고리"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>브랜드</label>
                                    <input
                                      id="prod_brand"
                                      name="prod_brand"
                                      type="text"
                                      class="form-control"
                                      placeholder="브랜드"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>수량</label>
                                    <input
                                      id="prod_qty"
                                      name="prod_qty"
                                      type="number"
                                      class="form-control"
                                      placeholder="수량"
                                      min="0"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>입고가</label>
                                    <input
                                      id="prod_price"
                                      type="number"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>거래처</label>
                                    <input
                                      id="company_code"
                                      name="company_code"
                                      type="text"
                                      class="form-control"
                                      readonly="readonly"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품위치</label>
                                    <input
                                      id="wh_number"
                                      name="wh_number"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품위치"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>등록일시</label>
                                    <input
                                      id="prod_regdate"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>등록자</label>
                                    <input
                                      id="prod_reguser"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                              	</div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>수정일시</label>
                                    <input
                                      id="prod_upddate"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>수정자</label>
                                    <input
                                      id="prod_upduser"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>비고</label>
                                    <textarea 
                                    	id="prod_remarks" 
                                    	name="prod_remarks" 
                                    	rows="4" cols="30" 
                                    	class="form-control"></textarea>
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>이미지</label>
                                    <input type="file" 
                                    	class="form-control input-full"
										id="uploadfile" 
										name="uploadfile" 
										accept=".jpeg, .jpg, .png, .gif" />
                                  </div>
                                </div>
                                <input type="hidden" id="current_image" name="current_image"/>
                                <input type="hidden" id="current_wh" name="current_wh"/>
                                <input type="hidden" id="current_qty" name="current_qty"/>
                              </div>
                         	</form>
                          </div>
                          <div class="modal-footer border-0" style="justify-content : center;">
                            <button
                              type="button"
                              id="prodUpdate"
                              class="btn btn-primary"
                            >
                              수정하기
                            </button>
                            <button
                              type="button"
                              class="btn btn-danger"
                              data-bs-dismiss="modal"
                            >
                              닫기
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
					
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
        
       
    	// <tr> 클릭 시 모달 열기
       $(".prod_detail").click(function() {
           var row = $(this); // 클릭한 <tr>
           var prod_id = row.find('td:eq(0)').text(); // 제품 식별 코드

           // prod_id를 POST 방식으로 보내기
           fetch('/prod/find', {
               method: 'POST', // HTTP 메서드 설정
               headers: {
                   'Content-Type': 'application/json' // 요청 본문의 데이터 형식 설정
               },
               body: JSON.stringify({ prod_id: prod_id }) // JSON 형식으로 데이터 전송
           })
           .then(response => {
               if (!response.ok) {
                   throw new Error('네트워크 응답이 올바르지 않습니다');
               }
               return response.json(); // JSON으로 응답 파싱
           })
           .then(data => {
               // 모달에 데이터 설정
               $("#prod_id").val(prod_id);
               $("#prod_name").val(data.prod_name);
               $("#prod_category").val(data.prod_category);
               $("#prod_brand").val(data.prod_brand);
               $("#prod_qty").val(data.prod_qty);
               $("#prod_price").val(data.prod_price);
               $("#company_code").val(data.company_code);
               $("#wh_number").val(data.wh_number);
               $("#prod_regdate").val(data.formatted_regdate);
               $("#prod_reguser").val(data.prod_reguser);
               $("#prod_upddate").val(data.formatted_upddate);
               $("#prod_upduser").val(data.prod_upduser);
               $("#prod_remarks").val(data.prod_remarks);
               $("#current_image").val(data.current_image);
               $("#current_wh").val(data.current_wh);
               $("#current_qty").val(data.current_qty);
               

               // 모달 열기
               $("#prodModal").modal('show');
               console.log(data.current_qty);
           })
           .catch(error => {
               console.error('데이터를 가져오는 과정에서 문제가 발생했습니다', error);
           });
       });
     	
     	
     	// 숫자 형식지정
        // 문자열로 된 숫자를 가져오기
        $(".prodNumber").each(function() {
            // 현재 td의 텍스트를 가져오기
            const prodNumber = $(this).text();
            
            // 문자열을 숫자로 변환하고 천 단위 구분 기호 추가
            const formatNumber = Number(prodNumber).toLocaleString();
            
            // 형식이 적용된 숫자를 다시 설정
            $(this).text(formatNumber);
        });
     	
     	
        $("#prodUpdate").click(function() {
            $("#prodUpdateForm").submit(); // 폼 제출
        });
        
        
        $('#prodUpdateForm').on('submit', function (e) {
            e.preventDefault(); // 기본 제출 이벤트 방지
            
            $("#prodUpdate").prop('disabled', true);
            
            var formData = new FormData(this); // FormData 객체 생성

            $.ajax({
                url: '/prod/update', // 서버의 처리 URL
                type: 'POST',
                data: formData,
                processData: false, // jQuery가 데이터를 처리하지 않도록 설정
                contentType: false, // jQuery가 Content-Type을 설정하지 않도록 설정
                success: function (response) {
                    // 성공 시 SweetAlert 모달 표시
                    swal({
                    	title: "성공!",
                    	text: "제품이 수정되었습니다!",
                    	icon: "success",
                    	buttons: {
                    		text: "확인",
                    	}
                    }).then(() => {
                        location.href = "/prod/list";
                    });
                },
                error: function (error) {
                    // 오류 시 SweetAlert 모달 표시
                    swal({
                    	title: "오류!",
                    	text: "제품 수정에 실패했습니다.",
                    	icon: "error"
                    });
                },
                complete: function() {
                    // 요청이 완료되면 버튼 활성화
                    $('#prodUpdate').prop('disabled', false);
                }
            });
        });
        
        
      });//jquery DOM 준비
    </script>
  
	
	
</body>
</html>