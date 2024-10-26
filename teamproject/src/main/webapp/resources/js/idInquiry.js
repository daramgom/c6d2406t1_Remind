$(document).ready(function () {
	let timer; // 타이머 변수 추가
	
	 function isValidKoreanName(name) {
		    const namePattern = /^[가-힣]{2,10}$/; // 한글만, 2자 이상 10자 이하
		    return namePattern.test(name);
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
	  let timeout; // 타임아웃 변수

	  $("#name").on("input", function () {
	      clearTimeout(timeout); // 이전 타임아웃을 클리어

	      const name = $(this).val().trim();

	      timeout = setTimeout(function() {
	          // 이름이 2글자 이상일 때
	          if (name.length >= 2) {
	              if (isValidKoreanName(name)) {
	                  $("#name").css("border-color", "#bfb3f2"); // 유효한 경우 색상 변경
	                  
	                  // 이메일 입력란 보이기
	                  if ($("#EmailInput").is(":hidden")) {
	                      $("#EmailInput").fadeIn(500); // 이메일 입력란 보이기
	                  }
	              } else {
	                  $("#name").css("border-color", "red"); // 유효하지 않은 경우 색상 변경
	              }
	          } else {
	              $("#name").css("border-color", "red"); // 2글자 미만일 경우 색상 변경
	          }

	          // 이름이 유효하지 않거나 2글자 미만인 경우 이메일 입력란 숨기기
	          if (name.length < 2 || !isValidKoreanName(name)) {
	              $("#EmailInput").fadeOut(500); // 이메일 입력란 숨기기
	          }
	      }, 300); // 300ms 후에 실행
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
	    // 로딩 스피너 표시
	    $("#spinnerContainer").show(); // 여기서 스피너를 보여줍니다.

	    $.ajax({
	      url: "/sendEmailCode",
	      type: "POST",
	      contentType: "application/json",
	      data: JSON.stringify({ 
	    	  member_email: email,
	    	  
	      }),
	      success: function (response) {
	    	 
	        if (response.result == "true") {
	          showSuccessAlert(
	            "요청성공!",
	            response.message
	          );
	          clearInterval(timer);
	          startTimer(300); // 5분 타이머 시작
	          $("#name").prop("readonly", true); // 이름 입력란을 읽기 전용으로 설정
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
		  var email = $("#email").val();
		  var name = $("#name").val().trim();

		    $.ajax({
		      url: "/idInquiry",
		      type: "POST",
		      contentType: "application/json",
		      data: JSON.stringify({
		        member_email: email,
		        member_name: name,
		      }),
		      success: function (response) {
		        if ("true" == response.result) {
		          $("#next-btn").css("display", "none");
		          
		          $("#EmailInput").css("display" , "none");
		          
		          $("#checkNameEmailInfo").css("display" , "none");
		          
		          $("#ResultId").css("display" , "block");
		          $("#title-h2").text("요청하신 회원님의 ID 입니다.");
		          $("#findId").val(response.id);
		        }
		        else {
		        	showErrorAlert(
		        			response.message
		        	);
		        }
		      },
		      error: function (xhr, status, error) {
		        // 오류 메시지 표시
		        showErrorAlert(xhr.responseJSON.message);
		      },
		    });
	    });
	  
	  function isValidPassword(password) {
		    const passwordPattern = /^(?=.*[A-Z])(?=.*[0-9]).{5,10}$/; // 최소 5자, 최대 10자, 대문자, 숫자 포함
		    return passwordPattern.test(password);
		  }
	  
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
