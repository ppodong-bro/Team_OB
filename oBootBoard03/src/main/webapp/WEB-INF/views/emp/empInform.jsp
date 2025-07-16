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
	        <h2 class="text-center mb-4">사원 등록</h2>
	        <form action="${pageContext.request.contextPath}/emp/saveEmp" method="post" enctype="multipart/form-data">


	            <div class="mb-3">
	                <label for="empname" class="form-label">이름</label>
	                <input type="text" class="form-control" id="emp_name" name="emp_name" placeholder="이름을 입력하세요" required>
	            </div>
	            <div class="mb-3">
	                <label for="Email" class="form-label">이메일</label>
	                <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" required>
	            </div>
	            <div class="mb-3">
	                <label for="EmpTel" class="form-label">전화번호</label>
	                <input type="text" class="form-control" id="emp_tel" name="emp_tel" placeholder="전화번호를 입력하세요(예: 010-0000-0000)" required>
	            </div>
					<div class="mb-3">
	                <label for="sal" class="form-label">급여</label>
	                <input type="number" class="form-control" id="sal" name="sal" placeholder="급여를 입력하세요" required>
	            </div>
	            <div class="mb-3">
	                <label for="emp_id" class="form-label">아이디</label>
	                <input type="text" class="form-control" id="emp_id" name="emp_id" placeholder="아이디를 입력하세요" required>
	            </div>
	            <div class="mb-3">
	                <label for="emp_password" class="form-label">패스워드</label>
	                <input type="password" class="form-control" id="emp_password" name="emp_password" placeholder="패스워드를 입력하세요" required>
	            </div>
	            <div class="mb-3">
	                <label for="in_date" class="form-label">등록일</label>
	                <input type="date" class="form-control" id="in_date" name="in_date" required>
	            </div>
	            <div class="row mb-3">
	             	<label for="dept_code" class="dept">부서</label>
	            	<select id="dept_code" name="dept_code">
	            		<c:forEach var="dept" items="${ deptAllList}">
	            			<option value="${dept.dept_code }">${dept.dept_name }</option>
	            		</c:forEach>
	            	</select>
	            </div>
	            <div class="mb-3">
	            	<label for="files" class="form-label">파일</label>
	            	<input type="file" multiple="multiple" id="files" name="files">
	            </div>
				
	            <!-- 폼 제출 버튼 -->
	            <div class="d-grid gap-2">
	                <button type="submit" class="btn btn-primary btn-lg" >등록하기</button>
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