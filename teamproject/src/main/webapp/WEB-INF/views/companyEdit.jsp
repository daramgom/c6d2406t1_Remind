<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />
</head>
<body>
    <!--퍼미션 아이디 03일때만 접속가능 다른 아이디면 메인페이지로 -->
    <c:if test="${empty sessionScope.id || sessionScope.permission_id != '03'}">
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
                    <h3 class="fw-bold mb-3">거래처 수정</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="card-title">거래처 수정</div>
                                <button type="submit" form="companyEditForm" class="btn btn-success">수정</button>
                            </div>

                            <div class="card-body">
                                <form id="companyEditForm" action="${pageContext.request.contextPath}/company/edit" method="post">
                                    <!-- CSRF 토큰 추가 (Spring MVC 사용 시) -->
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    
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
                                        <button type="button" class="btn btn-danger me-2" onclick="deleteCompany('${company.company_code}')">삭제</button>
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


    <script>
    function deleteCompany(companyCode) {
        if(confirm('정말로 삭제하시겠습니까?')) {
            $.ajax({
                url: '${pageContext.request.contextPath}/company/delete/' + companyCode,
                type: 'POST',
                success: function(response) {
                    alert('거래처가 삭제되었습니다.');
                    window.location.href = '${pageContext.request.contextPath}/company/companyList';
                },
                error: function(xhr, status, error) {
                    alert('삭제 중 오류가 발생했습니다.');
                }
            });
        }
    }
    </script>
</body>
</html>