<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REMIND</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<!-- Fonts and icons -->
<script src="/resources/js/plugin/webfont/webfont.min.js"></script>

<script>
	WebFont.load({
		google : {
			families : [ "Public Sans:300,400,500,600,700" ]
		},
		custom : {
			families : [ "Font Awesome 5 Solid", "Font Awesome 5 Regular",
					"Font Awesome 5 Brands", "simple-line-icons", ],
			urls : [ "/resources/css/fonts.min.css" ],
		},
		active : function() {
			sessionStorage.fonts = true;
		},
	});
</script>

<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />

<style>
.card-category {
	font-size: 1.5rem;
}

.numbers {
	display: inline-block;
	transition: transform 0.2s;
}

.numbers:hover {
	transform: scale(1.07);
}

.overview {
	display: inline-block;
	transition: transform 0.2s;
}

.overview:hover {
	transform: scale(1.03);
}

</style>
</head>
<body>
<c:if test="${empty sessionScope.id}">
	<c:redirect url="/login"/>
</c:if>
<c:if test="${sessionScope.member_code != 1}">
	<c:redirect url="/cmain"/>
</c:if>
	
	<div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />
	
	
	
	<!-- Main Content -->
	<div class="container">
		<div class="page-inner">
            <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
              <div>
                <h3 class="fw-bold mb-3">메인페이지</h3>
                <h6 class="op-7 mb-2">재고관리 시스템 메인페이지</h6>
              </div>
              <div class="ms-md-auto py-2 py-md-0">
                <a href="#" class="btn btn-label-info btn-round me-2">Manage</a>
                <a href="#" class="btn btn-primary btn-round">Add Customer</a>
              </div>
            </div>
            
            <div class="row">
              <div class="col-sm-6 col-md-3 numbers">
                <div class="card card-stats card-round">
	              <a href="/prod/list">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div class="icon-big text-center icon-primary bubble-shadow-small">
                          <i class="fas fa-box"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div>
                          <p class="card-category text-primary fw-bold">총 재고량</p>
                          <h4 class="card-title text-primary"><fmt:formatNumber value="${MainQty.prod_all_qty}" pattern="#,##0" /></h4>
                        </div>
                      </div>
                    </div>
                  </div>
	               </a>
                </div>
              </div>
              <div class="col-sm-6 col-md-3 numbers">
                <div class="card card-stats card-round">
             	<a href="/order-list">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div class="icon-big text-center icon-warning bubble-shadow-small">
                          <i class="fas fa-clipboard-list"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div>
                          <p class="card-category text-warning fw-bold">월 발주량</p>
                          <h4 class="card-title text-warning"><fmt:formatNumber value="${MainQty.month_ord}" pattern="#,##0" /></h4>
                        </div>
                      </div>
                    </div>
                  </div>
	              </a>
                </div>
              </div>
              <div class="col-sm-6 col-md-3 numbers">
                <div class="card card-stats card-round">
                 <a href="/rcvList2">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div class="icon-big text-center icon-success bubble-shadow-small">
                          <i class="fas fa-cart-arrow-down"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div>
                          <p class="card-category text-success fw-bold">월 입고량</p>
                          <h4 class="card-title text-success"><fmt:formatNumber value="${MainQty.month_rcv}" pattern="#,##0" /></h4>
                        </div>
                      </div>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
              <div class="col-sm-6 col-md-3 numbers">
                <div class="card card-stats card-round">
               	 <a href="/shpList2">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div class="icon-big text-center icon-danger bubble-shadow-small">
                          <i class="fas fa-truck-moving"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div>
                          <p class="card-category text-danger fw-bold">월 출고량</p>
                          <h4 class="card-title text-danger"><fmt:formatNumber value="${MainQty.month_shp}" pattern="#,##0" /></h4>
                        </div>
                      </div>
                    </div>
                  </div>
                  </a>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-8 overview">
                <div class="card card-round">
                  <div class="card-header">
                    <div class="card-head-row">
                      <div class="card-title">일일 재고 운영</div>
                      <div class="card-tools">
                        <a href="#" class="btn btn-label-info btn-round btn-sm me-2" id="exportImage">
                          <span class="btn-label">
                            <i class="far fa-image"></i>
                          </span>
                          Export
                        </a>
                      </div>
                    </div>
                  </div>
                  <div class="card-body">
                    <div class="chart-container" style="min-height: 375px"><div class="chartjs-size-monitor" style="position: absolute; inset: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
                      <canvas id="statisticsChart" style="display: block; width: 1007px; height: 405px;" width="1007" height="405" class="chartjs-render-monitor"></canvas>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-4 overview">
                <div class="card card-round">
                  <div class="card-header">
                    <div class="card-head-row">
                     <div class="card-title">온라인 채팅</div>
                     </div>
                    </div>
                  <div class="card-body pb-0">
                    <div class="mb-4 mt-2 col-12">
						<div id="msgArea" class="col" style="height:350px; overflow-y:auto;">
						</div>
						<div class="col-12">
						<div class="input-group mb-3">
						<input type="text" id="msg" class="form-control" maxlength="300" 
							aria-label="Recipient's username" aria-describedby="button-addon2">
						<div class="input-group-append">
						<button class="btn btn-secondary" type="button" id="button-send">전송</button>
						</div>
						</div>
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
$(document).ready(function() {
	$.ajax({
		url: '/main', // 데이터를 가져올 API 엔드포인트
		method: 'POST',
		success: function(mainList) {
			// 날짜 레이블과 데이터셋 초기화
			const dateLabels = [];
			const dayOrdData = [];
			const dayRcvData = [];
			const dayShpData = [];

			// 데이터 집계
			mainList.forEach(item => {
			    dateLabels.push(item.date);
				dayOrdData.push(item.day_ord);
				dayRcvData.push(item.day_rcv);
				dayShpData.push(item.day_shp);
			});

			// Chart.js 그래프 생성
			const ctx = $('#statisticsChart')[0].getContext('2d');
			Chart.defaults.borderColor = '#eee';
			const myChart = new Chart(ctx, {
				type: 'line',
				data: {
					labels: dateLabels,
					datasets: [
						{
							label: '발주',
							data: dayOrdData,
							borderColor: '#fdaf4b',
							backgroundColor: 'rgba(253, 175, 75, 0.6)',
							fill: true,
							lineTension: 0.3,
							pointStyle: 'circle',
							borderWidth: 3
						},
						{
							label: '입고',
							data: dayRcvData,
							borderColor: '#31ce36',
							backgroundColor: 'rgba(49, 206, 54, 0.52)',
							fill: true,
							lineTension: 0.3,
							pointStyle: 'circle',
							borderWidth: 3
						},
						{
							label: '출고',
							data: dayShpData,
							borderColor: '#f3545d',
							backgroundColor: 'rgba(243, 84, 93, 0.52)',
							fill: true,
							lineTension: 0.3,
							pointStyle: 'circle',
							borderWidth: 3
						},
					]
				},
				options: {
					elements: {
						point: {
							radius: 1
						}
					},
					responsive: true,
					scales: {
						x: {
							ticks: {
								font: {
									size: 16
								}
							},
							beginAtZero: true,
						},
						y: {
							ticks: {
								autoSkip: false,
								maxTicksLimit: 5,
								font: {
									size: 16
								}
							},
							beginAtZero: true,
							grid: {
								color: 'transparent'
							}
						}
					},
					plugins: {
						legend: {
							position: 'bottom',
							labels: {
								usePointStyle: true,
								padding: 30,
								font: {
									size: 18
								}
							}
						},
					}
				},
			});
		},
		error: function(error) {
			console.error('데이터를 가져오는 데 실패했습니다:', error);
		}
	});
	
	
// chatting
	//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
	sendMessage();
	$('#msg').val('');
});
const protocol = window.location.protocol;
const host = window.location.host;
var userName = '${sessionScope.name}';
var sock = new SockJS(protocol+'//'+host+'/chatting?userName='+encodeURIComponent(userName));
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMessage() {
	sock.send($("#msg").val());
}

//서버에서 메시지를 받았을 때
function onMessage(msg) {
	var data = msg.data;
	var sessionId = null;
	var message = null;

	var arr = data.split(":");

	for(var i=0; i<arr.length; i++) {
		console.log('arr[' + i + ']: ' + arr[i]);
	}

	var cur_session = userName;
	console.log("cur_session : " + cur_session);

	sessionId = arr[0];
	message = arr[1];

	
	if(sessionId == cur_session) {
		var str = "<div class='col-8 ms-auto'>";
		str += "<div class='alert alert-secondary' style='border-left:7px solid #6861ce; text-align: right;'>";
		str += "<b>" + message +"</b>";
		str += "</div></div>";

		$("#msgArea").append(str);
		$('#msgArea').scrollTop($('#msgArea')[0].scrollHeight);
	} else {
		var str = "<div class='col-8'>";
		str += "<div class='alert alert-warning' style='border-right: 7px solid #ffad46; border-left: none;'>";
		str += "<i class='fas fa-user'></i> <b>" + sessionId + " : " + message + "</b>";
		str += "</div></div>";

		$("#msgArea").append(str);
		$('#msgArea').scrollTop($('#msgArea')[0].scrollHeight);
	}
}

//채팅창에서 나갔을 때
function onClose(evt) {
}

//채팅창에 들어왔을 때
function onOpen(evt) {
}
// chatting


// 그래프 이미지 저장
$('#exportImage').on('click', function() {
	const canvas = $('#statisticsChart')[0];
	const canvasImg = canvas.toDataURL("image/png");
	
	const canvasToday = new Date();
	const canvasWeekAgo = new Date();
	canvasWeekAgo.setDate(canvasToday.getDate() - 7);
	
	const formatDate = (date) => {
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, '0');
		const day = String(date.getDate()).padStart(2, '0');
		return year+'-'+month+'-'+day;
	};
	
	const link = $('<a></a>');
	link.attr('href', canvasImg);
	link.attr('download', 'REMIND_Daily_Chart_'+ formatDate(canvasToday) +'_to_'+ formatDate(canvasWeekAgo) +'.png');
	link[0].click();
});
// 그래프 이미지 저장


// 엔터키 전송버튼
	$('#msg').on('keydown', function(e) {
		if (e.key === 'Enter') {
			$('#button-send').click();
		}
	});
// 엔터키 전송버튼


});//DOM준비



</script>
</body>
</html>