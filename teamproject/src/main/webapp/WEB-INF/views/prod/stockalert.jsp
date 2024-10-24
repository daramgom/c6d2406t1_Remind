<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고알람</title>

<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="/resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!-- Fonts and icons -->
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
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

<style>
	body, a, h3, li, p, td, b {
		font-family: 'NanumSquareNeo' !important;
	}
	
    #multi-filter-select thead th {
        background-color: #6861ce;
        color: white;
    }
    
	.table td {
		font-size: 1.2rem !important;
		text-align: center;
	}

	.table th {
		font-size: 1.25rem !important;
		text-align: center;
	}
    .form-select {
		font-size: 1.2rem !important;
	}
	
	.form-control {
		font-size: 1.2rem !important;
	}
	
	.btn-warning {
		color: #fff !important;
	} 
	
	#transferForm i {
		font-size: 1.2rem;
		line-height: 2;
	}
	
	#prod_image {
		width: 200px; height: 200px;
		border: dashed 3px #ccc;
		visibility: hidden;
		object-fit: contain;
	}
	
	.highlight {
		background-color: rgba(255, 0, 0, 0.1);
	}
	
	.custom-table {
	--bs-table-bg: transparent !important;
	}
	
</style>

<!-- CSS Files -->
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/plugins.min.css" />
<link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />


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
					<h3 class="fw-bold mb-3">제품관리</h3>
					<ul class="breadcrumbs mb-3">
						<li class="nav-home"><a href="#"> <i class="icon-home"></i>
						</a></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item"><a href="#">제품관리</a></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item"><a href="#">재고알림</a></li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card w-100">
							<div class="card-header">
								<div class="card-title">재고알림</div>
							</div>

							<div class="card-body d-flex flex-column">
								<div class="row">
								<div class="col-md-12">
									<form id="transferForm" action="" method="post">
									
										<div class="form-group d-flex" style="margin: 0 200px; gap: 100px;">
											<div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="prod_id" name="prod_id" required>
													<option value="">제품식별코드</option>
												</select>
												<label for="prod_id" class="selectFloatingLabel" style="font-size: 1.2rem !important;">제품식별코드</label>
												<input type="hidden" id="prod_reguser" name="prod_reguser" 
													value="테스터1" placeholder="등록작업자" />
												<input type="hidden" id="prod_upduser" name="prod_upduser" 
													value="테스터1" placeholder="수정작업자" />
											</div>
											<div class="form-floating form-floating-custom mb-1" style="flex: 1;">
												<input type="number" class="form-control" 
													id="prod_stock" name="prod_stock" placeholder="적정재고수량" min="0" max="#" required/>
												<label for="prod_stock" class="col-form-label-lg" style="font-size: 1.2rem !important;">적정재고수량</label>
											</div>
										</div>
										
										<div class="row d-flex justify-content-center">
											<div class="col-md-11">
												<div class="card-body">
													<div class="table-responsive">
														<table
														id="multi-filter-select"
														class="display table table-hover custom-table">
															<thead>
															<tr>
																<th>제품식별코드</th>
																<th>제품명</th>
																<th>브랜드</th>
																<th>제품이미지</th>
																<th>수량</th>
																<th>적정재고수량</th>
																<th>부족수량</th>
															</tr>
															</thead>
															<tfoot>
															<tr>
																<th>제품식별코드</th>
																<th>제품명</th>
																<th>브랜드</th>
																<th></th>
																<th>수량</th>
																<th>적정재고수량</th>
																<th>부족수량</th>
															</tr>
															</tfoot>
															<tbody>
															<c:forEach var="s" items="${stockList}">
																<tr class="prod_detail ${s.prod_qty < s.prod_stock ? 'highlight' : ''}">
																	<td>${s.prod_id}</td>
																	<td>${s.prod_name}</td>
																	<td>${s.prod_brand}</td>
																	<td><img src="${s.prod_image}" alt="제품이미지" style="width:75px; height:75px; object-fit: contain;"></td>
																	<td>${s.prod_qty}</td>
																	<td>${s.prod_stock}</td>
																	<c:choose>
																		<c:when test="${s.prod_qty < s.prod_stock}">
																			<td class="text-danger fw-bold">${s.prod_stock - s.prod_qty}</td>
																		</c:when>
																		<c:otherwise>
																			<td></td>
																		</c:otherwise>
																	</c:choose>
																</tr>
															</c:forEach>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
										<div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
											<button type="submit" class="btn btn-secondary">
												<span class="btn-label">
													<i class="fas fa-bell"> <b>적정재고수량 설정</b></i>
												</span>
											</button>
											<!-- 리셋버튼추가 -->
											<button type="button" class="btn btn-warning" id="inputReset">
												<span class="btn-label">
													<i class="fa fa-exclamation-circle"> <b>입력 초기화</b></i>
												</span>
											</button>
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
	
	// 데이터테이블
    $("#multi-filter-select").DataTable({
    	pageLength: 10, // 기본 페이지 길이
    	lengthMenu: [10, 20, 50, 100, 500], // 사용자가 선택할 수 있는 페이지 길이 옵션
    	initComplete: function () {
    		var table = this.api();

            // 필터를 적용할 열 인덱스 배열 (예: 두 번째 열과 세 번째 열)
            var columnsToFilter = [0,1,2,4,5,6];

            // 각 열에 대해 필터 추가
            columnsToFilter.forEach(function (index) {
                var column = table.column(index); // 특정 열 선택
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
                .each(function (d, j){
            		select.append(
                		'<option value="' + d + '">' + d + "</option>"
                	);
            	});
              });
            }
        });
 	// 데이터테이블
	
	

	// 알림 테스트
	function checkStock() {
		const alertShown = localStorage.getItem('alertShown');

		if (alertShown) {
			return;
		}

		$.ajax({
			url: '/prod/stockalertdata',
			method: 'POST',
			dataType: 'json',
			success: function(data) {
				let lowStockProd = [];

				data.forEach(function(item) {
					const prod_qty = item.prod_qty;
					const prod_stock = item.prod_stock;

					if (prod_qty < prod_stock) {
						lowStockProd.push(item.prod_id + ' - ' + item.prod_name + ' - ' + item.prod_brand);
					}
				});

				if (lowStockProd.length > 0) {
					const displayCount = 2;
					let message;

					if (lowStockProd.length > displayCount) {
						message = '<b class="text-warning">' + lowStockProd.slice(0, displayCount).join(', ') + '</b>' + ' 등 <b class="text-warning"> ' + (lowStockProd.length) + '개</b> 제품의 재고수량이 부족합니다.';
					} else {
						message = '<b class="text-warning">' + lowStockProd.join('/ ') + '</b>' + '의 재고수량이 부족합니다!';
					}

					$.notify({}, {
						type: "warning",
						delay: 5000,
						placement: {
							from: "bottom",
							align: "right"
						},
						template: '<div data-notify="container" class="alert alert-warning" role="alert">' +
							'<span data-notify="icon" class="icon-bell"></span>' +
							'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
							'<span data-notify="title" style="font-size: 20px;"><strong>적정재고수량 경고</strong></span> ' +
							'<span data-notify="message" style="font-size: 16px;">' +
							message + '</span>' +
							'</div>'
					});

					localStorage.setItem('alertShown', 'true');
				}
			},
			error: function(xhr, status, error) {
				console.error('데이터 불러오기 실패:', error);
			}
		});
	}
	
 	
		checkStock();
 	
	// 알림 테스트

	
	// select 요소 클릭 시 데이터 가져오기
	$('#prod_id').on('click', function() {
		if ($(this).find('option').length > 1) {
			return;
		}
		$.ajax({
			url: '/prod/transferSelect',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({}),
			dataType: 'json',
			success: function(data) {
				$('#prod_id').empty();
				$('#prod_id').append('<option value="">제품식별코드 선택</option>');
				$.each(data, function(index, p) {
					$('#prod_id').append('<option value="' + p.prod_id + '">' + p.prod_id + ' - ' + p.prod_name + ' - ' + p.prod_brand + '</option>');
				});
			},
			error: function(xhr, status, error) {
				console.error("데이터를 가져오는 데 오류가 발생했습니다:", error);
			}
		});
	});
	// select 요소 클릭 시 데이터 가져오기
	    	
	    	
	// swal 처리
	if ("${trans_message}" != "") {
		swal({
			title: "성공!",
			text: "${trans_message}",
			icon: "success",
			buttons: {
				confirm: {
					text: "확인",
				}
			}
		});
	} else if ("${trans_error}" != "") {
		swal({
			title: "오류!",
			text: "${trans_error}",
			icon: "error",
			buttons: {
				confirm: {
					text: "확인",
				}
			}
		});
	}
	// swal 처리
	
	        
	$("#inputReset").click(function (e) {
	    swal({
	        title: "입력값을 초기화하시겠습니까?",
	        text: "입력값이 모두 지워집니다!",
	        type: "warning",
	        buttons: {
	            confirm: {
	                text: "네, 지우겠습니다.",
	                className: "btn btn-warning",
	            },
	            cancel: {
	            	visible: true,
	                text: "취소",
	                className: "btn btn-danger",
	            },
	        },
	    }).then(function(clear) { // [confirm --> true / cancel --> false] - clear 값으로 전달
	        if (clear) {
	        	$('select').val('');
	        	$('select').empty();
	        	$('input').val('');
	        	$('#prod_id').append('<option value="">제품식별코드 선택</option>');
	        	
	            swal({
	                title: "초기화되었습니다.",
	                text: "모든 입력값이 초기화되었습니다.",
	                type: "success",
	                buttons: {
	                    confirm: {
	                        className: "btn btn-primary",
	                    },
	                },
	            });
	        } else {
	            swal.close();
	        }
	    });
	});
	        
	        
});//DOM 준비
</script>
   
</body>
</html>