<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>아이티윌 팀프로젝트</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="./resources/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="./resources/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["./resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>
    
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #e9ecef;
        margin: 0;
        padding: 20px;
    }
    header {
        background: #001f3f; /* 남색 */
        padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
        border-radius: 5px;
    }
    main {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
        max-width: 800px; /* 최대 너비 설정 */
        margin-left: auto; /* 가운데 정렬 */
        margin-right: auto; /* 가운데 정렬 */
    }
    h2 {
        border-bottom: 2px solid #001f3f; /* 남색 */
        padding-bottom: 10px;
        color: #001f3f; /* 남색 */
        font-size: 24px; /* 제목 크기 조정 */
    }
    .form-container {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
    }
    .form-group {
        display: flex;
        flex-direction: column;
    }
    label {
        margin-top: 15px;
        font-weight: bold;
        color: #333;
    }
    input, textarea {
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        transition: border-color 0.3s;
    }
    input:focus, textarea:focus {
        border-color: #001f3f; /* 남색 */
        outline: none;
    }
    button {
        grid-column: span 2; /* 버튼을 두 열에 걸치게 함 */
        margin-top: 20px;
        padding: 10px;
        background: #001f3f; /* 남색 */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background 0.3s;
    }
    button:hover {
        background: #001a33; /* 남색의 어두운 색 */
    }

    /* 새로운 스타일 추가 */
    .underline-container {
        position: relative; /* 포지션 설정 */
        display: inline-block; /* 인라인 블록으로 변경 */
    }
    .underline-input {
        border: none; /* 테두리 제거 */
        outline: none; /* 포커스 시 테두리 제거 */
        padding: 5px 0; /* 패딩 조정 */
        background-color: transparent; /* 배경 투명 */
        width: auto; /* 너비 자동 */
        min-width: 60px; /* 최소 너비 설정 */
    }
    .custom-underline {
        position: absolute;
        bottom: 0; /* 아래에 위치 */
        left: 0; /* 왼쪽에 위치 */
        height: 2px; /* 두께 설정 */
        background-color: navy; /* 남색 */
        width: calc(5ch); /* 3글자 길이만큼 설정 */
    }
</style>
<script>
        function fetchOrderDate() {
            const ordNumber = document.getElementById('ord_number').value;
            if (ordNumber) {
                fetch('/getOrderDate?ord_number=' + ordNumber)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('ord_date').value = data.ord_date || '';
                    })
                    .catch(error => console.error('Error:', error));
            } else {
                document.getElementById('ord_date').value = ''; // 입력이 없을 경우 초기화
            }
        }
    </script>
    
    <!-- 모달 -->
	<style>
	    .modal-content {
	    background-color: #fefefe;
	    margin: 5% auto; 
	    padding: 20px;
	    border: 1px solid #888;
	    width: 60%; /* 너비 조정 */
	    max-width: 500px; /* 최대 너비 설정 */
	    border-radius: 8px; /* 모서리 둥글게 */
	}
	
	.modal {
	    display: none; 
	    position: fixed; 
	    z-index: 1; 
	    left: 0;
	    top: 0;
	    width: 100%; 
	    height: 100%; 
	    overflow: auto; 
	    background-color: rgba(0, 0, 0, 0.5); /* 배경 색상 조정 */
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 24px; /* 크기 조정 */
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	    color: #000; /* 호버 시 색상 변경 */
	    text-decoration: none;
	    cursor: pointer;
	}

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }

    
    </style>
    
    <!-- 발주관리번호 -->
       <style>
        .dropdown {
            display: none;
            border: 1px solid #ccc;
            max-height: 150px;
            overflow-y: auto;
            position: absolute;
            background: white;
            z-index: 1000;
        }
        .dropdown div {
            padding: 8px;
            cursor: pointer;
        }
        .dropdown div:hover {
            background-color: #f0f0f0;
        }
    </style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>입고 대기 목록</title>
    <!-- CSS Files -->
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="./resources/css/plugins.min.css" />
    <link rel="stylesheet" href="./resources/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="./resources/css/demo.css" />
  </head>
  <body>
    <div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />
		
        <div class="container">
          <div class="page-inner">

<main>
    <h2>출고 요청</h2>
    <form action="/shpRQ" id="ShippingForm" method="post" onsubmit="return confirmSubmission()">
        <div class="form-container">
            <div class="form-group">
                <label for="ord_manager_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주 요청자
                </label>
                <div class="underline-container">
                    <input type="text" id="ord_manager_id" class="underline-input" placeholder="홍길동" required name="ord_manager_id">
                    <div class="custom-underline"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="ord_supervisor_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주 승인자
                </label>
                <div class="underline-container">
                    <input type="text" id="ord_supervisor_id" class="underline-input" placeholder="홍길동" required name="ord_supervisor_id">
                    <div class="custom-underline"></div>
                </div>
            </div>
            
                        <div class="form-group">
                <label for="shp_manager_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고 요청자
                </label>
                <div class="underline-container">
                    <input type="text" id="shp_manager_id" class="underline-input" placeholder="홍길동" required name="shp_manager_id">
                    <div class="custom-underline"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="shp_supervisor_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고 승인자
                </label>
                <div class="underline-container">
                    <input type="text" id="shp_supervisor_id" class="underline-input" placeholder="홍길동" required name="shp_supervisor_id">
                    <div class="custom-underline"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="ord_number">발주 관리 번호</label>
                <div style="display: flex; align-items: center;">
                    <input type="text" id="ord_number" placeholder="발주 관리 번호 입력" required onfocus="showOrderList()" oninput="fetchOrderData()" name="ord_number">
                    <button type="button" onclick="submitOrderNumber()">조회</button>
                </div>
                <div class="dropdown" id="orderDropdown"></div>
            </div>

            <div class="form-group">
                <label for="prod_id">제품 식별코드</label>
                <input type="text" id="prod_id" placeholder="제품 식별 코드를 입력" required name="prod_id">
            </div>

            <div class="form-group">
                <label for="prod_category">카테고리</label>
                <input type="text" id="prod_category" required name="prod_category">
            </div>

            <div class="form-group">
                <label for="prod_name">품목명</label>
                <input type="text" id="prod_name" required name="prod_name">
            </div>

            <div class="form-group">
                <label for="company_code">거래처</label>
                <input type="text" id="company_code" required name="company_code">
            </div>

            <div class="form-group">
                <label for="shp_quantity">출고 수량</label>
                <input type="number" id="shp_quantity" required name="shp_quantity">
            </div>

            <div class="form-group">
                <label for="shp_price">가격(단가)</label>
                <input type="text" id="shp_price" required name="shp_price">
            </div>

            <div class="form-group">
                <label for="shp_date">출고 날짜</label>
                <input type="date" id="shp_date" required name="shp_date">
            </div>

            <!-- 창고 번호 및 이름 입력 필드 -->
            <div class="form-group">
                <label for="wh_number">창고 번호</label>
                <input type="text" id="wh_number" placeholder="창고 번호 입력" required name="wh_number">
            </div>

            <div class="form-group">
                <label for="wh_name">창고 이름</label>
                <input type="text" id="wh_name" placeholder="창고 이름 입력" required name="wh_name">
            </div>

            <!-- 비고 필드, 마지막으로 이동 -->
            <div class="form-group">
                <label for="shp_remarks">비고</label>
                <textarea id="shp_remarks" placeholder="전달할 내용..." required name="shp_remarks"></textarea>
            </div>
 <c:if test="${sessionScope.id == 'user1'}">
            <button class="btn btn-primary" type="submit">출고 요청</button>
 </c:if>
        </div>
    </form>
    
       
   </div>
	<!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	</div>
    

    <script>
        const orderNumbers = ['ORD-2024-0001', 'ORD-2024-0005', 'ORD-2024-0006', 'ORD004']; // 예시 발주 번호 목록

        function showOrderList() {
            const dropdown = document.getElementById('orderDropdown');
            dropdown.innerHTML = ''; // 기존 목록 초기화
            dropdown.style.display = 'block'; // 드롭다운 표시
            
            orderNumbers.forEach(order => {
                const div = document.createElement('div');
                div.textContent = order;
                div.onclick = () => selectOrder(order); // 클릭 시 발주 번호 선택
                dropdown.appendChild(div);
            });
        }

        function selectOrder(order) {
            document.getElementById('ord_number').value = order; // 입력란에 선택한 발주 번호 넣기
            document.getElementById('orderDropdown').style.display = 'none'; // 드롭다운 숨기기
            fetchProductByOrderNumber(order); // 발주번호에 대한 제품 정보 요청
        }

        function fetchProductByOrderNumber(orderNumber) {
            return fetch(`/getShippingProductByOrderNumber?ord_number=` + orderNumber)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('prod_id').value = data.prod_id; // 제품 식별 코드 자동 입력
                    document.getElementById('prod_category').value = data.prod_category; // 제품 카테고리 자동 입력
                    document.getElementById('company_code').value = data.company_code; // 거래처 자동 입력
                    document.getElementById('prod_name').value = data.prod_name; // 품목명 자동 입력
                    document.getElementById('shp_price').value = data.ord_price; // 가격(단가) 자동 입력
                    
                    // 발주 승인자 및 요청자 이름 자동 입력
                    document.getElementById('ord_supervisor_id').value = data.ord_supervisor_name; // 발주 승인자 이름 자동 입력
                    document.getElementById('ord_manager_id').value = data.ord_manager_name; // 발주 요청자 이름 자동 입력
                    
                    // 창고 번호 및 이름 자동 입력
                    document.getElementById('wh_number').value = data.wh_number; // 창고 번호 자동 입력
                    document.getElementById('wh_name').value = data.wh_name; // 창고 이름 자동 입력
                    
                    // 오늘 날짜 자동 입력
                    document.getElementById('shp_date').value = new Date().toISOString().split('T')[0]; // 오늘 날짜 자동입력
                })
                .catch(error => console.error('Error fetching product details:', error));
        }

        function fetchOrderData() {
            const input = document.getElementById('ord_number').value.toLowerCase();
            const dropdown = document.getElementById('orderDropdown');
            dropdown.innerHTML = ''; // 기존 목록 초기화
            
            const filteredOrders = orderNumbers.filter(order => order.toLowerCase().includes(input));
            filteredOrders.forEach(order => {
                const div = document.createElement('div');
                div.textContent = order;
                div.onclick = () => selectOrder(order);
                dropdown.appendChild(div);
            });

            // 필터링된 결과가 없으면 드롭다운 숨김
            dropdown.style.display = filteredOrders.length > 0 ? 'block' : 'none';
        }

        // 클릭 시 드롭다운 숨기기 (입력 외부 클릭 시)
        document.addEventListener('click', (event) => {
            const dropdown = document.getElementById('orderDropdown');
            const input = document.getElementById('ord_number');
            if (!input.contains(event.target) && !dropdown.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
        
        function submitOrderNumber() {
            const ord_number = document.getElementById('ord_number').value;
            if (ord_number) {
                fetchProductByOrderNumber(ord_number)
                    .then(() => {
                        // 제품 정보를 성공적으로 가져온 후 폼 제출
                        document.getElementById('ShippingForm').submit();
                    });
            } else {
                alert("발주 관리번호를 입력하세요.");
            }
        }
    </script>
    
    <script type="text/javascript">
        function confirmSubmission() {
            const confirmation = confirm("확인을 누르면 출고 요청이 완료됩니다.");
            return confirmation; // 확인하면 true, 아니면 false
        }
    </script>
</main>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
