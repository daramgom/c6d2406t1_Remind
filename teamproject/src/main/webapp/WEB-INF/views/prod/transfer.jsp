<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
	
	.form-select {
		font-size: 1.2rem !important;
	}
	
	.form-control {
		font-size: 1.2rem !important;
	}
	
	.table td {
		font-size: 1.2rem !important;
		text-align: center;
	}

	.table th {
		font-size: 1.25rem !important;
		text-align: center;
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
				<div class="page-header">
					<h3 class="fw-bold mb-3">제품관리</h3>
					<ul class="breadcrumbs mb-3">
						<li class="nav-home"><a href="#"> <i class="icon-home"></i>
						</a></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item"><a href="#">제품관리</a></li>
						<li class="separator"><i class="icon-arrow-right"></i></li>
						<li class="nav-item"><a href="#">재고이동</a></li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card w-100">
							<div class="card-header">
								<div class="card-title">재고이동</div>
							</div>

							<div class="card-body d-flex flex-column">
								<div class="row">
								<div class="col-md-12">
									<form id="transferForm" action="" method="post">
									
										<div class="form-group d-flex" style="margin: 0; gap: 100px;">
											<div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="prod_id" name="prod_id" required>
													<option value="">제품식별코드</option>
												</select>
												<label for="prod_id" class="selectFloatingLabel" style="font-size: 1.2rem !important;" >제품식별코드</label>
												<input type="hidden" id="prod_reguser" name="prod_reguser" 
													value="${sessionScope.id }" placeholder="등록작업자" />
											</div>
											<div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="wh_number" name="wh_number" required disabled>
													<option value="">출발창고</option>
												</select>
												<label for="wh_number" class="selectFloatingLabel" style="font-size: 1.2rem !important;">창고</label>
											</div>
											<div class="form-floating form-floating-custom mb-1" style="flex: 1;">
												<input type="number" class="form-control" 
													id="prod_qty" name="prod_qty" min="0" max="#" readonly required/>
												<label for="prod_qty" class="col-form-label-lg" style="font-size: 1.2rem !important;">수량</label>
												<input type="hidden" id="current_qty" name="current_qty" value="#">
											</div>
										</div>
										
										<div class="form-group d-flex" style="margin: 0x; gap: 100px; align-items: center;">
											 <div style="flex: 1;">
											 	<img id="prod_image" src="#">
											 </div>
											 <div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="stock_wh" name="stock_wh" required disabled>
													<option value="">도착창고</option>
												</select>
												<label for="stock_wh" class="selectFloatingLabel" style="font-size: 1.2rem !important;">창고</label>
											</div>
											<div class="form-floating form-floating-custom mb-1" style="flex: 1;">
												<input type="number" class="form-control" 
													id="stock_qty" name="stock_qty" placeholder="수량" min="0" max="#" required/>
												<label for="stock_qty" class="col-form-label-lg" style="font-size: 1.2rem !important;">이동 수량</label>
											</div>
										</div>
										<div class="form-group d-flex" style="margin: 0x; gap: 100px; align-items: center;">
											<div class="input-group" style="flex: 0.5;">
												<span class="input-group-text" style="font-size: 1.2rem; color:#2a2f5b;">재고이동사유</span>
													<textarea id="move_reason" name="move_reason" class="form-control" required></textarea>
											</div>
										</div>
										<div class="row d-flex justify-content-center">
											<div class="col-md-8">
												<div class="card-body">
						                         	 <table class="table table-hover" id="stockList" style="display: none;">
												        <thead>
												            <tr>
												                <th>제품식별코드</th>
												                <th>창고</th>
												                <th>수량</th>
												            </tr>
												        </thead>
												        <tbody id="stockListBody">
												            <!-- 자바스크립트로 동적으로 추가되는 내용 -->
												        </tbody>
												    </table>
												</div>
											</div>
										</div>
										<div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
											<button type="submit" class="btn btn-secondary">
												<span class="btn-label">
													<i class="fa fa-cart-shopping"> <b>재고 이동</b></i>
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
				
				$('#prod_id').off('change').on('change',function() {
					$('#wh_number').empty();
					$('#wh_number').append('<option value="">창고 선택</option>');
					$('#prod_qty').val('');
					$('#stock_qty').val('');
					$('#stock_wh').empty();
					$('#stock_wh').append('<option value="">창고 선택</option>');
					$('#stockList').hide();
					
					var selectedProductId = $(this).val();
					var selectedProduct = data.find(p => p.prod_id == selectedProductId);
					
					if(selectedProductId != "") {
						$.ajax({
							url: '/prod/transferFind',
							type: 'POST',
							contentType: 'application/json',
							data: JSON.stringify({ prod_id: selectedProductId }),
							dataType: 'json',
							success: function(data){
								$('#stockList').show();
								$('#stockListBody').empty();
	
								$.each(data, function(index, item) {
									$('#stockListBody').append(
										'<tr>' +
											'<td>' + item.prod_id +' - '+ item.prod_name +' - '+ item.prod_brand + '</td>' +
											'<td>' + item.wh_number + '</td>' +
											'<td>' + item.prod_qty + '</td>' +
										'</tr>'
									);
								});
							},
							error: function(xhr, status, error) {
								console.error("데이터를 가져오는 데 오류가 발생했습니다:", error);
							}
						});
					}
					
					
					if (selectedProduct) {
						$('#prod_image').prop('src', selectedProduct.prod_image);
						$('#prod_image').css('visibility', 'visible');
					} else {
						$('#prod_image').css('visibility', 'hidden');
					}
					
		        	if ($(this).val() === "") {
			            $('#wh_number').prop('disabled', true);
			            $('#stock_wh').prop('disabled', true);
			            $('#stockList').hide();
			        } else {
			            $('#wh_number').prop('disabled', false);
			            $('#stock_wh').prop('disabled', false);
			        }
				});
				
				
			},
			error: function(xhr, status, error) {
				console.error("데이터를 가져오는 데 오류가 발생했습니다:", error);
			}
		});
	});
	
	$('#wh_number').on('click', function() {
		if ($(this).find('option').length > 1) {
			return;
		}
	
		const selectedProdId = $("#prod_id").val();
		$.ajax({
			url: '/prod/transferSelect2',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ prod_id: selectedProdId }),
			dataType: 'json',
			success: function(data) {
				$('#wh_number').empty();
				$('#wh_number').append('<option value="">창고 선택</option>');
				
				$.each(data, function(index, s) {
					$('#wh_number').append('<option value="' + s.wh_number + '">' + s.wh_number + ' - ' + s.wh_name + ' - ' + s.wh_location + ' - ' + s.wh_dt_location + '</option>');
				});

				$('#wh_number').off('change').on('change', function() {
					var selectedWh = $(this).val();
					
					$('#stock_wh').empty();
					$('#stock_wh').append('<option value="">창고 선택</option>');
					$('#stock_wh').prop('disabled', false);
					$('#stock_qty').val('');
					
					$.ajax({
						url: '/prod/transferSelect3',
						type: 'POST',
						data: JSON.stringify({}),
						dataType: 'json',
						success: function(response) {
					        
							$.each(response, function(index, s) {
								if (s.wh_number != selectedWh) {
									$('#stock_wh').append('<option value="' + s.wh_number + '">' + s.wh_number + ' - ' + s.wh_name + ' - ' + s.wh_location + ' - ' + s.wh_dt_location + '</option>');
								}
							});
					
						},
							
						error: function() {
							alert('다른 데이터를 가져오는 데 실패했습니다.');
						}
					});

					
					if (selectedWh === '') {
						$('#stock_wh').prop('disabled', true);
						$('#stock_wh').empty();
						$('#stock_wh').append('<option value="">창고 선택</option>');
						$('#stock_qty').prop('max','');
						$('#stock_qty').val('');
						$('#prod_qty').val('');
						
					} else {
						$.each(data, function(index, item) {
							if (item.wh_number == selectedWh) {
								var selectedQty = item.prod_qty;
								$('#prod_qty').val(selectedQty);
								$('#stock_qty').prop('max',selectedQty);
								$('#current_qty').val(selectedQty);
							}
						});
					}
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
					className: "btn btn-secondary",
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
					className: "btn btn-secondary",
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
	        	$('#wh_number').append('<option value="">창고 선택</option>');
	        	$('#stock_wh').append('<option value="">창고 선택</option>');
	        	$('#prod_image').prop('src', '');
	        	$('#prod_image').css('visibility', 'hidden');
	        	$('#stockList').hide();
	        	$('#stockListBody').empty();
	        	
	            swal({
	                title: "초기화되었습니다.",
	                text: "모든 입력값이 초기화되었습니다.",
	                type: "success",
	                buttons: {
	                    confirm: {
	                    	text: "확인",
	                        className: "btn btn-secondary",
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