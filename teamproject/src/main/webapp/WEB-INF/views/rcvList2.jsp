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
		<!-- Sidebar -->
		<div class="sidebar" data-background-color="dark">
			<div class="sidebar-logo">
				<!-- Logo Header -->
				<div class="logo-header" data-background-color="dark">
					<a href="index.html" class="logo"> <img
						src="./resources/img/kaiadmin/logo_light.svg" alt="navbar brand"
						class="navbar-brand" height="20" />
					</a>
					<div class="nav-toggle">
						<button class="btn btn-toggle toggle-sidebar">
							<i class="gg-menu-right"></i>
						</button>
						<button class="btn btn-toggle sidenav-toggler">
							<i class="gg-menu-left"></i>
						</button>
					</div>
					<button class="topbar-toggler more">
						<i class="gg-more-vertical-alt"></i>
					</button>
				</div>
				<!-- End Logo Header -->
			</div>
			<div class="sidebar-wrapper scrollbar scrollbar-inner">
				<div class="sidebar-content">
					<ul class="nav nav-secondary">
						<li class="nav-item active"><a data-bs-toggle="collapse"
							href="#dashboard" class="collapsed" aria-expanded="false"> <i
								class="fas fa-home"></i>
								<p>Dashboard</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="dashboard">
								<ul class="nav nav-collapse">
									<li><a href="../demo1/index.html"> <span
											class="sub-item">Dashboard 1</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-section"><span class="sidebar-mini-icon">
								<i class="fa fa-ellipsis-h"></i>
						</span>
							<h4 class="text-section">Components</h4></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#base"> <i class="fas fa-layer-group"></i>
								<p>Base</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="base">
								<ul class="nav nav-collapse">
									<li><a href="components/avatars.html"> <span
											class="sub-item">Avatars</span>
									</a></li>
									<li><a href="components/buttons.html"> <span
											class="sub-item">Buttons</span>
									</a></li>
									<li><a href="components/gridsystem.html"> <span
											class="sub-item">Grid System</span>
									</a></li>
									<li><a href="components/panels.html"> <span
											class="sub-item">Panels</span>
									</a></li>
									<li><a href="components/notifications.html"> <span
											class="sub-item">Notifications</span>
									</a></li>
									<li><a href="components/sweetalert.html"> <span
											class="sub-item">Sweet Alert</span>
									</a></li>
									<li><a href="components/font-awesome-icons.html"> <span
											class="sub-item">Font Awesome Icons</span>
									</a></li>
									<li><a href="components/simple-line-icons.html"> <span
											class="sub-item">Simple Line Icons</span>
									</a></li>
									<li><a href="components/typography.html"> <span
											class="sub-item">Typography</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#sidebarLayouts"> <i class="fas fa-th-list"></i>
								<p>Sidebar Layouts</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="sidebarLayouts">
								<ul class="nav nav-collapse">
									<li><a href="sidebar-style-2.html"> <span
											class="sub-item">Sidebar Style 2</span>
									</a></li>
									<li><a href="icon-menu.html"> <span class="sub-item">Icon
												Menu</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#forms"> <i class="fas fa-pen-square"></i>
								<p>Forms</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="forms">
								<ul class="nav nav-collapse">
									<li><a href="forms/forms.html"> <span class="sub-item">Basic
												Form</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#tables"> <i class="fas fa-table"></i>
								<p>Tables</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="tables">
								<ul class="nav nav-collapse">
									<li><a href="tables/tables.html"> <span
											class="sub-item">Basic Table</span>
									</a></li>
									<li><a href="tables/datatables.html"> <span
											class="sub-item">Datatables</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#maps"> <i class="fas fa-map-marker-alt"></i>
								<p>Maps</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="maps">
								<ul class="nav nav-collapse">
									<li><a href="maps/googlemaps.html"> <span
											class="sub-item">Google Maps</span>
									</a></li>
									<li><a href="maps/jsvectormap.html"> <span
											class="sub-item">Jsvectormap</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#charts"> <i class="far fa-chart-bar"></i>
								<p>Charts</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="charts">
								<ul class="nav nav-collapse">
									<li><a href="charts/charts.html"> <span
											class="sub-item">Chart Js</span>
									</a></li>
									<li><a href="charts/sparkline.html"> <span
											class="sub-item">Sparkline</span>
									</a></li>
								</ul>
							</div></li>
						<li class="nav-item"><a href="widgets.html"> <i
								class="fas fa-desktop"></i>
								<p>Widgets</p> <span class="badge badge-success">4</span>
						</a></li>
						<li class="nav-item"><a href="./documentation/index.html">
								<i class="fas fa-file"></i>
								<p>Documentation</p> <span class="badge badge-secondary">1</span>
						</a></li>
						<li class="nav-item"><a data-bs-toggle="collapse"
							href="#submenu"> <i class="fas fa-bars"></i>
								<p>Menu Levels</p> <span class="caret"></span>
						</a>
							<div class="collapse" id="submenu">
								<ul class="nav nav-collapse">
									<li><a data-bs-toggle="collapse" href="#subnav1"> <span
											class="sub-item">Level 1</span> <span class="caret"></span>
									</a>
										<div class="collapse" id="subnav1">
											<ul class="nav nav-collapse subnav">
												<li><a href="#"> <span class="sub-item">Level
															2</span>
												</a></li>
												<li><a href="#"> <span class="sub-item">Level
															2</span>
												</a></li>
											</ul>
										</div></li>
									<li><a data-bs-toggle="collapse" href="#subnav2"> <span
											class="sub-item">Level 1</span> <span class="caret"></span>
									</a>
										<div class="collapse" id="subnav2">
											<ul class="nav nav-collapse subnav">
												<li><a href="#"> <span class="sub-item">Level
															2</span>
												</a></li>
											</ul>
										</div></li>
									<li><a href="#"> <span class="sub-item">Level 1</span>
									</a></li>
								</ul>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- End Sidebar -->

		<div class="main-panel">
			<div class="main-header">
				<div class="main-header-logo">
					<!-- Logo Header -->
					<div class="logo-header" data-background-color="dark">
						<a href="index.html" class="logo"> <img
							src="./resources/img/kaiadmin/logo_light.svg" alt="navbar brand"
							class="navbar-brand" height="20" />
						</a>
						<div class="nav-toggle">
							<button class="btn btn-toggle toggle-sidebar">
								<i class="gg-menu-right"></i>
							</button>
							<button class="btn btn-toggle sidenav-toggler">
								<i class="gg-menu-left"></i>
							</button>
						</div>
						<button class="topbar-toggler more">
							<i class="gg-more-vertical-alt"></i>
						</button>
					</div>
					<!-- End Logo Header -->
				</div>
				<!-- Navbar Header -->
				<nav
					class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom">
					<div class="container-fluid">
						<nav
							class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex">
							<div class="input-group">
								<div class="input-group-prepend">
									<button type="submit" class="btn btn-search pe-1">
										<i class="fa fa-search search-icon"></i>
									</button>
								</div>
								<input type="text" placeholder="Search ..." class="form-control" />
							</div>
						</nav>

						<ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
							<li
								class="nav-item topbar-icon dropdown hidden-caret d-flex d-lg-none">
								<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown"
								href="#" role="button" aria-expanded="false"
								aria-haspopup="true"> <i class="fa fa-search"></i>
							</a>
								<ul class="dropdown-menu dropdown-search animated fadeIn">
									<form class="navbar-left navbar-form nav-search">
										<div class="input-group">
											<input type="text" placeholder="Search ..."
												class="form-control" />
										</div>
									</form>
								</ul>
							</li>
							<li class="nav-item topbar-icon dropdown hidden-caret"><a
								class="nav-link dropdown-toggle" href="#" id="messageDropdown"
								role="button" data-bs-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false"> <i class="fa fa-envelope"></i>
							</a>
								<ul class="dropdown-menu messages-notif-box animated fadeIn"
									aria-labelledby="messageDropdown">
									<li>
										<div
											class="dropdown-title d-flex justify-content-between align-items-center">
											Messages <a href="#" class="small">Mark all as read</a>
										</div>
									</li>
									<li>
										<div class="message-notif-scroll scrollbar-outer">
											<div class="notif-center">
												<a href="#">
													<div class="notif-img">
														<img src="./resources/img/jm_denis.jpg" alt="Img Profile" />
													</div>
													<div class="notif-content">
														<span class="subject">Jimmy Denis</span> <span
															class="block"> How are you ? </span> <span class="time">5
															minutes ago</span>
													</div>
												</a> <a href="#">
													<div class="notif-img">
														<img src="./resources/img/chadengle.jpg" alt="Img Profile" />
													</div>
													<div class="notif-content">
														<span class="subject">Chad</span> <span class="block">
															Ok, Thanks ! </span> <span class="time">12 minutes ago</span>
													</div>
												</a> <a href="#">
													<div class="notif-img">
														<img src="./resources/img/mlane.jpg" alt="Img Profile" />
													</div>
													<div class="notif-content">
														<span class="subject">Jhon Doe</span> <span class="block">
															Ready for the meeting today... </span> <span class="time">12
															minutes ago</span>
													</div>
												</a> <a href="#">
													<div class="notif-img">
														<img src="./resources/img/talha.jpg" alt="Img Profile" />
													</div>
													<div class="notif-content">
														<span class="subject">Talha</span> <span class="block">
															Hi, Apa Kabar ? </span> <span class="time">17 minutes ago</span>
													</div>
												</a>
											</div>
										</div>
									</li>
									<li><a class="see-all" href="javascript:void(0);">See
											all messages<i class="fa fa-angle-right"></i>
									</a></li>
								</ul></li>
							<li class="nav-item topbar-icon dropdown hidden-caret"><a
								class="nav-link dropdown-toggle" href="#" id="notifDropdown"
								role="button" data-bs-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false"> <i class="fa fa-bell"></i> <span
									class="notification">4</span>
							</a>
								<ul class="dropdown-menu notif-box animated fadeIn"
									aria-labelledby="notifDropdown">
									<li>
										<div class="dropdown-title">You have 4 new notification
										</div>
									</li>
									<li>
										<div class="notif-scroll scrollbar-outer">
											<div class="notif-center">
												<a href="#">
													<div class="notif-icon notif-primary">
														<i class="fa fa-user-plus"></i>
													</div>
													<div class="notif-content">
														<span class="block"> New user registered </span> <span
															class="time">5 minutes ago</span>
													</div>
												</a> <a href="#">
													<div class="notif-icon notif-success">
														<i class="fa fa-comment"></i>
													</div>
													<div class="notif-content">
														<span class="block"> Rahmad commented on Admin </span> <span
															class="time">12 minutes ago</span>
													</div>
												</a> <a href="#">
													<div class="notif-img">
														<img src="./resources/img/profile2.jpg" alt="Img Profile" />
													</div>
													<div class="notif-content">
														<span class="block"> Reza send messages to you </span> <span
															class="time">12 minutes ago</span>
													</div>
												</a> <a href="#">
													<div class="notif-icon notif-danger">
														<i class="fa fa-heart"></i>
													</div>
													<div class="notif-content">
														<span class="block"> Farrah liked Admin </span> <span
															class="time">17 minutes ago</span>
													</div>
												</a>
											</div>
										</div>
									</li>
									<li><a class="see-all" href="javascript:void(0);">See
											all notifications<i class="fa fa-angle-right"></i>
									</a></li>
								</ul></li>
							<li class="nav-item topbar-icon dropdown hidden-caret"><a
								class="nav-link" data-bs-toggle="dropdown" href="#"
								aria-expanded="false"> <i class="fas fa-layer-group"></i>
							</a>
								<div class="dropdown-menu quick-actions animated fadeIn">
									<div class="quick-actions-header">
										<span class="title mb-1">Quick Actions</span> <span
											class="subtitle op-7">Shortcuts</span>
									</div>
									<div class="quick-actions-scroll scrollbar-outer">
										<div class="quick-actions-items">
											<div class="row m-0">
												<a class="col-6 col-md-4 p-0" href="#">
													<div class="quick-actions-item">
														<div class="avatar-item bg-danger rounded-circle">
															<i class="far fa-calendar-alt"></i>
														</div>
														<span class="text">Calendar</span>
													</div>
												</a> <a class="col-6 col-md-4 p-0" href="#">
													<div class="quick-actions-item">
														<div class="avatar-item bg-warning rounded-circle">
															<i class="fas fa-map"></i>
														</div>
														<span class="text">Maps</span>
													</div>
												</a> <a class="col-6 col-md-4 p-0" href="#">
													<div class="quick-actions-item">
														<div class="avatar-item bg-info rounded-circle">
															<i class="fas fa-file-excel"></i>
														</div>
														<span class="text">Reports</span>
													</div>
												</a> <a class="col-6 col-md-4 p-0" href="#">
													<div class="quick-actions-item">
														<div class="avatar-item bg-success rounded-circle">
															<i class="fas fa-envelope"></i>
														</div>
														<span class="text">Emails</span>
													</div>
												</a> <a class="col-6 col-md-4 p-0" href="#">
													<div class="quick-actions-item">
														<div class="avatar-item bg-primary rounded-circle">
															<i class="fas fa-file-invoice-dollar"></i>
														</div>
														<span class="text">Invoice</span>
													</div>
												</a> <a class="col-6 col-md-4 p-0" href="#">
													<div class="quick-actions-item">
														<div class="avatar-item bg-secondary rounded-circle">
															<i class="fas fa-credit-card"></i>
														</div>
														<span class="text">Payments</span>
													</div>
												</a>
											</div>
										</div>
									</div>
								</div></li>

							<li class="nav-item topbar-user dropdown hidden-caret"><a
								class="dropdown-toggle profile-pic" data-bs-toggle="dropdown"
								href="#" aria-expanded="false">
									<div class="avatar-sm">
										<img src="./resources/img/profile.jpg" alt="..."
											class="avatar-img rounded-circle" />
									</div> <span class="profile-username"> <span class="op-7">Hi,</span>
										<span class="fw-bold">Hizrian</span>
								</span>
							</a>
								<ul class="dropdown-menu dropdown-user animated fadeIn">
									<div class="dropdown-user-scroll scrollbar-outer">
										<li>
											<div class="user-box">
												<div class="avatar-lg">
													<img src="./resources/img/profile.jpg" alt="image profile"
														class="avatar-img rounded" />
												</div>
												<div class="u-text">
													<h4>Hizrian</h4>
													<p class="text-muted">hello@example.com</p>
													<a href="profile.html"
														class="btn btn-xs btn-secondary btn-sm">View Profile</a>
												</div>
											</div>
										</li>
										<li>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="#">My Profile</a> <a class="dropdown-item" href="#">My
												Balance</a> <a class="dropdown-item" href="#">Inbox</a>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="#">Account Setting</a>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="#">Logout</a>
										</li>
									</div>
								</ul></li>
						</ul>
					</div>
				</nav>
				<!-- End Navbar -->
			</div>

			<div class="container">
				<div class="page-inner">
					<main>
						<body>
							<h1>입고 요청 목록</h1>

							<div class="form-container1">
								<form action="/searchReceiving" method="GET" class="search-form">
									<label for="status">입고 상태:</label> <select id="status"
										name="rcv_status">
										<option value="">모두</option>
										<option value="01" selected="selected">입고 요청</option>
										<option value="02">입고 완료</option>
										<option value="03">입고 반려</option>
										<option value="04">입고 삭제</option>
									</select> <input type="submit" value="검색" class="search-button">
								</form>
							</div>
							<table>
								<tr>
									<th>번호</th>
									<th>입고 요청자</th>
									<th>발주 관리 번호</th>
									<th>입고 관리 번호</th>
									<th>제품 ID</th>
									<th>품목명</th>
									<th>입고 수량</th>
									<th>입고 가격</th>
									<th>입고 날짜</th>
									<th>비고</th>
								</tr>

								<c:forEach var="item1" items="${receivingList}" varStatus="idx">
									<tr
										onclick="showDetails('${item1.rcv_manager_id}', '${item1.rcv_supervisor_id}', '${ordersList[idx.index].ord_manager_name}', '${ordersList[idx.index].ord_supervisor_name}', '${item1.ord_number}', '${item1.rcv_number}', '${item1.prod_category}', '${item1.prod_id}', '${item1.prod_name}', ${item1.rcv_quantity}, ${item1.rcv_price}, '${item1.wh_number}', '${item1.company_code}', '${item1.rcv_date}', '${item1.ord_date}', '${item1.rcv_remarks}')">
										<td>${item1.rcv_count}</td>
										<td>${item1.rcv_manager_id}</td>
										<td>${item1.ord_number}</td>
										<td>${item1.rcv_number}</td>
										<td>${item1.prod_id}</td>
										<td>${item1.prod_name}</td>
										<td>${item1.rcv_quantity}</td>
										<td>${item1.rcv_price}</td>
										<td>${item1.rcv_date}</td>
										<td>${item1.rcv_remarks}</td>
									</tr>
								</c:forEach>

								<!-- 슬라이드 패널 -->
								<div id="slidePanel" class="slide-container">
									<span class="close-btn" onclick="closePanel()">&times;</span>
									<h2>입고 요청</h2>
									<form id="ReceivingForm" onsubmit="return confirmSubmission()">
										<div class="form-container">
											<div class="form-group">
												<label for="rcvManagerId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">입고
													요청자
												</label>
												<div class="underline-container">
													<input type="text" id="rcvManagerId"
														class="underline-input" placeholder="홍길동" required
														name="rcvManagerId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="rcvSupervisorId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">입고
													승인자
												</label>
												<div class="underline-container">
													<input type="text" id="rcvSupervisorId"
														class="underline-input" placeholder="홍길동" required
														name="rcvSupervisorId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="ordManagerId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주
													요청자
												</label>
												<div class="underline-container">
													<input type="text" id="ordManagerId"
														class="underline-input" placeholder="홍길동" required
														name="ordManagerId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="ordSupervisorId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주
													승인자
												</label>
												<div class="underline-container">
													<input type="text" id="ordSupervisorId"
														class="underline-input" placeholder="홍길동" required
														name="ordSupervisorId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="ordNumber">발주 관리번호</label>
												<div style="display: flex; align-items: center;">
													<input type="text" id="ordNumber" placeholder="발주관리번호입력"
														required name="ordNumber">
													<button type="button" onclick="submitOrderNumber()">조회</button>
												</div>
												<div class="dropdown" id="orderDropdown"></div>
											</div>

											<div class="form-group">
												<label for="rcvNumber">입고 관리번호</label>
												<div style="display: flex; align-items: center;">
													<input type="text" id="rcvNumber" placeholder="입고관리번호입력"
														required name="rcvNumber">
													<button type="button" onclick="submitOrderNumber()">조회</button>
												</div>
												<div class="dropdown" id="orderDropdown"></div>
											</div>

											<div class="form-group">
												<label for="prodId">제품 식별코드</label> <input type="text"
													id="prodId" placeholder="제품식별코드를 입력" required name="prodId">
											</div>

											<div class="form-group">
												<label for="prodCategory">카테고리</label> <input type="text"
													id="prodCategory" required name="prodCategory">
											</div>

											<div class="form-group">
												<label for="prodName">품목명</label> <input type="text"
													id="prodName" required name="prodName">
											</div>

											<div class="form-group">
												<label for="companyCode">거래처</label> <input type="text"
													id="companyCode" required name="companyCode">
											</div>

											<div class="form-group">
												<label for="rcvQuantity">입고 수량</label> <input type="number"
													id="rcvQuantity" required name="rcvQuantity">
											</div>

											<div class="form-group">
												<label for="whNumber">창고 번호</label> <input type="number"
													id="whNumber" required name="whNumber">
											</div>

											<div class="form-group">
												<label for="rcvPrice">가격(단가)</label> <input type="text"
													id="rcvPrice" required name="rcvPrice">
											</div>

											<div class="form-group">
												<label for="ordDate">발주 날짜</label> <input type="date"
													id="ordDate" required name="ordDate">
											</div>

											<div class="form-group">
												<label for="rcvDate">입고 날짜</label> <input type="date"
													id="rcvDate" required name="rcvDate">
											</div>

											<div class="form-group">
												<label for="rcvRemarks">비고</label>
												<textarea id="rcvRemarks" placeholder="전달 할 '내용' ..."
													required name="rcvRemarks"></textarea>
											</div>

											<div class="button-group">
												<button type="button" onclick="saveDetails()">입고 승인</button>
												<button type="button" onclick="rejectReceiving()">입고
													반려</button>
												<button type="button" onclick="editDetails()">입고 수정</button>
												<button type="button" onclick="deleteReceiving()">입고
													삭제</button>
											</div>
										</div>
									</form>
								</div>
							</table>
						</body>
					</main>
				</div>
			</div>
		</div>
	</div>


	<script>
function showDetails(rcvManagerName, rcvSupervisorName, ordManagerName, ordSupervisorName, ordNumber, rcvNumber, prodCategory, prodId, prodName, rcvQuantity, rcvPrice, whNumber, companyCode, ordDate, rcvDate, rcvRemarks) {
	document.getElementById('slidePanel').classList.add('open');  // 슬라이드 열기
	document.getElementById('rcvManagerId').value = rcvManagerName; //입고 요청자 이름
    document.getElementById('rcvSupervisorId').value = rcvSupervisorName; // 입고 승인자 이름
    document.getElementById('ordManagerId').value = ordManagerName;  // 발주 요청자 이름
    document.getElementById('ordSupervisorId').value = ordSupervisorName; // 발주 승인자 이름
    document.getElementById('ordNumber').value = ordNumber;
    document.getElementById('rcvNumber').value = rcvNumber; 
    document.getElementById('prodCategory').value = prodCategory; 
    document.getElementById('prodId').value = prodId;
    document.getElementById('prodName').value = prodName;
    document.getElementById('rcvQuantity').value = rcvQuantity;
    document.getElementById('rcvPrice').value = rcvPrice;
    document.getElementById('whNumber').value = whNumber;   
    document.getElementById('companyCode').value = companyCode; // 거래처 추가
    document.getElementById('ordDate').value = ordDate;
    document.getElementById('rcvDate').value = rcvDate;
    document.getElementById('rcvRemarks').value = rcvRemarks;
    document.getElementById('slidePanel').classList.add('open');  // 슬라이드 열기
}

    function closePanel() {
        document.getElementById('slidePanel').classList.remove('open');  // 슬라이드 닫기
    }

    function saveDetails() {
        const updatedData = {
            rcv_manager_id: document.getElementById('rcvManagerId').value,
            rcv_supervisor_id: document.getElementById('rcvSupervisorId').value,
            ord_manager_id: document.getElementById('ordManagerId').value,
            ord_supervisor_id: document.getElementById('ordSupervisorId').value,
            ord_number: document.getElementById('ordNumber').value,
            rcv_number: document.getElementById('rcvNumber').value,
            prod_category: document.getElementById('prodCategory').value,
            prod_id: document.getElementById('prodId').value,
            prod_name: document.getElementById('prodName').value,
            rcv_quantity: document.getElementById('rcvQuantity').value,
            rcv_price: document.getElementById('rcvPrice').value,
            wh_number: document.getElementById('whNumber').value,
            company_code: document.getElementById('companyCode').value,
            ord_date: document.getElementById('ordDate').value,
            rcv_date: document.getElementById('rcvDate').value,
            rcv_remarks: document.getElementById('rcvRemarks').value
        };

        alert("저장중");
        const url = '/updateReceiving';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        })
        .then(response => {
            if (response.ok) {
                // 성공 메시지와 모달창 확인 요청
                if (confirm('입고가 완료되었습니다! 거래명세표를 확인하시겠습니까?')) {
                    openModal(); // 모달창 열기
                }
                closePanel(); // 슬라이드 닫기
            } else {
                throw new Error('업데이트 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('업데이트 실패: ' + error.message);
        });
    }

    // 모달 열기 함수 (여기에 기존의 모달 열기 코드 추가)
    function openModal() {
    	
        document.getElementById('invoiceModal').style.display = 'block';
    } 
    </script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

	<!-- 모달 HTML -->
	<div id="invoiceModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>

			<h3 style="text-align: center;">거래명세서</h3>
			<form id="invoiceForm">
				<table class="invoice-table">
					<tr>
						<th>항목</th>
						<th>내용</th>
					</tr>
					<tr>
						<td>입고 담당자</td>
						<td><input type="text" id="modal_rcv_manager_id"
							name="rcv_manager_id"></td>
					</tr>
					<tr>
						<td>입고 관리번호</td>
						<td><input type="text" id="modal_rcv_number"
							name="rcv_number"></td>
					</tr>
					<tr>
						<td>제품 식별코드</td>
						<td><input type="text" id="modal_prod_id" name="prod_id"></td>
					</tr>
					<tr>
						<td>카테고리</td>
						<td><input type="text" id="modal_prod_category"
							name="prod_category"></td>
					</tr>
					<tr>
						<td>품목명</td>
						<td><input type="text" id="modal_prod_name" name="prod_name"></td>
					</tr>
					<tr>
						<td>거래처</td>
						<td><input type="text" id="modal_company_code"
							name="company_code"></td>
					</tr>
					<tr>
						<td>입고 수량</td>
						<td><input type="number" id="modal_rcv_quantity"
							name="rcv_quantity"></td>
					</tr>
					<tr>
						<td>가격(단가)</td>
						<td><input type="number" id="modal_rcv_price"
							name="rcv_price"></td>
					</tr>
					<tr>
						<td>입고 날짜</td>
						<td><input type="date" id="modal_rcv_date" name="rcv_date"></td>
					</tr>
					<tr>
						<td>비고</td>
						<td><input type="text" id="modal_rcv_remarks"
							name="rcv_remarks"></td>
					</tr>
				</table>
				<button type="button" onclick="submitForm()">확인</button>
			</form>
		</div>
	</div>

	<script>
    function rejectReceiving() {
        const rcvNumber = document.getElementById('rcvNumber').value;
        const url = '/rejectReceiving'; // 반려 요청을 처리할 URL

        const reason = prompt("반려 사유를 입력하세요:"); // 반려 사유 입력받기

        if (reason) {
            const data = {
                rcv_number: rcvNumber,
                reason: reason,
                rcv_status: '03' // rcv_status를 '03'으로 설정
            };

            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (response.ok) {
                    alert('입고가 반려되었습니다!');
                    closePanel(); // 슬라이드 닫기
                } else {
                    throw new Error('반려 실패');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('반려 실패: ' + error.message);
            });
        } else {
            alert("반려 사유를 입력해야 합니다.");
        }
    }
    
    function editDetails() {
        const updatedData = {
            rcv_manager_id: document.getElementById('rcvManagerId').value,
            rcv_supervisor_id: document.getElementById('rcvSupervisorId').value,
            ord_manager_id: document.getElementById('ordManagerId').value,
            ord_supervisor_id: document.getElementById('ordSupervisorId').value,
            ord_number: document.getElementById('ordNumber').value,
            rcv_number: document.getElementById('rcvNumber').value,
            prod_id: document.getElementById('prodId').value,
            prod_name: document.getElementById('prodName').value,
            rcv_quantity: document.getElementById('rcvQuantity').value,
            rcv_price: document.getElementById('rcvPrice').value,
            wh_number: document.getElementById('whNumber').value,
            company_code: document.getElementById('companyCode').value, // 거래처 추가
            rcv_date: document.getElementById('rcvDate').value,
            ord_date: document.getElementById('ordDate').value,
            rcv_remarks: document.getElementById('rcvRemarks').value
        };

        alert("수정중...");
        const url = '/editReceiving'; // 수정 요청을 처리할 URL

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        })
        .then(response => {
            if (response.ok) {
                alert('입고 정보가 수정되었습니다!');
                closePanel(); // 슬라이드 닫기
            } else {
                throw new Error('수정 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('수정 실패: ' + error.message);
        });
    }
    
    function deleteReceiving() {
        const rcvNumber = document.getElementById('rcvNumber').value;
        const url = '/deleteReceiving'; 

        const data = {
            rcv_number: rcvNumber,
            rcv_status: '04' // rcv_status를 '04'로 설정
        };

        if (confirm("정말로 삭제하시겠습니까?")) {
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (response.ok) {
                    alert('입고 요청이 삭제되었습니다!');
                    closePanel(); // 슬라이드 닫기
                } else {
                    throw new Error('삭제 실패');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('삭제 실패: ' + error.message);
            });
        }
    }
</script>