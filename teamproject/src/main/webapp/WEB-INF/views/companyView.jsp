<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>REMIND</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />
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
	display: none;
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
	position: relative;
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

.close-btn {

    cursor: pointer;
    color: #001f3f;
    font-size: 24px;
    margin-bottom: 20px;
    position: absolute;
    top: 0px;
    right: 16px;
}

.swal-footer{
	align-items: center;
    display: flex;
    justify-content: center;
}

.spinner-container {
	position: fixed; /* 화면 전체에 고정 */
	top: 0;
	left: 0;
	width: 100%; /* 전체 너비 */
	height: 100%; /* 전체 높이 */
	background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경색 */
	z-index: 9998; /* 스피너보다 아래에 표시 */
	display: flex; /* Flexbox 사용 */
	justify-content: center; /* 수평 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
}

.spinner {
	border: 8px solid rgba(0, 0, 0, 0.1); /* 배경색 */
	border-left-color: #3498db; /* 스피너 색상 */
	border-radius: 50%;
	width: 40px; /* 스피너 크기 */
	height: 40px; /* 스피너 크기 */
	animation: spin 1s linear infinite; /* 회전 애니메이션 */
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
</style>
</head>
<body>
	<c:if test="${empty sessionScope.id}">
	<c:redirect url="/login"/>
	</c:if>
	<div id="spinnerContainer" class="spinner-container" style="display: none">
      <div id="loadingSpinner" class="spinner"></div>
    </div>
	
	
	<div id="company-modal-overlay">
		<div class="modal-container">
			<div class="company-modal-title">
				<header>거래처 회원가입</header>
				<div class="close-btn">x</div>
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
					type="password" id="password"  placeholder="최소 5자 최대 10자, 1개의 대문자 및 1개의 숫자를 포함하세요."
					class="input-field" required name="member_pw" />
			</div>
			
			<div class="input-wrapper">
				<label for="name" class="input-label">이름</label> <input type="text"
					id="name" placeholder="홍길동" class="input-field" required
					name="member_name" readonly />
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
 					readonly
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
                    <h3 class="fw-bold mb-3">거래처 상세보기</h3>
                   <ul class="breadcrumbs mb-3">
						<li class="nav-home"><i class="icon-home"></i></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item">거래처관리</li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item">거래처 상세보기</li>
					</ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">${company.company_name}</h4>
                            </div>
                            <div class="card-body">
                                <p><strong>거래처 코드:</strong> ${company.company_code}</p>
                                <p><strong>실무자:</strong> ${company.company_manager}</p>
                                <p><strong>전화번호:</strong> ${company.company_tel}</p>
                                <p><strong>이메일:</strong> ${company.company_email}</p>
                                <p><strong>주소:</strong> ${company.company_address}</p>
                                <hr>	
                                <div class="d-flex justify-content-end">
                                    <!-- permission_id가 03일 때만 회원가입 버튼 표시 -->
                                    <c:if test="${sessionScope.permission_id == '03'}">
										<button id="SignShowModal"  data-code="${company.company_code}" class="btn btn-secondary" style="margin-right: 7px;">거래처 회원가입</button>
                                    </c:if>
                                    <!-- permission_id가 03일 때만 수정 버튼 표시 -->
                                    <c:if test="${sessionScope.permission_id == '03'}">
                                        <a href="${pageContext.request.contextPath}/company/edit/${company.company_code}" class="btn btn-warning me-2">수정</a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/company/companyList" class="btn btn-black me-2">목록으로 돌아가기</a>
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
                className: "btn btn-secondary",
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
	    $(".close-btn").click(function () {
	    	$(".modal-container").fadeOut(300); // 300ms 동안 서서히 나타남
	    	$("#company-modal-overlay").css("display" , "none");
	    	$("#company-modal-overlay2").css("display" , "none");
	    });
	    
	 // 모달 배경 클릭 시 모달 닫기
	    $("#company-modal-overlay").click(function (event) {
	        // 클릭한 대상이 모달 컨테이너가 아닐 때만 닫기
	        if (event.target === this) {
	            $(".modal-container").fadeOut(300); // 300ms 동안 서서히 나타남
	            $(this).css("display", "none"); // 모달 숨기기
	        }
	    });
	    $("#company-modal-overlay2").click(function (event) {
	        // 클릭한 대상이 모달 컨테이너가 아닐 때만 닫기
	        if (event.target === this) {
	            $(".modal-container").fadeOut(300); // 300ms 동안 서서히 나타남
	            $(this).css("display", "none"); // 모달 숨기기
	        }
	    });

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
	    
     $("#SignShowModal").click(function (event) {
    	 let company_code = $(this).data("code");
    	 
    	  $.ajax({
        	 url: "/admin/companyMemberCheck",
             type: "POST",
             contentType: "application/json",
             data: JSON.stringify({
                 company_code: company_code
             }),
             success: function (response) {
            	 if(response.result == "true") {
            		 showSuccessAlert("요청성공!", response.message).then(() => {
                         $("#company-modal-overlay").css("display", "block");
                         $(".modal-container").fadeIn(300); // 300ms 동안 서서히 나타남
                         getCompanyInfo(company_code);
                     });
            	 }
            	 else {
            		 // 다른 모달창 open
            		// 이미 회원가입한 거래처에 대한 메시지
                     swal({
                         title: "이미 회원가입한 거래처입니다.",
                         text: "아이디 및 비밀번호를 이메일로 전송하시겠습니까?",
                         icon: "info",
                         buttons: {
                             confirm: {
                                 text: "예",
                                 value: true,
                                 className: "btn btn-secondary"
                             },
                             cancel: "아니요"
                         },
                     }).then((willConfirm) => {
                         if (willConfirm) {
                        	 sendEmail(company_code);
                         }
                         
                     });
            	 }
             },
             error : function(xhr , status, error) {
            	 console.error("Error occurred : ",error);
             }
            
         }); 
        
     });
     
     function sendEmail(company_code) {
    	// 로딩 스피너 표시
    	 $("#spinnerContainer").show(); // 여기서 스피너를 보여줍니다.
    	 $.ajax({
        	 url: "/admin/sendEmail",
             type: "POST",
             contentType: "application/json",
             data: JSON.stringify({
                 company_code: company_code
             }),
             success: function (response) {
            	 if(response.result == "true" ) {
            		 showSuccessAlert("요청 성공!", "비밀번호 재설정 이메일이 전송되었습니다.").then(() => {
                     });
            	 }
            	 else {
            		// 이메일 전송 실패
                     showErrorAlert("오류 발생!", response.message).then(() => {
                         // 추가 작업 (예: 사용자에게 재입력 요청)
                     });
            	 }
             },
             error : function(xhr , status, error) {
            	 console.error("Error occurred : ",error);
             },
             complete: function () {
                 // 로딩 스피너 숨기기
                 $("#spinnerContainer").hide(); // 여기서 스피너를 숨깁니다.
                 $("#SignShowModal").prop("disabled", true).css("cursor", "default"); // 버튼 활성화
               },
         }); 
     }
     
     function getCompanyInfo(company_code) {
    	 
         $.ajax({
        	 url: "/admin/companySignUpModal",
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
     }
     
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
             url: "/admin/checkUserId",
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
            	 
            	 
            	    if (response.result == "true") {
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
    	    checkFormCompletion()
    	});
     
     
     // 모든 입력값이 채워졌는지 확인하는 함수
     function checkFormCompletion() {
         const userid = $("#userid").val().trim();
         const name = $("#name").val().trim();
         const password = $("#password").val().trim();
         const email = $("#email").val().trim();
         const phone = $("#phone").val().trim();
         const code = $("#companyCode").val().trim();
         


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
         url: "/admin/companyMemberSignUp", // 서버의 회원가입 처리 URL
         type: "POST",
         contentType: "application/json",
         data: JSON.stringify(signupData),
         success: function (response) {
           // 성공적인 응답 처리
           if (response.message === "회원가입이 성공적으로 완료되었습니다!") {
             showSuccessAlert("회원가입 성공!", response.message).then(() => {
            	 location.reload();
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
