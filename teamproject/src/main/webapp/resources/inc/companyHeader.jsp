<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script src="/resources/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: {
          families: ["Public Sans:300,400,500,600,700"],
        },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["/resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

<div class="main-panel">
	<div class="main-header">
		<div class="main-header-logo">
			<!-- Logo Header -->
			<div class="logo-header" data-background-color="light">
				<a href="#" class="logo"> <img
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
						<ul id="userInfo" class="dropdown-menu dropdown-user animated fadeIn"
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
													style="height: 24px; border: none; background: transparent; position: absolute; right: 0px; width: 31px;">✏️</button>
											</h4>
											<p class="text-muted" style="height: 1.5rem;">
												전화번호 : <span id="userTel">${sessionScope.tel}</span>
												<button onclick="editField('userTel')"
													style="height: 24px; border: none; background: transparent; position: absolute; right: 0px; width: 31px; font-size: 14px;">✏️</button>
											</p>
											<p class="text-muted">
												이메일 : <span id="userEmail">${sessionScope.email}</span>
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
		 function isValidKoreanName(name) {
			    const namePattern = /^[가-힣]{2,10}$/; // 한글만, 2자 이상 10자 이하
			    return namePattern.test(name);
		  }

		// 전화번호 형식 정규 표현식 (하이픈 없이 10자 또는 11자)
		  function isValidPhoneNumber(phone) {
		      const phonePattern = /^\d{11}$/; // 숫자만, 10자 또는 11자
		      return phonePattern.test(phone);
		  }
		// 전화번호에 하이픈 추가하는 함수
		  function formatPhoneNumber(phone) {
		      if (phone.length === 11) {
		          return phone.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		      }
		      return phone; // 유효하지 않은 경우 원래 값 반환
		  }

		  document.addEventListener("click", function(event) {
			    const isUserInfoClick = userInfo.contains(event.target) || event.target.closest('.topbar-user'); // topbar-user 클릭 여부 확인

			    if (!isUserInfoClick) {
			        userInfo.classList.remove("show");
			    }
			}); 

		function getInfo() {
		 	const userInfo = document.getElementById("userInfo");
		    	userInfo.classList.add("show");
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
			    });
		};
		function editField(field) {
		    const span = document.getElementById(field);
		    const currentValue = span.textContent;

		    // 데이터베이스에서 가져온 전화번호를 하이픈 없이 표시하기
		    let displayValue = currentValue;
		    if (field === "userTel") {
		        displayValue = displayValue.replace(/-/g, ''); // 하이픈 제거
		    }

		    console.log("span : " + field);
		    let action = "";

		    if (field == "userName") {
		        action = "이름을";
		    } 
		    else {
		        action = "전화번호를 (하이픈 없이)";
		    }
		    const newValue = prompt("수정할 " + action + " 입력하세요:", displayValue);

		    if (newValue == null) {
		        return;
		    }

		    // 유효성 검사
		    if (field == "userName" && !isValidKoreanName(newValue)) {
		        alert("잘못된 이름입니다. 한글로 2자 이상 10자 이하로 입력하세요.");
		        return;
		    }


		    if (field == "userTel" && !isValidPhoneNumber(newValue)) {
		        alert("잘못된 전화번호입니다. 하이픈 없이 11자로 입력하세요.");
		        return;
		    }

		    // 하이픈을 포함한 전화번호로 변환
		    let formattedPhoneNumber = newValue;
		    if (field == "userTel") {
		        formattedPhoneNumber = formatPhoneNumber(newValue);
		    }

		    // 변경된 값이 현재 값과 다를 경우에만 업데이트
		    if (newValue !== currentValue) {
		        updateinfo(field, field === "userTel" ? formattedPhoneNumber : newValue);
		    } else {
		        alert("변경된 값이 없습니다.");
		    }
		}

	   
	    
	    function updateinfo( field, newValue) {
	    	const url =  "/updateMemberInfo";
	    	const data = {
	    			field : field,
	    			new_value : newValue 
	    			
	    	};
	    	
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
	            if (data.success) {
	                alert("정상적으로 정보가 변경되었습니다.");
	               location.reload(); 
	            } else {
	                alert("중복된 값입니다."); // field 값 중복 시 경고 메시지
	            }
	            console.log('정보가 성공적으로 업데이트되었습니다: ' + JSON.stringify(data));
	        })
	        .catch(error => {
	            console.error('업데이트 중 오류가 발생했습니다: ' + error);
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
				    localStorage.removeItem('colShow');
					localStorage.removeItem('colActive');
					localStorage.removeItem('alertShown');
					// 로그인 페이지로 이동하기 전에 현재 상태를 변경
		            window.history.replaceState(null, '', '/login');					
				    location.href = "/login";
				})
				.catch(error => {
				    console.error('문제가 발생했습니다:', error);
				});
		 };
		 
		</script>