<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>창고 지도</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <style>
        /* 테이블 헤더 배경색 */
        #map {
            width: 100%;
            height: 500px;
        }
        #multi-filter-select thead th {
            background-color: #0d6efd;
            color: white;
        }
        .button-container {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            margin-top: 1rem; /* 위쪽 여백 */
        }
    </style>

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
                    <h3 class="fw-bold mb-3">창고 지도</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div id="map"></div>
                                <!-- 창고 목록으로 가는 버튼 추가 -->
                                <div class="button-container">
                                    <a href="${pageContext.request.contextPath}/warehouse/wareHouseList" class="btn btn-primary">창고 목록으로 가기</a>
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
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=7dc432479314390de8962dfc3739f2f5"></script>

    <script>
        // 지도 초기화
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.978), // 초기 중심 좌표
            level: 5 // 확대 레벨
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 창고 데이터 가져오기
        fetch('${pageContext.request.contextPath}/warehouse/getAllWarehouses')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // 초기 마커를 추가하지 않음
                // 데이터가 있을 경우에만 마커를 추가
                if (data.length > 0) {
                    data.forEach(function(warehouse) {
                        var position = new kakao.maps.LatLng(warehouse.latitude, warehouse.longitude);
                        var marker = new kakao.maps.Marker({
                            position: position,
                            title: warehouse.wh_name
                        });
                        marker.setMap(map); // 마커를 지도에 추가

                        // 클릭 이벤트 추가
                        kakao.maps.event.addListener(marker, 'click', function() {
                            alert('창고 이름: ' + warehouse.wh_name);
                        });
                    });
                }
            })
            .catch(error => console.error('Error:', error));
    </script>
</body>
</html>
