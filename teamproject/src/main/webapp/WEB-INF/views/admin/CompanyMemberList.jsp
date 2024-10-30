<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>REMIND</title>

<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />
<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />

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

.edit-permission {
	
	border: none;
	background: transparent;
	width: 31px;
	font-size: 14px;
	position: relative;
}
.submit-Permission-btn {
	display: none;
	background: #6861ce;
	position: relative;
	padding: .35rem 1.4rem;
	border: #31ce36;
	font-size: 1rem;
	font-weight: 500;
	opacity: 1;
	border-radius: 3px;
	color: white;
} 

 .userPermission {
	position: relative;
    width: 70px;
    height: 30px;
}



.submit-Permission-btn:hover, .submit-Permission-btn:focus {
	opacity: .8;
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


<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/adminMemberList.css" />
</head>
<body>
	<c:if
		test="${sessionScope.id == null || sessionScope.permission_id != '03' || sessionScope.member_code != '1'}">
		<c:redirect url="/main" />
	</c:if>
	
	<div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />

		<!-- Main Content -->
		<div class="container">
			<div class="page-inner">
				<div class="page-header">
					<h3 class="fw-bold mb-3">거래처 회원목록</h3>
					<ul class="breadcrumbs mb-3">
						<li class="nav-home"><a href="/main"> <i class="icon-home"></i>
						</a></li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card w-100">
							<div class="card-header" style="display: flex; justify-content: space-between;align-items: center;">
								<div class="card-title">회원목록</div>
								<form action="/admin/CompanyMemberList" method="get"  id="searchForm">
								    <input type="text" name="keyword" class="form-control form-control-sm" placeholder="이름 검색">
								</form>
							</div>

							<div class="card-body d-flex flex-column">
								<div class="row">
									<div class="col-md-12">
										<table class="col-md-12 table">
											<tr style="height: 30px;">
												<th class="col-md-2">거래처</th>
												<th class="col-md-1">실무자</th>
												<th class="col-md-2">전화번호</th>
												<th class="col-md-2">주소</th>
												<th class="col-md-2">이메일</th>
												<th class="col-md-2">가입일자</th>
												<th class="col-md-1"></th>
											</tr>
											<c:forEach items="${memberList}" var="member">
												<tr style="position: relative;height: 63.9px; ">
													<td>${member.member_name}</td>
													<td>${member.company_manager}</td>
													<td>${member.member_tel}</td>
													<td>${member.company_address}</td>
													<td>${member.member_email}</td>
													<td>${member.create_date}</td>
													<td>
														<div class="nav-toggle">
															<button id="infoBtn" class="topbar-toggler more"
																style="border: none; background: none">
																<i class="gg-more-vertical-alt"></i>
															</button>
															<div class="btn-group dropstart" style="display: none">
																<ul class="dropdown-menu show" role="menu">
																	<li>
																		<a
																		data-member-id="${member.member_id}"
																		class="dropdown-item deleteButton" >삭제</a></li>
																</ul>
															</div>
														</div>
													</td>
												</tr>
											</c:forEach>
										</table>
									</div>
									<!-- 페이지 네비게이션 -->
								</div>
								<div style="display: flex; margin-right: 12px; justify-content: end;">
								    <!-- 페이지 네비게이션 -->
								    <c:if test="${pageCount >= 1}">
										    <div class="pagination">
										        <!-- 이전 페이지 링크 -->
										        <c:if test="${currentPage >= 1}">
										            <a href="?page=${currentPage - 1}" style="padding: 0 10px; color:black; font-size : 18px;     border-color: #ddd; background-color: var(--bs-pagination-disabled-bg);     border-radius: 100px;">Previous</a>
										        </c:if> 
										
										       					<c:forEach var="i" begin="1" end="${(currentPage + 2) > pageCount ? pageCount : (currentPage + 2)}">
										    <c:if test="${i >= (currentPage - 2) && i > 0}">
										        <a href="?page=${i}&keyword=${keyword}" style="padding: 0 10px; color:black; font-size: 20px;">
										            <span class="${currentPage == i ? 'currentpage' : ''}">${i}</span>
										        </a>
										    </c:if>
										</c:forEach>
										
										        <c:if test="${currentPage < pageCount}">
										    <a href="?page=${currentPage + 1}&keyword=${keyword}" style="padding: 0 10px; color:black; font-size: 18px; border-color: #ddd; background-color: var(--bs-pagination-disabled-bg); border-radius: 100px;">Next</a>
										</c:if>
										    </div>
										</c:if>
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
	<script>
  
    

      

     
      
      

	function showConfirmationAlert(message) {
	    return new Promise((resolve, reject) => {
	        swal({
	            title: "삭제하시겠습니까?",
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
	        }).then((willDelete) => {
	            if (willDelete) {
	                resolve(); // 확인 버튼 클릭 시 resolve 호출
	            } else {
	                reject(); // 취소 버튼 클릭 시 reject 호출
	            }
	        }).catch((error) => {
	            console.error("SweetAlert 오류:", error);
	            reject(); // 오류 발생 시 reject 호출
	        });
	    });
	}


    </script>

	<script>
      $(document).ready(function () {
    	  // 상세 보기
        $(".topbar-toggler").click(function (event) {
          event.stopPropagation();
          $(".btn-group").not($(this).next()).fadeOut(200);
          $(this).next().fadeToggle(200);
        });
        $(document).click(function () {
          $(".btn-group").fadeOut(200);
        });

       
		// 거래처 회원 정보 삭제. 실제로 삭제됨
		// 컨트롤러 만들.
        $(".deleteButton").click(function () {
            var memberId = $(this).data("member-id");

          // 삭제 확인 알림 표시
          showConfirmationAlert("회원 정보를 삭제하시겠습니까?")
            .then(() => {
              const data = {
                member_id: memberId
              };
              $.ajax({
                url: "/admin/deleteCompanyMember",
                type: "POST",
                dataType: "json",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function (response) {
                  if (response.result == "true") {
                    swal("회원 정보가 삭제되었습니다.", {
                      icon: "success",
                    }).then(() => {
                      // 퇴사 시 select 버튼 숨기기
                      location.reload(); // 페이지 새로고침
                    });
                  } else {
                    swal("삭제 중 오류가 발생했습니다.", { icon: "error" });
                  }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                  console.error("AJAX 오류:", textStatus, errorThrown);
                  swal("서버와의 통신 중 오류가 발생했습니다.", {
                    icon: "error",
                  });
                },
              });
            })
            .catch(() => {
              console.error("삭제가 취소되었습니다.");
            });
        });

		



        $('input[name="keyword"]').on('keypress', function(event) {
            if (event.which === 13) { // Enter 키 코드
                event.preventDefault(); // 기본 동작 방지
                $('#searchForm').submit(); // 폼 제출
            }
        });
      });
    </script>
</body>
</html>
