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
		
	// 사이드바 이펙트
	$('a[data-bs-toggle="collapse"]').on('click', function() {
		var hrefValue = $(this).attr('id');
		$("#"+hrefValue).closest('.nav-item').addClass('active');
		
		if(localStorage.getItem('colShow') == null) {
			localStorage.setItem('colShow', "#"+hrefValue);
		} else if(localStorage.getItem('colShow') == "#"+hrefValue) {
			$(localStorage.getItem('colShow')).closest('.nav-item').removeClass('active');
			localStorage.removeItem('colShow');
		} else if(localStorage.getItem('colShow') != "#"+hrefValue) {
			$(localStorage.getItem('colShow')).closest('.nav-item').removeClass('active');
			localStorage.setItem('colShow', "#"+hrefValue);
		}
	});
	const value = localStorage.getItem('colShow');
	
	if(value != null && value!= "") {
		$(value).closest('.nav-item').addClass('active');
	} else {
		console.log('사이드바 메인메뉴 활성화X (footer) : '+value);
	}
	
	$('#mainPage').on('click', function(){
		$(localStorage.getItem('colShow')).closest('.nav-item').removeClass('active');
		localStorage.removeItem('colShow');
		localStorage.removeItem('colActive');
		$('li').removeClass('active');
	});
	// 사이드바 이펙트
	
	
	
});//DOM준비
</script>