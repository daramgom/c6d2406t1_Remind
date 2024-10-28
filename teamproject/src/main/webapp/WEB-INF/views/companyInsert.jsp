<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>REMIND</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
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
                    <h3 class="fw-bold mb-3">거래처관리</h3>
                    <ul class="breadcrumbs mb-3">
                        <li class="nav-home"><i class="icon-home"></i></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item">거래처관리</li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item">거래처등록</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">거래처등록</div>
                            </div>

                            <div class="card-body d-flex flex-column align-items-center">
                                <div class="row">
                                    <div class="col-md-6 col-lg-12">
                                        <form id="companyForm" action="" method="post">
                                            <div class="form-group d-flex" style="gap: 20px;">
                                                <div style="flex: 1;">
                                                    <label for="company_code" class="col-form-label" style="font-size: 1.5rem;">거래처 코드</label>
                                                    <input type="text" class="form-control input-full" id="company_code" name="company_code" placeholder="거래처 코드" required />
                                                </div>
                                                <div style="flex: 1;">
                                                    <label for="company_name" class="col-form-label">거래처 이름</label>
                                                    <input type="text" class="form-control input-full" id="company_name" name="company_name" placeholder="거래처 이름" required />
                                                </div>
                                            </div>
                                            <div class="form-group d-flex" style="gap: 20px;">
                                                <div style="flex: 1;">
                                                    <label for="company_manager" class="col-form-label">실무자</label>
                                                    <input type="text" class="form-control input-full" id="company_manager" name="company_manager" placeholder="실무자" required />
                                                </div>
                                                <div style="flex: 1;">
                                                    <label for="company_tel" class="col-form-label">전화번호</label>
                                                    <input type="text" class="form-control input-full" id="company_tel" name="company_tel" placeholder="전화번호" required />
                                                </div>
                                            </div>
                                            <div class="form-group d-flex" style="gap: 20px;">
                                                <div style="flex: 1;">
                                                    <label for="company_email" class="col-form-label">이메일</label>
                                                    <input type="email" class="form-control input-full" id="company_email" name="company_email" placeholder="이메일" required />
                                                </div>
                                                <div style="flex: 1;">
                                                    <label for="company_address" class="col-form-label">주소</label>
                                                    <input type="text" class="form-control input-full" id="company_address" name="company_address" placeholder="주소" required />
                                                </div>
                                            </div>
                                            <div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
                                                <button type="submit" class="btn btn-secondary">거래처 등록</button>
                                                <button type="button" class="btn btn-danger" id="alert_demo_7">입력 초기화</button>
                                            </div>
                                        </form>
                                    </div>
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

    
    <script type="text/javascript">
        $(document).ready(function () {
            // 입력 초기화 버튼 클릭 이벤트
            $("#alert_demo_7").click(function () {
               if (confirm("입력값을 초기화하시겠습니까?")) {
                    $('input, textarea').val(''); // 입력 필드 비우기
                    alert("모든 입력값이 초기화되었습니다.");
                }
            });
        });
    </script>
</body>
</html>
