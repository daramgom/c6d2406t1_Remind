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
            justify-content: flex-end;
            margin-top: 1rem;
        }
        .search-container {
            width: 300px;
            max-width: 100%;
            margin-left: auto;
        }
        .input-group {
            width: 100%;
        }
        #searchInput {
            width: 70%;
        }
        #searchButton {
            width: 30%;
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
        }
        #searchInput {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
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
                    <h3 class="fw-bold mb-3">창고 지도</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="search-container mb-3">
                                    <div class="input-group">
                                        <input type="text" id="searchInput" class="form-control" placeholder="창고 이름 검색">
                                        <button id="searchButton" class="btn btn-primary">검색</button>
                                    </div>
                                </div>
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

    <!-- 카카오 앱 키  -->
    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=7dc432479314390de8962dfc3739f2f5"></script>

    <script>
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.978),
            level: 5
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var markers = []; // 모든 마커를 저장할 배열

        fetch('${pageContext.request.contextPath}/warehouse/getAllWarehouses')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.length > 0) {
                    data.forEach(function(warehouse) {
                        var position = new kakao.maps.LatLng(warehouse.latitude, warehouse.longitude);
                        var marker = new kakao.maps.Marker({
                            position: position,
                            title: warehouse.wh_name
                        });
                        marker.setMap(map);

                        // 마커 정보를 저장
                        markers.push({
                            marker: marker,
                            name: warehouse.wh_name
                        });

                        kakao.maps.event.addListener(marker, 'click', function() {
                            alert('창고 이름: ' + warehouse.wh_name);
                        });
                    });
                }
            })
            .catch(error => console.error('Error:', error));

        // 검색 기능 구현
        document.getElementById('searchButton').addEventListener('click', function() {
            var searchTerm = document.getElementById('searchInput').value.toLowerCase();
            var found = false;

            markers.forEach(function(markerInfo) {
                if (markerInfo.name.toLowerCase().includes(searchTerm)) {
                    // 검색어와 일치하는 마커를 찾으면 해당 위치로 지도 이동
                    map.setCenter(markerInfo.marker.getPosition());
                    map.setLevel(3); // 줌 레벨 설정
                    found = true;
                    alert('찾은 창고: ' + markerInfo.name);
                }
            });

            if (!found) {
                alert('검색 결과가 없습니다.');
            }
        });
    </script>
</body>
</html>