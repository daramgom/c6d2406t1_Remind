<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>REMIND</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
	<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />
</head>
<body>
	<c:if test="${empty sessionScope.id}">
	<c:redirect url="/login"/>
	</c:if>
    <div class="wrapper">

        <!-- Header -->
        <jsp:include page="/resources/inc/header.jsp" />

        <!-- Sidebar -->
        <jsp:include page="/resources/inc/sidebar.jsp" />

        <!-- Main Content -->
        <div class="container">
            <div class="page-inner">
                <div class="page-header">
                    <h3 class="fw-bold mb-3">공지사항</h3>
                    <ul class="breadcrumbs mb-3">
                        <li class="nav-home">
                                <i class="icon-home"></i>
                        </li>
                        <li class="separator">
                            <i class="icon-arrow-right"></i>
                        </li>
                        <li class="nav-item">
                            공지사항
                        </li>
                        <li class="separator">
                            <i class="icon-arrow-right"></i>
                        </li>
                        <li class="nav-item">
                            공지사항 상세보기
                        </li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">${notice.title}</h4>
                            </div>
                            <div class="card-body">
                                <p><strong>작성자:</strong> ${notice.writer}</p>
                                <p><strong>작성일자:</strong> ${notice.regdate}</p>
                                <hr>
                                <h5>본문 내용:</h5>
                                <div>${notice.content}</div> <!-- 본문 내용 출력 -->
                                <hr>
                                <div class="d-flex justify-content-end">
                                    <!-- permission_id가 03일 때만 수정 버튼 표시 -->
                                    <c:if test="${sessionScope.permission_id == '03'}">
                                        <a href="${pageContext.request.contextPath}/notice/noticeEdit?no=${notice.no}" class="btn btn-warning me-2">수정</a>
                                    </c:if>
                                    <!-- 삭제 버튼 제거 -->
                                    <a href="${pageContext.request.contextPath}/notice/noticeList" class="btn btn-black ms-2">목록으로 돌아가기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/resources/inc/footer.jsp" />
    </div>
 
    
</body>
</html>
