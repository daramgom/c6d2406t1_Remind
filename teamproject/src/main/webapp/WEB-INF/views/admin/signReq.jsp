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


</style>

<!-- Fonts and icons -->
<script src="/resources/js/plugin/webfont/webfont.min.js"></script>
<script>
      WebFont.load({
        google: {
          families: ["Public Sans:300,400,500,600,700"],
        },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["/resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/adminMemberList.css" />
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
					<h3 class="fw-bold mb-3">회원 가입 신청 목록</h3>
					<ul class="breadcrumbs mb-3">
						<li class="nav-home"><a href="#"> <i class="icon-home"></i>
						</a></li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card w-100">
							<div class="card-header" style="display: flex; justify-content: space-between;">
								<div class="card-title"
									>목록</div>
								<c:if test="${ WaitingList != ''}">
									<div style="margin-right : 3rem;">
										<button style="margin-right: 1rem; padding: 0.7rem 2rem;  background: #5f41e4 ! IMPORTANT; border: none; "
											class="btn btn-success hover-btn" >승인</button>
										<button style="padding: 0.7rem 2rem;" class="btn btn-danger">삭제</button>
									</div>
								</c:if>
							</div>

							<div class="card-body d-flex flex-column">
								<div class="row">
									<div class="col-md-12">
										<table class="col-md-12 table">
											<tr>
												<th style="width: 1%"><input type="checkbox"
													class="form-check-input"></th>
												<th class="col-md-1">이름</th>
												<th class="col-md-1">직급</th>
												<th class="col-md-2">부서</th>
												<th class="col-md-2">이메일</th>
												<th class="col-md-2">전화번호</th>
												<th class="col-md-2">가입일자</th>
											</tr>

											<c:if test="${ WaitingList != ''}">
												<c:forEach items="${WaitingList}" var="member">
													<tr>
														<td><input class="form-check-input"
															name="${member.member_id}" id="selectUser"
															type="checkbox"></td>
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
									</div>
								</div>
								<c:if test="${WaitingList == ''}">
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
		<jsp:include page="/resources/inc/footer.jsp" />
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
      function memberInfo() {
        event.preventDefault();
        $.ajax({
          url: "/admin/getMemberInfo",
          type: "POST",
          data: JSON.stringify({ }),
          contentType: "application/json",
          dataType: "json",
          success: function (response) {
            console.log(response);
            $("#EmpRank").empty();
            $("#Department").empty();
            
            $("#memberName").text(response.member.member_name);
            $("#memberTel").text(response.member.member_tel);
            $("#memberEmail").text(response.member.member_email);
            // 기존 내용 삭제
            $.each(response.empRank, function (key, value) {
              var selected =
                response.member.employee_rank == value.common_value
                  ? "selected"
                  : ""; // 조건에 따라 selected 설정
              $("#memberRank").append(
                '<option value="' +value.common_value +'" ' +selected +">" +value.common_status +"</option>"  );});
          
            $("#memberDepartment").empty();
            $.each(response.department, function (key, value) {
              const selected =
                response.member.department_id == value.department_id
                  ? "selected"
                  : ""; // 조건에 따라 selected 설정
              $("#memberDepartment").append(
                '<option value="' +
                  value.department_id +
                  '" ' +
                  selected +
                  ">" +
                  value.department_name +
                  "</option>"
              );
            });

            $("#memberStatus").empty();
            $.each(response.memberState, function (key, value) {
              if (value.common_status == "퇴사") {
                DeleteCode = value.common_value;
                return;
              }
              const selected =
                response.member.member_state == value.common_value
                  ? "selected"
                  : ""; // 조건에 따라 selected 설정
              $("#memberStatus").append(
                '<option value="' +
                  value.common_value +
                  '" ' +
                  selected +
                  ">" +
                  value.common_status +
                  "</option>"
              );
            });

            $("#detailsModal").css("display", "block").hide().fadeIn(200);
          },
        });
      }

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
