<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Sidebar -->
<div class="sidebar" data-background-color="light">
	<div class="sidebar-logo">
		<!-- Logo Header -->
		<div class="logo-header" data-background-color="light">
			<a href="/main" class="logo" id="mainPage1"> <img
				src="/resources/img/kaiadmin/logo_light.png" alt="navbar brand"
				class="navbar-brand" height="30"
				style="width: 200px;" />
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
				<li class="nav-item active"><a href="/main" aria-expanded="false" id="mainPage2">
				<i class="fas fa-home"></i>
						<p>메인페이지</p>
				</a></li>
				<li class="nav-section"><span class="sidebar-mini-icon">
						<i class="fa fa-ellipsis-h"></i>
				</span>
					<h4 class="text-section">재고 관리 시스템 메뉴</h4></li>
				<li class="nav-item"><a data-bs-toggle="collapse" href="#orderMenu">
						<i class="fas fa-clipboard-list"></i>
						<p>발주관리</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="orderMenu">
						<ul class="nav nav-collapse">
							<li><a class="subMenu" id="a1" href="/order-insert"> <span
									class="sub-item">발주 요청</span>
							</a></li>
							<li><a class="subMenu" id="a2" href="/order-list"> <span
									class="sub-item">발주 목록</span>
							</a></li>

						</ul>
					</div></li>
				<li class="nav-item"><a data-bs-toggle="collapse"
					href="#prodMenu"> <i class="fas fa-boxes"></i>
						<p>제품 관리</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="prodMenu">
						<ul class="nav nav-collapse">
							<li><a class="subMenu" id="a3" href="/prod/insert"> <span
									class="sub-item">제품 등록</span>
							</a></li>
							<li><a class="subMenu" id="a4" href="/prod/list"> <span
									class="sub-item">제품 목록</span>
							</a></li>
							<li><a class="subMenu" id="a5" href="/prod/transfer"> <span
									class="sub-item">재고 이동</span>
							</a></li>
							<li><a class="subMenu" id="a6" href="/prod/movestock"> <span
									class="sub-item">재고 이동 내역</span>
							</a></li>
							<li><a class="subMenu" id="a7" href="/prod/stockalert"> <span
									class="sub-item">재고 알람 설정</span>
							</a></li>
						</ul>
					</div></li>
				<li class="nav-item"><a data-bs-toggle="collapse" href="#rcvMenu">
						<i class="fas fa-dolly"></i>
						<p>입고 관리</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="rcvMenu">
						<ul class="nav nav-collapse">
							<li><a class="subMenu" id="a8" href="/rcvRQ"> <span
									class="sub-item">입고 요청</span>
							</a></li>
							<li><a class="subMenu" id="a9" href="/rcvList2"> <span
									class="sub-item">입고 목록</span>
							</a></li>
						</ul>
					</div></li>
				<li class="nav-item"><a data-bs-toggle="collapse"
					href="#shpMenu"> <i class="fas fa-truck-loading"></i>
						<p>출고 관리</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="shpMenu">
						<ul class="nav nav-collapse">
						
							<li><a class="subMenu" id="a10" href="/cordList2"> <span
									class="sub-item">출고 요청 목록</span>
							</a></li>						
							<li><a class="subMenu" id="a11" href="/shpRQ"> <span
									class="sub-item">출고 처리</span>
							</a></li>
							<li><a class="subMenu" id="a12" href="/shpList2"> <span
									class="sub-item">출고처리 대기 목록</span>
							</a></li>
						</ul>
					</div></li>
				<li class="nav-item"><a data-bs-toggle="collapse" href="#wareMenu">
						<i class="fas fa-warehouse"></i>
						<p>창고 관리</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="wareMenu">
						<ul class="nav nav-collapse">

							<li><a class="subMenu" id="a13" href="/warehouse/wareHouseList">
									<span class="sub-item">창고 목록</span>
							</a></li>
							<li><a class="subMenu" id="a14" href="/warehouse/wareHouseMap">
									<span class="sub-item">창고 지도</span>
							</a></li>
						</ul>
					</div></li>
				<li class="nav-item"><a data-bs-toggle="collapse" href="#coMenu">
						<i class="fas fa-building "></i>
						<p>거래처 관리</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="coMenu">
						<ul class="nav nav-collapse">

							<li><a class="subMenu" id="a15" href="/company/companyList">
									<span class="sub-item">거래처 목록</span>
							</a></li>
						</ul>
					</div></li>
				<li class="nav-item"><a data-bs-toggle="collapse" href="#noticeMenu">
						<i class="fas fa-bullhorn"></i>
						<p>공지사항</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="noticeMenu">
						<ul class="nav nav-collapse">

							<li><a class="subMenu" id="a16" href="/notice/noticeList">
									<span class="sub-item">공지사항 목록</span>
							</a></li>
						</ul>
					</div></li>
				<c:if test="${sessionScope.permission_id == '03' }">
				<li class="nav-item"><a data-bs-toggle="collapse"
					href="#adminMenu"> <i class="fas fa-users-cog"></i>
						<p>관리자 페이지</p> <span class="caret"></span>
				</a>
					<div class="collapse" id="adminMenu">
						<ul class="nav nav-collapse">
							<li><a class="subMenu" id="a17" href="/admin/signReq"> <span
									class="sub-item">회원 가입 신청 목록</span>
							</a></li>
							<li><a class="subMenu" id="a18" href="/admin/adminMemberList">
									<span class="sub-item">회원 목록</span>
							</a></li>
						</ul>
					</div></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
<!-- End Sidebar -->
