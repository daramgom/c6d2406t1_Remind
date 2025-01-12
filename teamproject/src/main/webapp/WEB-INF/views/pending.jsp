<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>알림</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />
    <script src="./resources/js/core/jquery-3.7.1.min.js"></script>
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />
    <script type="text/javascript">
      let result = "${snsCode}";
      
      

      $(document).ready(function () {
    	  const showSweetAlert = (message, redirectUrl) => {
    	    Swal.fire({
    	      title: "알림",
    	      text: message,
    	      icon: "info",
    	      confirmButtonText: "확인",
    	    }).then((result) => {
    	      if (result.isConfirmed) {
    	        // 리디렉션 처리
    	        window.location.href = redirectUrl;
    	      }
    	    });
    	  };

    	  if (result == "REGISTRATION_PENDING") {
    	    showSweetAlert(
    	      "회원가입 승인 대기 중입니다.",
    	      "/login"
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
  
  
  </body>
</html>
