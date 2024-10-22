<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>아이티윌 팀프로젝트</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="./resources/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="./resources/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["./resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>
    
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #e9ecef;
        margin: 0;
        padding: 20px;
    }
    header {
        background: #001f3f; /* 남색 */
        padding: 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
        border-radius: 5px;
    }
    main {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
        max-width: 800px; /* 최대 너비 설정 */
        margin-left: auto; /* 가운데 정렬 */
        margin-right: auto; /* 가운데 정렬 */
    }
    h2 {
        border-bottom: 2px solid #001f3f; /* 남색 */
        padding-bottom: 10px;
        color: #001f3f; /* 남색 */
        font-size: 24px; /* 제목 크기 조정 */
    }
    .form-container {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
    }
    .form-group {
        display: flex;
        flex-direction: column;
    }
    label {
        margin-top: 15px;
        font-weight: bold;
        color: #333;
    }
    input, textarea {
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        transition: border-color 0.3s;
    }
    input:focus, textarea:focus {
        border-color: #001f3f; /* 남색 */
        outline: none;
    }
    button {
        grid-column: span 2; /* 버튼을 두 열에 걸치게 함 */
        margin-top: 20px;
        padding: 10px;
        background: #001f3f; /* 남색 */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background 0.3s;
    }
    button:hover {
        background: #001a33; /* 남색의 어두운 색 */
    }

    /* 새로운 스타일 추가 */
    .underline-container {
        position: relative; /* 포지션 설정 */
        display: inline-block; /* 인라인 블록으로 변경 */
    }
    .underline-input {
        border: none; /* 테두리 제거 */
        outline: none; /* 포커스 시 테두리 제거 */
        padding: 5px 0; /* 패딩 조정 */
        background-color: transparent; /* 배경 투명 */
        width: auto; /* 너비 자동 */
        min-width: 60px; /* 최소 너비 설정 */
    }
    .custom-underline {
        position: absolute;
        bottom: 0; /* 아래에 위치 */
        left: 0; /* 왼쪽에 위치 */
        height: 2px; /* 두께 설정 */
        background-color: navy; /* 남색 */
        width: calc(5ch); /* 3글자 길이만큼 설정 */
    }
</style>
<script>
        function fetchOrderDate() {
            const ordNumber = document.getElementById('ord_number').value;
            if (ordNumber) {
                fetch('/getOrderDate?ord_number=' + ordNumber)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('ord_date').value = data.ord_date || '';
                    })
                    .catch(error => console.error('Error:', error));
            } else {
                document.getElementById('ord_date').value = ''; // 입력이 없을 경우 초기화
            }
        }
    </script>
    
    <!-- 모달 -->
	<style>
	    .modal-content {
	    background-color: #fefefe;
	    margin: 5% auto; 
	    padding: 20px;
	    border: 1px solid #888;
	    width: 60%; /* 너비 조정 */
	    max-width: 500px; /* 최대 너비 설정 */
	    border-radius: 8px; /* 모서리 둥글게 */
	}
	
	.modal {
	    display: none; 
	    position: fixed; 
	    z-index: 1; 
	    left: 0;
	    top: 0;
	    width: 100%; 
	    height: 100%; 
	    overflow: auto; 
	    background-color: rgba(0, 0, 0, 0.5); /* 배경 색상 조정 */
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 24px; /* 크기 조정 */
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	    color: #000; /* 호버 시 색상 변경 */
	    text-decoration: none;
	    cursor: pointer;
	}

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }

    
    </style>
    
    <!-- 발주관리번호 -->
       <style>
        .dropdown {
            display: none;
            border: 1px solid #ccc;
            max-height: 150px;
            overflow-y: auto;
            position: absolute;
            background: white;
            z-index: 1000;
        }
        .dropdown div {
            padding: 8px;
            cursor: pointer;
        }
        .dropdown div:hover {
            background-color: #f0f0f0;
        }
    </style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>입고 대기 목록</title>
    <!-- CSS Files -->
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="./resources/css/plugins.min.css" />
    <link rel="stylesheet" href="./resources/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="./resources/css/demo.css" />
  </head>
  <body>
    <div class="wrapper">
      <!-- Sidebar -->
      <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
          <!-- Logo Header -->
          <div class="logo-header" data-background-color="dark">
            <a href="index.html" class="logo">
              <img
                src="./resources/img/kaiadmin/logo_light.svg"
                alt="navbar brand"
                class="navbar-brand"
                height="20"
              />
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
        <div class="sidebar-wrapper scrollbar scrollbar-inner">
          <div class="sidebar-content">
            <ul class="nav nav-secondary">
              <li class="nav-item active">
                <a
                  data-bs-toggle="collapse"
                  href="#dashboard"
                  class="collapsed"
                  aria-expanded="false"
                >
                  <i class="fas fa-home"></i>
                  <p>Dashboard</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="dashboard">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="../demo1/index.html">
                        <span class="sub-item">Dashboard 1</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-section">
                <span class="sidebar-mini-icon">
                  <i class="fa fa-ellipsis-h"></i>
                </span>
                <h4 class="text-section">Components</h4>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#base">
                  <i class="fas fa-layer-group"></i>
                  <p>Base</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="base">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="components/avatars.html">
                        <span class="sub-item">Avatars</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/buttons.html">
                        <span class="sub-item">Buttons</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/gridsystem.html">
                        <span class="sub-item">Grid System</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/panels.html">
                        <span class="sub-item">Panels</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/notifications.html">
                        <span class="sub-item">Notifications</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/sweetalert.html">
                        <span class="sub-item">Sweet Alert</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/font-awesome-icons.html">
                        <span class="sub-item">Font Awesome Icons</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/simple-line-icons.html">
                        <span class="sub-item">Simple Line Icons</span>
                      </a>
                    </li>
                    <li>
                      <a href="components/typography.html">
                        <span class="sub-item">Typography</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#sidebarLayouts">
                  <i class="fas fa-th-list"></i>
                  <p>Sidebar Layouts</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="sidebarLayouts">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="sidebar-style-2.html">
                        <span class="sub-item">Sidebar Style 2</span>
                      </a>
                    </li>
                    <li>
                      <a href="icon-menu.html">
                        <span class="sub-item">Icon Menu</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#forms">
                  <i class="fas fa-pen-square"></i>
                  <p>Forms</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="forms">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="forms/forms.html">
                        <span class="sub-item">Basic Form</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#tables">
                  <i class="fas fa-table"></i>
                  <p>Tables</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="tables">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="tables/tables.html">
                        <span class="sub-item">Basic Table</span>
                      </a>
                    </li>
                    <li>
                      <a href="tables/datatables.html">
                        <span class="sub-item">Datatables</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#maps">
                  <i class="fas fa-map-marker-alt"></i>
                  <p>Maps</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="maps">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="maps/googlemaps.html">
                        <span class="sub-item">Google Maps</span>
                      </a>
                    </li>
                    <li>
                      <a href="maps/jsvectormap.html">
                        <span class="sub-item">Jsvectormap</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#charts">
                  <i class="far fa-chart-bar"></i>
                  <p>Charts</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="charts">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="charts/charts.html">
                        <span class="sub-item">Chart Js</span>
                      </a>
                    </li>
                    <li>
                      <a href="charts/sparkline.html">
                        <span class="sub-item">Sparkline</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a href="widgets.html">
                  <i class="fas fa-desktop"></i>
                  <p>Widgets</p>
                  <span class="badge badge-success">4</span>
                </a>
              </li>
              <li class="nav-item">
                <a href="./documentation/index.html">
                  <i class="fas fa-file"></i>
                  <p>Documentation</p>
                  <span class="badge badge-secondary">1</span>
                </a>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#submenu">
                  <i class="fas fa-bars"></i>
                  <p>Menu Levels</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="submenu">
                  <ul class="nav nav-collapse">
                    <li>
                      <a data-bs-toggle="collapse" href="#subnav1">
                        <span class="sub-item">Level 1</span>
                        <span class="caret"></span>
                      </a>
                      <div class="collapse" id="subnav1">
                        <ul class="nav nav-collapse subnav">
                          <li>
                            <a href="#">
                              <span class="sub-item">Level 2</span>
                            </a>
                          </li>
                          <li>
                            <a href="#">
                              <span class="sub-item">Level 2</span>
                            </a>
                          </li>
                        </ul>
                      </div>
                    </li>
                    <li>
                      <a data-bs-toggle="collapse" href="#subnav2">
                        <span class="sub-item">Level 1</span>
                        <span class="caret"></span>
                      </a>
                      <div class="collapse" id="subnav2">
                        <ul class="nav nav-collapse subnav">
                          <li>
                            <a href="#">
                              <span class="sub-item">Level 2</span>
                            </a>
                          </li>
                        </ul>
                      </div>
                    </li>
                    <li>
                      <a href="#">
                        <span class="sub-item">Level 1</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <!-- End Sidebar -->

      <div class="main-panel">
        <div class="main-header">
          <div class="main-header-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="dark">
              <a href="index.html" class="logo">
                <img
                  src="./resources/img/kaiadmin/logo_light.svg"
                  alt="navbar brand"
                  class="navbar-brand"
                  height="20"
                />
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
            class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom"
          >
            <div class="container-fluid">
              <nav
                class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"
              >
                <div class="input-group">
                  <div class="input-group-prepend">
                    <button type="submit" class="btn btn-search pe-1">
                      <i class="fa fa-search search-icon"></i>
                    </button>
                  </div>
                  <input
                    type="text"
                    placeholder="Search ..."
                    class="form-control"
                  />
                </div>
              </nav>

              <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
                <li
                  class="nav-item topbar-icon dropdown hidden-caret d-flex d-lg-none"
                >
                  <a
                    class="nav-link dropdown-toggle"
                    data-bs-toggle="dropdown"
                    href="#"
                    role="button"
                    aria-expanded="false"
                    aria-haspopup="true"
                  >
                    <i class="fa fa-search"></i>
                  </a>
                  <ul class="dropdown-menu dropdown-search animated fadeIn">
                    <form class="navbar-left navbar-form nav-search">
                      <div class="input-group">
                        <input
                          type="text"
                          placeholder="Search ..."
                          class="form-control"
                        />
                      </div>
                    </form>
                  </ul>
                </li>
                <li class="nav-item topbar-icon dropdown hidden-caret">
                  <a
                    class="nav-link dropdown-toggle"
                    href="#"
                    id="messageDropdown"
                    role="button"
                    data-bs-toggle="dropdown"
                    aria-haspopup="true"
                    aria-expanded="false"
                  >
                    <i class="fa fa-envelope"></i>
                  </a>
                  <ul
                    class="dropdown-menu messages-notif-box animated fadeIn"
                    aria-labelledby="messageDropdown"
                  >
                    <li>
                      <div
                        class="dropdown-title d-flex justify-content-between align-items-center"
                      >
                        Messages
                        <a href="#" class="small">Mark all as read</a>
                      </div>
                    </li>
                    <li>
                      <div class="message-notif-scroll scrollbar-outer">
                        <div class="notif-center">
                          <a href="#">
                            <div class="notif-img">
                              <img
                                src="./resources/img/jm_denis.jpg"
                                alt="Img Profile"
                              />
                            </div>
                            <div class="notif-content">
                              <span class="subject">Jimmy Denis</span>
                              <span class="block"> How are you ? </span>
                              <span class="time">5 minutes ago</span>
                            </div>
                          </a>
                          <a href="#">
                            <div class="notif-img">
                              <img
                                src="./resources/img/chadengle.jpg"
                                alt="Img Profile"
                              />
                            </div>
                            <div class="notif-content">
                              <span class="subject">Chad</span>
                              <span class="block"> Ok, Thanks ! </span>
                              <span class="time">12 minutes ago</span>
                            </div>
                          </a>
                          <a href="#">
                            <div class="notif-img">
                              <img
                                src="./resources/img/mlane.jpg"
                                alt="Img Profile"
                              />
                            </div>
                            <div class="notif-content">
                              <span class="subject">Jhon Doe</span>
                              <span class="block">
                                Ready for the meeting today...
                              </span>
                              <span class="time">12 minutes ago</span>
                            </div>
                          </a>
                          <a href="#">
                            <div class="notif-img">
                              <img
                                src="./resources/img/talha.jpg"
                                alt="Img Profile"
                              />
                            </div>
                            <div class="notif-content">
                              <span class="subject">Talha</span>
                              <span class="block"> Hi, Apa Kabar ? </span>
                              <span class="time">17 minutes ago</span>
                            </div>
                          </a>
                        </div>
                      </div>
                    </li>
                    <li>
                      <a class="see-all" href="javascript:void(0);"
                        >See all messages<i class="fa fa-angle-right"></i>
                      </a>
                    </li>
                  </ul>
                </li>
                <li class="nav-item topbar-icon dropdown hidden-caret">
                  <a
                    class="nav-link dropdown-toggle"
                    href="#"
                    id="notifDropdown"
                    role="button"
                    data-bs-toggle="dropdown"
                    aria-haspopup="true"
                    aria-expanded="false"
                  >
                    <i class="fa fa-bell"></i>
                    <span class="notification">4</span>
                  </a>
                  <ul
                    class="dropdown-menu notif-box animated fadeIn"
                    aria-labelledby="notifDropdown"
                  >
                    <li>
                      <div class="dropdown-title">
                        You have 4 new notification
                      </div>
                    </li>
                    <li>
                      <div class="notif-scroll scrollbar-outer">
                        <div class="notif-center">
                          <a href="#">
                            <div class="notif-icon notif-primary">
                              <i class="fa fa-user-plus"></i>
                            </div>
                            <div class="notif-content">
                              <span class="block"> New user registered </span>
                              <span class="time">5 minutes ago</span>
                            </div>
                          </a>
                          <a href="#">
                            <div class="notif-icon notif-success">
                              <i class="fa fa-comment"></i>
                            </div>
                            <div class="notif-content">
                              <span class="block">
                                Rahmad commented on Admin
                              </span>
                              <span class="time">12 minutes ago</span>
                            </div>
                          </a>
                          <a href="#">
                            <div class="notif-img">
                              <img
                                src="./resources/img/profile2.jpg"
                                alt="Img Profile"
                              />
                            </div>
                            <div class="notif-content">
                              <span class="block">
                                Reza send messages to you
                              </span>
                              <span class="time">12 minutes ago</span>
                            </div>
                          </a>
                          <a href="#">
                            <div class="notif-icon notif-danger">
                              <i class="fa fa-heart"></i>
                            </div>
                            <div class="notif-content">
                              <span class="block"> Farrah liked Admin </span>
                              <span class="time">17 minutes ago</span>
                            </div>
                          </a>
                        </div>
                      </div>
                    </li>
                    <li>
                      <a class="see-all" href="javascript:void(0);"
                        >See all notifications<i class="fa fa-angle-right"></i>
                      </a>
                    </li>
                  </ul>
                </li>
                <li class="nav-item topbar-icon dropdown hidden-caret">
                  <a
                    class="nav-link"
                    data-bs-toggle="dropdown"
                    href="#"
                    aria-expanded="false"
                  >
                    <i class="fas fa-layer-group"></i>
                  </a>
                  <div class="dropdown-menu quick-actions animated fadeIn">
                    <div class="quick-actions-header">
                      <span class="title mb-1">Quick Actions</span>
                      <span class="subtitle op-7">Shortcuts</span>
                    </div>
                    <div class="quick-actions-scroll scrollbar-outer">
                      <div class="quick-actions-items">
                        <div class="row m-0">
                          <a class="col-6 col-md-4 p-0" href="#">
                            <div class="quick-actions-item">
                              <div class="avatar-item bg-danger rounded-circle">
                                <i class="far fa-calendar-alt"></i>
                              </div>
                              <span class="text">Calendar</span>
                            </div>
                          </a>
                          <a class="col-6 col-md-4 p-0" href="#">
                            <div class="quick-actions-item">
                              <div
                                class="avatar-item bg-warning rounded-circle"
                              >
                                <i class="fas fa-map"></i>
                              </div>
                              <span class="text">Maps</span>
                            </div>
                          </a>
                          <a class="col-6 col-md-4 p-0" href="#">
                            <div class="quick-actions-item">
                              <div class="avatar-item bg-info rounded-circle">
                                <i class="fas fa-file-excel"></i>
                              </div>
                              <span class="text">Reports</span>
                            </div>
                          </a>
                          <a class="col-6 col-md-4 p-0" href="#">
                            <div class="quick-actions-item">
                              <div
                                class="avatar-item bg-success rounded-circle"
                              >
                                <i class="fas fa-envelope"></i>
                              </div>
                              <span class="text">Emails</span>
                            </div>
                          </a>
                          <a class="col-6 col-md-4 p-0" href="#">
                            <div class="quick-actions-item">
                              <div
                                class="avatar-item bg-primary rounded-circle"
                              >
                                <i class="fas fa-file-invoice-dollar"></i>
                              </div>
                              <span class="text">Invoice</span>
                            </div>
                          </a>
                          <a class="col-6 col-md-4 p-0" href="#">
                            <div class="quick-actions-item">
                              <div
                                class="avatar-item bg-secondary rounded-circle"
                              >
                                <i class="fas fa-credit-card"></i>
                              </div>
                              <span class="text">Payments</span>
                            </div>
                          </a>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>

                <li class="nav-item topbar-user dropdown hidden-caret">
                  <a
                    class="dropdown-toggle profile-pic"
                    data-bs-toggle="dropdown"
                    href="#"
                    aria-expanded="false"
                  >
                    <div class="avatar-sm">
                      <img
                        src="./resources/img/profile.jpg"
                        alt="..."
                        class="avatar-img rounded-circle"
                      />
                    </div>
                    <span class="profile-username">
                      <span class="op-7">Hi,</span>
                      <span class="fw-bold">Hizrian</span>
                    </span>
                  </a>
                  <ul class="dropdown-menu dropdown-user animated fadeIn">
                    <div class="dropdown-user-scroll scrollbar-outer">
                      <li>
                        <div class="user-box">
                          <div class="avatar-lg">
                            <img
                              src="./resources/img/profile.jpg"
                              alt="image profile"
                              class="avatar-img rounded"
                            />
                          </div>
                          <div class="u-text">
                            <h4>Hizrian</h4>
                            <p class="text-muted">hello@example.com</p>
                            <a
                              href="profile.html"
                              class="btn btn-xs btn-secondary btn-sm"
                              >View Profile</a
                            >
                          </div>
                        </div>
                      </li>
                      <li>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">My Profile</a>
                        <a class="dropdown-item" href="#">My Balance</a>
                        <a class="dropdown-item" href="#">Inbox</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Account Setting</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Logout</a>
                      </li>
                    </div>
                  </ul>
                </li>
              </ul>
            </div>
          </nav>
          <!-- End Navbar -->
        </div>

        <div class="container">
          <div class="page-inner">

<main>
    <h2>출고 요청</h2>
    <form action="/shpRQ" id="ShippingForm" method="post" onsubmit="return confirmSubmission()">
        <div class="form-container">
            <div class="form-group">
                <label for="ord_manager_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주 요청자
                </label>
                <div class="underline-container">
                    <input type="text" id="ord_manager_id" class="underline-input" placeholder="홍길동" required name="ord_manager_id">
                    <div class="custom-underline"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="ord_supervisor_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주 승인자
                </label>
                <div class="underline-container">
                    <input type="text" id="ord_supervisor_id" class="underline-input" placeholder="홍길동" required name="ord_supervisor_id">
                    <div class="custom-underline"></div>
                </div>
            </div>
            
                        <div class="form-group">
                <label for="shp_manager_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고 요청자
                </label>
                <div class="underline-container">
                    <input type="text" id="shp_manager_id" class="underline-input" placeholder="홍길동" required name="shp_manager_id">
                    <div class="custom-underline"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="shp_supervisor_id">
                    <img src="${pageContext.request.contextPath}/resources/img/회원.png" alt="사람 아이콘"
                         style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">출고 승인자
                </label>
                <div class="underline-container">
                    <input type="text" id="shp_supervisor_id" class="underline-input" placeholder="홍길동" required name="shp_supervisor_id">
                    <div class="custom-underline"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="ord_number">발주 관리 번호</label>
                <div style="display: flex; align-items: center;">
                    <input type="text" id="ord_number" placeholder="발주 관리 번호 입력" required onfocus="showOrderList()" oninput="fetchOrderData()" name="ord_number">
                    <button type="button" onclick="submitOrderNumber()">조회</button>
                </div>
                <div class="dropdown" id="orderDropdown"></div>
            </div>

            <div class="form-group">
                <label for="prod_id">제품 식별코드</label>
                <input type="text" id="prod_id" placeholder="제품 식별 코드를 입력" required name="prod_id">
            </div>

            <div class="form-group">
                <label for="prod_category">카테고리</label>
                <input type="text" id="prod_category" required name="prod_category">
            </div>

            <div class="form-group">
                <label for="prod_name">품목명</label>
                <input type="text" id="prod_name" required name="prod_name">
            </div>

            <div class="form-group">
                <label for="company_code">거래처</label>
                <input type="text" id="company_code" required name="company_code">
            </div>

            <div class="form-group">
                <label for="shp_quantity">출고 수량</label>
                <input type="number" id="shp_quantity" required name="shp_quantity">
            </div>

            <div class="form-group">
                <label for="shp_price">가격(단가)</label>
                <input type="text" id="shp_price" required name="shp_price">
            </div>

            <div class="form-group">
                <label for="shp_date">출고 날짜</label>
                <input type="date" id="shp_date" required name="shp_date">
            </div>

            <!-- 창고 번호 및 이름 입력 필드 -->
            <div class="form-group">
                <label for="wh_number">창고 번호</label>
                <input type="text" id="wh_number" placeholder="창고 번호 입력" required name="wh_number">
            </div>

            <div class="form-group">
                <label for="wh_name">창고 이름</label>
                <input type="text" id="wh_name" placeholder="창고 이름 입력" required name="wh_name">
            </div>

            <!-- 비고 필드, 마지막으로 이동 -->
            <div class="form-group">
                <label for="shp_remarks">비고</label>
                <textarea id="shp_remarks" placeholder="전달할 내용..." required name="shp_remarks"></textarea>
            </div>

            <button class="btn btn-primary" type="submit">출고 요청</button>
        </div>
    </form>

    <script>
        const orderNumbers = ['ORD-2024-0001', 'ORD-2024-0005', 'ORD-2024-0006', 'ORD004']; // 예시 발주 번호 목록

        function showOrderList() {
            const dropdown = document.getElementById('orderDropdown');
            dropdown.innerHTML = ''; // 기존 목록 초기화
            dropdown.style.display = 'block'; // 드롭다운 표시
            
            orderNumbers.forEach(order => {
                const div = document.createElement('div');
                div.textContent = order;
                div.onclick = () => selectOrder(order); // 클릭 시 발주 번호 선택
                dropdown.appendChild(div);
            });
        }

        function selectOrder(order) {
            document.getElementById('ord_number').value = order; // 입력란에 선택한 발주 번호 넣기
            document.getElementById('orderDropdown').style.display = 'none'; // 드롭다운 숨기기
            fetchProductByOrderNumber(order); // 발주번호에 대한 제품 정보 요청
        }

        function fetchProductByOrderNumber(orderNumber) {
            return fetch(`/getShippingProductByOrderNumber?ord_number=` + orderNumber)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('prod_id').value = data.prod_id; // 제품 식별 코드 자동 입력
                    document.getElementById('prod_category').value = data.prod_category; // 제품 카테고리 자동 입력
                    document.getElementById('company_code').value = data.company_code; // 거래처 자동 입력
                    document.getElementById('prod_name').value = data.prod_name; // 품목명 자동 입력
                    document.getElementById('shp_price').value = data.ord_price; // 가격(단가) 자동 입력
                    
                    // 발주 승인자 및 요청자 이름 자동 입력
                    document.getElementById('ord_supervisor_id').value = data.ord_supervisor_name; // 발주 승인자 이름 자동 입력
                    document.getElementById('ord_manager_id').value = data.ord_manager_name; // 발주 요청자 이름 자동 입력
                    
                    // 창고 번호 및 이름 자동 입력
                    document.getElementById('wh_number').value = data.wh_number; // 창고 번호 자동 입력
                    document.getElementById('wh_name').value = data.wh_name; // 창고 이름 자동 입력
                    
                    // 오늘 날짜 자동 입력
                    document.getElementById('shp_date').value = new Date().toISOString().split('T')[0]; // 오늘 날짜 자동입력
                })
                .catch(error => console.error('Error fetching product details:', error));
        }

        function fetchOrderData() {
            const input = document.getElementById('ord_number').value.toLowerCase();
            const dropdown = document.getElementById('orderDropdown');
            dropdown.innerHTML = ''; // 기존 목록 초기화
            
            const filteredOrders = orderNumbers.filter(order => order.toLowerCase().includes(input));
            filteredOrders.forEach(order => {
                const div = document.createElement('div');
                div.textContent = order;
                div.onclick = () => selectOrder(order);
                dropdown.appendChild(div);
            });

            // 필터링된 결과가 없으면 드롭다운 숨김
            dropdown.style.display = filteredOrders.length > 0 ? 'block' : 'none';
        }

        // 클릭 시 드롭다운 숨기기 (입력 외부 클릭 시)
        document.addEventListener('click', (event) => {
            const dropdown = document.getElementById('orderDropdown');
            const input = document.getElementById('ord_number');
            if (!input.contains(event.target) && !dropdown.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
        
        function submitOrderNumber() {
            const ord_number = document.getElementById('ord_number').value;
            if (ord_number) {
                fetchProductByOrderNumber(ord_number)
                    .then(() => {
                        // 제품 정보를 성공적으로 가져온 후 폼 제출
                        document.getElementById('ShippingForm').submit();
                    });
            } else {
                alert("발주 관리번호를 입력하세요.");
            }
        }
    </script>
    
    <script type="text/javascript">
        function confirmSubmission() {
            const confirmation = confirm("확인을 누르면 출고 요청이 완료됩니다.");
            return confirmation; // 확인하면 true, 아니면 false
        }
    </script>
</main>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
