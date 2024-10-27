<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Sidebar -->
<div class="sidebar" data-background-color="light">
	<div class="sidebar-logo">
		<!-- Logo Header -->
		<div class="logo-header" data-background-color="light">
			<a href="#" class="logo"> <img
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
				<li class="nav-item active"><a href="#" aria-expanded="false">
				<i class="fas fa-home"></i>
						<p>환영합니다 ${sessionScope.name }님!</p>
				</a>
				</li>
				<c:choose>
				<c:when test="true">
				<li class="nav-section"><span class="sidebar-mini-icon">
						<i class="fa fa-ellipsis-h"></i>
				</span>
					<h4 class="text-section">재고 관리 시스템 메뉴</h4></li>
				<li class="nav-item"><a data-bs-toggle="collapse" href="#" id="comOrdMenu">
						<i class="fas fa-clipboard-check"></i>
						<p>발주 수락</p>
				</a>
				</li>
				<li class="nav-item"><a	data-bs-toggle="collapse" href="#" id="comShpMenu"> 
						<i class="fas fa-shipping-fast"></i>
						<p>출고 요청</p>
				</a>
				</li>
				
				
				</c:when>
				<c:otherwise>
				</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>
<!-- End Sidebar -->
