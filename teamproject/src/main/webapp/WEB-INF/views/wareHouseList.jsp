<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>REMIND</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <style>
       #multi-filter-select thead th {
		background-color: #6861ce !important;
		color: white;
	}
    
	.table td {
		font-size: 1.2rem !important;
		text-align: center;
		white-space: nowrap;
	}
    
	.table th {
		font-size: 1.25rem !important;
		text-align: center;
		white-space: nowrap;
	}

	.modal-dialog {
		--bs-modal-width: 1200px;
	}

	.modal-content {
		height: 90vh;
		overflow-y: auto;
		overflow-x: hidden;
	}

	.modal-footer i {
		font-size: 1.2rem;
		line-height: 2;
	}
	
	.modal-footer button {
		font-size: 1.2rem;
		line-height: 2;
		margin-bottom: 10px;
		font-weight: bold;
	}

    </style>

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
                    <h3 class="fw-bold mb-3">창고관리</h3>
                     <ul class="breadcrumbs mb-3">
						<li class="nav-home"><i class="icon-home"></i></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item">창고관리</li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item">창고목록</li>
					</ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <div class="card-title">창고목록</div>
                                <!-- permission_id가 03일 때만 창고 추가 버튼 표시 -->
                                <c:if test="${sessionScope.permission_id == '03'}">
                                    <a href="${pageContext.request.contextPath}/warehouse/wareHouseInsert" class="btn btn-secondary">창고 추가</a>
                                </c:if>
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

    

    <script>
        $(document).ready(function() {
            // 데이터테이블 초기화
            $("#multi-filter-select").DataTable({
                pageLength: 10, // 기본 페이지 길이
                lengthMenu: [3, 10, 20, 50, 100, 500] // 페이지 길이 옵션
            });
        });
    </script>
</body>
</html>
 