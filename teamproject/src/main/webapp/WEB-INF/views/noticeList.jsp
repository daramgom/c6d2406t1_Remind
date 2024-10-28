<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록</title>
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
        .pinned {
            font-weight: bold; /* 핀된 항목 스타일 */
        }
    </style>

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
	<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />
    <!-- DataTables CSS -->
    

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
                    <h3 class="fw-bold mb-3">공지사항 목록</h3>
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
                            <a href="#">공지사항 목록</a>
                        </li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h4 class="card-title">공지목록</h4>
                                <c:if test="${sessionScope.permission_id == '03'}">
                                    <a href="${pageContext.request.contextPath}/notice/noticeInsert" class="btn btn-primary">글쓰기</a>
                                </c:if>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="multi-filter-select" class="display table table-hover">
                                        <thead>
                                            <tr>
                                                <th>번호</th>
                                                <th>제목</th>
                                                <th>작성일자</th>
                                                <th>작성자</th>
                                            </tr>
                                        </thead>
                                        <tfoot>
                                            <tr>
                                                <th>번호</th>
                                                <th>제목</th>
                                                <th>작성일자</th>
                                                <th>작성자</th>
                                            </tr>
                                        </tfoot>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty noticeList}">
                                                    <c:forEach var="n" items="${noticeList}">
                                                        <c:choose>
                                                            <c:when test="${n.pinned}">
                                                                <tr class="pinned">
                                                                    <td>${n.no}</td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/notice/view?no=${n.no}">
                                                                            ${n.title}
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${not empty n.regdate}">
                                                                                <fmt:formatDate value="${n.regdate}" pattern="yyyy.MM.dd" />
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                -
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${n.writer}</td>
                                                                </tr>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>

                                                    <c:forEach var="n" items="${noticeList}">
                                                        <c:choose> 
                                                            <c:when test="${!n.pinned}">
                                                                <tr>
                                                                    <td>${n.no}</td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/notice/view?no=${n.no}">
                                                                            ${n.title}
                                                                        </a>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${not empty n.regdate}">
                                                                                <fmt:formatDate value="${n.regdate}" pattern="yyyy.MM.dd" />
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                -
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${n.writer}</td> 
                                                                </tr>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td colspan="4" class="text-center">등록된 공지사항이 없습니다.</td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
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
                lengthMenu: [3, 10, 20, 50, 100, 500], // 페이지 길이 옵션
                searching: true, // 검색 기능 활성화
                ordering: true, // 정렬 기능 활성화
                order: [], // 기본 정렬 초기화
                columns: [
                    { data: 'no' },
                    { data: 'title' },
                    { data: 'regdate' },
                    { data: 'writer' }
                ],
                language: {
                    emptyTable: "등록된 공지사항이 없습니다."
                }
            });
        });
    </script>
</body>
</html>