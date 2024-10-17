<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원 목록</title>

    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="/resources/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />

    <style>
      .btn-confirm {
        padding: 0.65rem 1.4rem;
        font-size: 1rem;
        font-weight: 500;
        opacity: 1;
        border-radius: 3px;
        background-color: #5f41e4; /* 확인 버튼 배경색 */
        color: #fff; /* 확인 버튼 텍스트 색상 */
      }

      .btn-cancel {
        padding: 0.65rem 1.4rem;
        font-size: 1rem;
        font-weight: 500;
        opacity: 1;
        border-radius: 3px;
        background-color: #d1c6e7; /* 취소 버튼 배경색 */
        color: #000; /* 취소 버튼 텍스트 색상 */
      }
    </style>

    <!-- Fonts and icons -->
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

    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="/resources/css/adminMemberList.css" />
  </head>
  <body>
    <c:if
      test="${sessionScope.id == null || sessionScope.permission_id != '03'}"
    >
      <c:redirect url="/index" />
    </c:if>

    <div class="wrapper">
      <!-- Header -->
      <jsp:include page="/resources/inc/header.jsp" />

      <!-- Sidebar -->
      <jsp:include page="/resources/inc/sidebar.jsp" />

      <!-- Main Content -->
      <div class="container">
        <div class="page-inner">
          <div class="page-header">
            <h3 class="fw-bold mb-3">회원목록</h3>
            <ul class="breadcrumbs mb-3">
              <li class="nav-home">
                <a href="#"> <i class="icon-home"></i> </a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="card w-100">
                <div class="card-header">
                  <div class="card-title">회원목록</div>
                </div>

                <div class="card-body d-flex flex-column">
                  <div class="row">
                    <div class="col-md-12">
                      <table class="col-md-12 table">
                        <tr>
                          <th class="col-md-2">이름</th>
                          <th class="col-md-2">직급</th>
                          <th class="col-md-2">전화번호</th>
                          <th class="col-md-2">가입일자</th>
                          <th class="col-md-2">수정일자</th>
                          <th class="col-md-1"></th>
                        </tr>
                        <c:forEach items="${memberList}" var="member">
                          <tr>
                            <td>${member.member_name}</td>
                            <td>${member.employee_rank_value}</td>
                            <td>${member.member_tel}</td>
                            <td>${member.create_date}</td>
                            <td>${member.update_date}</td>
                            <td>
                              <div class="nav-toggle">
                                <button
                                  id="infoBtn"
                                  class="topbar-toggler more"
                                  style="border: none; background: none"
                                >
                                  <i class="gg-more-vertical-alt"></i>
                                </button>
                                <div
                                  class="btn-group dropstart"
                                  style="display: none"
                                >
                                  <ul class="dropdown-menu show" role="menu">
                                    <li>
                                      <a
                                        data-member-id="${member.member_id}"
                                        class="dropdown-item member-details"
                                        href="#"
                                        >상세보기</a
                                      >
                                      <div class="dropdown-divider"></div>
                                      <a
                                        data-member-id="${member.member_id}"
                                        class="dropdown-item memberUpdate"
                                        href="#"
                                        >수정</a
                                      >
                                      <div class="dropdown-divider"></div>
                                      <a
                                        data-member-id="${member.member_id}"
                                        class="dropdown-item memberDelete"
                                        href="#"
                                        >삭제</a
                                      >
                                    </li>
                                  </ul>
                                </div>
                              </div>
                            </td>
                          </tr>
                        </c:forEach>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Footer -->
      <jsp:include page="/resources/inc/footer.jsp" />
    </div>

    <!-- 모달 구조 추가 -->

    <div
      class="modal"
      id="detailsModal"
      tabindex="-1"
      role="dialog"
      style="display: none"
    >
      <div
        style="
          background-color: rgba(0, 0, 0, 0.5);
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          width: 100%;
          height: 100%;
          z-index: 100;
        "
      >
        <div class="modal-dialog" role="document" style="margin-top: 8rem">
          <div class="modal-content">
            <div class="modal-header" id="modalHeader">
              <h5 class="modal-title">상세보기</h5>
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body" style="text-align: center">
              <p>
                <i class="icon-user" style="font-size: 59px"></i>
              </p>
              <input type="hidden" id="member_id_hidden" />
              <p><strong>이름 : </strong> <span id="memberName"></span></p>
              <p><strong>전화번호 : </strong> <span id="memberTel"></span></p>
              <p><strong>이메일 : </strong> <span id="memberEmail"></span></p>
              <div id="selectBox">
                <p>
                  <strong>직급 : </strong>
                  <select id="memberRank"></select>
                </p>
                <p>
                  <strong>부서 : </strong>
                  <select id="memberDepartment"></select>
                </p>
                <p>
                  <strong>근무 상태 : </strong>
                  <select id="memberStatus"></select>
                </p>
              </div>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-primary"
                id="editButton"
                style="display: none"
              >
                수정
              </button>
              <button
                type="button"
                class="btn btn-danger"
                id="deleteButton"
                style="display: none"
              >
                삭제
              </button>
              <button
                type="button"
                class="btn btn-secondary closeBtn"
                data-dismiss="modal"
              >
                닫기
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--   Core JS Files   -->
    <script src="/resources/js/core/jquery-3.7.1.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>

    <!-- jQuery Scrollbar -->
    <script src="/resources/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="/resources/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="/resources/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="/resources/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="/resources/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="/resources/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="/resources/js/plugin/jsvectormap/world.js"></script>

    <!-- Sweet Alert -->
    <script src="/resources/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="/resources/js/kaiadmin.min.js"></script>
    <script>
      let GlobalRank;
      let GlobalDept;
      let GlobalStatus;
      let DeleteCode;

      function memberInfoDetails(data) {
        event.preventDefault();
        $.ajax({
          url: "/admin/getMemberInfo",
          type: "POST",
          data: JSON.stringify({ member_id: data }),
          contentType: "application/json",
          dataType: "json",
          success: function (response) {
            console.log(response);
            $("#memberRank").empty();
            $("#memberDepartment").empty();
            $("#memberStatus").empty();

            $("#member_id_hidden").val(response.member.member_id);
            $("#memberName").text(response.member.member_name);
            $("#memberTel").text(response.member.member_tel);
            $("#memberEmail").text(response.member.member_email);
            GlobalRank = response.member.employee_rank;
            GlobalDept = response.member.department_id;
            GlobalStatus = response.member.member_state;
            // 기존 내용 삭제

            $("#memberRank").empty();
            $.each(response.empRank, function (key, value) {
              const selected =
                response.member.employee_rank == value.common_value
                  ? "selected"
                  : ""; // 조건에 따라 selected 설정
              $("#memberRank").append(
                '<option value="' +
                  value.common_value +
                  '" ' +
                  selected +
                  ">" +
                  value.common_status +
                  "</option>"
              );
            });

            // 기존 내용 삭제
            $("#memberDepartment").empty();
            $.each(response.department, function (key, value) {
              const selected =
                response.member.department_id == value.department_id
                  ? "selected"
                  : ""; // 조건에 따라 selected 설정
              $("#memberDepartment").append(
                '<option value="' +
                  value.department_id +
                  '" ' +
                  selected +
                  ">" +
                  value.department_name +
                  "</option>"
              );
            });

            // 기존 내용 삭제
            $("#memberStatus").empty();
            $.each(response.memberState, function (key, value) {
              if (value.common_status == "퇴사") {
                DeleteCode = value.common_value;
                return;
              }
              const selected =
                response.member.member_state == value.common_value
                  ? "selected"
                  : ""; // 조건에 따라 selected 설정
              $("#memberStatus").append(
                '<option value="' +
                  value.common_value +
                  '" ' +
                  selected +
                  ">" +
                  value.common_status +
                  "</option>"
              );
            });

            $("#detailsModal").css("display", "block").hide().fadeIn(200);
          },
        });
      }

      function showConfirmationAlert(message) {
        return new Promise((resolve, reject) => {
          swal({
            title: "변경하시겠습니까?",
            text: message,
            icon: "warning",
            buttons: {
              confirm: {
                text: "확인",
                value: true,
                visible: true,
                className: "btn-confirm",
                closeModal: true,
              },
              cancel: {
                text: "취소",
                value: null,
                visible: true,
                className: "btn-cancel",
                closeModal: true,
              },
            },
          }).then((willChange) => {
            if (willChange) {
              resolve(); // 확인 버튼 클릭 시 resolve 호출
            } else {
              reject(); // 취소 버튼 클릭 시 reject 호출
            }
          });
        });
      }
    </script>

    <script>
      $(document).ready(function () {
        $(".topbar-toggler").click(function (event) {
          event.stopPropagation();
          $(".btn-group").not($(this).next()).fadeOut(200);
          $(this).next().fadeToggle(200);
        });
        $(document).click(function () {
          $(".btn-group").fadeOut(200);
        });

        $("#editButton").click(function () {
          const userId = $("#member_id_hidden").val().trim();
          const rank = $("#memberRank").val().trim();
          const department = $("#memberDepartment").val().trim();
          const memberStatus = $("#memberStatus").val().trim();

          if (
            rank != GlobalRank ||
            department != GlobalDept ||
            memberStatus != GlobalStatus
          ) {
            showConfirmationAlert("회원 정보를 수정하시겠습니까?")
              .then(() => {
                const data = {
                  member_id: userId,
                  employee_rank: rank,
                  department_id: department,
                  member_state: memberStatus,
                };
                $.ajax({
                  url: "/admin/updateMember",
                  type: "POST",
                  dataType: "json",
                  data: JSON.stringify(data),
                  contentType: "application/json",
                  success: function (response) {
                    if (response.message === "수정") {
                      swal("회원 정보가 수정되었습니다.", {
                        icon: "success",
                      }).then(() => {
                        location.reload();
                      });
                    } else {
                      swal("수정 중 오류가 발생했습니다.", { icon: "error" });
                    }
                  },
                  error: function (jqXHR, textStatus, errorThrown) {
                    console.error("AJAX 오류:", textStatus, errorThrown);
                    swal("서버와의 통신 중 오류가 발생했습니다.", {
                      icon: "error",
                    });
                  },
                });
              })
              .catch(() => {
                console.log("수정이 취소되었습니다.");
              });
          } else {
            swal("변경사항이 없습니다!", { icon: "info" });
          }
        });

        $("#deleteButton").click(function () {
          const userId = $("#member_id_hidden").val().trim();
          const memberStatus = DeleteCode;

          // 삭제 확인 알림 표시
          showConfirmationAlert("회원 정보를 삭제하시겠습니까?")
            .then(() => {
              const data = {
                member_id: userId,
                member_state: memberStatus,
              };
              $.ajax({
                url: "/admin/deleteMember",
                type: "POST",
                dataType: "json",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function (response) {
                  if (response.message == "삭제") {
                    swal("회원 정보가 삭제되었습니다.", {
                      icon: "success",
                    }).then(() => {
                      // 퇴사 시 select 버튼 숨기기
                      location.reload(); // 페이지 새로고침
                    });
                  } else {
                    swal("삭제 중 오류가 발생했습니다.", { icon: "error" });
                  }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                  console.error("AJAX 오류:", textStatus, errorThrown);
                  swal("서버와의 통신 중 오류가 발생했습니다.", {
                    icon: "error",
                  });
                },
              });
            })
            .catch(() => {
              console.log("삭제가 취소되었습니다.");
            });
        });

        $(".member-details").click(function () {
          var memberId = $(this).data("member-id");
          memberInfoDetails(memberId);
        });

        $(".memberUpdate").click(function () {
          var memberId = $(this).data("member-id");
          memberInfoDetails(memberId);
          $("#editButton").css("display", "block");
        });

        $(".memberDelete").click(function () {
          var memberId = $(this).data("member-id");
          memberInfoDetails(memberId);
          // 퇴사 시 select 버튼 숨기기
          $("#selectBox").hide(); // 직급 선택 숨기기
          $("#deleteButton").css("display", "block");
        });

        $(".closeBtn, .close").on("click", function () {
          $("#detailsModal").css("display", "none");
          $("#editButton").css("display", "none");
          $("#deleteButton").css("display", "none");
        });
      });
    </script>
  </body>
</html>
