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
	        <h2 class="text-center mb-4">부서 상세 조회</h2>
	        <!-- 조회 화면이므로 form action은 필요 없음. -->
	        <!-- 만약 수정 페이지로 이동하는 버튼이 있다면, 해당 버튼에 onclick 등으로 처리 -->
        <form>
            <!-- 부서 번호 -->
            <div class="row mb-3">
                <label for="deptCode" class="col-sm-2 col-form-label form-label-col">부서 번호</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="deptCode" name="dept_code" value="${deptDto.dept_code}" disabled="disabled">
                </div>
            </div>
            
            <!-- 부서 이름 -->
            <div class="row mb-3">
                <label for="deptName" class="col-sm-2 col-form-label form-label-col">부서 이름</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="deptName" name="dept_name" value="${deptDto.dept_name}" disabled="disabled">
                </div>
            </div>

            <!-- 부서 대표 전화 -->
            <div class="row mb-3">
                <label for="deptTel" class="col-sm-2 col-form-label form-label-col">부서 대표 전화</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="deptTel" name="dept_tel" value="${deptDto.dept_tel}" disabled="disabled">
                </div>
            </div>

            <!-- 부서 위치 -->
            <div class="row mb-3">
                <label for="deptLoc" class="col-sm-2 col-form-label form-label-col">부서 위치</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="deptLoc" name="dept_loc" value="${deptDto.dept_loc}" disabled="disabled">
                </div>
            </div>

            <!-- 부서장 -->
            <div class="row mb-3">
                <label for="deptCaptain" class="col-sm-2 col-form-label form-label-col">부서장</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="deptCaptain" name="dept_captain" value="${deptDto.dept_captain}" disabled="disabled">
                </div>
            </div>

            <!-- 부서 구분 -->
            <div class="row mb-3">
                <label for="deptGubun" class="col-sm-2 col-form-label form-label-col">부서삭제</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="deptGubun" name="dept_gubun" value="${deptDto.dept_gubun}" disabled="disabled">
                </div>
            </div>

            <!-- 등록일 -->
            <div class="row mb-3">
                <label for="inDate" class="col-sm-2 col-form-label form-label-col">등록일</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="inDate" name="in_date" value="${deptDto.in_date}" disabled="disabled">
                </div>
            </div>

            <!-- 버튼 -->
			<div class="d-flex gap-2 mt-4 justify-content-center"> <!-- justify-content-center 추가로 버튼들을 가운데 정렬 -->
			    <button type="button" class="btn btn-primary btn-lg" onclick="location.href='${pageContext.request.contextPath}/dept/modifyForm?dept_code=${deptDto.dept_code}'">수정하기</button>
			     <!-- <button type="button" class="btn btn-danger btn-lg" onclick="location.href='${pageContext.request.contextPath}/dept/deleteForm?dept_code=${deptDto.dept_code}'">삭제하기</button> 삭제 버튼은 danger 색상이 어울려! -->
			    <!-- 삭제 버튼: data-bs-toggle과 data-bs-target으로 모달 연결 -->
                <button type="button" class="btn btn-danger btn-lg" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">삭제하기</button>
    
			    <button type="button" class="btn btn-secondary btn-lg" onclick="location.href='${pageContext.request.contextPath}/dept/list'">목록으로</button>
			</div>
			
			<!-- 삭제 확인 모달 (Modal) -->
			<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="deleteConfirmModalLabel">삭제 확인</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			        진정 이 부서 정보를 삭제하시겠습니까? 삭제된 정보는 되돌릴 수 없습니다.
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			        <!-- 모달 안의 실제 삭제 버튼 -->
			        <button type="button" class="btn btn-danger" 
			                id="confirmDeleteBtn"  
			                onclick="location.href='${pageContext.request.contextPath}/dept/deleteDept?dept_code=${deptDto.dept_code}'">
			                삭제
			         </button>
			      </div>
			    </div>
			  </div>
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