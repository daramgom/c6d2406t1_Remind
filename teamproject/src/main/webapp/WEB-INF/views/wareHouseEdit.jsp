<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>창고 수정</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
</head>
<body>
    <div class="wrapper">
        <!-- Header -->
        <jsp:include page="/resources/inc/header.jsp" />

        <!-- Sidebar -->
        <jsp:include page="/resources/inc/sidebar.jsp" />

        <!-- Main Content -->
        <div class="container">
            <div class="page-inner">
                <div class="page-header">
                    <h3 class="fw-bold mb-3">창고 수정</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="card-title">창고 정보 수정</div>
                                <button type="button" class="btn btn-success" onclick="document.getElementById('warehouseEditForm').submit();">창고 수정</button>
                            </div>

                            <div class="card-body">
                                <form id="warehouseEditForm" action="${pageContext.request.contextPath}/warehouse/edit" method="post">
                                    <div class="form-group">
                                        <label for="wh_number" class="col-form-label">창고 번호</label>
                                        <input type="text" class="form-control" id="wh_number" name="wh_number" value="${warehouse.wh_number}" readonly required />
                                    </div>
                                    <div class="form-group">
                                        <label for="wh_name" class="col-form-label">창고 이름</label>
                                        <input type="text" class="form-control" id="wh_name" name="wh_name" value="${warehouse.wh_name}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="wh_location" class="col-form-label">위치</label>
                                        <input type="text" class="form-control" id="wh_location" name="wh_location" value="${warehouse.wh_location}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="wh_reguser" class="col-form-label">등록 사용자</label>
                                        <input type="text" class="form-control" id="wh_reguser" name="wh_reguser" value="${warehouse.wh_reguser}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="wh_admin" class="col-form-label">담당자</label>
                                        <input type="text" class="form-control" id="wh_admin" name="wh_admin" value="${warehouse.wh_admin}" required />
                                    </div>

                                    <!-- 버튼들을 오른쪽으로 정렬 -->
                                    <div class="d-flex justify-content-end mt-4">
                                        <button type="button" class="btn btn-danger me-2" onclick="if(confirm('정말로 삭제하시겠습니까?')) { document.getElementById('warehouseEditForm').action='${pageContext.request.contextPath}/warehouse/delete'; document.getElementById('warehouseEditForm').submit(); }">삭제</button>
                                        <input type="hidden" name="wh_number" id="deleteWhNumber" value="${warehouse.wh_number}" />
                                        <a href="${pageContext.request.contextPath}/warehouse/wareHouseList" class="btn btn-secondary">목록으로</a>
                                    </div>
                                </form>
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
    <script src="/resources/js/core/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
