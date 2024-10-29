<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>로그인</title>
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />
    <link rel="stylesheet" href="./resources/css/login.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="./resources/js/core/jquery-3.7.1.min.js"></script>

    <script>
      $(document).ready(function () {
    	// 페이지 로드 시 쿠키에서 아이디를 가져오기
          const savedUsername = getCookie("remind_username"); // /// 쿠키에서 아이디 가져오기
          if (savedUsername) {
              $("#member_id").val(savedUsername); // /// 입력 필드에 아이디 채우기
              $("#rememberMe").prop("checked", true); // /// 체크박스 체크
          }
        $("#loginBtn").click(function () {
          event.preventDefault(); // 기본 동작 방지 (폼 제출 등)
          performLogin();
        });

        // 입력 필드에서 엔터 키 입력 이벤트
        $("#member_id, #member_pw").keypress(function (event) {
          if (event.which === 13) {
            // 엔터 키의 키 코드
            event.preventDefault(); // 기본 동작 방지 (폼 제출 등)
            performLogin(); // 로그인 함수 호출
          }
        });
        function handleLoginSuccess(val) {
            localStorage.setItem('sessionCheckKey',val ); // 로그인 성공 시 세션 상태 업데이트
            window.location.href = '/main'; // 메인 페이지로 리디렉션
        }

        function performLogin() {
          var member_id = $("#member_id").val();
          var member_pw = $("#member_pw").val();

          var data = {
            member_id: member_id,
            member_pw: member_pw,
          };
       // 입력값 검증
          if (!member_id || !member_pw) {
              showErrorAlert("아이디와 비밀번호를 입력하세요.");
              return;
          }

          $.ajax({
            url: "/login",
            type: "POST",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
            	 // 로그인 성공 시 쿠키 저장
                if (response.code === "SUCCESS") { // /// 로그인 성공 확인
                    if ($("#rememberMe").is(":checked")) { // /// 체크박스 확인
                        setCookie("remind_username", member_id, 7); // /// 쿠키에 아이디 저장 (7일 동안)
                    } else {
                        deleteCookie("remind_username"); // /// 체크 해제 시 쿠키 삭제
                    }
                    
                    showSuccessAlert("로그인 성공", response.message).then(() => {
						localStorage.removeItem('colShow');
      					localStorage.removeItem('colActive');
      					localStorage.removeItem('alertShown');
      					localStorage.removeItem('alertShown2');
      					
      					alert(response.sessionCheckKey);
      					handleLoginSuccess(response.sessionCheckKey); // 로그인 성공 처리
                    });
                } else {
                	 // 로그인 실패 시 응답 처리
                    switch (response.code) {
                        case "NOT_REGISTERED":
                            showErrorAlert(response.message);
                            break;
                        case "INVALID_PASSWORD":
                            showWarningAlert(response.message);
                            break;
                        case "REGISTRATION_PENDING":
                            showWarningAlert(response.message);
                            break;
                        default:
                            showErrorAlert("알 수 없는 오류가 발생했습니다.");
                    }
                }
            },
            error: function (xhr, status, error) {
              console.error("AJAX 오류:", status, error);
              showErrorAlert("서버 오류: " + error);
            },
          });
        }
        function showSuccessAlert(title, message) {
          return Swal.fire({
            title: title,
            text: message,
            icon: "success",
          });
        }

        function showErrorAlert(message) {
          Swal.fire({
            title: "오류",
            text: message,
            icon: "error",
          });
        }

        function showWarningAlert(message) {
          Swal.fire({
            title: "주의",
            text: message,
            icon: "warning",
          });
        }
        // 쿠키 설정 함수 추가
        function setCookie(name, value, days) { // /// 쿠키 설정 함수
            let expires = "";
            if (days) {
                const date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
            
        }
        // 쿠키 삭제 함수
        function deleteCookie(name) { // /// 쿠키 삭제 함수
            document.cookie = name + '=; Max-Age=-99999999;';  
        }

        
     // 쿠키 가져오기 함수
        function getCookie(name) { // /// 쿠키 가져오기 함수
            const nameEQ = name + "=";
            const ca = document.cookie.split(';');
            for (let i = 0; i < ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) === ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }
      });
    </script>
  </head>
  <body>
  	<c:if test="${!empty sessionScope.id}">
  		<c:redirect url="/main" />
  	</c:if> 
  	
    <div class="login-container">
      <h2 class="form-title">로그인</h2>
      <div class="social-login">
        <button class="social-button" onclick=" location.href='${naver_url}'; ">
          <img src="./resources/img/btnG.png" alt="Naver" class="social-icon" />
        </button>
      </div>

      <p class="separator"><span>or</span></p>
      <form action="#" class="login-form">
        <div class="input-wrapper">
          <input
            type="text"
            placeholder="Id"
            class="input-field"
            required
            id="member_id"
            name="member_id"
          />
        </div>
        <div class="input-wrapper">
          <input
            type="password"
            placeholder="Password"
            class="input-field"
            required
            id="member_pw"
            name="member_pw"
          />
        </div>
        <div class="input-wrapper" style="margin: 0;
    height: 0;
    top: -16px;">
                <label>
                    <input type="checkbox" id="rememberMe"> 아이디 저장하기
                </label>
            </div>

        <button class="login-button" id="loginBtn">로그인</button>
      </form>

      <p class="signup-text">
      <a href="/idInquiry">아이디 찾기</a> | <a href="/pwInquiry">비밀번호 찾기</a>
      </p>
      <p class="signup-text">
        회원이 아니신가요? <a href="/signup">회원가입</a>
      </p>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>

    <!-- Sweet Alert -->
    <script src="./resources/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="./resources/js/kaiadmin.min.js"></script>

    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="./resources/js/setting-demo2.js"></script>
  </body>
</html>
