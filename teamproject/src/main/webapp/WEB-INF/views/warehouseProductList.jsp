<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 목록</title>
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
                    <h3 class="fw-bold mb-3">제품 목록</h3>
                    <ul class="breadcrumbs mb-3">
                        <li class="nav-home"><a href="#"><i class="icon-home"></i></a></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item"><a href="#">창고 관리</a></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item"><a href="#">제품 목록</a></li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">창고별 제품 목록</div>
                            </div>

                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="display table table-hover">
                                        <thead>
                                            <tr>
                                                <th>제품 ID</th>
                                                <th>제품 이름</th>
                                                <th>수량</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>제품 ID</th>
                                                <th>제품 이름</th>
                                                <th>수량</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <td>${product.prod_id}</td>
                                                    <td>${product.prod_name}</td>
                                                    <td>${product.prod_qty}</td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty productList}">
                                                <tr>
                                                    <td colspan="3">조회된 제품이 없습니다.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- 버튼을 오른쪽 하단으로 이동 -->
                                <div class="d-flex justify-content-end mt-4" style="position: relative;">
                                    <a href="${pageContext.request.contextPath}/warehouse/wareHouseList" class="btn btn-secondary">목록으로 돌아가기</a>
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
    <script src="${pageContext.request.contextPath}/resources/js/core/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
