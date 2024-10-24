$(document).ready(function () {
	let timer; // 타이머 변수 추가
	
	
	function isValidUsername(username) {
	    const usernamePattern = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{5,10}$/; // 영문자와 숫자가 모두 포함된 5자 이상 10자 이하
	    return usernamePattern.test(username);
	  }
	  // 이메일 형식 정규 표현식
	  function isValidEmail(email) {
	    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    return emailPattern.test(email);
	  }
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

/*	$("#next-btn").prop("disabled", false);
*/	
	// 아이디 길이에 따른 비밀번호 입력란 활성화
	$("#username").on("input", function () {
	    const userid = $(this).val().trim();
	    if (isValidUsername(userid)) {
	        $(this).css("border-color", "#bfb3f2"); // 유효한 경우 색상 변경
	        $("#EmailInput").css("display", "block"); // 비밀번호 입력란 보이기
	    } else {
	        $(this).css("border-color", "red"); // 유효하지 않은 경우 색상 변경
	        $("#EmailInput").css("display", "none"); // 비밀번호 입력란 숨기기
	    }
	});
	
	// 이메일 입력 필드의 input 이벤트 리스너
	  $("#email").on("input", function () {
	    const email = $(this).val().trim();

	    // 이메일 필드가 비어있으면 인증 코드 발송 버튼 비활성화
	    if (email === "") {
	      $("#requestCodeBtn").prop("disabled", true); // 이메일이 비어있으면 버튼 비활성화
	      $("#requestCodeBtn").text("인증 코드 발송"); // 버튼 텍스트 초기화
	      $("#requestCodeBtn").css("cursor", "pointer"); // 커서 스타일 변경
	      clearInterval(timer); // 타이머 정리
	      return; // 함수 종료
	    }

	    // 이메일 형식 검증
	    if (isValidEmail(email)) {
	      $("#requestCodeBtn").prop("disabled", false); // 이메일 형식이 올바르면 인증 코드 발송 버튼 활성화
	      $(this).css("border-color", "#bfb3f2"); // 유효한 경우 색상 변경
	    } else {
	      $("#requestCodeBtn").prop("disabled", true); // 이메일 형식이 올바르지 않으면 비활성화
	      $(this).css("border-color", "red"); // 유효하지 않은 경우 색상 변경
	    }

	    // 이메일이 비어있지 않은 경우 버튼 상태 업데이트
	    $("#requestCodeBtn").text("인증 코드 발송"); // 버튼 텍스트 초기화
	    $("#requestCodeBtn").css("cursor", "pointer"); // 커서 스타일 변경
	    clearInterval(timer); // 타이머 정리
	    $("#code").val("").prop("disabled", true); // 인증 코드 입력 필드 비활성화
	  });

	  // 페이지 로드 시 이메일 입력 필드의 값이 있는지 확인하여 버튼 상태 업데이트
	  const initialEmail = $("#email").val().trim();
	  if (isValidEmail(initialEmail)) {
	    $("#requestCodeBtn").prop("disabled", false);
	  } else {
	    $("#requestCodeBtn").prop("disabled", true);
	  }
	  
	  // 인증 코드 요청 함수
	  $("#requestCodeBtn").click(function () {
	    var email = $("#email").val();
	    const userid = $("#username").val().trim();

	    // 로딩 스피너 표시
	    $("#spinnerContainer").show(); // 여기서 스피너를 보여줍니다.

	    $.ajax({
	      url: "/findMemberInfo",
	      type: "POST",
	      contentType: "application/json",
	      data: JSON.stringify({ 
	    	  member_email: email,
	    	  member_id : userid
	    	  
	      }),
	      success: function (response) {
	    	  /// 수정해야됨
	        if (response.result == "true") {
	          showSuccessAlert(
	            "요청성공!",
	            response.message
	          );
	          clearInterval(timer);
	          startTimer(300); // 5분 타이머 시작

	          $("#requestCodeBtn").prop("disabled", true);
	          $("#code").prop("disabled", false);
	        } else {
	          showErrorAlert(
	        		  response.message
	          );
	        }
	      },
	      error: function (xhr, status, error) {
	        showErrorAlert("입력하신 이메일을 확인후 다시 시도해 주세요." + error);
	      },
	      complete: function () {
	        // 로딩 스피너 숨기기
	        $("#spinnerContainer").hide(); // 여기서 스피너를 숨깁니다.
	      },
	    });
	  });
	  
	  
	  // 타이머 시작 함수
	  function startTimer(duration) {
	    let timerDuration = duration,
	      minutes,
	      seconds;
	    $("#requestCodeBtn").prop("disabled", true).css("cursor", "default"); // 버튼 비활성화 및 커서 스타일 변경

	    timer = setInterval(function () {
	      minutes = parseInt(timerDuration / 60, 10);
	      seconds = parseInt(timerDuration % 60, 10);
	      minutes = minutes < 10 ? "0" + minutes : minutes;
	      seconds = seconds < 10 ? "0" + seconds : seconds;

	      $("#requestCodeBtn").text(minutes + ":" + seconds); // 버튼 텍스트 업데이트

	      if (--timerDuration < 0) {
	        clearInterval(timer);
	        $("#requestCodeBtn")
	          .prop("disabled", false)
	          .css("cursor", "pointer")
	          .text("인증 코드 발송"); // 버튼 활성화
	      }
	    }, 1000);
	  }



	  
	  
	  
	  
	  
	  
	  
	  

 
});
