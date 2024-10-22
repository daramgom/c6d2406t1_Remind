<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>창고 목록</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <style>
        /* 테이블 헤더 배경색 */
        #multi-filter-select thead th {
            background-color: #0d6efd;
            color: white;
        }
    </style>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>

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
                    <h3 class="fw-bold mb-3">창고 목록</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h4 class="card-title">창고 목록</h4>
                                <a href="${pageContext.request.contextPath}/warehouse/wareHouseInsert" class="btn btn-primary">창고 추가</a>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="multi-filter-select" class="display table table-hover">
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>창고 이름</th>
                                                <th>위치</th>
                                                <th>등록 사용자</th>
                                                <th>수정 사용자</th>
                                            </tr>
                                        </thead>
                                        <tbody id="warehouse-table-body">
                                            <c:forEach var="warehouse" items="${warehouseList}">
                                                <tr class="warehouse-row">
                                                    <td>${warehouse.wh_number}</td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/warehouse/view?wh_number=${warehouse.wh_number}">
                                                            ${warehouse.wh_name}
                                                        </a>
                                                    </td>
                                                    <td>${warehouse.wh_location}</td>
                                                    <td>${warehouse.wh_reguser}</td>
                                                    <td>${warehouse.wh_updateuser}</td>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function() {
            // 데이터테이블 초기화
            $("#multi-filter-select").DataTable({
                pageLength: 10, // 기본 페이지 길이 (3개씩 표시)
                lengthMenu: [3, 10, 20, 50, 100, 500] // 사용자가 선택할 수 있는 페이지 길이 옵션
            });
        });
    </script>
</body>
</html>