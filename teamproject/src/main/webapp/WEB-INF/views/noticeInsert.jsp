<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 등록</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
</head>
<body>
    <div class="wrapper">
        <!-- Header -->
        <jsp:include page="/resources/inc/header.jsp" />

        <!-- Sidebar -->
        <jsp:include page="/resources/inc/sidebar.jsp" />

        <!-- Main Content -->
        <div class="container">
            <div class="page-inner">
                <div class="page-header">
                    <h3 class="fw-bold mb-3">공지사항 관리</h3>
                    <ul class="breadcrumbs mb-3">
                        <li class="nav-home"><a href="#"><i class="icon-home"></i></a></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item"><a href="#">공지사항 관리</a></li>
                        <li class="separator"><i class="icon-arrow-right"></i></li>
                        <li class="nav-item"><a href="#">공지사항 등록</a></li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">공지사항 등록</div>
                            </div>

                            <div class="card-body d-flex flex-column align-items-center">
                                <div class="row">
                                    <div class="col-md-6 col-lg-12">
                                        <form id="noticeForm" action="" method="post">
                                            <div class="form-group d-flex" style="gap: 20px;">
                                                <div style="flex: 1;">
                                                    <label for="title" class="col-form-label" style="font-size: 1.5rem;">제목</label>
                                                    <input type="text" class="form-control input-full" id="title" name="title" placeholder="공지사항 제목" required />
                                                </div>
                                                <div style="flex: 1;">
                                                    <label for="writer" class="col-form-label">작성자</label>
                                                    <input type="text" class="form-control input-full" id="writer" name="writer" placeholder="작성자" required />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="content" class="col-form-label">내용</label>
                                                <textarea class="form-control" id="content" name="content" rows="5" placeholder="공지사항 내용" required></textarea>
                                            </div>
                                            <div style="display: flex; justify-content: center; margin-bottom: 20px; gap: 20px;">
                                                <button type="submit" class="btn btn-success">공지사항 등록</button>
                                                <button type="button" class="btn btn-danger" id="alert_demo_7">입력 초기화</button>
                                            </div>
                                        </form>
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

    <!-- Core JS Files -->
    <script src="/resources/js/core/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            // 폼 제출 이벤트
//             $('#noticeForm').on('submit', function (e) {
//                 e.preventDefault(); // 기본 제출 이벤트 방지

//                 var formData = new FormData(this); // FormData 객체 생성

//                 // FormData 내용 출력 (디버깅용)
//                 for (var pair of formData.entries()) {
//                     console.log(pair[0] + ': ' + pair[1]); // 각 필드의 이름과 값을 출력
//                 }

//                 $.ajax({
//                     url: '/notice/add', // 서버의 처리 URL
//                     type: 'POST',
//                     data: formData,
//                     processData: false, // jQuery가 데이터를 처리하지 않도록 설정
//                     contentType: false, // jQuery가 Content-Type을 설정하지 않도록 설정
//                     success: function (response) {
//                         alert("공지사항이 등록되었습니다!"); // 성공 메시지
//                         $('input, textarea').val(''); // 입력값 초기화
//                     },
//                     error: function (error) {
//                         // 오류 메시지
//                         var errorMessage = "공지사항 등록에 실패했습니다.";
//                         if (error.responseJSON && error.responseJSON.message) {
//                             errorMessage = error.responseJSON.message; // 서버에서 보낸 오류 메시지
//                         }
//                         alert(errorMessage);
//                     }
//                 });
            });

            // 입력 초기화 버튼 클릭 이벤트
            $("#alert_demo_7").click(function () {
                if (confirm("입력값을 초기화하시겠습니까?")) {
                    $('input, textarea').val(''); // 입력 필드 비우기
                    alert("모든 입력값이 초기화되었습니다.");
                }
            });
        
    </script>
</body>
</html>
