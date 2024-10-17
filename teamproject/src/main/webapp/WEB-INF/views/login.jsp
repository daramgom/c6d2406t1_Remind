<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>로그인</title>
    <link rel="stylesheet" href="./resources/css/login.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="./resources/js/core/jquery-3.7.1.min.js"></script>

    <script>
      $(document).ready(function () {
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

        function performLogin() {
          var member_id = $("#member_id").val();
          var member_pw = $("#member_pw").val();

          var data = {
            member_id: member_id,
            member_pw: member_pw,
          };

          $.ajax({
            url: "/login",
            type: "POST",
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: function (response) {
              console.log("서버 응답:", response); // 디버깅용

              switch (response.code) {
                case "SUCCESS":
                  showSuccessAlert("로그인 성공", response.message).then(() => {
                    location.href = "/admin"; // 관리자 페이지로 이동
                  });
                  break;
                case "NOT_REGISTERED":
                  showErrorAlert(response.message);
                  break;
                case "PENDING_APPROVAL":
                  showWarningAlert(response.message);
                  break;
                default:
                  showErrorAlert("알 수 없는 오류가 발생했습니다.");
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
      });
    </script>
  </head>
  <body>
  	<c:if test="${!empty sessionScope.id}">
  		<c:redirect url="/admin" />
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

        <button class="login-button" id="loginBtn">로그인</button>
      </form>

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
