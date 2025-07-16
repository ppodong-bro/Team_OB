<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- 부트스트랩 CSS CDN 링크 -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        /* 폼 컨테이너를 페이지 중앙에 배치하고 최대 너비 설정 (선택 사항) */
        .form-container {
            max-width: 70%;
            margin: 20px auto;
            padding: 20px;
            background-color: #FFBB00;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
	<div id="header">
		<%@ include file="../header.jsp" %>
	</div>
	<div id="contents">
	  <div class="container form-container  bg-primary bg-opacity-25">
	        <h2 class="text-center mb-4">부서 등록</h2>
	        <form action="${pageContext.request.contextPath}/dept/saveDept" method="post">
	            <!-- 부서 이름 입력 필드 -->
	            <div class="mb-3">
	                <label for="deptName" class="form-label">부서 이름</label>
	                <input type="text" class="form-control" id="dept_name" name="dept_name" placeholder="부서이름을 입력하세요(예:개발팀)" required>
	            </div>
	
	            <!-- 부서 대표 전화 입력 필드 -->
	            <div class="mb-3">
	                <label for="location" class="form-label">부서 대표 전화</label>
	                <input type="text" class="form-control" id="dept_tel" name="dept_tel" placeholder="부서대표전화를 입력하세요 (예:02-333-1234)" required>
	            </div>
	            
	            <!-- 부서 위치 입력 필드 -->
	            <div class="mb-3">
	                <label for="location" class="form-label">부서 위치</label>
	                <input type="text" class="form-control" id="dept_loc" name="dept_loc" placeholder="부서위치를 입력하세요 (예:서울)" required>
	            </div>

	            <!-- 폼 제출 버튼 -->
	            <div class="d-grid gap-2">
	                <button type="submit" class="btn btn-primary btn-lg">등록하기</button>
	                <button type="reset" class="btn btn-secondary btn-lg">초기화</button>
	            </div>
	        </form>
	    </div>	
    </div>
	<div id="footer">
		<%@ include file="../foot.jsp" %>
	</div>
	<!-- 부트스트랩 JS CDN 링크 (<body> 태그 닫기 직전에!) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>