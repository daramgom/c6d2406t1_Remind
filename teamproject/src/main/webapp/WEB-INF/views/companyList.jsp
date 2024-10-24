<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>거래처 목록</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <style>
        /* 테이블 헤더 배경색 */
        #multi-filter-select thead th {
            background-color: #0d6efd; /* 원하는 색상으로 변경 */
            color: white;
        }
    </style>

    <!-- Fonts and icons -->
    <script src="/resources/js/plugin/webfont/webfont.min.js"></script>
    <script>
        WebFont.load({
            google: {
                families: ["Public Sans:300,400,500,600,700"]
            },
            custom: {
                families: ["Font Awesome 5 Solid", "Font Awesome 5 Regular", "Font Awesome 5 Brands", "simple-line-icons"],
                urls: ["/resources/css/fonts.min.css"],
            },
            active: function() {
                sessionStorage.fonts = true;
            },
        });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>

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
                    <h3 class="fw-bold mb-3">거래처 목록</h3>
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
                            <a href="#">거래처 목록</a>
                        </li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h4 class="card-title">거래처 목록</h4>
                                <c:if test="${sessionScope.permission_id == '03'}">
                                    <a href="${pageContext.request.contextPath}/company/companyInsert" class="btn btn-primary">거래처 등록</a>
                                </c:if>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="multi-filter-select" class="display table table-hover">
                                        <thead>
                                            <tr>
                                                <th>거래처 코드</th>
                                                <th>거래처 이름</th>
                                                <th>실무자</th>
                                                <th>전화번호</th>
                                                <th>이메일</th>
                                                <th>주소</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>거래처 코드</th>
                                                <th>거래처 이름</th>
                                                <th>실무자</th>
                                                <th>전화번호</th>
                                                <th>이메일</th>
                                                <th>주소</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:forEach var="company" items="${companyList}">
                                                <tr>
                                                    <td>${company.company_code}</td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/company/view/${company.company_code}">
                                                            ${company.company_name}
                                                        </a>
                                                    </td>
                                                    <td>${company.company_manager}</td>
                                                    <td>${company.company_tel}</td>
                                                    <td>${company.company_email}</td>
                                                    <td>${company.company_address}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
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
    <script src="/resources/js/core/jquery-3.7.1.min.js?ver=1.0"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function() {
            // 데이터테이블 초기화
            $("#multi-filter-select").DataTable({
                pageLength: 10, // 기본 페이지 길이
                lengthMenu: [3, 10, 20, 50, 100, 500], // 페이지 길이 옵션
                searching: true, // 검색 기능 활성화
                ordering: true // 정렬 기능 활성화
            });
        });
    </script>
</body>
</html>
