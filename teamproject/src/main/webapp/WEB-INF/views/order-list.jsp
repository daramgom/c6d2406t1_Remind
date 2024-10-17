<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
	
		<!--   Core JS Files   -->
	<script src="./resources/js/core/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
    <!-- Fonts and icons -->
    <script src="./resources/js/plugin/webfont/webfont.min.js"></script>
    <!-- jQuery Sparkline -->
	<script
		src="./resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>
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
    }
    h2 {
        border-bottom: 2px solid #001f3f; /* 남색 */
        padding-bottom: 10px;
        color: #001f3f; /* 남색 */
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
    .container-disable{
    	pointer-events: none;
    	background-color: grey;
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
    
    
    
    
    
    table {
            width: 50%;
            border-collapse: collapse;
        }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    
    
    .table-responsive {
            overflow-x: auto; /* 가로 스크롤바 추가 */
    }
    
    
    
    .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    
    
    
    
</style>



<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>발주 요청 페이지</title>
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
                  <p>발주 페이지</p>
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
              
              
              <!-- 발주 페이지 하위의 다른 페이지들바 여서 필요없음 -->
              
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
              
              <!-- 발주 페이지 하위의 다른 페이지들바 여서 필요없음 -->
              
              
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
              
              <!-- 홈페이지 위에 검색하는 부분인데 필요없을듯 -->
              <!--
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
               -->
                
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
 <div class="container">
 	<div class="table-responsive">
        <h1>발주 목록</h1>
        <div id="multi-filter-select_filter" class="dataTables_filter">
        
        	
        </div>
        <table class="display table table-striped table-hover dataTable">
            <thead>
                <tr>
                    <th>순번</th>
                    <th>발주관리번호</th>
                    <th>발주상태</th>
                    <th>발주 담당자</th>
                    <th>발주 승인 담당자</th>
                    <th>제품식별코드</th>
                    <th>발주 금액</th>
                    <th>발주 수량</th>
                    <th>발주 일자</th>
                    <th>발주 수정 일자</th>
                    <th>거래처 코드</th>
                    <!-- <th>비고</th> -->
                    <th>입고 예정 창고</th>
                    <!-- <th>삭제 상태</th> -->
                </tr>
             </thead>
             <tbody>
 
 
				 <c:forEach var="o" items="${oListVO }">
				 	<tr onclick="openModal('${o.ord_count}', '${o.ord_number}', '${o.ord_status}', '${o.ord_manager_id}', '${o.ord_supervisor_id}', '${o.prod_id}', '${o.ord_price}', '${o.ord_quantity}', '${o.ord_date}', '${o.ord_date_change}', '${o.company_code}', '${o.ord_text}', '${o.wh_number}')">
				 
						<td>${o.ord_count}</td>
                        <td>${o.ord_number}</td>
                        <td>${o.ord_status}</td>
                        <td>${o.ord_manager_id}</td>
                        <td>${o.ord_supervisor_id}</td>
                        <td>${o.prod_id}</td>
                        <td>${o.ord_price}</td>
                        <td>${o.ord_quantity}</td>
                        <td>${o.ord_date}</td>
                        <td>${o.ord_date_change}</td>
                        <td>${o.company_code}</td>
                        <%-- <td>${o.ord_text}</td> --%>
                        <td>${o.wh_number}</td>
                        <%-- <td>${o.ord_delete_status }</td> --%>
                        
                    </tr>
				  
				 </c:forEach>
 
 			</tbody>
 			
		</table>
	</div>
</div>


</main>
    </div>
    </div>
</div>
</div>


<!-- 모달 -->
    <div id="orderModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
	            <h2>발주 상세 정보</h2>
	            <form action="" id="orderForm" method="post" name="orderForm">
		            <label>순번:</label>
		            <input type="text" id="modalOrdCount" name="ord_count" readonly="readonly" /><br>
		            <label>발주 관리 번호:</label>
		            <input type="text" id="modalOrdNumber" name="ord_number" readonly="readonly" /><br>
 		            <label>발주 상태:</label>
 		            <input type="text" id="modalOrdStatus" name="ord_status" readonly="readonly" /><br>
		            <label>발주 담당자:</label>
		            <input type="text" id="modalOrdManagerId" name="ord_manager_id" readonly="readonly" /><br>
		            <label>발주 승인 담당자:</label>
		            <input type="text" id="modalOrdSupervisorId" name="ord_supervisor_id" readonly="readonly" /><br>
		            <label>제품식별코드:</label>
		            <input type="text" id="modalProdId" name="prod_id" /><br>
		            <label>발주 금액:</label>
		            <input type="text" id="modalOrdPrice" name="ord_price" /><br>
		            <label>발주 수량:</label>
		            <input type="text" id="modalOrdQuantity" name="ord_quantity" /><br>
		            <label>발주 일자:</label>
		            <input type="text" id="modalOrdDate" name="ord_date" /><br>
		            <label>발주 수정 일자:</label>
		            <input type="text" id="modalOrdDateChange" name="ord_date_change" /><br>
		            <label>거래처 코드:</label>
		            <input type="text" id="modalCompanyCode" name="company_code" /><br>
		            <label>비고:</label>
		            <textarea class="form-control" id="modalOrdText" name="ord_text"></textarea><br>
		            <label>입고 예정 창고:</label>
		            <input type="text" id="modalWhNumber" name="wh_number" /><br>
		            <!-- <label>삭제 상태:</label> -->
		            <input type="hidden" id="modalOrdDeleteStatus" name="ord_delete_status" /><br>
	            </form>
	            
	            <div id="buttonContainer"></div>
	            
        </div>
    </div>
    
    

<script>
	
	
    function openModal(ord_count, ord_number, ord_status, ord_manager_id, ord_supervisor_id, prod_id, ord_price, ord_quantity, ord_date, ord_date_change, company_code, ord_text, wh_number, ord_delete_status) {
        document.getElementById('modalOrdCount').value = ord_count;
        document.getElementById('modalOrdNumber').value = ord_number;
        document.getElementById('modalOrdStatus').value = ord_status;
        document.getElementById('modalOrdManagerId').value = ord_manager_id;
        document.getElementById('modalOrdSupervisorId').value = ord_supervisor_id;
        document.getElementById('modalProdId').value = prod_id;
        document.getElementById('modalOrdPrice').value = ord_price;
        document.getElementById('modalOrdQuantity').value = ord_quantity;
        document.getElementById('modalOrdDate').value = ord_date;
        document.getElementById('modalOrdDateChange').value = ord_date_change;
        document.getElementById('modalCompanyCode').value = company_code;
        document.getElementById('modalOrdText').value = ord_text;
        document.getElementById('modalWhNumber').value = wh_number;
        document.getElementById('modalOrdDeleteStatus').value = ord_delete_status;

        // 여기서 ord_status 값을 기반으로 버튼을 렌더링
        renderButtons(ord_status);

        // 모달 표시
        document.getElementById('orderModal').style.display = 'block';
    }

    function renderButtons(ord_status) {
        var buttonContainer = document.getElementById('buttonContainer');
        buttonContainer.innerHTML = ''; // 기존 버튼 초기화

        if (ord_status === '01') {
            buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="container-disable">요청</button>';
            buttonContainer.innerHTML += '<button id="updateBtn" class="btn btn-success">수정</button>';
            buttonContainer.innerHTML += '<button id="deleteBtn" class="btn btn-danger">삭제</button>';
            buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="container-disable">요청(관리자)</button>';
            buttonContainer.innerHTML += '<button id="updateBtn03" class="btn btn-success">발주 처리</button>';
            buttonContainer.innerHTML += '<button id="updateBtn02" class="btn btn-danger">발주 반려</button>';
        } else if (ord_status === '02') {
            buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="container-disable">반려</button>';
            buttonContainer.innerHTML += '<button id="updateBtn01" class="btn btn-success">재요청</button>';
            buttonContainer.innerHTML += '<button id="deleteBtn01" class="btn btn-danger">삭제</button>';
        } else if (ord_status === '03') {
            buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="container-disable">결재</button>';
        } else if (ord_status === '04') {
            buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="container-disable">거래처 반려</button>';
        } else if (ord_status === '05') {
            buttonContainer.innerHTML += '<button type="button" disabled="disabled" class="container-disable">완료</button>';
        }

        // 버튼에 이벤트 리스너 추가
        addButtonEventListeners();
    }

    function addButtonEventListeners() {
    	
        document.getElementById('updateBtn')?.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            var formData = new FormData(document.getElementById('orderForm'));
            fetch("/updateOrder", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
                return response.text();
            })
            .then(data => {
                alert("발주 정보가 수정 되었습니다.");
                location.reload();
            })
            .catch(error => {
                console.error(error);
                alert("수정 중 오류가 발생했습니다.");
            });
        });

        document.getElementById('deleteBtn')?.addEventListener('click', function(event) {
            event.preventDefault();
            var formData = new FormData(document.getElementById('orderForm'));
            fetch("/deleteOrder", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
                return response.text();
            })
            .then(data => {
                alert("발주 정보가 삭제되었습니다.");
                location.reload();
            })
            .catch(error => {
                console.error(error);
                alert("삭제 중 오류가 발생했습니다.");
            });
        });

        document.getElementById('updateBtn03')?.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            var formData = new FormData(document.getElementById('orderForm'));
            fetch("/updateOrder03", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
                return response.text();
            })
            .then(data => {
                alert("발주 처리 되었습니다.");
                location.reload();
            })
            .catch(error => {
                console.error(error);
                alert("수정 중 오류가 발생했습니다.");
            });
        });
        
        document.getElementById('updateBtn02')?.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            var formData = new FormData(document.getElementById('orderForm'));
            fetch("/updateOrder02", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
                return response.text();
            })
            .then(data => {
                alert("발주 반려 되었습니다.");
                location.reload();
            })
            .catch(error => {
                console.error(error);
                alert("수정 중 오류가 발생했습니다.");
            });
        });
        
        document.getElementById('updateBtn01')?.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            var formData = new FormData(document.getElementById('orderForm'));
            fetch("/updateOrder", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
                return response.text();
            })
            .then(data => {
                alert("발주 정보가 재요청 되었습니다.");
                location.reload();
            })
            .catch(error => {
                console.error(error);
                alert("수정 중 오류가 발생했습니다.");
            });
        });
        
        document.getElementById('deleteBtn01')?.addEventListener('click', function(event) {
            event.preventDefault();
            var formData = new FormData(document.getElementById('orderForm'));
            fetch("/deleteOrder", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok " + response.statusText);
                return response.text();
            })
            .then(data => {
                alert("발주 정보가 삭제되었습니다.");
                location.reload();
            })
            .catch(error => {
                console.error(error);
                alert("삭제 중 오류가 발생했습니다.");
            });
        });
        
    }

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        var modal = document.getElementById('orderModal');
        if (event.target === modal) {
            closeModal();
        }
    });

    function closeModal() {
        document.getElementById('orderModal').style.display = 'none'; // 모달 숨기기
    }
</script>

  </body>
</html>
