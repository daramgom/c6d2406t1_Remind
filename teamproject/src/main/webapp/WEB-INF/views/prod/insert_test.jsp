<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <style>
        #preview { /* 미리보기 img 태그 id */
            display: none; /* 초기에는 숨김 */
            max-width: 300px; /* 최대 너비 설정 */
            margin: 10px; /* 여백 설정 */
        }
    </style>
    
</head>
<body>
	<h1>insertProd 테스트</h1>
	 
	 <fieldset>
		 <form action="" method="post" enctype="multipart/form-data">
	 		prod_id : <input type="text" name="prod_id"> <br>
	 		prod_name : <input type="text" name="prod_name"> <br>
	 		prod_reguser : <input type="text" name="prod_reguser"> <br> <!-- 이후에 세션영역의 id 정보 저장 -->
	 		prod_upduser : <input type="text" name="prod_upduser"> <br> <!-- 이후에 세션영역의 id 정보 저장 -->
	 		prod_category : <input type="text" name="prod_category"> <br>
	 		prod_brand : <input type="text" name="prod_brand"> <br>
	 		prod_price : <input type="number" name="prod_price"> <br>
	 		prod_qty : <input type="number" name="prod_qty"> <br>
	 		company_code : <input type="text" name="company_code"> <br>
	 		uploadfile : <input type="file" name="uploadfile" 
			id="uploadfile" accept=".jpeg, .jpg, .png, .gif"> <img id="preview" alt="미리보기이미지" src="#"/> <br>
			<!-- 파일 업로드시 이미지 파일 업로드할 수 있도록 제한 (자바스크립트에서 추가제어) -->
	 		<input type="submit" value="제품등록">
		 </form>
	 </fieldset>
	 <!-- <img alt="uploadimageview" src="/uploads/e008a376-8d6f-4fa7-a5b2-5d587eb2dfc6_daramg.jpg" style="max-width: 300px;" /> -->
	 <!--  web.xml에 서블릿 추가한 뒤 이미지가 보임 -->
	
	<!-- 미리보기 기능과 업로드 파일 이미지로 제한주기 -->
    <script>
        const uploadFile = document.getElementById('uploadfile'); // const : 선언된 변수가 재할당되지 않도록 고정된 값
        const preview = document.getElementById('preview');

        uploadFile.addEventListener('change', function(event) {
            const file = event.target.files[0]; // 선택된 파일
            if (file) {
          
                 // MIME 타입 확인
                 const fileType = file.type;
                 const ImageTypes = [
                     'image/jpeg',  // JPEG
                     'image/png',   // PNG
                     'image/gif',   // GIF
                     //'image/bmp',   // BMP
                     //'image/tiff',  // TIFF
                     //'image/webp',  // WEBP
                     //'image/svg+xml', // SVG
                     //'image/heif',  // HEIF
                     //'image/heic'   // HEIC
                 ]; // 허용하는 이미지 타입

                 if (!ImageTypes.includes(fileType)) {
                     alert('이미지 파일만 업로드 가능합니다.'); // 경고 메시지
                     uploadFile.value = ''; // 입력값 초기화 (업로드 자체를 막음)
                     preview.style.display = 'none'; // 미리보기 숨김
                     return; // 함수 종료
                 }
            	
                const reader = new FileReader(); // FileReader 객체 생성

                // 파일이 로드되면 미리보기 이미지 src를 설정
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'inline-block'; // 이미지 display 속성을 inline-block으로 변경하여 보이도록 설정
                };

                reader.readAsDataURL(file); // 파일을 Data URL로 읽기
            }
        });
    </script>
    <!-- 미리보기 기능과 업로드 파일 이미지로 제한주기 -->
    
    <a href="http://localhost:8088/main">메인페이지</a>
</body>
</html>