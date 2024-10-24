<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${notice.title}</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
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
                    <h3 class="fw-bold mb-3">공지사항 상세보기</h3>
                    <ul class="breadcrumbs mb-3">
                        <li class="nav-home">
                            <a href="#">
                                <i class="icon-home"></i>
                            </a>
                        </li>
                        <li class="separator">
                            <i class="icon-arrow-right"></i>
                        </li>
                        <li class="nav-item">
                            <a href="#">공지사항 상세보기</a>
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
                                <p><strong>조회수:</strong> ${notice.viewcnt}</p>
                                <hr>
                                <h5>본문 내용:</h5>
                                <div>${notice.content}</div> <!-- 본문 내용 출력 -->
                                <hr>
                                <div class="d-flex justify-content-end">
                                    <a href="${pageContext.request.contextPath}/notice/noticeList" class="btn btn-secondary me-2">목록으로 돌아가기</a>
                                    <!-- permission_id가 03일 때만 수정 버튼 표시 -->
                                    <c:if test="${sessionScope.permission_id == '03'}">
                                        <a href="${pageContext.request.contextPath}/notice/noticeEdit?no=${notice.no}" class="btn btn-warning me-2">수정</a>
                                    </c:if>
                                    <!-- 삭제 버튼 제거 -->
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
 
    <!-- Core JS Files -->
    <script src="${pageContext.request.contextPath}/resources/js/core/jquery-3.7.1.min.js?ver=1.0"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
