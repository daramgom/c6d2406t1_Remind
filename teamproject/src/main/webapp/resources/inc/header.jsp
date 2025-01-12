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
    
<script type="text/javascript">
function getSessionCheck() {
    const url = "/getSessionCheck";
    const sessionCheckKey = localStorage.getItem('sessionCheckKey'); // 로컬스토리지에서 세션 체크 키 가져오기

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ sessionCheckKey }) // 세션 체크 키를 요청 본문에 포함
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('네트워크 응답이 좋지 않습니다: ' + response.statusText);
        }
        return response.json(); // 응답을 JSON으로 변환
    })
    .then(data => {
        if (data.result == "true") {
            // 동일 사용자일 경우 아무것도 하지 않음
        } else {
            // false일 경우 로그아웃 요청 보내고 로그인 페이지로 이동
            logoutAndRedirect();
        }
    })
    .catch(error => {
        console.error('문제가 발생했습니다:', error);
    });
}

// 로그아웃 요청을 보내고 로그인 페이지로 이동하는 함수
function logoutAndRedirect() {
    const logoutUrl = "/logout"; // 로그아웃 요청을 보낼 URL

    fetch(logoutUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => {
        if (response.ok) {
            // 로그아웃 성공 시 로그인 페이지로 이동
            window.location.href = "/login"; // 로그인 페이지로 이동
        } else {
            throw new Error('로그아웃 요청에 실패했습니다: ' + response.statusText);
        }
    })
    .catch(error => {
        console.error('로그아웃 중 문제가 발생했습니다:', error);
    });
}

// 함수 정의 후 즉시 호출
getSessionCheck();
</script>
    
    
    








<div class="main-panel">
	<div class="main-header">
		<div class="main-header-logo">
			<!-- Logo Header -->
			<div class="logo-header" data-background-color="light">
				<a href="/main" class="logo"> <img
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
						 class="dropdown-toggle profile-pic"
						data-bs-toggle="dropdown" href="#" aria-expanded="false">
							<div class="avatar-sm"
								style="text-align: center; line-height: 54px;">
								<i class="icon-user" style="font-size: 30px"></i>
							</div> <span class="profile-username"> <span class="fw-bold">${sessionScope.name}</span>
								<span class="op-7">님</span>
						</span>
					</a>
						<ul id="userInfo" class="dropdown-menu dropdown-user animated fadeIn"
							style="width: 360px">
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

		// 드롭다운 메뉴 호버 이벤트 처리
		    const userInfo = document.getElementById("userInfo");
		    const topbarUser = document.querySelector('.topbar-user');

		    let isHovered = false;
		    let cachedUserInfo = null; // 캐시를 위한 변수
		    
		    topbarUser.addEventListener("mouseover", function() {
		    	  if (!cachedUserInfo) { // 캐시가 없을 때만 요청
		              getInfo(); // 호버 시 정보 요청
		          } else {
		              populateUserInfo(cachedUserInfo); // 캐시된 데이터로 UI 업데이트
		          }
		        userInfo.classList.add("show");
		        isHovered = true;
		    });

		    topbarUser.addEventListener("mouseout", function() {
		        isHovered = false;
		        setTimeout(() => {
		            if (!isHovered) {
		                userInfo.classList.remove("show");
		            }
		        }, 200);
		    });

		    userInfo.addEventListener("mouseover", function() {
		        isHovered = true;
		    });

		    userInfo.addEventListener("mouseout", function() {
		        isHovered = false;
		        setTimeout(() => {
		            if (!isHovered) {
		                userInfo.classList.remove("show");
		            }
		        }, 200);
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
			    	 cachedUserInfo = data; // 데이터를 캐시
			            populateUserInfo(data); // UI 업데이트


			    })
			    .catch(error => {
			        console.error('문제가 발생했습니다:', error);
			    });
		};
		
		function populateUserInfo(data) {
	        const resultEmp = document.getElementById('userInfoEmp');
	        const resultDept = document.getElementById('userInfoDept');

	        resultEmp.innerHTML = "";
	        resultDept.innerHTML = "";

	        // empRank를 HTML로 표시
	        for (const key in data.empRank) {
	            const emp = data.empRank[key];
	            if (emp.common_value == userInfoEmp) {
	                resultEmp.innerHTML += emp.common_status;
	            }
	        }

	        for (const key in data.department) {
	            const dept = data.department[key];
	            if (dept.department_id == userInfoDept) {
	                resultDept.innerHTML += dept.department_name;
	            }
	        }
	    };

		function editField(field) {
		    const span = document.getElementById(field);
		    const currentValue = span.textContent;

		    // 데이터베이스에서 가져온 전화번호를 하이픈 없이 표시하기
		    let displayValue = currentValue;
		    if (field === "userTel") {
		        displayValue = displayValue.replace(/-/g, ''); // 하이픈 제거
		    }

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
					localStorage.removeItem('alertShown2');
					// 로그인 페이지로 이동하기 전에 현재 상태를 변경
		            window.history.replaceState(null, '', '/login');
		            // 로그인 페이지로 리디렉션
				    location.href = "/login";
				})
				.catch(error => {
				    console.error('문제가 발생했습니다:', error);
				});
		 };
		 
		</script>