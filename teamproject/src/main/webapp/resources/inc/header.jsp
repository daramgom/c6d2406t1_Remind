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

					<li class="nav-item topbar-user dropdown hidden-caret"><a
						onclick="getInfo()" class="dropdown-toggle profile-pic"
						data-bs-toggle="dropdown" href="#" aria-expanded="false">
							<div class="avatar-sm"
								style="text-align: center; line-height: 54px;">
								<i class="icon-user" style="font-size: 30px"></i>
							</div> <span class="profile-username"> <span class="fw-bold">${sessionScope.name}</span>
								<span class="op-7">님</span>
						</span>
					</a>
						<ul class="dropdown-menu dropdown-user animated fadeIn"
							style="width: 300px">
							<div class="dropdown-user-scroll scrollbar-outer">
								<li>
									<div class="user-box">
										<div class="avatar-lg"
											style="text-align: center; line-height: 9.97rem;">
											<i class="icon-user" style="font-size: 30px"></i>
										</div>
										<div class="u-text">
											<h4 style="height: 1.5rem">
												<span id="userName">${sessionScope.name}</span> 님
												<button onclick="editField('userName')"
													style="height: 24px; border: none; background: transparent; position: relative; right: -97px">✏️</button>
											</h4>
											<p class="text-muted">
												이메일 : <span id="userEmail">${sessionScope.email}</span>
												<button onclick="editField('userEmail')"
													style="height: 24px; border: none; background: transparent; position: relative;">✏️</button>
											</p>
											<p class="text-muted" >
												전화번호 : <span id="userTel">${sessionScope.tel}</span>
												<button onclick="editField('userTel')"
													style="height: 24px; border: none; background: transparent; position: relative; right: -15px;">✏️</button>
											</p>
											<p class="text-muted">
												직급 : <span id="userInfoEmp">${sessionScope.emp}</span>
											</p>
											<p class="text-muted">
												부서 : <span id="userInfoDept">${sessionScope.dept}</span>
											</p>
										</div>
									</div>
								</li>
								<li>
									<div class="dropdown-divider"></div> <a class="dropdown-item"
									onclick="Logout()">Logout</a>
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
			        if (!response.ok) {
			            throw new Error('네트워크 응답이 좋지 않습니다: ' + response.statusText);
			        }
			        return response.json(); // 응답을 JSON으로 변환
			    })
			    .then(data => {
			        
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


			    })
			    .catch(error => {
			        console.error('문제가 발생했습니다:', error);
			    });};
	    function editField(field) {
	    	
	        const span = document.getElementById(field);
	        const currentValue = span.textContent;
	       	let action = "";
	        
	        if(field == "userName" ) {
	        	action = "이름을";
	        } else if(field == "userEmail") {
	        	action = "이메일을";
	        } else {
	        	action = "전화번호를";
	        }
	        const newValue = prompt("수정할 " + action + " 입력하세요:", currentValue);
	        
	        if( newValue == null ) {
	       		return;
	        }
	        // span = 변경할 데이터베이스 속성 (member_name , member_email , member_tel)
	        // newValue = 변경할 값.
	        
	        if( newValue != null && field == "userEmail") {
	        	sendVerificationCode(newValue);
	        }
	        updateinfo( span , newValue);
	        
	        

	    }
	    function sendVerificationCode (newValue) {
	    		const url =  "/sendVerificationCode";
        		const updateEmail = {
        			email : newValue
        		}
    	        fetch(url, {
    	            method: 'POST', // 또는 'POST'로 변경 가능
    	            headers: {
    	                'Content-Type': 'application/json',
    	            },
    	        	 body: JSON.stringify(updateEmail) // JSON 형식으로 데이터 전송
    	        })
    	        .then(response => {
    	            if (!response.ok) {
    	                throw new Error('네트워크 응답이 정상적이지 않습니다.');
    	            }
    	            return response.json();
    	        })
    	        .then(data => {
    	        	console.log(data);
    	        	if(data) {
	    	            alert("인증코드가 이메일로 전송되었습니다!");
	    	            
	    	            const emailcode = prompt("인증코드를  입력하세요.", currentValue);
	    	            
	    	            if(emailcode == null ){
	    	            	return;
	    	            }
	    	            verifyCode(emailcode);
    	        	}else {
    	        		return;
    	        	}
    	        })
    	        
    	        .catch(error => {
    	            console.error('업데이트 중 오류가 발생했습니다:', error);
    	        });
	    }
	    
	    function verifyCode(emailcode) {
	    	const url =  "/verifyCode";
        		// AJAX 요청 (예: Fetch API 사용)
        		const Code = {
        			code : emailcode
        		}
    	        fetch(url, {
    	            method: 'POST', // 또는 'POST'로 변경 가능
    	            headers: {
    	                'Content-Type': 'application/json',
    	            },
    	        	 body: JSON.stringify(Code) // JSON 형식으로 데이터 전송
    	        })
    	        .then(response => {
    	            if (!response.ok) {
    	                throw new Error('네트워크 응답이 정상적이지 않습니다.');
    	            }
    	            return response.json();
    	        })
    	        .then( data => {
    	        	updateinfo( span , newValue);  	    	        	
    	        })
    	        .catch( error => {
    	            console.error('업데이트 중 오류가 발생했습니다:', error);
    	        })
	    }
	    
	    function updateinfo( span, newValue) {
	    	const url =  "/updateMemberInfo";
	    	const data = {
	    			span : span,
	    			new_value : newValue 
	    			
	    	};
	    	// AJAX 요청 (예: Fetch API 사용)
	        fetch(url, {
	            method: 'POST', // 또는 'POST'로 변경 가능
	            headers: {
	                'Content-Type': 'application/json',
	            },
	        	 body: JSON.stringify(data) // JSON 형식으로 데이터 전송
	        })
	        .then(response => {
	            if (!response.ok) {
	                throw new Error('네트워크 응답이 정상적이지 않습니다.');
	            }
	            return response.json();
	        })
	        .then(data => {
	            console.log('정보가 성공적으로 업데이트되었습니다:', data);
	        })
	        .catch(error => {
	            console.error('업데이트 중 오류가 발생했습니다:', error);
	        });
	    }
			    
		 
		 function Logout() {
			 const url = "/logout";

			 fetch(url, {
				    method: 'POST',
				})
				.then(response => {
				    if (!response.ok) {
				        throw new Error('네트워크 응답이 좋지 않습니다: ' + response.statusText);
				    }
				})
				.then(() => {
				    alert("로그아웃이 정상적으로 실행되었습니다.");
				    location.href = "login";
				})
				.catch(error => {
				    console.error('문제가 발생했습니다:', error);
				});
		 };
		 
		</script>