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
            z-index: 9000;
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
  
  	  <c:if test="${empty sessionScope.id}">
	  <c:redirect url="/login"/>
	  </c:if>

	 <c:if test="${sessionScope.member_code != '1'}">
	 <c:redirect url="/cmain"/>
	 </c:if>
	
	
    <div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />

        <div class="container">
          <div class="page-inner">
          
          
          
<main>
    <h2>입고 요청</h2>
    <form action="/rcvRQ" id="ReceivingForm" method="post" onsubmit="return confirmSubmission()">
        <div class="form-container">
            <div class="form-group">
                <label for="RCV_MANAGER_ID">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">입고 요청자
                </label>
                <div class="underline-container">
                    <input type="text" id="rcv_manager_id" class="underline-input" placeholder="홍길동" required name="rcv_manager_id" value="${sessionScope.name }" readonly="readonly" >
                    <div class="custom-underline"></div>
                </div>
            </div>
            
             <div class="form-group">
                <label for="RCV_SUPERVISOR_ID">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">입고 승인자
                </label>
                <div class="underline-container">
                   <select id="rcv_supervisor_id" name="rcv_supervisor_id" required="required">
			<option value="" >선택하세요</option>
			<c:forEach var="r" items="${RsList }">
				<option value="${r.member_id}"> ${r.member_name} / ${r.department_name} / ${r.common_status} / ${r.member_tel }</option>
			</c:forEach>
		   </select>
                    <div class="custom-underline"></div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="ORD_MANAGER_ID">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주 요청자
                </label>
                <div class="underline-container">
                    <input type="text" id="ord_manager_id" class="underline-input" placeholder="홍길동" required name="ord_manager_id" readonly="readonly">
                    <div class="custom-underline"></div>
                </div>
            </div>
            
            
           <div class="form-group">
                <label for="ORD_SUPERVISOR_ID">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주 승인자
                </label>
                <div class="underline-container">
                    <input type="text" id="ord_supervisor_id" class="underline-input" placeholder="홍길동" required name="ord_supervisor_id" readonly="readonly">
                    <div class="custom-underline"></div>
                </div>
            </div>
           

			<div class="form-group">
			    <label for="ord_number">발주 관리번호</label>
			    <div style="display: flex; align-items: center;">
			        <input type="text" id="ord_number" placeholder="발주관리번호입력" required onfocus="showOrderList()" oninput="fetchOrderData()" name="ord_number">
			        <button type="button" onclick="submitOrderNumber()">조회</button> <!-- 추가된 버튼 -->
			    </div>
			    <div class="dropdown" id="orderDropdown"></div>
			</div>

            <div class="form-group">
                <label for="PROD_ID">제품 식별코드</label>
                <input type="text" id="prod_id" placeholder="제품식별코드를 입력" required name="prod_id">
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
                <label for="COMPANY_CODE">거래처</label>
                <input type="text" id="company_code" required name="company_code">
            </div>

            <div class="form-group">
                <label for="RCV_QUANTITY">입고 수량</label>
                <input type="number" id="rcv_quantity" required name="rcv_quantity">
            </div>
            
            <div class="form-group">
                <label for="WH_NUMBER">창고 번호</label>
                <input type="number" id="wh_number" required name="wh_number">
            </div>

            <div class="form-group">
                <label for="RCV_PRICE">가격(단가)</label>
                <input type="text" id="rcv_price" required name="rcv_price">
            </div>

            <div class="form-group">
                <label for="ORD_DATE">발주 날짜</label>
                <input type="date" id="ord_date" required name="ord_date">
            </div> 

            <div class="form-group">
                <label for="RCV_DATE">입고 날짜</label>
                <input type="date" id="rcv_date" required name="rcv_date">
            </div>

            <div class="form-group">
                <label for="RCV_REMARKS">비고</label>
                <textarea id="rcv_remarks" placeholder="전달 할 '내용' ..." required name="rcv_remarks"></textarea>
            </div>
            
 <c:if test="${ sessionScope.permission_id == '01'}">
            <button class="btn btn-primary" type="submit">입고 요청</button>
 </c:if>
        </div>
    </form>
    
   </div>
	<!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	</div>
    
    
    
    <!-- 발주관리번호 셀렉트박스,자동채우기 -->
    
     <script>
 
     // 서버에서 전달받은 발주 번호 목록
    const orderNumbers = ['ORD-2024-0001','ORD-2024-0002', 'ORD-2024-0003','ORD-2024-0004']; // 예시 발주 번호 목록

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
            return fetch(`/getProductByOrderNumber?ord_number=` + orderNumber)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    document.getElementById('prod_id').value = data.prod_id; // 제품 식별 코드 자동 입력
                    document.getElementById('prod_category').value = data.prod_category; // 제품 카테고리 자동입력
                    document.getElementById('company_code').value = data.company_code; // 거래처 자동입력
                    document.getElementById('prod_name').value = data.prod_name; // 품목명 자동입력
                    document.getElementById('rcv_price').value = data.ord_price; // 가격(단가) 자동입력
                    
                    // 발주 승인자와 창고 번호 자동 입력
                    document.getElementById('ord_supervisor_id').value = data.ord_supervisor_id; // 발주 승인자 이름 자동입력
                    document.getElementById('wh_number').value = data.wh_number; // 창고 번호 자동입력
                    
                    // 날짜 형식 변환 및 입력
                    const ordDate = new Date(data.ord_date);
                    const formattedOrdDate = ordDate.toISOString().split('T')[0]; // YYYY-MM-DD 형식으로 변환
                    document.getElementById('ord_date').value = formattedOrdDate; // 발주 날짜 자동입력

                    // 오늘 날짜 자동 입력
                    document.getElementById('rcv_date').value = new Date().toISOString().split('T')[0]; // 오늘 날짜 자동입력

                    document.getElementById('ord_manager_id').value = data.ord_manager_name; // 발주 요청자 자동입력
                    document.getElementById('ord_price').value = data.ord_price; // 가격 자동입력
                })
                .catch(error => {
                    console.error('Error fetching product details:', error);
                    alert("해당 발주 번호에 대한 정보를 불러왔습니다."); // 오류 메시지 추가
                });
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
                fetchProductByOrderNumber(ord_number) // 직접 입력한 번호로 제품 정보 요청
                    .then(() => {
                        // 입력한 번호에 대한 정보를 성공적으로 가져온 후 폼 제출
                        // 이 부분은 필요에 따라 수정 가능
                        // document.getElementById('ReceivingForm').submit();
                    });
            } else {
                alert("발주 관리번호를 입력하세요.");
            }
        }
    </script>
    
 <script type="text/javascript">
 function confirmSubmission() {
	    const confirmation = confirm("확인을 누르면 입고 요청이 완료됩니다.");
	    if (confirmation) {
	        // 여기서 return false를 해서 폼 제출을 방지
	        return true;
	    }
	    return false; // 사용자가 "취소" 클릭 시 폼 제출
	}

</script>

</body>
</html>
