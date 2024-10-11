<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>회원가입</title>
<link rel="stylesheet" href="./resources/css/signup.css">
<script src="./resources/js/core/jquery-3.7.1.min.js"></script>
<script src="./resources/js/signUp.js"></script>

</head>
<body>
<div id="spinnerContainer" class="spinner-container" style="display: none;">
    <div id="loadingSpinner" class="spinner"></div>
</div>
	<div class="signup-container">
		<h2 class="form-title">회원가입</h2>

		<p class="separator"></p>
		<form id="signupForm" action="membersignup" class="signup-form" method="post">
			<div class="input-wrapper">
				<label for="username" class="input-label">아이디</label> <input
					type="text" id="username" placeholder="영문자와 숫자를 포함하여 5자 이상 10자 이하로 입력해주세요." class="input-field"
					required name="member_id" />
						<button type="button" id="userIdBtn"
					class="send-userId-button" disabled >중복 조회</button>
			</div>
			<div class="input-wrapper">
				<label for="name" class="input-label">이름</label> <input type="text"
					id="name" placeholder="홍길동" class="input-field" required
					name="member_name" value="${member.name}" />
			</div>
			<div class="input-wrapper">
				<label for="password" class="input-label">비밀번호</label> <input
					type="password" id="password" placeholder="Password"
					class="input-field" required name="member_pw" />
			</div>
			<div class="input-wrapper">
				<label for="confirm-password" class="input-label">비밀번호 확인</label> <input
					type="password" id="confirm-password" placeholder="Password"
					class="input-field" required disabled /> <span
					id="password-message" class="password-message"></span>
				<!-- 메시지를 표시할 span 추가 -->
			</div>
			<div class="input-wrapper">
				<label for="email" class="input-label">이메일</label> 
				<input
					type="email" id="email" placeholder="itwill@itwillbs.com"
					class="input-field"  name="member_email" required value="${member.email}" />
				<button type="button" id="requestCodeBtn"
					class="send-verification-button" disabled>인증 코드 발송</button>
			</div>
			<div class="input-wrapper">
				<label for="auth-code" class="input-label">인증 코드</label> <input
					type="text" id="code" placeholder="!@#$%^&" class="input-field"
					required disabled />
				<button type="button" id="verifyCodeBtn"
					class="send-verification-button auth" disabled>코드 인증</button>
			</div>
			<div class="input-wrapper">
				<label for="phone" class="input-label">전화번호</label> <input
					type="tel" id="phone" placeholder="010-1234-5678"
					class="input-field" required name="member_tel" value="${member.tel}" />
			</div>
			<button class="signup-button" id="signUp-btn" disabled>회원가입</button>
		</form>
		

		<p class="signup-text">
			회원이신가요? <a href="/login">로그인</a>
		</p>
	</div>
	


    <!-- Sweet Alert -->
    <script src="./resources/js/plugin/sweetalert/sweetalert.min.js"></script>
  
</body>
</html>
