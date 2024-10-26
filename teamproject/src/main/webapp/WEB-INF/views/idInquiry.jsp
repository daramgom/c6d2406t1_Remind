<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>아이디 찾기</title>
<link rel="stylesheet" href="./resources/css/idInquiry.css" />
<script src="./resources/js/core/jquery-3.7.1.min.js"></script>
<script src="./resources/js/idInquiry.js"></script>



</head>


<body>
	<c:if test="${!empty sessionScope.id}">
		<c:redirect url="/main" />
	</c:if>
	<div id="spinnerContainer" class="spinner-container"
		style="display: none">
		<div id="loadingSpinner" class="spinner"></div>
	</div>
	<div class="signup-container">
		<h2 class="form-title" id="title-h2">찾으려는 ID를 입력해 주세요.</h2>

		<p class="separator"></p>

		<form id="signupForm" action="membersignup" class="signup-form"
			method="post">
			<div id="checkIdEmailInfo"  >
				<div class="input-wrapper" id="usernameInput">
					<label for="username" class="input-label">아이디</label> <input
						type="text" id="username"
						placeholder="영문자와 숫자가 모두 포함된 5자 이상 10자 이하" class="input-field"
						required name="member_id" />
				</div>
				<!-- 메시지를 표시할 span 추가 -->

				<div id="EmailInput">
					<div class="input-wrapper">
						<label for="email" class="input-label">이메일</label> <input
							type="email" id="email" placeholder="itwill@itwillbs.com"
							class="input-field" name="member_email" required
							value="${member.email}" />
						<button type="button" id="requestCodeBtn"
							class="send-verification-button" disabled>인증 코드 발송</button>
					</div>
					<div class="input-wrapper" id="CodeInput">
						<label for="auth-code" class="input-label">인증 코드</label> <input
							type="text" id="code" placeholder="!@#$%^&" class="input-field"
							required disabled />
						<button type="button" id="verifyCodeBtn"
							class="send-verification-button auth" disabled>코드 인증</button>
					</div>
				</div>
			</div>

			<div id="ResultId" style="display: none">
				<div class="input-wrapper">
					<label for="username" class="input-label">아이디</label> <input
						type="text" id="findId"
						placeholder="영문자와 숫자가 모두 포함된 5자 이상 10자 이하" class="input-field"
						required name="member_id" readonly />
				</div>
			</div>

		</form>
		<button class="signup-button" id="next-btn" disabled>다음</button>

	</div>

	<!-- Sweet Alert -->
	<script src="./resources/js/plugin/sweetalert/sweetalert.min.js"></script>
</body>
</html>
