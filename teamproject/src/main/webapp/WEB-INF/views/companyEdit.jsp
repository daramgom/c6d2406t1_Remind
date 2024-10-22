<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래처 수정</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
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
                    <h3 class="fw-bold mb-3">거래처 수정</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="card-title">거래처 수정</div>
                                <form action="${pageContext.request.contextPath}/company/edit" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-success">거래처 수정</button>
                                </form>
                            </div>

                            <div class="card-body">
                                <form id="companyEditForm" action="${pageContext.request.contextPath}/company/edit" method="post">
                                    <div class="form-group">
                                        <label for="company_code" class="col-form-label">거래처 코드</label>
                                        <input type="text" class="form-control" id="company_code" name="company_code" value="${company.company_code}" readonly required />
                                    </div>
                                    <div class="form-group">
                                        <label for="company_name" class="col-form-label">거래처 이름</label>
                                        <input type="text" class="form-control" id="company_name" name="company_name" value="${company.company_name}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="company_manager" class="col-form-label">실무자</label>
                                        <input type="text" class="form-control" id="company_manager" name="company_manager" value="${company.company_manager}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="company_tel" class="col-form-label">전화번호</label>
                                        <input type="text" class="form-control" id="company_tel" name="company_tel" value="${company.company_tel}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="company_email" class="col-form-label">이메일</label>
                                        <input type="email" class="form-control" id="company_email" name="company_email" value="${company.company_email}" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="company_address" class="col-form-label">주소</label>
                                        <input type="text" class="form-control" id="company_address" name="company_address" value="${company.company_address}" required />
                                    </div>
                                    <div class="d-flex justify-content-end mt-3">
                                        <form action="${pageContext.request.contextPath}/company/delete/${company.company_code}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger me-2" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</button>
                                        </form>
                                        <a href="${pageContext.request.contextPath}/company/companyList" class="btn btn-secondary">목록으로</a>
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
    <script src="${pageContext.request.contextPath}/resources/js/core/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
