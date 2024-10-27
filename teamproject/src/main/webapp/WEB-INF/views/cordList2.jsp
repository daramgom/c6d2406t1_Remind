<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>아이티윌 팀프로젝트</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="./resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<!-- Fonts and icons -->
<script src="./resources/js/plugin/webfont/webfont.min.js"></script>
<script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["./resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

<!-- <script>
        function fetchOrderDate() {
            const ordNumber = document.getElementById('ord_number').value;
            if (ordNumber) {
                fetch('/getOrderDate?ord_number=' + ordNumber)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('ord_date').value = data.ord_date || '';
                    })
                    .catch(error => console.error('Error:', error));
            } else {
                document.getElementById('ord_date').value = ''; // 입력이 없을 경우 초기화
            }
        }
    </script> -->


<!-- 모달 -->
<style>
.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 60%; /* 너비 조정 */
	max-width: 500px; /* 최대 너비 설정 */
	border-radius: 8px; /* 모서리 둥글게 */
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5); /* 배경 색상 조정 */
}

.close {
	color: #aaa;
	float: right;
	font-size: 24px; /* 크기 조정 */
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000; /* 호버 시 색상 변경 */
	text-decoration: none;
	cursor: pointer;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
</style>

<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

/* 슬라이드 스타일 */
.slide-container {
	position: fixed;
	top: 0;
	right: -400px; /* 초기 위치는 화면 밖 */
	width: 400px;
	height: 100%;
	background: white;
	box-shadow: -2px 0 10px rgba(0, 0, 0, 0.5);
	transition: right 0.3s ease;
	z-index: 1000;
	padding: 20px;
	overflow-y: auto;
}

.slide-container.active {
	right: 0; /* 슬라이드가 보일 때 위치 */
}

/* 닫기 버튼 스타일 */
.close-btn {
	cursor: pointer;
	color: #001f3f;
	font-size: 20px;
	margin-bottom: 20px;
}

.close-btn:hover {
	color: #d9534f;
}

/* 제목 스타일 */
h2 {
	color: #001f3f;
	border-bottom: 2px solid #001f3f;
	padding-bottom: 10px;
}

/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 테이블에 그림자 추가 */
	border-radius: 8px; /* 모서리 둥글게 */
	overflow: hidden; /* 경계선이 둥글어지도록 */
}

th, td {
	padding: 12px 15px; /* 패딩을 좀 더 여유롭게 */
	text-align: left;
	border: 1px solid #ddd;
}

th {
	background-color: #f5f5f5; /* 부드러운 회색 */
	color: #333; /* 텍스트 색상 */
	font-weight: bold;
	text-transform: uppercase; /* 대문자 변환 */
}

td {
	background-color: #fff; /* 데이터 셀 배경 */
	color: #555; /* 데이터 텍스트 색상 */
}

/* 호버 효과 */
tbody tr:hover {
	background-color: #f0f8ff; /* 호버 시 부드러운 파란색 */
}

/* 테이블의 첫 번째 열 강조 */
td:first-child {
	font-weight: bold; /* 첫 번째 열 강조 */
}

/* 반응형 디자인 */
@media ( max-width : 600px) {
	th, td {
		padding: 10px; /* 작은 화면에서 패딩 조정 */
	}
}

/* 슬라이드 패널 스타일 */
#slidePanel {
	display: none;
	position: fixed;
	z-index: 1000;
	right: 0;
	top: 95px;
	width: 740px;
	height: calc(100% - 60px);
	background-color: #fff;
	box-shadow: -2px 0 5px rgba(0, 0, 0, 0.3);
	transition: transform 0.3s ease;
	transform: translateX(100%);
}

#slidePanel.open {
	display: block;
	transform: translateX(0);
}

/* 폼 스타일 */
.form-container {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 8px; /* 간격 조정 */
	max-width: 700px; /* 최대 너비 설정 */
	margin: 0 auto; /* 가운데 정렬 */
}

.form-group {
	display: flex;
	flex-direction: column;
}

label {
	margin-top: 5px; /* 간격 줄이기 */
	font-weight: bold;
	color: #333;
}

input, textarea {
	padding: 6px; /* 패딩 줄이기 */
	margin-top: 3px;
	border: 1px solid #ccc;
	border-radius: 4px;
	transition: border-color 0.3s;
	font-size: 14px; /* 폰트 크기 조정 */
}

input:focus, textarea:focus {
	border-color: #001f3f;
	outline: none;
}

/* 버튼 그룹 스타일 */
.button-group {
	grid-column: span 2;
	display: flex;
	justify-content: space-between;
	margin-top: 10px; /* 간격 조정 */
}

/* 버튼 스타일 */
button {
	padding: 8px; /* 패딩 줄이기 */
	background: #001f3f;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px; /* 폰트 크기 조정 */
	transition: background 0.3s;
}

button:hover {
	background: #001a33;
}

/* 새로운 스타일 추가 */
.underline-container {
	position: relative;
	display: inline-block;
}

.underline-input {
	border: none;
	outline: none;
	padding: 5px 0;
	background-color: transparent;
	width: auto;
	min-width: 60px;
}

.custom-underline {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 2px;
	background-color: navy;
	width: calc(5ch);
}

/* 반응형 디자인 */
@media ( max-width : 600px) {
	table, thead, tbody, th, td, tr {
		display: block;
	}
	th {
		display: none;
	}
	tr {
		margin-bottom: 15px;
	}
	td {
		text-align: right;
		padding-left: 50%;
		position: relative;
	}
	td::before {
		content: attr(data-label);
		position: absolute;
		left: 10px;
		width: 45%;
		padding-right: 10px;
		white-space: nowrap;
		text-align: left;
		font-weight: bold;
	}
}

/* 검색 박스 스타일 */
.search-box {
	width: 220px; /* 박스 너비 조정 */
	padding: 10px; /* 패딩 추가 */
	background-color: rgba(255, 255, 255, 0.8); /* 반투명 흰색 배경 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 8px; /* 둥근 모서리 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
	position: absolute; /* 화면 왼쪽에 고정 */
	left: 20px; /* 왼쪽 여백 */
	top: 80px; /* 상단 여백 (테이블 시작점에 맞춤) */
	margin-bottom: 20px; /* 아래쪽 간격 추가 */
}

/* 검색 폼 스타일 */
.search-form {
	display: flex;
	align-items: center; /* 수직 중앙 정렬 */
	gap: 6px; /* 요소 간격 조정 */
	margin-bottom: 7px; /* 아래쪽 간격 추가 */
}

.search-form label {
	font-weight: bold; /* 레이블 강조 */
}

.search-form select {
	padding: 4px; /* 패딩 조정 */
	border: 1px solid #ccc; /* 테두리 스타일 */
	border-radius: 4px; /* 둥근 모서리 */
	font-size: 12px; /* 폰트 크기 조정 */
	transition: border-color 0.3s; /* 포커스 시 테두리 색상 변화 */
}

.search-form select:focus {
	border-color: #007bff; /* 포커스 시 색상 변경 */
	outline: none; /* 기본 아웃라인 제거 */
}

.search-button {
	padding: 6px 10px; /* 패딩 조정 */
	background: #cccccc; /* 회색 버튼 배경색 */
	color: white; /* 텍스트 색상 */
	border: none; /* 테두리 제거 */
	border-radius: 4px; /* 둥근 모서리 */
	cursor: pointer; /* 포인터 커서 */
	font-size: 12px; /* 폰트 크기 조정 */
	transition: background 0.3s; /* 배경색 변화 */
}

.search-button:hover {
	background: #999999; /* 호버 시 색상 변경 */
}
</style>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>입고 대기 목록</title>
<!-- CSS Files -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/plugins.min.css" />
<link rel="stylesheet" href="./resources/css/kaiadmin.min.css" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link rel="stylesheet" href="./resources/css/demo.css" />
</head>
<body>
	<div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />

			<div class="container">
				<div class="page-inner">


<h1>거래처 요청 목록</h1>

<div class="form-container1">
    <form action="/searchCorders" method="GET" class="search-form">
        <label for="status">발주 상태:</label>
        <select id="status" name="cord_status">
            <option value="">모두</option>
            <option value="01" selected="selected">발주 요청</option>
            <option value="02">발주 완료</option>
        </select>
        <input type="submit" value="검색" class="search-button">
    </form>
</div>

<table>
    <tr>
        <th>번호</th>
        <th>발주 요청자</th>
        <th>거래처 발주 관리 번호</th>
        <th>제품 ID</th>
        <th>발주 수량</th>
        <th>가격</th>
        <th>발주 날짜</th>
        <th>비고</th>
    </tr>

    <c:forEach var="item" items="${cordersList}" >
        <tr onclick="showCordersDetails('${item.cord_count}','${item.cord_manager_id}','${item.cord_number}','${item.cprod_id}',''${item.cord_quantity}','${item.cord_price}','${item.cord_date}','${item.cord_text}')">
            <td>${item.cord_count}</td>
            <td>${item.cord_manager_id}</td>
            <td>${item.cord_number}</td>
            <td>${item.cprod_id}</td>
            <td>${item.cord_quantity}</td>
            <td>${item.cord_price}</td>
            <td>${item.cord_date}</td>
            <td>${item.cord_text}</td>
        </tr>
    </c:forEach>
</table>



	<!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	</div>

	



