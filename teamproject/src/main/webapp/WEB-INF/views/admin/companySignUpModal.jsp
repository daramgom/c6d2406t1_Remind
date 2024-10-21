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
@import
	url("https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css")
	;

* {
	font-family: "NanumSquare", sans-serif;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

#company-modal-overlay {
	display: none; 
	width: 100%;
	background-color: rgba(1, 1, 1, 0.4); /* 검정색 배경에 50% 투명도 */
	height: 101%;
	position: fixed;
	top: 0;
	left: 0;
	z-index: 9980;
}

.modal-container {
	background: #fff;
	width: 36rem;
	height: 45rem;
	margin: 8rem auto;
	padding: 2rem 1.5rem;
	border: 1px solid darkgray;
	border-radius: 1.4rem;
	/* box-sizing: border-box; */
}

.company-modal-title {
	text-align: center;
	font-size: 1.77rem;
	font-weight: 600;
	margin-bottom: 1.87rem;
}

.input-wrapper {
	height: 54px;
	width: 100%;
	position: relative;
	margin-bottom: 1.8rem;
}

.input-wrapper .input-label {
	font-weight: 600;
	font-size: 1rem;
	display: block;
	margin: 0.5rem 0 0.5rem 0;
}

.input-wrapper .input-field {
	height: 80%;
	width: 100%;
	padding: 0 1.25rem 0 1.25rem;
	border: 1px solid #bfb3f2;
	border-radius: 0.31rem;
	outline: none;
	font-size: 1.06rem;
	transition: 0.2s ease;
}

.input-wrapper .input-field:focus {
	border-radius: #5f41e4;
}

.input-wrapper .input-field::placeholder {
	color: #a386e0;
}

#userid::placeholder {
	font-size: 0.88rem; /* 폰트 크기 조정 */
}

.input-wrapper i {
	color: #a395e0;
	position: absolute;
	top: 50%;
	left: 0.9rem;
	transform: translateY(-50%);
	pointer-events: none;
	transition: 0.2s ease;
}

.input-wrapper .input-field:focus ~ i {
	color: #5f41e4;
}

.forgot-pass-link {
	display: block;
	width: fit-content;
	margin-top: -0.44rem;
}

.signup-button {
	width: 100%;
	height: 54px;
	cursor: pointer;
	outline: none;
	color: #fff;
	border: none;
	font-weight: 500;
	font-size: 1.125rem;
	background: #5f41e4;
	margin-top: 2.19rem;
	border-radius: 0.31rem;
	transition: 0.2s ease;
}

.signup-button:hover {
	background: #4320df;
}

.signup-button:disabled {
	cursor: not-allowed;
	background: #d3d3d3;
}

.send-user-button {
	position: absolute;
	top: 2.4rem;
	right: 0.4rem;
	width: 100px;
	height: 32px;
	cursor: pointer;
	outline: none;
	color: #fff;
	border: none;
	background: #5f41e4;
	border-radius: 0.31rem;
	line-height: 16px;
}

.send-user-button:disabled {
	cursor: not-allowed;
	background: #d3d3d3;
}
</style>

<!-- Fonts and icons -->
<script src="/resources/js/plugin/webfont/webfont.min.js"></script>

<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/adminMemberList.css" />
</head>
<body>
	<%--
    <c:if
      test="${sessionScope.id == null || sessionScope.permission_id != '03'}"
    >
      <c:redirect url="/index" />
    </c:if>
    --%>
	<div id="company-modal-overlay">
		<div class="modal-container">
			<div class="company-modal-title">
				<header>거래처 회원가입</header>
				<%-- ${companyList} --%>
			</div>
			<div class="input-wrapper">
				<label for="username" class="input-label">아이디</label> <input
					type="text" id="userid"
					placeholder="영문자와 숫자를 포함하여 5자 이상 10자 이하로 입력해주세요."
					class="input-field" required name="member_id" maxlength="10" />
				<button type="button" id="userIdBtn" class="send-user-button"
					disabled>중복 조회</button>
			</div>
			
			<input type="hidden" id="companyCode" >
			

			<div class="input-wrapper">
				<label for="password" class="input-label">비밀번호</label> <input
					type="password" id="password" placeholder="Password"
					class="input-field" required name="member_pw" />
			</div>

			<div class="input-wrapper">
				<label for="name" class="input-label">이름</label> <input type="text"
					id="name" placeholder="홍길동" class="input-field" required
					name="member_name" />
			</div>

			<div class="input-wrapper">
				<label for="email" class="input-label">이메일</label> <input
					type="email" id="email" placeholder="itwill@itwillbs.com"
					class="input-field" name="member_email" required
					/>
					<button type="button" id="userEmailBtn" class="send-user-button"
					disabled>중복 조회</button>
			</div>
			<div class="input-wrapper">
				<label for="phone" class="input-label">전화번호</label> <input
					type="tel" id="phone" placeholder="010-1234-5678"
					class="input-field" required name="member_tel"
					 />
			</div>
			<button class="signup-button" id="signUp-btn" disabled>회원가입</button>
		</div>
	</div>


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
							<div class="card-header"
								style="display: flex; justify-content: space-between">
								<div class="card-title">목록</div>
							</div>

							<div class="card-body d-flex flex-column">
								<div class="row">
									<div class="col-md-12">
										<form action="">
											<table class="col-md-12 table">
												<tr>
													<th style="width: 1%"><input type="checkbox"
														id="selectAll" class="form-check-input" />
													</th>
													<th class="col-md-1">이름</th>
													<th class="col-md-1">직급</th>
													<th class="col-md-2">부서</th>
													<th class="col-md-2">이메일</th>
													<th class="col-md-2">전화번호</th>
													<th class="col-md-2">가입일자</th>
												</tr>
												<c:forEach var="List" items="${companyList}">
												
												<tr>
												<td>
													${List.company_name}
												</td>
												<td>
													${List.company_manager}
												</td>
												<td>
													${List.company_tel}
												</td>
												<td>
													${List.company_email}
												</td>
												<td>
													${List.company_address}
												</td>
												
												<td>
													<button class="SignShowModal"  data-code="${List.company_code}"
													style="width: 40px; height: 40px">+</button>

												</td>
												</tr>
												</c:forEach>
											</table>
										</form>

									</div>
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
    
 
    function isValidUserId(userid) {
        const useridPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,10}$/; // 영문자와 숫자가 모두 포함된 5자 이상 10자 이하
        return useridPattern.test(userid);
      }
      function isValidPassword(password) {
        const passwordPattern = /^(?=.*[A-Z])(?=.*[0-9]).{5,10}$/; // 최소 5자, 최대 10자, 대문자, 숫자 포함
        return passwordPattern.test(password);
      }
      
   // 이메일 형식 정규 표현식
      function isValidEmail(email) {
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailPattern.test(email);
      }
   


      

      /* // 입력 필드 변경 시 버튼 활성화 체크
      $(".input-field").on("input", function() {
          checkFormCompletion(); // 입력값이 변경될 때마다 체크
      }); */
  
      function showSuccessAlert(message, detail) {
        return new Promise((resolve) => {
          swal(message, detail, {
            icon: "success",
            buttons: {
              confirm: {
                className: "btn btn-success",
              },
            },
          }).then(() => {
            resolve(); // 알림창이 닫힐 때 resolve 호출
          });
        });
      }

      function showErrorAlert(message) {
        swal("오류 발생!", message, {
          icon: "error",
          buttons: {
            confirm: {
              className: "btn btn-danger",
            },
          },
        });
      }
 
 </script>
 
 <script >
 $(document).ready(function () {
	    let isUseridAvailable = false; // 아이디 중복 체크 결과
	    let isEmailAvailable = false; // 이메일 중복 체크 결과

     // 비밀번호 입력 시 비밀번호 확인 필드 활성화
     $("#password").on("input", function () {
         const userpw = $(this).val().trim();
         if(isValidPassword(userpw)) {
        	$(this).css("border-color","#bfb3f2");
         }
         else {
            $(this).css("border-color", "red"); // 유효하지 않은 경우 색상 변경
         }
         checkFormCompletion();  // 중복 검사 후 폼 체크
     });
	    
     $(".SignShowModal").click(function ( event) {
    	 event.preventDefault();	
         $("#company-modal-overlay").css("display", "block");
         let company_code = $(this).data("code");
         
         $.ajax({
        	 url: "companySignUpModal",
             type: "POST",
             contentType: "application/json",
             data: JSON.stringify({
                 company_code: company_code
             }),
             success: function (response) {
                 $("#name").val(response.company_name); // 이름 필드에 회사 이름 설정
                 $("#email").val(response.company_email); // 이메일 필드에 회사 이메일 설정
                 $("#phone").val(response.company_tel); // 전화번호 필드에 회사 전화번호 설정 (ID 수정)
                 $("#companyCode").val(response.company_code); // 전화번호 필드에 회사 전화번호 설정 (ID 수정)
              // 이메일 필드가 비어있지 않으면 버튼 활성화
                 if ($("#email").val().trim() !== "") {
                     $("#userEmailBtn").prop("disabled", false); // 버튼 활성화
                 }
            	 
             },
             error : function(xhr , status, error) {
            	 console.error("Error occurred : ",error);
             }
            
         });
     });
     
     // 아이디 길이에 따른 버튼 활성화
     $("#userid").on("input", function () {
         const userid = $(this).val().trim();
         if (isValidUserId(userid)) {
             $("#userIdBtn").prop("disabled", false);
             $(this).css("border-color", "#bfb3f2"); // 유효한 경우 색상 변경
         } else {
             $("#userIdBtn").prop("disabled", true);
             $(this).css("border-color", "red"); // 유효하지 않은 경우 색상 변경
         }
     });

     $("#userIdBtn").click(function () {
         var member_id = $("#userid").val();

         $.ajax({
             url: "checkUserId",
             type: "POST",
             contentType: "application/json",
             data: JSON.stringify({
                 member_id: member_id,
             }),
             success: function (response) {
                 if ("사용가능한 아이디 입니다!" == response.message) {
                     showSuccessAlert("요청성공!", response.message); // 사용가능한 아이디 입니다.
                     isUseridAvailable = true; // 상태 업데이트
                     $("#userIdBtn").prop("disabled", true);
                     $("#userid").prop("readonly", true);
                 } else {
                     showErrorAlert(response.message); // 중복된 아이디 입니다.
                     isUseridAvailable = false; // 상태 업데이트
                 }
                 checkFormCompletion();  // 중복 검사 후 폼 체크
             },
             error: function (xhr, status, error) {
                 // 오류 메시지 표시
                 showErrorAlert(xhr.responseJSON.message);
             },
         });
     });
     
     $("#userEmailBtn").click(function () {
         var member_email = $("#email").val().trim();

         $.ajax({
             url: "/admin/checkUserEamil",
             type: "POST",
             contentType: "application/json",
             data: JSON.stringify({
            	 member_email:  member_email,
             }),
             success: function (response) {
            	    if (response.result) {
            	        showSuccessAlert("요청성공!", response.message);
            	        isEmailAvailable = true; 
            	        $("#userEmailBtn").prop("disabled", true);
            	        $("#email").prop("readonly", true);
            	    } else {
            	        showErrorAlert(response.message);
            	        isEmailAvailable = false; 
            	    }
            	    checkFormCompletion(); 
            	},
            	error: function (xhr, status, error) {
            	    const errorMessage = xhr.responseJSON ? xhr.responseJSON.message : "알 수 없는 오류가 발생했습니다.";
            	    showErrorAlert(errorMessage);
            	}
         });
     });
     
     
     $("#phone").on("input", function () {
    	    // 입력된 전화번호에서 숫자만 추출
    	    let phoneNumber = $(this).val().replace(/[^0-9]/g, "");

    	    // 하이픈 추가
    	    if (phoneNumber.length < 4) {
    	        $(this).val(phoneNumber);
    	    } else if (phoneNumber.length < 7) {
    	        $(this).val(phoneNumber.replace(/(\d{3})(\d+)/, "$1-$2"));
    	    } else {
    	        $(this).val(phoneNumber.replace(/(\d{3})(\d{4})(\d+)/, "$1-$2-$3"));
    	    }
    	});
     // 모든 입력값이 채워졌는지 확인하는 함수
     function checkFormCompletion() {
         const userid = $("#userid").val().trim();
         const name = $("#name").val().trim();
         const password = $("#password").val().trim();
         const email = $("#email").val().trim();
         const phone = $("#phone").val().trim();
         const code = $("#companyCode").val().trim();
         
         console.log("userid:", userid);
         console.log("name:", name);
         console.log("password:", password);
         console.log("email:", email);
         console.log("phone:", phone);
         console.log("code:", code);
         console.log("isUseridAvailable:", isUseridAvailable);
         console.log("isUseridAvailable:", isUseridAvailable);


         // 모든 입력값이 비어있지 않고, 아이디 및 이메일 중복 검사를 통과한 경우에만 회원가입 버튼 활성화
         if (
             isValidUserId(userid) &&
             isUseridAvailable &&
             name &&
             password &&
             email &&
             code &&
             isEmailAvailable &&
             phone.replace(/-/g, "").length === 11 // 전화번호 길이 확인 (하이픈 제외)
         ) {
             $(".signup-button").prop("disabled", false); // 회원가입 버튼 활성화
         } else {
             $(".signup-button").prop("disabled", true); // 회원가입 버튼 비활성화
         }
     }
     
  // 회원가입 버튼 클릭 이벤트 리스너
     $("#signUp-btn").click(function () {
       // 기본 form 제출 방지
       event.preventDefault();

       // 모든 입력값 가져오기
         const userid = $("#userid").val().trim();
         const name = $("#name").val().trim();
         const password = $("#password").val().trim();
         const email = $("#email").val().trim();
         const phone = $("#phone").val().trim();
         const code = $("#companyCode").val().trim();

       // 회원가입 데이터 객체 생성
       const signupData = {
         member_id: userid,
         member_name: name,
         member_pw: password,
         member_email: email,
         member_tel: phone,
         member_code : code,
       };

       // AJAX 요청으로 회원가입 처리
       $.ajax({
         url: "/membersignup", // 서버의 회원가입 처리 URL
         type: "POST",
         contentType: "application/json",
         data: JSON.stringify(signupData),
         success: function (response) {
           // 성공적인 응답 처리
           if (response.message === "회원가입이 성공적으로 완료되었습니다!") {
             showSuccessAlert("회원가입 성공!", response.message).then(() => {
               window.location.href = "/login"; // 로그인 페이지로 이동
             });
           } else {
             showErrorAlert(response.message);
           }
         },
         error: function (xhr, status, error) {
           showErrorAlert(
             xhr.responseJSON.message ||
               "회원가입 중 문제가 발생했습니다. 다시 시도해 주세요."
           );
         },
       });
     });
     
 });
</script>

 

	
</body>
</html>
