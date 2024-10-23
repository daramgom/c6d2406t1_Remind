<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>아이티윌 팀프로젝트</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="./resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

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

<!-- <script>
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
    </script> -->


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

.close:hover, .close:focus {
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

<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

/* 슬라이드 스타일 */
.slide-container {
	position: fixed;
	top: 0;
	right: -400px; /* 초기 위치는 화면 밖 */
	width: 400px;
	height: 100%;
	background: white;
	box-shadow: -2px 0 10px rgba(0, 0, 0, 0.5);
	transition: right 0.3s ease;
	z-index: 1000;
	padding: 20px;
	overflow-y: auto;
}

.slide-container.active {
	right: 0; /* 슬라이드가 보일 때 위치 */
}

/* 닫기 버튼 스타일 */
.close-btn {
	cursor: pointer;
	color: #001f3f;
	font-size: 20px;
	margin-bottom: 20px;
}

.close-btn:hover {
	color: #d9534f;
}

/* 제목 스타일 */
h2 {
	color: #001f3f;
	border-bottom: 2px solid #001f3f;
	padding-bottom: 10px;
}

/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 테이블에 그림자 추가 */
	border-radius: 8px; /* 모서리 둥글게 */
	overflow: hidden; /* 경계선이 둥글어지도록 */
}

th, td {
	padding: 12px 15px; /* 패딩을 좀 더 여유롭게 */
	text-align: left;
	border: 1px solid #ddd;
}

th {
	background-color: #f5f5f5; /* 부드러운 회색 */
	color: #333; /* 텍스트 색상 */
	font-weight: bold;
	text-transform: uppercase; /* 대문자 변환 */
}

td {
	background-color: #fff; /* 데이터 셀 배경 */
	color: #555; /* 데이터 텍스트 색상 */
}

/* 호버 효과 */
tbody tr:hover {
	background-color: #f0f8ff; /* 호버 시 부드러운 파란색 */
}

/* 테이블의 첫 번째 열 강조 */
td:first-child {
	font-weight: bold; /* 첫 번째 열 강조 */
}

/* 반응형 디자인 */
@media ( max-width : 600px) {
	th, td {
		padding: 10px; /* 작은 화면에서 패딩 조정 */
	}
}

/* 슬라이드 패널 스타일 */
#slidePanel {
	display: none;
	position: fixed;
	z-index: 1000;
	right: 0;
	top: 95px;
	width: 740px;
	height: calc(100% - 60px);
	background-color: #fff;
	box-shadow: -2px 0 5px rgba(0, 0, 0, 0.3);
	transition: transform 0.3s ease;
	transform: translateX(100%);
}

#slidePanel.open {
	display: block;
	transform: translateX(0);
}

/* 폼 스타일 */
.form-container {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 8px; /* 간격 조정 */
	max-width: 700px; /* 최대 너비 설정 */
	margin: 0 auto; /* 가운데 정렬 */
}

.form-group {
	display: flex;
	flex-direction: column;
}

label {
	margin-top: 5px; /* 간격 줄이기 */
	font-weight: bold;
	color: #333;
}

input, textarea {
	padding: 6px; /* 패딩 줄이기 */
	margin-top: 3px;
	border: 1px solid #ccc;
	border-radius: 4px;
	transition: border-color 0.3s;
	font-size: 14px; /* 폰트 크기 조정 */
}

input:focus, textarea:focus {
	border-color: #001f3f;
	outline: none;
}

/* 버튼 그룹 스타일 */
.button-group {
	grid-column: span 2;
	display: flex;
	justify-content: space-between;
	margin-top: 10px; /* 간격 조정 */
}

/* 버튼 스타일 */
button {
	padding: 8px; /* 패딩 줄이기 */
	background: #001f3f;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px; /* 폰트 크기 조정 */
	transition: background 0.3s;
}

button:hover {
	background: #001a33;
}

/* 새로운 스타일 추가 */
.underline-container {
	position: relative;
	display: inline-block;
}

.underline-input {
	border: none;
	outline: none;
	padding: 5px 0;
	background-color: transparent;
	width: auto;
	min-width: 60px;
}

.custom-underline {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 2px;
	background-color: navy;
	width: calc(5ch);
}

/* 반응형 디자인 */
@media ( max-width : 600px) {
	table, thead, tbody, th, td, tr {
		display: block;
	}
	th {
		display: none;
	}
	tr {
		margin-bottom: 15px;
	}
	td {
		text-align: right;
		padding-left: 50%;
		position: relative;
	}
	td::before {
		content: attr(data-label);
		position: absolute;
		left: 10px;
		width: 45%;
		padding-right: 10px;
		white-space: nowrap;
		text-align: left;
		font-weight: bold;
	}
}

/* 검색 박스 스타일 */
.search-box {
	width: 220px; /* 박스 너비 조정 */
	padding: 10px; /* 패딩 추가 */
	background-color: rgba(255, 255, 255, 0.8); /* 반투명 흰색 배경 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 8px; /* 둥근 모서리 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
	position: absolute; /* 화면 왼쪽에 고정 */
	left: 20px; /* 왼쪽 여백 */
	top: 80px; /* 상단 여백 (테이블 시작점에 맞춤) */
	margin-bottom: 20px; /* 아래쪽 간격 추가 */
}

/* 검색 폼 스타일 */
.search-form {
	display: flex;
	align-items: center; /* 수직 중앙 정렬 */
	gap: 6px; /* 요소 간격 조정 */
	margin-bottom: 7px; /* 아래쪽 간격 추가 */
}

.search-form label {
	font-weight: bold; /* 레이블 강조 */
}

.search-form select {
	padding: 4px; /* 패딩 조정 */
	border: 1px solid #ccc; /* 테두리 스타일 */
	border-radius: 4px; /* 둥근 모서리 */
	font-size: 12px; /* 폰트 크기 조정 */
	transition: border-color 0.3s; /* 포커스 시 테두리 색상 변화 */
}

.search-form select:focus {
	border-color: #007bff; /* 포커스 시 색상 변경 */
	outline: none; /* 기본 아웃라인 제거 */
}

.search-button {
	padding: 6px 10px; /* 패딩 조정 */
	background: #cccccc; /* 회색 버튼 배경색 */
	color: white; /* 텍스트 색상 */
	border: none; /* 테두리 제거 */
	border-radius: 4px; /* 둥근 모서리 */
	cursor: pointer; /* 포인터 커서 */
	font-size: 12px; /* 폰트 크기 조정 */
	transition: background 0.3s; /* 배경색 변화 */
}

.search-button:hover {
	background: #999999; /* 호버 시 색상 변경 */
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

<!-- 출고 요청 목록 -->
<!-- 출고 요청 목록 -->
<h1>출고 요청 목록</h1>
<div class="form-container1">
    <form action="/searchShipping" method="GET" class="search-form">
        <label for="status">출고 상태:</label>
        <select id="status" name="shp_status">
            <option value="">모두</option>
            <option value="01" selected="selected">출고 요청</option>
            <option value="02">출고 완료</option>
            <option value="03">출고 반려</option>
            <option value="04">출고 삭제</option>
        </select>
        <input type="submit" value="검색" class="search-button">
    </form>
</div>
<table>
    <tr>
        <th>번호</th>
        <th>출고 요청자</th>
        <th>출고 관리 번호</th>
        <th>제품 ID</th>
        <th>품목명</th>
        <th>출고 수량</th>
        <th>출고 가격</th>
        <th>출고 날짜</th>
        <th>비고</th>
    </tr>

    <c:forEach var="item" items="${shippingList}" varStatus="idx">
        <tr onclick="showShippingDetails('${item.shp_manager_id}', '${item.shp_supervisor_id}','${ordersList[idx.index].ord_manager_name}', '${ordersList[idx.index].ord_supervisor_name}', '${item.ord_number}', '${item.shp_number}', '${item.prod_id}', '${item.prod_name}','${item.company_code}', '${item.shp_quantity}', '${item.wh_number}','${item.shp_price}', '${item.shp_date}', '${item.shp_remarks}')">
            <td>${item.shp_count}</td>
            <td>${item.shp_manager_id}</td>
            <td>${item.shp_number}</td>
            <td>${item.prod_id}</td>
            <td>${item.prod_name}</td>
            <td>${item.shp_quantity}</td>
            <td>${item.shp_price}</td>
            <td>${item.shp_date}</td>
            <td>${item.shp_remarks}</td>
        </tr>
    </c:forEach>
</table>

<!-- 출고 요청 슬라이드 패널 -->
<div id="slidePanel" class="slide-container">
    <span class="close-btn" onclick="closePanel()">&times;</span>
    <h2>출고 요청</h2>
    <form id="ShippingForm" onsubmit="return confirmSubmission()">
        <div class="form-container">
            <div class="form-group">
           <label for="shpManagerId"> <img
		    src="${pageContext.request.contextPath}/resources/img/회원.png"
			alt="사람 아이콘"
			style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고
			요청자
			</label>
			<div class="underline-container">
			<input type="text" id="shpManagerId"
			class="underline-input" placeholder="홍길동" required
			name="shpManagerId">
			<div class="custom-underline"></div>
			</div>
            </div>
            
		   <div class="form-group">
		    <label for="shpSupervisorId">
		        <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘" style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">
		        출고 승인자
		    </label>
		    <div class="underline-container">
		        <input type="text" id="shpSupervisorId" class="underline-input" placeholder="홍길동" required name="shpSupervisorId">
		        <div class="custom-underline"></div>
		    </div>
		   </div>

			<div class="form-group">
			    <label for="ordManagerId">
			        <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘" style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">
			        발주 요청자
			    </label>
			    <div class="underline-container">
			        <input type="text" id="ordManagerId" class="underline-input" placeholder="홍길동" required name="ordManagerId">
			        <div class="custom-underline"></div>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="ordSupervisorId">
			        <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘" style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">
			        발주 승인자
			    </label>
			    <div class="underline-container">
			        <input type="text" id="ordSupervisorId" class="underline-input" placeholder="홍길동" required name="ordSupervisorId">
			        <div class="custom-underline"></div>
			    </div>
			</div>
            <div class="form-group">
                <label for="ordNumber">발주 관리번호</label>
                <input type="text" id="ordNumber" required name="ordNumber">
            </div>
            <div class="form-group">
                <label for="shpNumber">출고 관리번호</label>
                <input type="text" id="shpNumber" required name="shpNumber">
            </div>
            <div class="form-group">
                <label for="prodId">제품 식별코드</label>
                <input type="text" id="prodId" required name="prodId">
            </div>
            <div class="form-group">
                <label for="prodName">제품명</label>
                <input type="text" id="prodName" required name="prodName">
            </div>
            
			<div class="form-group">
				<label for="companyCode">거래처</label> <input type="text"
				id="companyCode" required name="companyCode">
			</div>
            
            <div class="form-group">
                <label for="shpQuantity">출고 수량</label>
                <input type="number" id="shpQuantity" required name="shpQuantity">
            </div>
            
            <div class="form-group">
			<label for="whNumber">창고 번호</label>
			 <input type="number" id="whNumber" required name="whNumber">
			</div>
            
            <div class="form-group">
                <label for="shpPrice">가격(단가)</label>
                <input type="text" id="shpPrice" required name="shpPrice">
            </div>
            <div class="form-group">
                <label for="shpDate">출고 날짜</label>
                <input type="date" id="shpDate" required name="shpDate">
            </div>
            <div class="form-group">
                <label for="shpRemarks">비고</label>
                <textarea id="shpRemarks" required name="shpRemarks"></textarea>
            </div>
            <div class="button-group">
            
              	<c:if test="${sessionScope.id == 'super1'}">
                <button type="button" onclick="saveShippingDetails()">출고 승인</button>
                <button type="button" onclick="rejectShipping()">출고 반려</button>
                </c:if>
                
                 <c:if test="${sessionScope.id == 'user1'}">
                <button type="button" onclick="editShippingDetails()">출고 수정</button>
                <button type="button" onclick="deleteShipping()">출고 삭제</button>
                </c:if>
            </div>
        </div>
    </form>
</div>


	<!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	</div>
	
<!-- 출고 모달 HTML -->
<div id="invoiceModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h3 style="text-align: center;">출고 명세서</h3>
        <table class="invoice-table">
            <tr>
                <th>항목</th>
                <th>내용</th>
            </tr>
            <tr>
                <td>출고 담당자</td>
                <td id="display_shp_manager_id">홍길동</td>
            </tr>
            <tr>
                <td>출고 관리번호</td>
                <td id="display_shp_number">123456</td>
            </tr>
            <tr>
                <td>제품 식별코드</td>
                <td id="display_prod_id">ABC123</td>
            </tr>
            <tr>
                <td>품목명</td>
                <td id="display_prod_name">제품명</td>
            </tr>
            <tr>
                <td>출고 수량</td>
                <td id="display_shp_quantity">10</td>
            </tr>
            <tr>
                <td>가격(단가)</td>
                <td id="display_shp_price">10000</td>
            </tr>
            <tr>
                <td>거래처</td>
                <td id="display_company_code">거래처명</td>
            </tr>
            <tr>
                <td>출고 날짜</td>
                <td id="display_shp_date">2024-01-01</td>
            </tr>
            <tr>
                <td>비고</td>
                <td id="display_shp_remarks">특이사항</td>
            </tr>
        </table>
	 <button type="button" onclick="closeModal()">확인</button>
	
	<script type="text/javascript">
	    function downloadExcel2() {
	        const shpManagerId = document.getElementById('display_shp_manager_id').innerText;
	        const shpNumber = document.getElementById('display_shp_number').innerText;
	        const prodId = document.getElementById('display_prod_id').innerText;
	        const prodName = document.getElementById('display_prod_name').innerText;
	        const shpQuantity = document.getElementById('display_shp_quantity').innerText;
	        const shpPrice = document.getElementById('display_shp_price').innerText;
	        const companyCode = document.getElementById('display_company_code').innerText;
	        const shpDate = document.getElementById('display_shp_date').innerText;
	        const shpRemarks = document.getElementById('display_shp_remarks').innerText;
	
	        const params = new URLSearchParams({
	            shpManagerId,
	            shpNumber,
	            prodId,
	            prodName,
	            shpQuantity,
	            shpPrice,
	            companyCode,
	            shpDate,
	            shpRemarks
	        });
	
	        // 엑셀 파일 다운로드 요청
	        window.location.href = '/downloadExcel2?' + params.toString();
	    }
	</script>
	
	<button onclick="downloadExcel2()" type="button">엑셀다운</button>
	


<script>
/**
 * 출고 세부 정보를 표시하는 함수
 */
function showShippingDetails(shpManagerName, shpSupervisorName, ordManagerName, ordSupervisorName, ordNumber, shpNumber, prodId, prodName, companyCode, shpQuantity, whNumber, shpPrice, shpDate, shpRemarks) {
    document.getElementById('slidePanel').classList.add('open');
    document.getElementById('shpManagerId').value = shpManagerName;
    document.getElementById('shpSupervisorId').value = shpSupervisorName;
    document.getElementById('ordManagerId').value = ordManagerName;
    document.getElementById('ordSupervisorId').value = ordSupervisorName;
    document.getElementById('ordNumber').value = ordNumber;
    document.getElementById('shpNumber').value = shpNumber;
/*     document.getElementById('prodCategory').value = prodCategory; */
    document.getElementById('prodId').value = prodId;
    document.getElementById('prodName').value = prodName;
    document.getElementById('companyCode').value = companyCode; 
    document.getElementById('shpQuantity').value = shpQuantity;
    document.getElementById('whNumber').value = whNumber;
    document.getElementById('shpPrice').value = shpPrice;
/*     document.getElementById('ordDate').value = ordDate; */
    document.getElementById('shpDate').value = shpDate;
    document.getElementById('shpRemarks').value = shpRemarks;
}

/**
 * 슬라이드 패널을 닫는 함수
 */
function closePanel() {
    document.getElementById('slidePanel').classList.remove('open');
}

/**
 * 제출 확인 메시지를 표시하는 함수
 */
function confirmSubmission() {
    return confirm("출고 요청을 제출하시겠습니까?");
}

/**
 * 출고 세부 정보를 저장하는 함수
 */
function saveShippingDetails() {
    const updatedData = {
        shp_manager_id: document.getElementById('shpManagerId').value,
        shp_supervisor_id: document.getElementById('shpSupervisorId').value,
        ord_manager_id: document.getElementById('ordManagerId').value,
        ord_supervisor_id: document.getElementById('ordSupervisorId').value,
        ord_number: document.getElementById('ordNumber').value,
        shp_number: document.getElementById('shpNumber').value,
        prod_id: document.getElementById('prodId').value,
        prod_name: document.getElementById('prodName').value,
        company_code: document.getElementById('companyCode').value,
        shp_quantity: document.getElementById('shpQuantity').value,
        wh_number: document.getElementById('whNumber').value,
        shp_price: document.getElementById('shpPrice').value,
        shp_date: document.getElementById('shpDate').value,
        shp_remarks: document.getElementById('shpRemarks').value
    };

    alert("저장중...");
    const url = '/updateShipping';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(updatedData)
    })
    .then(response => {
        if (response.ok) {
            if (confirm('출고가 완료되었습니다! 거래명세서를 확인하시겠습니까?')) {
                openModal();
            }
            closePanel();
        } else {
            throw new Error('업데이트 실패');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('업데이트 실패: ' + error.message);
    });
}

/**
 * 모달을 여는 함수
 */
 function openModal() {
	    document.getElementById('display_shp_manager_id').innerText = document.getElementById('shpManagerId').value;
	    document.getElementById('display_shp_number').innerText = document.getElementById('shpNumber').value;
	    document.getElementById('display_prod_id').innerText = document.getElementById('prodId').value;
	    document.getElementById('display_prod_name').innerText = document.getElementById('prodName').value;
	    document.getElementById('display_shp_quantity').innerText = document.getElementById('shpQuantity').value;
	    document.getElementById('display_shp_price').innerText = document.getElementById('shpPrice').value;
	    document.getElementById('display_company_code').innerText = document.getElementById('companyCode').value;
	    document.getElementById('display_shp_date').innerText = document.getElementById('shpDate').value;
	    document.getElementById('display_shp_remarks').innerText = document.getElementById('shpRemarks').value;

	    document.getElementById('invoiceModal').style.display = 'block';
	}

/**
 * 모달을 닫는 함수
 */
function closeModal() {
    document.getElementById('invoiceModal').style.display = 'none';
}

/**
 * 출고 요청을 반려하는 함수
 */
function rejectShipping() {
    const shpNumber = document.getElementById('shpNumber').value;
    const reason = prompt("반려 사유를 입력하세요:");

    if (reason) {
        const data = {
            shp_number: shpNumber,
            reason: reason,
            shp_status: '03'
        };

        fetch('/rejectShipping', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                alert('출고가 반려되었습니다!');
                closePanel();
            } else {
                throw new Error('반려 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('반려 실패: ' + error.message);
        });
    } else {
        alert("반려 사유를 입력해야 합니다.");
    }
}

/**
 * 출고 세부 정보를 수정하는 함수
 */
function editShippingDetails() {
    const updatedData = {
        shp_manager_id: document.getElementById('shpManagerId').value,
        shp_supervisor_id: document.getElementById('shpSupervisorId').value,
        ord_manager_id: document.getElementById('ordManagerId').value,
        ord_supervisor_id: document.getElementById('ordSupervisorId').value,
        ord_number: document.getElementById('ordNumber').value,
        shp_number: document.getElementById('shpNumber').value,
        prod_id: document.getElementById('prodId').value,
        prod_name: document.getElementById('prodName').value,
        shp_quantity: document.getElementById('shpQuantity').value,
        shp_price: document.getElementById('shpPrice').value,
        wh_number: document.getElementById('whNumber').value,
        company_code: document.getElementById('companyCode').value,
        shp_date: document.getElementById('shpDate').value,
        shp_remarks: document.getElementById('shpRemarks').value
    };

    alert("수정중...");
    fetch('/editShipping', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(updatedData)
    })
    .then(response => {
        if (response.ok) {
            alert('출고 정보가 수정되었습니다!');
            closePanel();
        } else {
            throw new Error('수정 실패');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('수정 실패: ' + error.message);
    });
}

/**
 * 출고 요청을 삭제하는 함수
 */
function deleteShipping() {
    const shpNumber = document.getElementById('shpNumber').value;
    const data = {
        shp_number: shpNumber,
        shp_status: '04'
    };

    if (confirm("정말로 삭제하시겠습니까?")) {
        fetch('/deleteShipping', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                alert('출고 요청이 삭제되었습니다!');
                closePanel();
            } else {
                throw new Error('삭제 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('삭제 실패: ' + error.message);
        });
    }
}

</script>


