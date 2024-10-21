<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>알림</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="./resources/js/core/jquery-3.7.1.min.js"></script>

    <script type="text/javascript">
      let result = "${isFirstVisit}";
      
      

      $(document).ready(function () {
        const showSweetAlert = (message, redirectUrl) => {
          Swal.fire({
            title: "알림",
            text: message,
            icon: "info",
            confirmButtonText: "확인",
          }).then((result) => {
            if (result.isConfirmed) {
              // 폼 제출
              $("#signupForm").submit();
            }
          });
        };

        if (result == "SNS") {
          showSweetAlert(
            "등록된 회원정보가 없습니다. 회원가입 페이지로 이동합니다.",
            "/signup"
          );
        } else {
          showSweetAlert(
            "잘못된 접근입니다. 로그인 페이지로 이동합니다.",
            "/login"
          );
        }
      });
    </script>
  </head>
  <body>
    <form id="signupForm" action="/signup" method="post">
      <input type="hidden" name="tel" value="${userInfo.tel}" />
      <input type="hidden" name="email" value="${userInfo.email}" />
      <input type="hidden" name="name" value="${userInfo.name}" />
    </form>
  </body>
</html>
