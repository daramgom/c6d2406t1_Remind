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
	// 아이디 길이에 따른 이메일 입력란 활성화
	$("#username").on("input", function () {
	    const userid = $(this).val().trim();
	    if (isValidUsername(userid)) {
	        $(this).css("border-color", "#bfb3f2"); // 유효한 경우 색상 변경
	        // 이메일 입력란 보이기
	        if ($("#EmailInput").css("display") === "none") { // display: none일 때만 나타나게 함
	            $("#EmailInput").css("display", "block").hide().fadeIn(500); // 비밀번호 입력란 보이기
	        }

	    } else {
	        $(this).css("border-color", "red"); // 유효하지 않은 경우 색상 변경
	        $("#EmailInput").fadeOut(500, function() {
	            $(this).css("display", "none"); // 비밀번호 입력란 숨기기
	        });
	        
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
	    	 
	        if (response.result == "true") {
	          showSuccessAlert(
	            "요청성공!",
	            response.message
	          );
	          clearInterval(timer);
	          startTimer(300); // 5분 타이머 시작

	          $("#requestCodeBtn").prop("disabled", true);
	          $("#code").prop("disabled", false);
	          // 인증 코드 입력란 보이기
              
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
	  // 인증 코드 입력 필드의 input 이벤트 리스너
	  $("#code").on("input", function () {
	    const code = $(this).val().trim();

	    // 인증 코드가 6자리가 되면 비활성화 해제
	    if (code.length === 6) {
	      $("#verifyCodeBtn").prop("disabled", false); //
	    } else {
	      $("#verifyCodeBtn").prop("disabled", true); // 인증 코드 입력 필드 비활성화
	    }
	    
	  });
	  // 인증 코드 확인 함수
	  $("#verifyCodeBtn").click(function () {
	    var email = $("#email").val();
	    var code = $("#code").val();

	    $.ajax({
	      url: "/verifyCode",
	      type: "POST",
	      contentType: "application/json",
	      data: JSON.stringify({
	        email: email,
	        code: code,
	      }),
	      success: function (response) {
	        if ("인증이 완료되었습니다!" === response.message) {
	          showSuccessAlert("요청성공!", response.message);
	          $("#email").prop("readonly", true); // 이메일 필드 비활성화
	          $("#requestCodeBtn").prop("disabled", true); // 인증 코드 요청 버튼 비활성화
	          $("#code").prop("disabled", true); // 인증 코드 입력 필드 비활성화
	          $("#verifyCodeBtn").prop("disabled", true); // 인증 코드 확인 버튼 비활성화
	          $("#next-btn").prop("disabled", false);
	        }
	      },
	      error: function (xhr, status, error) {
	        // 오류 메시지 표시
	        showErrorAlert(xhr.responseJSON.message);
	      },
	    });
	  });
	  
	  $("#next-btn").click(function () {
	        $("#IdEmail").text("변경할 비밀번호를 입력하세요.");
	        $("#checkIdEmailInfo").css("display", "none");
	        $("#next-btn").css("display", "none");
	        
	        $("#changePassword").css("display", "block").hide().fadeIn(500);
	        $("#submit-btn").css("display", "block").hide().fadeIn(500);
	    });
	  
	  function isValidPassword(password) {
		    const passwordPattern = /^(?=.*[A-Z])(?=.*[0-9]).{5,10}$/; // 최소 5자, 최대 10자, 대문자, 숫자 포함
		    return passwordPattern.test(password);
		  }
	// 비밀번호 일치 여부 확인
	  function confirmPw() {
		  var password = $("#password").val();
		  var confirmPassword = $("#confirm-password").val();
		  
		  if (password !== confirmPassword) {
			  $("#submit-btn").prop("disabled", true);
			  
		    } else {
		      $("#submit-btn").prop("disabled", false);
		    }
	  }
	  
	  $("#confirm-password").on("input", function () {
	    var password = $("#password").val();
	    var confirmPassword = $(this).val();
	    var message = $("#password-message"); // 메시지를 표시할 span 선택

	    if (password !== confirmPassword) {
	      $(this).css("border-color", "red"); // 일치하지 않으면 빨간색 테두리
	      message.text("비밀번호가 일치하지 않습니다."); // 메시지 설정
	      message.css("color", "red"); // 메시지 색상 변경
	    } else {
	      $(this).css("border-color", "#bfb3f2"); // 일치하면 초록색 테두리
	      message.text("비밀번호가 일치합니다."); // 메시지 설정
	      message.css("color", "#bfb3f2"); // 메시지 색상 변경
	      $("#submit-btn").prop("disabled", false);
	    }
	    confirmPw();

	  });
	  $("#password").on("input", function () {
	      var password = $(this).val().trim();
	      
	      // 비밀번호 유효성 검사
	      if (isValidPassword(password)) {
	    	  $("#confirm-password").prop("disabled", false); // 비밀번호 입력 시 활성화
	          $("#password-message").text(""); // 메시지 초기화
	          $(this).css("border-color", "#bfb3f2"); // 유효한 경우 색상 변경
	          
	      } else {
	    	  $("#confirm-password").prop("disabled", true); // 비밀번호 입력 시 활성화
	          $("#password-message").text(
	              "비밀번호는 최소 5자 최대 10자, 1개의 대문자 및 1개의 숫자를 포함해야 합니다."
	          ); // 메시지 설정
	          $(this).css("border-color", "red"); // 유효하지 않은 경우 색상 변경
	          $("#submit-btn").prop("disabled", true);
	      }

	      // 조건 체크
	      $("#length-check").prop("checked", password.length >= 5 && password.length <= 10);
	      $("#uppercase-check").prop("checked", /[A-Z]/.test(password));
	      $("#number-check").prop("checked", /\d/.test(password));

	      // 정보 박스 표시
	      $(".info-box").css("display", "block");
	      confirmPw();
	      
	      
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

	  
	// 회원가입 버튼 클릭 이벤트 리스너
	  $("#submit-btn").click(function () {
	    // 기본 form 제출 방지
	    event.preventDefault();

	    // 모든 입력값 가져오기
	    const username = $("#username").val().trim();
	    const password = $("#password").val().trim();

	    // 회원가입 데이터 객체 생성
	    const changPwData = {
	      member_id: username,
	      member_pw: password,
	    };

	    // AJAX 요청으로 회원가입 처리
	    $.ajax({
	      url: "/pwInquiry", // 서버의 회원가입 처리 URL
	      type: "POST",
	      contentType: "application/json",
	      data: JSON.stringify(changPwData),
	      success: function (response) {
	        // 성공적인 응답 처리
	        if (response.result == "true") {
	          showSuccessAlert(response.message,"로그인 페이지로 이동합니다.").then(() => {
	            window.location.href = "/login"; // 로그인 페이지로 이동
	          });
	        } else {
	          showErrorAlert(response.message);
	        }
	      },
	      error: function (xhr, status, error) {
	        showErrorAlert(
	          xhr.responseJSON.message ||
	            "비밀번호 변경 중 문제가 발생했습니다. 다시 시도해 주세요."
	        );
	      },
	    });
	  });

	  
	  
	  
	  
	  
	  
	  
	  

 
});
