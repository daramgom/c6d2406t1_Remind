<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
        #previewimg { /* 미리보기 img 태그 id */
            display: none; /* 초기에는 숨김 */
            width: 95%; /* 최대 너비 설정 */
            height: 95%;
            margin: 10px; /* 여백 설정 */
            object-fit: contain;
        }

        .preview {
            width: 200px; /* 최대 너비 설정 */
            height: 150px;
            margin: 10px; /* 여백 설정 */
            border: 2px dashed #ccc; /* 대시 테두리 */
    		display: flex;
    		justify-content: center;
    		align-items: center;
    		background-color: #f9f9f9; /* 배경색 */
        }
        
        #prodForm label {
        	font-size: 20px !important;
        }
        
        #prodForm button {
        	font-size: 20px;
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
						<li class="nav-item"><a href="#">제품등록</a></li>
					</ul>
				</div>
				<div class="row">
					<div class="col-md-12">
						<div class="card">
							<div class="card-header">
								<div class="card-title">제품등록</div>
							</div>

							<div class="card-body d-flex flex-column align-items-center">
								<div class="row">
									<div class="col-md-12">
									<form id="prodForm" action="" method="post" enctype="multipart/form-data">
										<div class="form-group d-flex" style="gap: 40px;">
											<!-- <div style="flex: 1;">
												<label for="prod_id" class="col-form-label" style="font-size: 1.5rem;">제품식별코드</label>
												<input type="text" class="form-control input-full"
													id="prod_id" name="prod_id" placeholder="제품식별코드" />
											</div> -->
											<div style="flex: 1;">
												<label for="prod_name" class="col-form-label-lg">제품명</label>
												<input type="text" class="form-control input-full"
													id="prod_name" name="prod_name" placeholder="제품명" />
											</div>
											<div style="flex: 1;">
												<label for="prod_category" class="col-form-label-lg">제품카테고리</label>
												<input type="text" class="form-control input-full"
													id="prod_category" name="prod_category" placeholder="제품카테고리" />
											</div>
											<!-- <div style="flex: 1;">
												<label for="prod_reguser" class="col-form-label">등록작업자</label>
												<input type="text" class="form-control input-full"
													id="prod_reguser" name="prod_reguser" placeholder="등록작업자" />
											</div>
											<div style="flex: 1;">
												<label for="prod_upduser" class="col-form-label">수정작업자</label>
												<input type="text" class="form-control input-full"
													id="prod_upduser" name="prod_upduser" placeholder="수정작업자" />
											</div> -->
										</div>
										<div class="form-group d-flex" style="gap: 40px;">
											
											<div style="flex: 1;">
												<label for="prod_brand" class="col-form-label-lg">제품브랜드</label>
												<input type="text" class="form-control input-full"
													id="prod_brand" name="prod_brand" placeholder="제품브랜드" />
											</div>
											<div style="flex: 1;">
												<label for="prod_price" class="col-form-label-lg">입고가</label>
												<input type="number" class="form-control input-full"
													id="prod_price" name="prod_price" placeholder="입고가" />
											</div>
										</div>
										<div class="form-group d-flex" style="gap: 40px;">
											
											<div style="flex: 1;">
												<label for="prod_qty" class="col-form-label-lg">제품수량</label>
												<input type="number" class="form-control input-full"
													id="prod_qty" name="prod_qty" placeholder="제품수량" />
											</div>
											<div style="flex: 1;">
												<label for="company_code" class="col-form-label-lg">입고처</label>
												<input type="text" class="form-control input-full"
													id="company_code" name="company_code" placeholder="입고처" />
											</div>
										</div>
										<div class="form-group d-flex" style="gap: 40px;">
											<div>
												<label for="prod_remarks" class="col-form-label-lg">비고</label>
												<textarea id="prod_remarks" name="prod_remarks" rows="4" cols="30" class="form-control"></textarea>
											</div>
											<div style="flex: 1;">
												<label for="uploadfile" class="col-form-label-lg">제품이미지</label>
												<input type="file" class="form-control input-full"
													id="uploadfile" name="uploadfile" accept=".jpeg, .jpg, .png, .gif" />
											</div>
											<div class="preview">
												<img id="previewimg" alt="미리보기이미지" src="#"/>
											</div>
										</div>
										<div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
											<button type="submit" class="btn btn-success" id="alert_demo_3_3">제품 등록</button>
											<!-- 리셋버튼추가 -->
											<button type="button" class="btn btn-danger" id="alert_demo_7">입력 초기화</button>
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
	    	

	        $('#uploadfile').on('change', function(event) {
	            const file = event.target.files[0]; // 선택된 파일
	            if (file) {
	                // MIME 타입 확인
	                const ImageTypes = [
	                    'image/jpeg',  // JPEG
	                    'image/png',   // PNG
	                    'image/gif',   // GIF
	                    //'image/bmp',   // BMP
	                    //'image/tiff',  // TIFF
	                    //'image/webp',  // WEBP
	                    //'image/svg+xml', // SVG
	                    //'image/heif',  // HEIF
	                    //'image/heic'   // HEIC
	                ]; // 허용하는 이미지 타입

	                if (!ImageTypes.includes(file.type)) {
	                    swal("오류!", "이미지 파일만 업로드 가능합니다.", "error");
	                    $('#uploadfile').val(''); // 입력값 초기화 (업로드 자체를 막음)
	                    $('#previewimg').hide(); // 미리보기 숨김
	                    return; // 함수 종료
	                }

	                const reader = new FileReader(); // FileReader 객체 생성

	                // 파일이 로드되면 미리보기 이미지 src를 설정
	                reader.onload = function(e) {
	                	$('#previewimg').attr('src', e.target.result); // jQuery로 src 설정
	                    $('#previewimg').css('display', 'inline-block'); // 미리보기 보여줌
	                };

	                reader.readAsDataURL(file); // 파일을 Data URL로 읽기
	            } else {
	                // 파일 선택이 취소된 경우
	                $('#uploadfile').val(''); // 입력값 초기화
	                $('#previewimg').hide(); // 미리보기 숨김
	            }
	        });
	    	
	    	
	        $('#prodForm').on('submit', function (e) {
	            e.preventDefault(); // 기본 제출 이벤트 방지
	
	            var formData = new FormData(this); // FormData 객체 생성
	
	            $.ajax({
	                url: '/prod/insert', // 서버의 처리 URL
	                type: 'POST',
	                data: formData,
	                processData: false, // jQuery가 데이터를 처리하지 않도록 설정
	                contentType: false, // jQuery가 Content-Type을 설정하지 않도록 설정
	                success: function (response) {
	                    // 성공 시 SweetAlert 모달 표시
	                    swal("성공!", "제품이 등록되었습니다!", "success");
	                    $('input').val('');
	                    $('#uploadfile').val('');
	                    $('#prod_remarks').val('');
	                    $('#previewimg').hide();
	                },
	                error: function (error) {
	                    // 오류 시 SweetAlert 모달 표시
	                    swal("오류!", "제품 등록에 실패했습니다.", "error");
	                }
	            });
	        });
	        
	        
	        $("#alert_demo_7").click(function (e) {
	            swal({
	                title: "입력값을 초기화하시겠습니까?",
	                text: "입력값이 모두 지워집니다!",
	                type: "warning",
	                buttons: {
	                    confirm: {
	                        text: "네, 지우겠습니다.",
	                        className: "btn btn-success",
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
	                    $('input').val('');
	                    $('#uploadfile').val('');
	                    $('#prod_remarks').val('');
	                    $('#previewimg').hide();

	                    swal({
	                        title: "초기화되었습니다.",
	                        text: "모든 입력값이 초기화되었습니다.",
	                        type: "success",
	                        buttons: {
	                            confirm: {
	                                className: "btn btn-success",
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