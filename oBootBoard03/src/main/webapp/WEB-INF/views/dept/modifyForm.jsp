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
	    <div class="form-container bg-primary bg-opacity-25">
	        <h2 class="text-center mb-4">부서 수정 저장</h2>
	        <!-- 조회 화면이므로 form action은 필요 없음. -->
	        <!-- 만약 수정 페이지로 이동하는 버튼이 있다면, 해당 버튼에 onclick 등으로 처리 -->
			<form action="${pageContext.request.contextPath}/dept/update" method="post">
			    <!-- 부서 번호 -->
			    <div class="row mb-3">
			        <label for="deptCode" class="col-sm-2 col-form-label form-label-col">부서 번호</label>
			        <div class="col-sm-10">
			            <!-- 부서 번호는 보통 수정할 수 없도록 readonly를 유지하거나 hidden으로 처리합니다. -->
			            <!-- 여기서는 화면에 보여주면서 수정은 막도록 readonly를 유지합니다. -->
			            <input type="text" class="form-control" id="deptCode" name="dept_code" value="${deptDto.dept_code}" readonly="readonly">
			        </div>
			    </div>
			    
			    <!-- 부서 이름 -->
			    <div class="row mb-3">
			        <label for="deptName" class="col-sm-2 col-form-label form-label-col">부서 이름</label>
			        <div class="col-sm-10">
			            <input type="text" class="form-control" id="deptName" name="dept_name" value="${deptDto.dept_name}">
			        </div>
			    </div>
			
			    <!-- 부서 대표 전화 -->
			    <div class="row mb-3">
			        <label for="deptTel" class="col-sm-2 col-form-label form-label-col">부서 대표 전화</label>
			        <div class="col-sm-10">
			            <input type="text" class="form-control" id="deptTel" name="dept_tel" value="${deptDto.dept_tel}">
			        </div>
			    </div>
			
			    <!-- 부서 위치 -->
 			    <div class="row mb-3">
			        <label for="deptLoc" class="col-sm-2 col-form-label form-label-col">부서 위치</label>
			        <div class="col-sm-10">
			            <input type="text" class="form-control" id="deptLoc" name="dept_loc" value="${deptDto.dept_loc}">
			        </div>
			    </div>

			
			    <!-- 부서장 -->
			    <div class="row mb-3">
			        <label for="deptCaptain" class="col-sm-2 col-form-label form-label-col">부서장</label>
   	             	<select id="deptCaptain" name="dept_captain">
	            		<c:forEach var="emp" items="${ empAllList}">
	            			<option value="${emp.emp_no }">${emp.emp_name }</option>
	            		</c:forEach>
	            	</select>
			    </div>
			
			    <!-- 부서 구분 -->
			       <div class="row mb-3">
	                <label for="deptGubun" class="col-sm-2 col-form-label form-label-col">부서 구분</label>
	                <div class="col-sm-10">
	                    <select class="form-select" id="deptGubun" name="dept_gubun" disabled="disabled">
	                        <option value="true" <c:if test="${deptDto.dept_gubun == true}">selected</c:if>>true</option>
	                        <option value="false" <c:if test="${deptDto.dept_gubun == false}">selected</c:if>>false</option>
	                    </select>
	                </div>
		         </div>

			
			    <!-- 등록일 -->
			    <div class="row mb-3">
			        <label for="inDate" class="col-sm-2 col-form-label form-label-col">등록일</label>
			        <div class="col-sm-10">
			            <!-- 등록일은 보통 수정하지 않는 필드이므로 readonly를 유지합니다. -->
			            <input type="text" class="form-control" id="inDate" name="in_date" value="${deptDto.in_date}" readonly>
			        </div>
			    </div>
			
			    <!-- 버튼 -->
			    <div class="d-flex gap-2 mt-4 justify-content-center"">
			        <!-- 수정하기 버튼: 폼을 서버로 제출 (type="submit") -->
			        <button type="submit" class="btn btn-primary btn-lg">수정 완료</button>
			        <!-- 목록으로 버튼: 부서 목록 페이지로 이동 (type="button" 유지) -->
			        <button type="button" class="btn btn-secondary btn-lg" onclick="location.href='${pageContext.request.contextPath}/dept/list'">목록으로</button>
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