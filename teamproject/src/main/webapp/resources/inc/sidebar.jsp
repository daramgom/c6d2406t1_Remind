<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!-- Sidebar -->
      <div class="sidebar" data-background-color="light">
        <div class="sidebar-logo">
          <!-- Logo Header -->
          <div class="logo-header" data-background-color="light">
            <a href="index.html" class="logo">
              <img
                src="/resources/img/kaiadmin/logo_light.svg"
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
                  href="/main"
                  aria-expanded="false"
                >
                  <i class="fas fa-home"></i>
                  <p>메인페이지</p>
                  <span class="caret"></span>
                </a>
                
              </li>
              <li class="nav-section">
                <span class="sidebar-mini-icon">
                  <i class="fa fa-ellipsis-h"></i>
                </span>
                <h4 class="text-section">재고 관리 시스템 메뉴</h4>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#base">
                  <i class="fas fa-layer-group"></i>
                  <p>발주관리</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="base">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/order-insert">
                        <span class="sub-item">발주 요청</span>
                      </a>
                    </li>
                    <li>
                      <a href="/order-list">
                        <span class="sub-item">발주 목록</span>
                      </a>
                    </li>
                    
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#sidebarLayouts">
                  <i class="fas fa-th-list"></i>
                  <p>제품 관리</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="sidebarLayouts">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/prod/insert">
                        <span class="sub-item">제품 등록</span>
                      </a>
                    </li>
                    <li>
                      <a href="/prod/list">
                        <span class="sub-item">제품 목록</span>
                      </a>
                    </li>
                    <li>
                      <a href="/prod/transfer">
                        <span class="sub-item">재고 이동</span>
                      </a>
                    </li>
                    <li>
                      <a href="/prod/stockalert">
                        <span class="sub-item">재고 알람 설정</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#forms">
                  <i class="fas fa-pen-square"></i>
                  <p>입고 관리</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="forms">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/rcvRQ">
                        <span class="sub-item">입고 요청</span>
                      </a>
                    </li>
                    <li>
                      <a href="/rcvList2">
                        <span class="sub-item">입고 목록</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#tables">
                  <i class="fas fa-table"></i>
                  <p>출고 관리</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="tables">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/shpRQ">
                        <span class="sub-item">출고 요청</span>
                      </a>
                    </li>
                    <li>
                      <a href="/shpList2">
                        <span class="sub-item">출고 목록</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#ware">
                  <i class="fas fa-map-marker-alt"></i>
                  <p>창고 관리</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="ware">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/wareHouseInsert">
                        <span class="sub-item">창고 등록</span>
                      </a>
                    </li>
                    <li>
                      <a href="/wareHouseList">
                        <span class="sub-item">창고 목록</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#cp">
                  <i class="fas fa-map-marker-alt"></i>
                  <p>거래처 관리</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="cp">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/companyInsert">
                        <span class="sub-item">거래처 등록</span>
                      </a>
                    </li>
                    <li>
                      <a href="/companyList">
                        <span class="sub-item">거래처 목록</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#noti">
                  <i class="fas fa-map-marker-alt"></i>
                  <p>공지사항</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="noti">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/noticeInsert">
                        <span class="sub-item">공지사항 등록</span>
                      </a>
                    </li>
                    <li>
                      <a href="/noticeList">
                        <span class="sub-item">공지사항 목록</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#charts">
                  <i class="far fa-chart-bar"></i>
                  <p>관리자 페이지</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="charts">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="/signReq">
                        <span class="sub-item">회원 가입 신청 목록</span>
                      </a>
                    </li>
                    <li>
                      <a href="/adminMemberList">
                        <span class="sub-item">회원 목록</span>
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