<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <footer class="footer">
          <div class="container-fluid d-flex justify-content-between">
            <nav class="pull-left">
              <ul class="nav">
                <li class="nav-item">
                  <a class="nav-link" href="http://www.themekita.com">
                    ThemeKita
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"> Help </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"> Licenses </a>
                </li>
              </ul>
            </nav>
            <div class="copyright">
              2024, made with <i class="fa fa-heart heart text-danger"></i> by
              <a href="http://www.themekita.com">ThemeKita</a>
            </div>
            <div>
              Distributed by
              <a target="_blank" href="https://themewagon.com/">ThemeWagon</a>.
            </div>
          </div>
        </footer>
      
      	<!--   Core JS Files   -->
	<script src="${pageContext.request.contextPath }/resources/js/core/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<!-- jQuery Scrollbar -->
	<script
		src="/resources/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<!-- Chart JS -->
	<script src="/resources/js/plugin/chart.js/chart.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<!-- jQuery Sparkline -->
	<script	src="${pageContext.request.contextPath }/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

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
	
	<!-- sock JS -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script>
$(document).ready(function(){
	
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
						message = '<b class="text-danger">' + lowStockProd.slice(0, displayCount).join(', ') + '</b>' + ' 등 <b class="text-warning"> ' + (lowStockProd.length) + '개</b> 제품의 재고수량이 부족합니다.';
					} else {
						message = '<b class="text-danger">' + lowStockProd.join('/ ') + '</b>' + '의 재고수량이 부족합니다!';
					}

					$.notify({}, {
						type: "warning",
						delay: 0,
						placement: {
							from: "bottom",
							align: "right"
						},
						template: '<div data-notify="container" class="alert alert-danger" role="alert">' +
							'<span data-notify="icon" class="icon-bell"></span>' +
							'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
							'<span data-notify="title" style="font-size: 20px;"><b>적정재고수량 경고</b></span> ' +
							'<span data-notify="message" style="font-size: 16px;">' +
							message + '</span>' +
							'</div>',
							onClosed: function() {
								localStorage.setItem('alertShown', 'true');
							}
					});

				}
				console.log();	
			},
			error: function(xhr, status, error) {
				console.error('데이터 불러오기 실패:', error);
			}
		});
	}
	
	checkStock();
	// 알림 테스트
	
	
	/* // 알림 테스트
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
						message = '<b class="text-secondary">' + lowStockProd.slice(0, displayCount).join(', ') + '</b>' + ' 등 <b class="text-warning"> ' + (lowStockProd.length) + '개</b> 제품의 재고수량이 부족합니다.';
					} else {
						message = '<b class="text-secondary">' + lowStockProd.join('/ ') + '</b>' + '의 재고수량이 부족합니다!';
					}

					$.notify({}, {
						type: "warning",
						delay: 5000,
						placement: {
							from: "bottom",
							align: "right"
						},
						template: '<div data-notify="container" class="alert alert-secondary" role="alert">' +
							'<span data-notify="icon" class="icon-bell"></span>' +
							'<button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button>' +
							'<span data-notify="title" style="font-size: 20px;"><b>적정재고수량 경고</b></span> ' +
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
	// 알림 테스트 */
	
	
	
	// 사이드바 이펙트
	$('a[data-bs-toggle="collapse"]').on('click', function() {
		var hrefValue = $(this).attr('href');
		$(hrefValue).closest('.nav-item').addClass('active');
		
		if(localStorage.getItem('colShow') == null) {
			localStorage.setItem('colShow', hrefValue);
		} else if(localStorage.getItem('colShow') == hrefValue) {
			$(localStorage.getItem('colShow')).closest('.nav-item').removeClass('active');
			localStorage.removeItem('colShow');
			localStorage.removeItem('colActive');
		} else if(localStorage.getItem('colShow') != hrefValue) {
			$(localStorage.getItem('colShow')).removeClass('show');
			$(localStorage.getItem('colShow')).closest('.nav-item').removeClass('active');
			localStorage.setItem('colShow', hrefValue);
		}
	});
	const value = localStorage.getItem('colShow');
	
	if(value != null && value!= "") {
		$(value).addClass('show');
		$(value).closest('.nav-item').addClass('active');
	} else {
		console.log('사이드바 메인메뉴 활성화X (footer) : '+value);
	}
	
	$('.subMenu').on('click', function(e) {
		e.preventDefault();
		var hrefValue2 = $(this).attr('id');
		$("#"+hrefValue2).closest('li').addClass('active');
		if(localStorage.getItem('colActive') == null) {
			localStorage.setItem('colActive', hrefValue2);
		} 
		else if(localStorage.getItem('colActive') != hrefValue2) {
			$("#"+localStorage.getItem('colActive')).closest('li').removeClass('active');
			localStorage.setItem('colActive', hrefValue2);
		}
		window.location.href = $(this).attr('href');
	});
	const value2 = localStorage.getItem('colActive');
	
	if(value2 != null && value2 != "") {
		$("#"+value2).closest('li').addClass('active');
	} else {
		console.log('사이드바 보조메뉴 활성화X (footer) :'+value2);
	}
	
	$('#mainPage1,#mainPage2').on('click', function(){
		$(localStorage.getItem('colShow')).closest('.nav-item').removeClass('active');
		localStorage.removeItem('colShow');
		localStorage.removeItem('colActive');
		$('li').removeClass('active');
	});
	// 사이드바 이펙트
	
	
	
});//DOM준비
</script>