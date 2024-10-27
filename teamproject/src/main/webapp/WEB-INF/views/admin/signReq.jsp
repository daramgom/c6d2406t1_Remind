<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원 목록</title>

<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<style>
.btn-confirm {
	padding: 0.65rem 1.4rem;
	font-size: 1rem;
	font-weight: 500;
	opacity: 1;
	border-radius: 3px;
	background-color: #5f41e4; /* 확인 버튼 배경색 */
	color: #fff; /* 확인 버튼 텍스트 색상 */
}

.btn-cancel {
	padding: 0.65rem 1.4rem;
	font-size: 1rem;
	font-weight: 500;
	opacity: 1;
	border-radius: 3px;
	background-color: #d1c6e7; /* 취소 버튼 배경색 */
	color: #000; /* 취소 버튼 텍스트 색상 */
}

.EmpRank, .Department {
	padding: 10px 10px 10px 5px;
	width: 100px;
	border-radius: 8px;
	border: 1px solid #eee;
}

tr {
	text-align: center;
}

@import
	url('https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css')
	;

* {
	font-family: 'NanumSquare', sans-serif;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
.currentpage {

	font-size: 26px;
	font-weight: 400;
	line-height: 30px;
	color : #6861ce;
	border-color: #ddd; background-color: var(--bs-pagination-disabled-bg);     border-radius: 100px;
	padding: 0 10px
}
</style>

<!-- Fonts and icons -->


<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/adminMemberList.css" />
</head>
<body>

<c:if
		test="${sessionScope.id == null || sessionScope.permission_id != '03'}">
		<c:redirect url="/main" />
	</c:if>
	
	
	<c:if
		test="${sessionScope.member_code != '01'}">
		<c:redirect url="/main" />
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
					<h3 class="fw-bold mb-3">회원 가입 신청 목록</h3>
					<ul class="breadcrumbs mb-3">
						<li class="nav-home"><a href="#"> <i class="icon-home"></i>
						</a>
						</li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card w-100">
							<div class="card-header"
								style="display: flex; justify-content: space-between;">
								<div class="card-title">목록</div>
								<c:if test="${ WaitingList != null}">
									<div style="margin-right: 1rem;">
										<button id="approveBtn"
											style="margin-right: 1rem; padding: 0.7rem 2rem; background: #5f41e4 ! IMPORTANT; border: none;"
											class="btn btn-success hover-btn">승인</button>
										<button style="padding: 0.7rem 2rem;" id="deleteBtn"
											class="btn btn-danger">삭제</button>
									</div>
								</c:if>
							</div>

							<div class="card-body d-flex flex-column">
								<div class="row">
									<div class="col-md-12">
										<form action="">
											<table class="col-md-12 table">
												<tr>
													<th style="width: 1%"><input type="checkbox"
														id="selectAll" class="form-check-input"></th>
													<th class="col-md-1">이름</th>
													<th class="col-md-1">직급</th>
													<th class="col-md-2">부서</th>
													<th class="col-md-2">이메일</th>
													<th class="col-md-2">전화번호</th>
													<th class="col-md-2">가입일자</th>
												</tr>

												<c:if test="${ WaitingList != null}">
													<c:forEach items="${WaitingList}" var="member">
														<tr>
															<td><input class="form-check-input"
																name="${member.member_id}" type="checkbox"></td>
															<td>${member.member_name}</td>
															<td><select name="" class="EmpRank">
																	<!-- 어드민 리스트에서 했던 작업 그대로 쓰면 될듯. -->
																	<c:forEach items="${EmpList}" var="emp">
																		<option value="${emp.common_value}"
																			<c:if test="${member.employee_rank == emp.common_value}">selected</c:if>>${emp.common_status}</option>
																	</c:forEach>

															</select></td>
															<td><select name="" class="Department">
																	<!-- 어드민 리스트에서 했던 작업 그대로 쓰면 될듯. -->
																	<c:forEach items="${DeptList}" var="dept">
																		<option value="${dept.department_id}"
																			<c:if test="${member.department_id == dept.department_id}">selected</c:if>>${dept.department_name}</option>
																	</c:forEach>
															</select></td>
															<td>${member.member_email}</td>
															<td>${member.member_tel}</td>
															<td>${member.create_date}</td>
														</tr>
													</c:forEach>
												</c:if>

											</table>
										</form>
										<div style="    float: right;
    margin-right: 30px;"><!-- 페이지 네비게이션 -->
<c:if test="${pageCount > 1}">
    <div class="pagination">
        <!-- 이전 페이지 링크 -->
        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}" style="padding: 0 10px; color:black; font-size : 18px;     border-color: #ddd; background-color: var(--bs-pagination-disabled-bg);     border-radius: 100px;">Previous</a>
        </c:if> 

        <!-- 페이지 번호 링크 -->
        <c:forEach var="i" begin="1" end="${pageCount}">
            <a href="?page=${i}" style="padding: 0 10px; color:black; font-size : 20px;">
                <span class="${currentPage == i ? 'currentpage' : ''}">${i}</span>
            </a>
        </c:forEach>

        <!-- 다음 페이지 링크 -->
        <c:if test="${currentPage < pageCount}">
            <a href="?page=${currentPage + 1}"  style="padding: 0 10px; color:black; font-size : 18px;     border-color: #ddd; background-color: var(--bs-pagination-disabled-bg);     border-radius: 100px;">Next</a>
        </c:if>
    </div>
</c:if> </div>
									</div>
								</div>
								<c:if test="${WaitingList == null}">
									<div style="margin: 20px auto;">
										<h3>현재 승인 대기 중인 회원가입 요청이 없습니다.</h3>
									</div>
								</c:if>
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
	<script src="/resources/js/core/jquery-3.7.1.min.js"></script>
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
	<script>
	
      

      function showConfirmationAlert(message) {
        return new Promise((resolve, reject) => {
          swal({
            title: "변경하시겠습니까?",
            text: message,
            icon: "warning",
            buttons: {
              confirm: {
                text: "확인",
                value: true,
                visible: true,
                className: "btn-confirm",
                closeModal: true,
              },
              cancel: {
                text: "취소",
                value: null,
                visible: true,
                className: "btn-cancel",
                closeModal: true,
              },
            },
          }).then((willChange) => {
            if (willChange) {
              resolve(); // 확인 버튼 클릭 시 resolve 호출
            } else {
              reject(); // 취소 버튼 클릭 시 reject 호출
            }
          });
        });
      }
    </script>
	<script>
	 $(document).ready(function () {
         // 전체 선택 체크박스 클릭 이벤트
         $("#selectAll").click(function () {
             var isChecked = $(this).is(":checked");
             $(".form-check-input").prop("checked", isChecked);
         });

         // 각 행의 체크박스 클릭 이벤트
         $(".form-check-input").click(function () {
             var allChecked = $(".form-check-input:checked").length === $(".form-check-input").length;
             $("#selectAll").prop("checked", allChecked);
         });

         $("#deleteBtn").click(function () {
             var deleteData = [];
             $('.form-check-input:checked').each(function () {
                 var row = $(this).closest('tr'); // 체크박스가 포함된 행 선택
                 var memberId = $(this).attr('name');

                 deleteData.push({
                     member_id: memberId
                 });
             });
             if (deleteData.length > 0) {
                 $.ajax({
                     url: "/admin/signReqDelete",
                     type: "POST",
                     data: JSON.stringify(deleteData), // 선택된 데이터 배열을 JSON 문자열로 변환
                     contentType: "application/json",
                     dataType: "json",
                     success: function (response) {
                         if (response.result) {
                             swal("회원 정보가 삭제되었습니다.", {
                                 icon: "success",
                             }).then(() => {
                                 location.reload(); // 페이지 새로 고침
                             });
                         } else {
                             swal("삭제 중 오류가 발생했습니다.", {
                                 icon: "error"
                             });
                         }
                     },
                     error: function (jqXHR, textStatus, errorThrown) {
                         console.error("AJAX 요청 실패:", textStatus, errorThrown);
                         swal("서버와의 연결에 실패했습니다.", {
                             icon: "error"
                         });
                     }
                 });
             } else {
                 swal("오류", "선택된 항목이 없습니다.", {
                     icon: "error",
                 });
             }
         });

         $("#approveBtn").click(function () {
             var selectedData = []; // 선택된 데이터 배열
             const DefaultDept = 0; // 기본 부서 값
             const DefaultEmp = '00'; // 기본 직급 값
             let isValid = true; // 유효성 검사 변수 초기화

             // 체크된 모든 체크박스에 대해 반복
             $('.form-check-input:checked').each(function () {
                 var row = $(this).closest('tr'); // 체크박스가 포함된 행 선택
                 var memberId = $(this).attr('name'); // 체크박스의 name 속성 값
                 var rank = row.find('td:eq(2) select').val(); // 직급
                 var department = row.find('td:eq(3) select').val(); // 부서

                 // 기본값과 비교하여 유효성 검사
                 if (department == DefaultDept || rank == DefaultEmp) {
                     isValid = false; // 기본값과 일치하면 유효성 검사 실패
                     return false; // 반복문 종료
                 }

                 // 선택된 데이터 배열에 추가
                 selectedData.push({
                     department_id: department,
                     employee_rank: rank,
                     member_id: memberId
                 });
             });

             // 유효성 검사 통과 시 AJAX 요청
             if (isValid) {
                 if (selectedData.length > 0) {
                     $.ajax({
                         url: "/admin/signReq",
                         type: "POST",
                         data: JSON.stringify(selectedData), // 선택된 데이터 배열을 JSON 문자열로 변환
                         contentType: "application/json",
                         dataType: "json",
                         success: function (response) {
                             if (response.result) {
                                 swal("회원 정보가 수정되었습니다.", {
                                     icon: "success",
                                 }).then(() => {
                                     location.reload(); // 페이지 새로 고침
                                 });
                             } else {
                                 swal("수정 중 오류가 발생했습니다.", {
                                     icon: "error"
                                 });
                             }
                         },
                         error: function (jqXHR, textStatus, errorThrown) {
                             console.error("AJAX 요청 실패:", textStatus, errorThrown);
                             swal("서버와의 연결에 실패했습니다.", {
                                 icon: "error"
                             });
                         }
                     });
                 } else {
                     swal("오류", "선택된 항목이 없습니다.", {
                         icon: "error",
                     });
                 }
             } else {
                 swal("경고", "변경하지 않은 값이 있습니다.", {
                     icon: "warning",
                 });
             }
         });

         // 직급 또는 부서 선택 변경 시 유효성 검사 업데이트
         $('select').change(function () {
             var row = $(this).closest('tr'); // 변경된 셀의 행 선택
             var rank = row.find('td:eq(2) select').val(); // 직급
             var department = row.find('td:eq(3) select').val(); // 부서
             
             // 기본값과 비교하여 유효성 검사 업데이트
             if (department != DefaultDept && rank != DefaultEmp) {
                 isValid = true; // 값이 기본값이 아니면 isValid를 true로 설정
             }
         });

         $(document).click(function () {
             $(".btn-group").fadeOut(200);
         });

         $(".closeBtn, .close").on("click", function () {
             $("#detailsModal").css("display", "none");
         });
     });
</script>

</body>
</html>
