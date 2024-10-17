<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고이동</title>

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

<style>
	.btn-warning {
		color: #fff !important;
	} 
	
	#transferForm i {
		font-size: 18px;
		line-height: 2;
	}
	
	#prod_image {
		width: 300px; height: 200px;
		border: dashed 3px #ccc;
		visibility: hidden;
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
									
										<div class="form-group d-flex" style="margin: 0 200px; gap: 100px;">
											<div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="prod_id" name="prod_id">
													<option>제품식별코드</option>
												</select>
												<label for="prod_id" class="selectFloatingLabel">제품식별코드</label>
												<input type="hidden" id="prod_reguser" name="prod_reguser" 
													value="테스터1" placeholder="등록작업자" />
												<input type="hidden" id="prod_upduser" name="prod_upduser" 
													value="테스터1" placeholder="수정작업자" />
											</div>
											<div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="wh_number" name="wh_number">
													<option>창고</option>
												</select>
												<label for="wh_number" class="selectFloatingLabel">창고</label>
											</div>
											<div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="prod_qty" name="prod_qty" disabled>
													<option>수량</option>
												</select>
												<label for="prod_qty" class="selectFloatingLabel">수량</label>
											</div>
										</div>
										
										<div class="form-group d-flex" style="margin: 0 200px; gap: 100px;">
											 <div style="flex: 1;">
											 	<img id="prod_image" src="#">
											 </div>
											 <div class="form-floating form-floating-custom mb-3" style="flex: 1;">
												<select class="form-select" id="wh_number2" name="wh_number2">
													<option>창고</option>
												</select>
												<label for="wh_number2" class="selectFloatingLabel">창고</label>
											</div>
											<div class="form-floating form-floating-custom mb-1" style="flex: 1;">
												<input type="number" class="form-control" 
													id="prod_qty2" name="prod_qty2" placeholder="수량"/>
												<label for="prod_qty2" class="col-form-label-lg">이동 수량</label>
											</div>
										</div>
										<div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
											<button type="submit" class="btn btn-primary">
												<span class="btn-label">
													<i class="fa fa-plus"> 제품 등록</i>
												</span>
											</button>
											<!-- 리셋버튼추가 -->
											<button type="button" class="btn btn-warning" id="inputReset">
												<span class="btn-label">
													<i class="fa fa-exclamation-circle"> 입력 초기화</i>
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

	<!--   Core JS Files   -->
	<script src="/resources/js/core/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<!-- jQuery Scrollbar -->
	<script
		src="/resources/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<!-- Chart JS -->
	<script src="/resources/js/plugin/chart.js/chart.min.js"></script>

	<!-- jQuery Sparkline -->
	<script
		src="/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

	<!-- Chart Circle -->
	<script src="/resources/js/plugin/chart-circle/circles.min.js"></script>

	<!-- Datatables -->
	<script src="/resources/js/plugin/datatables/datatables.min.js"></script>

	<!-- Bootstrap Notify -->
	<script
		src="/resources/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

	<!-- jQuery Vector Maps -->
	<script src="/resources/js/plugin/jsvectormap/jsvectormap.min.js"></script>
	<script src="/resources/js/plugin/jsvectormap/world.js"></script>

	<!-- Sweet Alert -->
	<script src="/resources/js/plugin/sweetalert/sweetalert.min.js"></script>

	<!-- Kaiadmin JS -->
	<script src="/resources/js/kaiadmin.min.js"></script>
	
	
	<script type="text/javascript">
    
	$(document).ready(function () {
	    	
	// select 요소 클릭 시 데이터 가져오기
	$('#prod_id').on('click', function() {
		if ($(this).find('option').length > 1) {
			return; // 첫 번째 옵션만 있을 때만 요청
		}
		$.ajax({
			url: '/prod/transferSelect', // 서버의 URL (데이터를 가져오는 엔드포인트)
			type: 'POST', // POST 방식으로 요청
			contentType: 'application/json', // JSON 형식으로 전송
			data: JSON.stringify({}), // 빈 객체를 JSON 문자열로 전송
			dataType: 'json',
			success: function(data) {
				var select = $('#prod_id');
				select.empty();
				select.append('<option value="">제품식별코드 선택</option>');
				$.each(data, function(index, p) {
					select.append('<option value="' + p.prod_id + '">' + p.prod_id + ' - ' + p.prod_name + '</option>');
				});
			},
			error: function(xhr, status, error) {
				console.error("데이터를 가져오는 데 오류가 발생했습니다:", error);
			}
		});
	});
	
	$('#wh_number').on('click', function() {
		if ($(this).find('option').length > 1) {
			return; // 첫 번째 옵션만 있을 때만 요청
		}
	
		const selectedProdId = $("#prod_id").val();
		$.ajax({
			url: '/prod/transferSelect2',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ prod_id: selectedProdId }),
			dataType: 'json',
			success: function(data) {
				var select = $('#wh_number');
				select.empty();
				select.append('<option>창고 선택</option>');
				
				$.each(data, function(index, s) {
    				select.append('<option value="' + s.wh_number + '">' + s.wh_code + ' - ' + s.wh_name + ' - ' + s.wh_location + '</option>');
				});

				select.change(function() {
					var selectedWh = $(this).val(); // 선택된 창고

					$('#prod_qty').empty();
					$('#prod_qty').append('<option>수량 선택</option>');

					$.each(data, function(index, item) {
						if (item.wh_number == selectedWh) {
							var selectedQty = item.prod_qty;
							$('#prod_qty').append('<option value="' + selectedQty + '">' + selectedQty + '</option>');
							$('#prod_qty').val(selectedQty);
							
							
						}
					});
				});
			},
			error: function(xhr, status, error) {
				console.error("데이터를 가져오는 데 오류가 발생했습니다:", error);
			}
		});
	});
	
	// select 요소 클릭 시 데이터 가져오기
	    	
	    	
	    	
	    	
	    	
	    	
	        $('#prodForm').on('submit', function (e) {
	            e.preventDefault(); // 기본 제출 이벤트 방지
	            
	         	// 버튼 비활성화
	            $('button[type="submit"]').prop('disabled', true);
	            
	            var formData = new FormData(this); // FormData 객체 생성
	
	            $.ajax({
	                url: '/prod/insert', // 서버의 처리 URL
	                type: 'POST',
	                data: formData,
	                processData: false, // jQuery가 데이터를 처리하지 않도록 설정
	                contentType: false, // jQuery가 Content-Type을 설정하지 않도록 설정
	                success: function (response) {
	                    // 성공 시 SweetAlert 모달 표시
	                    swal({
	                    	title: "성공!",
	                    	text: "제품이 등록되었습니다!",
	                    	icon: "success",
	                    	buttons: {
	                    		text: "확인",
	                    	}
	                    });
	                },
	                error: function (error) {
	                    // 오류 시 SweetAlert 모달 표시
	                    swal({
	                    	title: "오류!",
	                    	text: "제품 등록에 실패했습니다.",
	                    	icon: "error"
	                    });
	                	$('#prod_reguser').val("테스터1");
	                	$('#prod_upduser').val("테스터1");
	                },
	                complete: function() {
	                    // 요청이 완료되면 버튼 활성화
	                    $('button[type="submit"]').prop('disabled', false);
	                }
	            });
	        });
	        
	        
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
	                    // 입력 필드 비우기 로직

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
	        
	        
	        
	    });//DOM 준비 이벤트
	</script>
   
</body>
</html>