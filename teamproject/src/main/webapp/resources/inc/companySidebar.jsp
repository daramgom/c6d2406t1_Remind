<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Sidebar -->
<div class="sidebar" data-background-color="light">
	<div class="sidebar-logo">
		<!-- Logo Header -->
		<div class="logo-header" data-background-color="light">
			<a href="/cmain" class="logo"> <img
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
				<li class="nav-item active"><a href="/cmain" aria-expanded="false">
				<i class="fas fa-home"></i>
						<p>환영합니다 ${sessionScope.name }님!</p>
				</a>
				</li>
				<li class="nav-section"><span class="sidebar-mini-icon">
						<i class="fa fa-ellipsis-h"></i>
				</span>
					<h4 class="text-section">발주 관리 (거래처)</h4></li>
				<li class="nav-item"><a href="/order-insert02" id="comOrdMenu"> 
						<i class="fas fa-shipping-fast"></i>
						<p>발주 요청</p>
				</a>
				</li>
				<li class="nav-item"><a href="/order-list03" id="comOrdMenu2">
						<i class="fas fa-clipboard-list"></i>
						<p>발주 요청 목록</p>
				</a>
				</li>
				<li class="nav-item"><a href="/order-list02" id="comShpMenu">
						<i class="fas fa-clipboard-check"></i>
						<p>출고 수락</p>
				</a>
				</li>
			</ul>
		</div>
	</div>
</div>
<!-- End Sidebar -->
