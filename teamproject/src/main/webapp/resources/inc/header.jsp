<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<div class="main-panel">
		<div class="main-header">
			<div class="main-header-logo">
				<!-- Logo Header -->
				<div class="logo-header" data-background-color="light">
					<a href="index.html" class="logo"> <img
						src="/resources/img/kaiadmin/logo_light.svg" alt="navbar brand"
						class="navbar-brand" height="20" />
					</a>
					<div class="nav-toggle">
						<button class="btn btn-toggle toggle-sidebar">
							<i class="gg-menu-right"></i>
						</button>
						<button class="btn btn-toggle sidenav-toggler">
							<i class="gg-menu-left"></i>
						</button>
					</div>
					<button class="topbar-toggler more">
						<i class="gg-more-vertical-alt"></i>
					</button>
				</div>
				<!-- End Logo Header -->
			</div>
			<!-- Navbar Header -->
			<nav
				class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom">
				<div class="container-fluid">
					<nav
						class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex">
						<div class="input-group">
							<div class="input-group-prepend">
								<button type="submit" class="btn btn-search pe-1">
									<i class="fa fa-search search-icon"></i>
								</button>
							</div>
							<input type="text" placeholder="Search ..." class="form-control" />
						</div>
					</nav>

					<ul class="navbar-nav topbar-nav ms-md-auto align-items-center">

						<li class="nav-item topbar-user dropdown hidden-caret"><a onclick="getInfo()"
							class="dropdown-toggle profile-pic" data-bs-toggle="dropdown"
							href="#" aria-expanded="false">
								<div class="avatar-sm" style="text-align: center; line-height: 54px;">
									<i class="icon-user" style="font-size: 30px"></i>
								</div> <span class="profile-username"> <span class="fw-bold">${sessionScope.name}</span>
									<span class="op-7">님</span>
							</span>
						</a>
							<ul class="dropdown-menu dropdown-user animated fadeIn" style="width: 280px">
								<div class="dropdown-user-scroll scrollbar-outer">
									<li>
										<div class="user-box">
											<div class="avatar-lg"
												style="text-align: center; line-height: 9.97rem;">
												<i class="icon-user" style="font-size: 30px"></i>
											</div>
											<div class="u-text">
												<h4>${sessionScope.name} 님</h4>
												<p class="text-muted" >이메일 : ${sessionScope.email}</p>
												<p class="text-muted" >전화번호 : ${sessionScope.tel}</p>
												<p class="text-muted" >직급 : <span id="userInfoEmp"></span></p>
												<p class="text-muted" >부서 : <span id="userInfoDept"></span></p>
											</div>
										</div>
									</li>
									<li>
										<div class="dropdown-divider"></div> <a class="dropdown-item"
										href="#">Logout</a>
									</li>
								</div>
							</ul></li>
					</ul>
				</div>
			</nav>
			<!-- End Navbar -->
		</div>
		
		<script type="text/javascript">
		let userInfoEmp = '${sessionScope.employee_rank}';		 
		let userInfoDept = '${sessionScope.department_id}';		 
		 function getInfo() {
			
			 
			 
			 
			 const url = "/postInfo";

			    fetch(url, {
			        method: 'POST',
			        headers: {
			            'Content-Type': 'application/json'
			        },
			    })
			    .then(response => {
			        // 응답이 성공적인지 확인
			        if (!response.ok) {
			            throw new Error('네트워크 응답이 좋지 않습니다: ' + response.statusText);
			        }
			        return response.json(); // 응답을 JSON으로 변환
			    })
			    .then(data => {
			        // 데이터를 화면에 표시
			        
			        console.log(data.empRank);
			        console.log(data.department);
			       
			        
			        const resultEmp = document.getElementById('userInfoEmp');
			        const resultDept = document.getElementById('userInfoDept');
			        
			        resultEmp.innerHTML = "";
			        resultDept.innerHTML = "";
			     // empRank를 HTML로 표시
			        for (const key in data.empRank) {
			            const emp = data.empRank[key];

			            // 입력한 값과 비교
			            if (emp.common_value == userInfoEmp) {
			                resultEmp.innerHTML += emp.common_status;
			            }
			        }
			     
			        for (const key in data.department) {
			            const dept = data.department[key];

			            // 입력한 값과 비교
			            if (dept.department_id == userInfoDept) {
			            	resultDept.innerHTML += dept.department_name;
			            }
			        }


		/* 	        // 응답 데이터로 HTML 업데이트
			        resultEmp.innerHTML = data.empInfo; // 적절한 키로 변경
			        resultDept.innerHTML = data.deptInfo; // 적절한 키로 변경 */
			    })
			    .catch(error => {
			        console.error('문제가 발생했습니다:', error);
			    });}
		</script>