<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/plugins.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kaiadmin.min.css" />
<link rel="stylesheet" href="/resources/css/css-table/leaderFont.css" />

<style>
		
	#moveStockTable thead th {
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
	
	.btn-label b {
		font-size: 1.2rem;
		line-height: 2;
	}
	
	strong {
		color: blue;
	}
	
	#moveStockTable b {
		color: red;
	} 
	
	.highlight {
		background-color: rgba(255,192,203,0.2);
	}
	
	.custom-table {
		--bs-table-bg: transparent !important;
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
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/sidebar.jsp" />

		<!-- Main Content -->
		<div class="container">
          <div class="page-inner">
            <div class="page-header">
              <h3 class="fw-bold mb-3">제품관리</h3>
              <ul class="breadcrumbs mb-3">
                <li class="nav-home">
                    <i class="icon-home"></i>
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  제품관리
                </li>
                <li class="separator">
                  <i class="icon-arrow-right"></i>
                </li>
                <li class="nav-item">
                  재고이동내역
                </li>
              </ul>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <h3 class="card-title">재고이동내역</h3>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive" style="overflow-x: auto; -webkit-overflow-scrolling: touch;">
                      <table
                        id="moveStockTable"
                        class="display table table-hover custom-table"
                      >
                        <thead>
                        <tr>
                        	<th></th>
                            <th>제품식별코드</th>
                            <th>출발창고</th>
                            <th>도착창고</th>
                            <th>이동수량</th>
                            <th>작업자</th>
                            <th>작업일시</th>
                            <th>재고이동사유</th>
                            <th>확인자</th>
                            <th>확인일시</th>
                            <th>결과</th>
                        </tr>
                        </thead>
                        <tfoot>
						<tr>
							<th><button class="btn btn-secondary btn-sm" id="boxClear" style="display: none;">체크 해제</button></th>
							<th>제품식별코드</th>
							<th>출발창고</th>
							<th>도착창고</th>
							<th>이동수량</th>
							<th>작업자</th>
							<th>작업일시</th>
							<th></th>
							<th>확인자</th>
							<th>확인일시</th>
							<th>결과</th>
						</tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="m" items="${moveList}">
							<c:choose>
								<c:when test="${m.move_result == '취소'}">
									<tr class="highlight">
								</c:when>
								<c:otherwise>
									<tr>
								</c:otherwise>
							</c:choose>
								<c:choose>
									<c:when test="${empty m.prod_updname && empty m.formatted_upddate && m.wh_admin2 == sessionScope.id}">
										<td id="boxCheck" style="padding:0 !important;">
											<div class="selectgroup selectgroup-secondary selectgroup-pills">
												<label class="selectgroup-item">
													<input type="checkbox" name="moveCheck" class="selectgroup-input"
													data-prod-id="${m.prod_id}"
													data-wh-number="${m.wh_number}"
													data-stock-wh="${m.stock_wh}"
													data-stock-qty="${m.stock_qty}"
													data-wh-admin2="${m.wh_admin2}"
													>
													<span class="selectgroup-button selectgroup-button-icon"><i class="fas fa-dolly-flatbed"></i></span>
												</label>
											</div>
			                            </td>
		                            </c:when>
		                            <c:otherwise>
		                            	<td></td>
		                            </c:otherwise>
	                            </c:choose>
								<td style="padding:0 !important;">${m.prod_id}<br> ${m.prod_name}-${m.prod_brand}<br> ${m.company_code}</td>
								<c:choose>
									<c:when test="${m.move_result == '취소'}">
										<td style="padding:0 !important;">
											${m.wh_number}-${m.wh_name}<br>${m.wh_dt_location}<br>
											${m.current_qty + m.stock_qty}
										</td>
										<td style="padding:0 !important;">
											${m.stock_wh}-${m.wh_name2}<br>${m.wh_dt_location2}<br>
											${m.current_qty2 - m.stock_qty}
										</td>
									</c:when>
									<c:otherwise>
										<td style="padding:0 !important;">
											${m.wh_number}-${m.wh_name}<br>${m.wh_dt_location}<br>
											<b>${m.current_qty - m.stock_qty} (- ${m.stock_qty})</b>
										</td>
										<td style="padding:0 !important;">
											${m.stock_wh}-${m.wh_name2}<br>${m.wh_dt_location2}<br>
											<strong>${m.current_qty2 + m.stock_qty} (+ ${m.stock_qty})</strong>
										</td>
									</c:otherwise>
								</c:choose>
								<td style="padding:0 !important;">${m.stock_qty}</td>
								<td style="padding:0 !important;">${m.prod_regname}<br>(${m.prod_reguser})</td>
								<td style="padding:0 !important;">${m.formatted_regdate}</td>
								<td style="padding:0 !important;">${m.move_reason}</td>
								<c:choose>
									<c:when test="${!empty m.prod_updname}">
										<td style="padding:0 !important;">${m.prod_updname}<br>(${m.prod_upduser})</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${!empty m.formatted_upddate}">
										<td style="padding:0 !important;">${m.formatted_upddate}</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${!empty m.move_result && m.move_result == '취소'}">
										<td style="padding:0 !important;"><b>${m.move_result}</b></td>
									</c:when>
									<c:when test="${!empty m.move_result && m.move_result == '승인'}">
										<td style="padding:0 !important;"><strong>${m.move_result}</strong></td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
                        </tbody>
                      </table>
						<div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
	                      	<button type="submit" class="btn btn-secondary" id="moveStockConfirm" style="display: none;">
								<span class="btn-label">
									<i class="fas fa-cart-arrow-down"> <b>재고 이동 승인</b></i>
								</span>
							</button>
							<button type="submit" class="btn btn-danger" id="moveStockCancle" style="display: none;">
								<span class="btn-label">
									<i class="fas fa-backspace"> <b>재고 이동 취소</b></i>
								</span>
							</button>
						</div>
                      </div>
                    </div>
                  </div>
					
                    </div>
                  </div>
                </div>
              </div>
           
		
		<!-- Footer -->
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/footer.jsp" />
	</div>
	
<script type="text/javascript">
$(document).ready(function () {
	let prodImage;
		
	// 데이터테이블
	$("#moveStockTable").DataTable({
		pageLength: 10,
		lengthMenu: [10, 20, 50, 100, 500],
		columnDefs: [{ orderable: false, targets: [0] }],
		order: [[6, 'desc']],
		initComplete: function () {
			var table = this.api();

			var columnsToFilter = [1, 2, 3, 4, 5, 6, 8, 9, 10];

			columnsToFilter.forEach(function (index) {
				var column = table.column(index);
				var select = $(
					'<select class="form-select"><option value=""></option></select>'
				)
				.appendTo($(column.footer()).empty())
				.on("change", function () {
					var val = $.fn.dataTable.util.escapeRegex($(this).val());
					column
						.search(val ? "^" + val + "$" : "", true, false)
						.draw();
				});
				column
					.data()
					.unique()
					.sort()
					.each(function (d, j) {
						select.append(
							'<option value="' + d + '">' + d + "</option>"
						);
					});
			});
		}
	});
	// 데이터테이블
	
	
	// 라디오버튼 체크해제, 조건제어
	if($('#boxCheck input[type="checkbox"]').length > 0) {
		$('#boxClear').show();
		$('#moveStockConfirm').show();
		$('#moveStockCancle').show();
	}
	$('#boxClear').on('click', function() {
		$('input[name="moveCheck"]').prop('checked', false);
	});
	// 라디오버튼 체크해제, 조건제어
	
	
	// 재고이동승인 버튼 처리
	$('#moveStockConfirm').on('click', function(e) {
		var selectedMoveStock = [];
		$('#moveStockConfirm').prop('disabled', true);
		
		swal({
			title: "알림!",
			text: "재고 이동을 승인하시겠습니까?",
			icon: "info",
			buttons: {
				confirm: {
					text: "네, 승인하겠습니다.",
					className: 'btn btn-secondary'
				},
				cancel: {
					visible: true,
					text: "닫기",
					className: 'btn btn-black'
				}
			}
		}).then((confirm) => {
			if(confirm) {
				$('#moveStockTable tr').each(function() {
					var checkbox = $(this).find('input[name="moveCheck"]');
					if (checkbox.is(':checked')) {
						selectedMoveStock.push({
							prod_id: checkbox.data('prodId'),
							wh_number: checkbox.data('whNumber'),
							stock_wh: checkbox.data('stockWh'),
							stock_qty: checkbox.data('stockQty'),
							wh_admin2: checkbox.data('whAdmin2'),
							move_result: '승인'
						});
					}
				});
	
				if (selectedMoveStock.length > 0) {
					$.ajax({
						url: '/prod/movestock',
						method: 'POST',
						contentType: 'application/json',
						data: JSON.stringify(selectedMoveStock),
						success: function(response) {
							swal({
								title: "성공!",
								text: "재고 이동이 승인되었습니다!",
								icon: "success",
								buttons: {
									confirm:{
										text: "확인",
										className: 'btn btn-secondary'
										}
								}
							}).then(() => {
		                    	location.reload();
		                    });
						},
						error: function(xhr, status, error) {
							swal({
								title: "오류!",
								text: "재고 이동 승인에 실패하였습니다.",
								icon: "error",
								buttons: {
									confirm:{
										text: "확인",
										className: 'btn btn-secondary'
									}
								}
							});
						}
					});
				} else {
					swal({
						title: "오류!",
						text: "선택된 항목이 없습니다!",
						icon: "error",
						buttons: {
							confirm:{
								text: "확인",
								className: 'btn btn-secondary'
							}
						}
					});
				}
			}	$('#moveStockConfirm').prop('disabled', false);
		});
	});
	// 재고이동승인 버튼 처리
	
	
	// 재고이동취소 버튼 처리
	$('#moveStockCancle').on('click', function() {
		var selectedMoveStock = [];
		swal({
			title: "경고!",
			text: "재고 이동을 취소하시겠습니까?",
			icon: "warning",
			buttons: {
				confirm: {
					text: "확인",
					className: 'btn btn-secondary'
				},
				cancel: {
					visible: true,
					text: "닫기",
					className: 'btn btn-black'
				}
			}
		}).then((confirm) => {
	    	if(confirm) {
				$('#moveStockTable tr').each(function() {
						var checkbox = $(this).find('input[name="moveCheck"]');
						if (checkbox.is(':checked')) {
							selectedMoveStock.push({
								prod_id: checkbox.data('prodId'),
								wh_number: checkbox.data('whNumber'),
								stock_wh: checkbox.data('stockWh'),
								stock_qty: checkbox.data('stockQty'),
								wh_admin2: checkbox.data('whAdmin2'),
								move_result: '취소'
							});
						}
					});
				
					if (selectedMoveStock.length > 0) {
						$.ajax({
							url: '/prod/movestockcancel',
							method: 'POST',
							contentType: 'application/json',
							data: JSON.stringify(selectedMoveStock),
							success: function(response) {
								swal({
									title: "알림!",
									text: "재고 이동이 취소되었습니다!",
									icon: "info",
									buttons: {
										confirm:{
											text: "확인",
											className: 'btn btn-secondary'
											}
									}
								}).then(() => {
			                    	location.reload();
			                    });
							},
							error: function(xhr, status, error) {
								swal({
									title: "오류!",
									text: "재고 이동 취소에 실패하였습니다.",
									icon: "error",
									buttons: {
										confirm:{
											text: "확인",
											className: 'btn btn-secondary'
											}
									}
								});
							}
						});
					} else {
						swal({
							title: "오류!",
							text: "선택된 항목이 없습니다!",
							icon: "error",
							buttons: {
								confirm:{
									text: "확인",
									className: 'btn btn-secondary'
								}
							}
						});
					}
				}
	    });
	});
	
	
	// 재고이동취소 버튼 처리
	
	
	
	
});//jquery DOM 준비
</script>

	
	
</body>
</html>