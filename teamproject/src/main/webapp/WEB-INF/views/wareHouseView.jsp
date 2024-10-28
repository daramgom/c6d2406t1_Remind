<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>창고 상세 정보</title>

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
                    <h3 class="fw-bold mb-3">창고 관리</h3>
                    <ul class="breadcrumbs mb-3">
                        <li class="nav-home"><a href="#"><i class="icon-home"></i></a></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item"><a href="#">창고 관리</a></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item"><a href="#">창고 상세 정보</a></li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">창고 상세 정보</div>
                            </div>

                            <div class="card-body">
                                <p><strong>창고 번호:</strong> ${warehouse.wh_number}</p>
                                <p><strong>창고 이름:</strong> ${warehouse.wh_name}</p>
                                <p><strong>위치:</strong> ${warehouse.wh_location}</p>
                                <p><strong>등록 사용자:</strong> ${warehouse.wh_reguser}</p>
                                <p><strong>담당자:</strong> ${warehouse.wh_admin}</p>

                                <!-- 버튼을 오른쪽 하단으로 이동 -->
                                <div class="d-flex justify-content-end mt-4" style="position: relative;">
                                    <!-- permission_id가 03일 때만 수정 버튼 표시 -->
                                    <c:if test="${sessionScope.permission_id == '03'}">
                                        <a href="${pageContext.request.contextPath}/warehouse/wareHouseEdit?wh_number=${warehouse.wh_number}" class="btn btn-warning me-2">수정하기</a>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/warehouse/wareHouseList" class="btn btn-secondary">목록으로 돌아가기</a>
                                    <a href="${pageContext.request.contextPath}/warehouse/products?wh_number=${warehouse.wh_number}" class="btn btn-info ms-2">제품 목록 보기</a> <!-- 추가된 버튼 -->
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
 