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
    
	<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #e9ecef;
        margin: 0;
       
    }
    header {
        background: #6861ce; /* 남색 */
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
        border-bottom: 2px solid #CCCCCC; /* 남색 */
        padding-bottom: 10px;
        color: #CCCCCC; /* 남색 */
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
        background: #6861ce; /* 남색 */
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
        background-color: #CCCCCC; /* 남색 */
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
        .dropdown1 {
            display: none;
            border: 1px solid #ccc;
            max-height: 150px;
            overflow-y: auto;
           position: relative;
		    background: white;
		    top: 0px;
		    width: 240px;
            z-index: 1000;
        }
        .dropdown1 div {
            padding: 8px;
            cursor: pointer;
        }
        .dropdown1 div:hover {
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
          
          
            <div class="page-header">
              <h3 class="fw-bold mb-3">출고관리</h3>
              <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                    <i class="icon-home"></i>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                 출고관리
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                 출고요청
                </li>
              </ul>
            </div>
          
          

<main>

<h2>출고 처리</h2>
<form action="/shpRQ" id="ShippingForm" method="post" onsubmit="return confirmSubmission()">
    <div class="form-container">
        <div class="form-group">
            <label for="shp_manager_id">
                <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                     style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고 처리자
            </label>
            <div class="underline-container">
                <input type="text" id="shp_manager_id" class="underline-input" placeholder="홍길동" required name="shp_manager_id" value="${sessionScope.name }" readonly="readonly">
                <div class="custom-underline"></div>
            </div>
        </div>

        <div class="form-group">
            <label for="SHP_SUPERVISOR_ID">
                <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                     style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고 승인자
            </label>
            <div class="underline-container">
                <select id="shp_supervisor_id" name="shp_supervisor_id" required="required" style= "height:30px;" >
                    <option value="">선택하세요</option>
                    <c:forEach var="r" items="${SsList }">
                        <option value="${r.member_id}"> ${r.member_name} / ${r.department_name} / ${r.common_status} / ${r.member_tel }</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="cord_number">거래처 발주 관리 번호</label>
            <div style="display: flex; align-items: center;">
                <input type="text" id="cord_number" placeholder="발주 관리 번호 입력" required onfocus="showCorderList()" oninput="fetchCorderData()" name="cord_number">
                <button type="button" onclick="submitCorderNumber()">조회</button>
            </div>
            <div class="dropdown1" id="corderDropdown"></div>
        </div>

        <div class="form-group">
            <label for="wh_number">창고 번호</label>
            <select id="wh_number" name="wh_number" required="required" max="prod_qty" style= "height:42px;" >
                <option value="">창고를 선택하세요</option>
            </select>
        </div>

        <div class="form-group">
            <label for="shp_quantity">출고 수량</label>
            <input type="number" id="shp_quantity" required name="shp_quantity" >
        </div>

        <div class="form-group">
            <label for="prod_id">제품 식별코드</label>
            <input type="text" id="prod_id" placeholder="제품 식별 코드를 입력" required name="prod_id" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="prod_category">카테고리</label>
            <input type="text" id="prod_category" required name="prod_category" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="prod_name">품목명</label>
            <input type="text" id="prod_name" required name="prod_name" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="company_code">거래처</label>
            <input type="text" id="company_code" required name="company_code" readonly="readonly">
        </div>
	
		  <div class="form-group">
		    <label for="shp_price">가격(단가)</label>
		    <input type="number" id="shp_price" required name="shp_price" min="0">
		</div>


        <div class="form-group">
            <label for="cord_date">발주 날짜</label>
            <input type="date" id="cord_date" required name="cord_date" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="shp_date">출고 날짜</label>
            <input type="date" id="shp_date" required name="shp_date">
        </div>

        <div class="form-group">
            <label for="shp_remarks">비고</label>
            <textarea id="shp_remarks" placeholder="전달할 내용..." required name="shp_remarks"></textarea>
        </div>

            <button class="button" type="submit">출고 요청</button>

    </div>
</form>

</main>
</div>

<jsp:include page="/resources/inc/footer.jsp" />
</div>


</div>

    
    
    <!-- 거래처 발주관리번호 셀렉트박스,자동채우기 -->
    
   <script>
    var prodId;
    var prodQty;

    const corderNumbers = ['CORD-2024-0001', 'CORD-2024-0002', 'CORD-2024-0003', 'CORD-2024-0004'];

    function showCorderList() {
        const dropdown = document.getElementById('corderDropdown');
        dropdown.innerHTML = '';
        dropdown.style.display = 'block';

        corderNumbers.forEach(corder => {
            const div = document.createElement('div');
            div.textContent = corder;
            div.onclick = () => selectOrder(corder);
            dropdown.appendChild(div);
        });
    }

    function selectOrder(corder) {
        document.getElementById('cord_number').value = corder;
        document.getElementById('corderDropdown').style.display = 'none';
        fetchProductByCorderNumber(corder);
    }

    function fetchProductByCorderNumber(corderNumber) {
        return fetch(`/getShippingProductByCorderNumber?cord_number=` + corderNumber)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                document.getElementById('prod_id').value = data.cprod_id;
                prodId = data.cprod_id;
                document.getElementById('prod_category').value = data.cprod_category;
                document.getElementById('company_code').value = data.ccompany_code;
                document.getElementById('prod_name').value = data.cprod_name;
                document.getElementById('shp_price').value = data.cord_price;

                document.getElementById('wh_number').value = data.wh_number;

                const cordDate = new Date(data.cord_date);
                const formattedCordDate = cordDate.toISOString().split('T')[0];
                document.getElementById('cord_date').value = formattedCordDate;

                document.getElementById('shp_date').value = new Date().toISOString().split('T')[0];
                
               test(prodId);
            })
            .catch(error => {
                console.error('Error fetching product details:', error);
                alert("해당 발주 번호에 대한 정보를 불러왔습니다.");
            });
    }

    function fetchCorderData() {
        const input = document.getElementById('cord_number').value.toLowerCase();
        const dropdown = document.getElementById('corderDropdown');
        dropdown.innerHTML = '';

        const filteredCorders = corderNumbers.filter(corder => corder.toLowerCase().includes(input));
        filteredCorders.forEach(corder => {
            const div = document.createElement('div');
            div.textContent = corder;
            div.onclick = () => selectOrder(corder);
            dropdown.appendChild(div);
        });

        dropdown.style.display = filteredCorders.length > 0 ? 'block' : 'none';
    }

    document.addEventListener('click', (event) => {
        const dropdown = document.getElementById('corderDropdown');
        const input = document.getElementById('cord_number');
        if (!input.contains(event.target) && !dropdown.contains(event.target)) {
            dropdown.style.display = 'none';
        }
    });

    function submitCorderNumber() {
        const cord_number = document.getElementById('cord_number').value;
        if (cord_number) {
            fetchProductByCorderNumber(cord_number);
        } else {
            alert("발주 관리번호를 입력하세요.");
        }
    }

    function confirmSubmission() {
        const confirmation = confirm("확인을 누르면 출고 요청이 완료됩니다.");
        return confirmation;
    }

    function test(prodId) {
        return fetch(`/getwhNumberFromStock?prodId=` + prodId)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                
                var whNumberSelect = document.getElementById("wh_number");
                whNumberSelect.innerHTML = '';

                var defaultOption = document.createElement("option");
                defaultOption.value = "";
                defaultOption.selected = true;
                defaultOption.textContent = "창고를 선택하세요";
                whNumberSelect.appendChild(defaultOption);
                
                // data가 배열일 경우
                data.forEach(function(item) {
                    // option 요소 생성
                    var option = document.createElement("option");
                    option.value = item.wh_number; // wh_number 값 사용
                    option.textContent = item.wh_number + ' / ' + item.prod_qty; // prod_qty 값 사용
                    
                    // select 박스에 추가
                    whNumberSelect.appendChild(option);
                });

                // change 이벤트 추가
                whNumberSelect.addEventListener('change', function() {
                    var selectedValue = this.value; // 선택된 값
                    var selectedItem = data.find(item => item.wh_number == selectedValue);
                    if (selectedItem) {
                        test2(selectedItem.prod_qty); // 원하는 함수 호출
                    }
                });
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }
    
    
    
    function test2(prod_qty) {
        
        // 출고 수량 입력 요소
        var quantityInput = document.getElementById("shp_quantity");
        
        if (quantityInput) {
            quantityInput.max = prod_qty; // max 속성에 선택된 수량 설정
            quantityInput.value = ""; // 기존 입력값 초기화 (선택된 수량이 변경되면 초기화)
        }
    }

    
</script>




</body>
</html>
