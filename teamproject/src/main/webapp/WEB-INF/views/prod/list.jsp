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
	
	#multi-filter-select thead th {
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

	.modal-dialog {
		--bs-modal-width: 1200px;
	}

	.modal-content {
		height: 90vh;
		overflow-y: auto;
		overflow-x: hidden;
	}
    
	#previewimg {
		width: 95%;
		height: 95%;
		margin: 10px;
		object-fit: contain;
	}

	.preview {
		width: 200px;
		height: 150px;
		margin: 10px;
		border: 2px dashed #ccc;
		display: flex;
		justify-content: center;
		align-items: center;
		background-color: #f9f9f9;
	}
	
	#prodUpdateForm label {
		font-size: 1.1rem !important;
	}

	#prodUpdateForm input {
		font-size: 1.1rem !important;
	}
	
	.modal-footer i {
		font-size: 1.2rem;
		line-height: 2;
	}
	
	.modal-footer button {
		font-size: 1.2rem;
		line-height: 2;
		margin-bottom: 10px;
		font-weight: bold;
	}

	textarea {
		transition: background-color 0.3s, border 0.3s;
	}
	
	input:not([readonly]):not([disabled]) {
		transition: background-color 0.3s, border 0.3s;
	}

	input:not([readonly]):not([disabled]):hover {
		background-color: rgba(104,97,206,0.1) !important;
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
                  제품목록
                </li>
              </ul>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <h3 class="card-title">제품목록</h3>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive" 
                    style="overflow-x: auto; -webkit-overflow-scrolling: touch;">
                      <table
                        id="multi-filter-select"
                        class="display table table-hover"
                      >
                        <thead>
                          <tr>
                            <th>제품식별코드</th>
                            <th>제품명</th>
                            <th>카테고리</th>
                            <th>수량</th>
                            <th>입고처</th>
                            <th>등록일시</th>
                            <th>제품이미지</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>제품식별코드</th>
                            <th>제품명</th>
                            <th>카테고리</th>
                            <th>수량</th>
                            <th>입고처</th>
                            <th>등록일시</th>
                            <th></th>
                          </tr>
                        </tfoot>
                        <tbody>
						<c:forEach var="p" items="${plistVO}">
							<tr class="prod_detail">
								<td style="padding:0 !important;">${p.prod_id}</td>
								<td style="padding:0 !important;">${p.prod_name}</td>
								<td style="padding:0 !important;">${p.prod_category}</td>
								<td style="padding:0 !important;">${p.prod_qty}</td>
								<td style="padding:0 !important;">${p.company_name}</td>
								<td style="padding:0 !important;">${p.formatted_regdate}</td>
								<td style="padding:0 !important;"><img src="${p.prod_image}" alt="제품이미지" style="width:75px; height:75px; object-fit: contain;"></td>
							</tr>
						</c:forEach>
                        </tbody>
                      </table>
                      
					<!-- Modal -->
                    <div
                      class="modal fade"
                      id="prodModal"
                      tabindex="-1"
                      role="dialog"
                      aria-hidden="true"
                    >
                      <div class="modal-dialog" role="document" style="width:1200px">
                        <div class="modal-content">
                          <div class="modal-header border-0">
                            <h5 class="modal-title">
                              <span class="fw-mediumbold"> 제품상세정보 </span>
                            </h5>
                            <button
                              type="button"
                              class="close"
                              data-bs-dismiss="modal"
                              aria-label="Close"
                            >
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">
                            <form action="/prod/update" id="prodUpdateForm" method="post" enctype="multipart/form-data">
                              <div class="row">
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품식별코드</label>
                                    <input
                                      id="prod_id"
                                      name="prod_id"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품식별코드"
                                      readonly="readonly"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품이름</label>
                                    <input
                                      id="prod_name"
                                      name="prod_name"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품이름"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>제품카테고리</label>
                                    <input
                                      id="prod_category"
                                      name="prod_category"
                                      type="text"
                                      class="form-control"
                                      placeholder="제품카테고리"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>브랜드</label>
                                    <input
                                      id="prod_brand"
                                      name="prod_brand"
                                      type="text"
                                      class="form-control"
                                      placeholder="브랜드"
                                      required="required"
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>입고처</label>
                                    <input
                                      id="company_code"
                                      name="company_code"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>등록일시</label>
                                    <input
                                      id="prod_regdate"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>등록자</label>
                                    <input
                                      id="prod_regname"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                              	</div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>수정일시</label>
                                    <input
                                      id="prod_upddate"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>수정자</label>
                                    <input
                                      id="prod_updname"
                                      type="text"
                                      class="form-control"
                                      disabled
                                    />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>비고</label>
                                    <textarea 
                                    	id="prod_remarks" 
                                    	name="prod_remarks" 
                                    	rows="4" cols="30" 
                                    	class="form-control"
                                    	style="background-color: transparent;"
                                    	onmouseover="this.style.setProperty('background-color', 'rgba(104,97,206,0.1)', 'important')"
                                    	onmouseout="this.style.setProperty('background-color', 'transparent', 'important')"></textarea>
                                  </div>
                                </div>
                                <div class="col-md-4">
                                  <div class="form-group form-group-default">
                                    <label>이미지</label>
                                    <input type="file" 
                                    	class="form-control input-full"
										id="uploadfile" 
										name="uploadfile" 
										accept=".jpeg, .jpg, .png, .gif" />
                                  </div>
									<div class="form-group-default"> 
										<div class="d-flex justify-content-center">
											<div class="form-check d-flex align-items-center">
												<input class="form-check-input" type="radio" name="prod_option" id="prod_barcode" value="barcode">
												<label class="form-check-label" for="prod_barcode">바코드</label>
											</div>
											<div style="flex:1">
											</div>
											<div class="form-check d-flex align-items-center">
												<input class="form-check-input" type="radio" name="prod_option" id="prod_qrcode" value="qrcode">
												<label class="form-check-label" for="prod_qrcode">QR코드</label>
											</div>
											<div style="flex:1">
											</div>
										</div>
										<div class="d-flex align-items-center justify-content-center">
											<img id="codeImage" alt="#" src="#" 
											style="width: #; height: #; margin-bottom: 10px; display: none; object-fit: contain;">
										</div>
									</div>
                               </div>
								<div class="col-md-4" style="display: flex;">
									<div class="preview">
										<img id="previewimg" alt="미리보기이미지" src="#"/>
									</div>
									<div style="margin-top:10px;">
										<button class="btn btn-black btn-border btn-sm" id="image_delete">이미지제거</button>
									</div>
								</div>
								<input type="hidden" id="prod_upduser" name="prod_upduser">
								<input type="hidden" id="prod_image" name="prod_image">
								<input type="hidden" id="temp_image" name="temp_image">
                              </div>
                         	</form>
							<div class="card-body">
	                         	 <table class="table table-hover" id="stockList">
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
						
                          <div class="modal-footer border-0" style="justify-content : center;">
                            <button
                              type="button"
                              id="prodUpdate"
                              class="btn btn-secondary"
                            >
                              <i class="fa fa-pen"><b> 제품 수정</b></i>
                            </button>
                            <button
                              type="button"
                              id="prodDelete"
                              class="btn btn-danger"
                            >
                             <i class="fa fa-trash"><b> 제품 삭제</b></i>
                            </button>
                            <button
                              type="button"
                              class="btn btn-black"
                              data-bs-dismiss="modal"
                            >
                              닫기
                            </button>
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
        </div>
		
		<!-- Footer -->
		<jsp:include page="${pageContext.request.contextPath}/resources/inc/footer.jsp" />
	</div>

	
	<script type="text/javascript">
	$(document).ready(function () {
		let prodImage;
		
		
		// 데이터테이블
        $("#multi-filter-select").DataTable({
        	autoWidth: false,
        	pageLength: 10, // 기본 페이지 길이
        	lengthMenu: [10, 20, 50, 100, 500], // 사용자가 선택할 수 있는 페이지 길이 옵션
        	initComplete: function () {
        		var table = this.api();

                // 필터를 적용할 열 인덱스 배열 (예: 두 번째 열과 세 번째 열)
                var columnsToFilter = [0,1,2,3,4,5];

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
     	
       
    	// <tr> 클릭 시 모달 열기
       $('#multi-filter-select tbody').on('click', '.prod_detail', function() {
           var row = $(this); // 클릭한 <tr>
           var prod_id = row.find('td:eq(0)').text(); // 제품 식별 코드

           // prod_id를 POST 방식으로 보내기
           fetch('/prod/find', {
               method: 'POST', // HTTP 메서드 설정
               headers: {
                   'Content-Type': 'application/json' // 요청 본문의 데이터 형식 설정
               },
               body: JSON.stringify({ prod_id: prod_id }) // JSON 형식으로 데이터 전송
           })
           .then(response => {
               if (!response.ok) {
                   throw new Error('네트워크 응답이 올바르지 않습니다');
               }
               return response.json(); // JSON으로 응답 파싱
           })
           .then(data => {
               // 모달에 데이터 설정
               $("#prod_id").val(prod_id);
               $("#prod_name").val(data.prodVO.prod_name);
               $("#prod_category").val(data.prodVO.prod_category);
               $("#prod_brand").val(data.prodVO.prod_brand);
               $("#company_code").val(data.prodVO.company_name);
               $("#prod_regdate").val(data.prodVO.formatted_regdate);
               $("#prod_regname").val(data.prodVO.prod_regname);
               $("#prod_upddate").val(data.prodVO.formatted_upddate);
               $("#prod_updname").val(data.prodVO.prod_updname);
               $("#prod_upduser").val('${sessionScope.id}');
               $("#prod_remarks").val(data.prodVO.prod_remarks);
               prodImage = data.prodVO.prod_image;
			   $("#previewimg").attr("src", prodImage);
			   $("#previewimg").show();
			   $("#prod_image").val(prodImage);
			   $("#temp_image").val(prodImage);
			   
			   
               // 재고 리스트 표시
               const stockListBody = $("#stockListBody");
               stockListBody.empty(); // 기존 재고 리스트 초기화

               data.stockListVO.forEach(stock => {
                   const stockRow = $('<tr></tr>');
                   stockRow.append('<td style="padding:0 !important;">' + stock.prod_id + '</td>');
                   stockRow.append('<td style="padding:0 !important;">' + stock.wh_number + ' - ' + stock.wh_name + ' - ' + stock.wh_location + ' - ' + stock.wh_dt_location + '</td>');
                   stockRow.append('<td style="padding:0 !important;">' + stock.prod_qty + '</td>');
                   stockListBody.append(stockRow);
               });
               
               // 모달 열기
               $("#prodModal").modal('show');
           })
           .catch(error => {
               console.error('데이터를 가져오는 과정에서 문제가 발생했습니다', error);
           });
       });
    	// <tr> 클릭 시 모달 열기
     	
    	
		// 이미지 업로드 미리보기
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
	                	swal({
	                    	title: "오류!",
	                    	text: "제품 등록에 실패했습니다.",
	                    	icon: "error",
	                    	buttons: {
	                    		confirm:{
	                    			text: "확인",
									className: 'btn btn-secondary'
	                    		}
							}
	                    });
	                    $('#uploadfile').val(''); // 입력값 초기화 (업로드 자체를 막음)
	                    $('#previewimg').hide(); // 미리보기 숨김
	                    return; // 함수 종료
	                }

	                const reader = new FileReader(); // FileReader 객체 생성

	                // 파일이 로드되면 미리보기 이미지 src를 설정
	                reader.onload = function(e) {
	                	$('#previewimg').show();
	                	$('#previewimg').attr('src', e.target.result); // jQuery로 src 설정
	                };

	                reader.readAsDataURL(file); // 파일을 Data URL로 읽기
	                
	            } else {
	                // 파일 선택이 취소된 경우
	                $('#uploadfile').val(''); // 입력값 초기화
	                $("#previewimg").attr("src", prodImage);
	            }
	        });
     	// 이미지 업로드 미리보기
    	
     	// 이미지 제거
     	$("#image_delete").click(function(e) {
     		e.preventDefault();
     		$("#prod_image").val('');
     		$('#uploadfile').val('');
     		$("#previewimg").hide();
     	});
    	// 이미지 제거
    	
    	// 제품정보 수정사항 제출
		$("#prodUpdate").click(function() {
			$("#prodUpdateForm").submit();
		});
		
		$('#prodUpdateForm').on('submit', function (e) {
			e.preventDefault();
			$("#prodUpdate").prop('disabled', true);
			var formData = new FormData(this);
			
			swal({
		        title: "알림!",
		        text: "제품을 수정하시겠습니까?",
		        icon: "info",
		        buttons: {
		            confirm: {
		                text: "네, 수정하겠습니다.",
		                className: "btn btn-secondary",
		            },
		            cancel: {
		            	visible: true,
		                text: "취소",
		                className: "btn btn-black",
		            },
		        },
		    }).then(function(confirm) {
		    	if(confirm) {
					$.ajax({
						url: '/prod/update',
						type: 'POST',
						data: formData,
						processData: false,
						contentType: false,
						success: function (response) {
							swal({
								title: "성공!",
								text: "제품이 수정되었습니다!",
								icon: "success",
								buttons: {
									confirm: {
										text: "확인",
										className: "btn btn-secondary"
									}
								}
							}).then(() => {
								location.reload();
							});
						},
						error: function (error) {
							swal({
								title: "오류!",
								text: "제품 수정에 실패했습니다.",
								icon: "error",
								buttons: {
									confirm: {
										text: "확인",
										className: "btn btn-secondary"
									}
								}
							});
							var currentImage = $('#prod_image').val();
							$('#prod_image').val(currentImage);
						},
						complete: function() {
							$('#prodUpdate').prop('disabled', false);
						}
					});
				} $('#prodUpdate').prop('disabled', false);
		    });
		});
     	// 제품정보 수정사항 제출
        
     	
     	// 제품정보 삭제
		$("#prodDelete").click(function() {
			var prod_id = $("#prod_id").val();
			
		swal({
			title: "제품을 삭제하시겠습니까?",
			text: "등록된 제품이 삭제됩니다!",
			icon: "warning",
			buttons: {
				confirm: {
					text: "네, 삭제하겠습니다.",
					className: "btn btn-danger",
				},
				cancel: {
					visible: true,
					text: "취소",
					className: "btn btn-black",
				},
			},
		}).then(function(confirm) {
			if (confirm) {
				$.ajax({
					url: "/prod/delete",
					type: "POST",
					data: {
						prod_id: prod_id
					},
					success: function(response) {
						swal({
							title: "삭제되었습니다.",
							text: "등록된 제품이 삭제되었습니다.",
							buttons: {
								confirm: {
									text: "확인",
									className: "btn btn-secondary",
								}
							}
						}).then(function(){
							location.reload();
						});
					},
					error: function(xhr, status, error) {
						swal({
							title: "오류 발생",
							text: "제품 삭제에 실패했습니다.",
							icon: "error",
							buttons: {
								confirm: {
									text: "확인",
									className: "btn btn-secondary",
								}
							}
						}).then(function(){
							location.reload();
						});
					}
				});
			} else {
				swal.close();
			}
		});
	});
    // 제품정보 삭제
    
    // 바코드, QR코드 생성
	$('input[name="prod_option"]').on('change', function() {
		var selectedOption = $(this).val();
		var prod_id = $("#prod_id").val();
		const absoluteUrl = new URL(prodImage, window.location.origin).href;
		
		$.ajax({
			url: '/prod/genCode', // 컨트롤러의 URL로 변경
			type: 'POST',
			data: { option: selectedOption,
					prod_id: prod_id,
					imgUrl: absoluteUrl
			},
			xhrFields: {
				responseType: 'blob'
			},
			success: function(response) {
				var url = URL.createObjectURL(response);
				if(selectedOption == 'barcode'){
					$('#codeImage').attr('src', url).attr('style', 'width: 300px; height: 100px; margin: 10px;').show();
				} else if (selectedOption == 'qrcode') {
					$('#codeImage').attr('src', url).attr('style', 'width: 200px; height: 200px;').show();
				}
			},
			error: function(error) {
				console.error('Error:', error);
			}
		});
	});
    // 바코드, QR코드 생성
    
    // 모달 닫힐때 바코드, uploadfile 초기화
	$("#prodModal").on('hidden.bs.modal', function() {
		$("#codeImage").attr('src',"").hide();
		$("input[name='prod_option']").prop('checked', false);
		$("#uploadfile").val('');
	});
    // 모달 닫힐때 바코드, uploadfile 초기화
    
    
    
});//jquery DOM 준비
</script>
  
	
	
</body>
</html>