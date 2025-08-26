<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부품 등록</title>
<jsp:include page="/common.jsp" />
<script>
    function deleteFile(partsNo) {
        if(confirm('파일을 삭제하시겠습니까?')) {
            fetch(${pageContext.request.contextPath}+'/parts/deleteFile/' + partsNo, {
                method: 'DELETE'
            }).then(response => {
                if(response.ok) {
                    alert('파일이 삭제되었습니다.');
                    location.reload(); // 새로고침해서 UI 업데이트
                } else {
                    alert('파일 삭제에 실패했습니다.');
                }
            }).catch(e => alert('오류가 발생했습니다.'));
        }
    }
</script>
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #198754;
	color: white;
} /* Green theme for editing */
.required-field::after {
	content: " *";
	color: red;
}

.image-box {
	width: auto; /* 원하는 가로 크기 */
	height: 300px; /* 원하는 세로 크기 */
	overflow: hidden;
}

.image-box img {
	width: 100%;
	height: 100%;
	display: block; /* 여백 제거 */
}

.parent-container {
	display: flex;
	flex-direction: column;
	gap: 30px; /* 항목들 사이 간격을 균일하게 12px 설정 */
}
</style>
<!-- 공통 CSS -->
</head>
<body>
	<!-- 전체 레이아웃 -->
	<div id="layout">
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>
		<div id="main-area">
			<jsp:include page="/header.jsp" />
			<!-- 이곳에 자신의 코드를 작성하세요 -->
			<div id="contents">
				<div class="container-fluid px-4 py-4">
					<div class="card shadow-sm">
						<%------------------------------------------------------------------------------
                					1. Card Header 정중앙
                	 			------------------------------------------------------------------------------%>
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<%------------------------------------------------------------------------------
                						1-1. 목록 버튼 스타일
                 					------------------------------------------------------------------------------%>
							<a href="${pageContext.request.contextPath}/parts/partsList" class="btn btn-outline-light btn-sm">
								<i class="bi bi-list-ul me-1"></i> 목록
							</a>
							<%------------------------------------------------------------------------------
                						1-2. 타이틀 중앙 정렬 스타일
                 					------------------------------------------------------------------------------%>
							<h4 class="card-title mb-0">
							 <i class="bi bi-pencil-square me-2"></i> 부품 수정</h4>
							<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body p-4">
							<form method="post"
								action="${pageContext.request.contextPath}/parts/partsUpdate"
								enctype="multipart/form-data">
								<input type="hidden" name="parts_no"
									value="${partsDTO.parts_no }">

								<h5 class="mb-3">기본 정보</h5>

								<div class="row">
									<!-- 부품명 -->
									<div class="col-md-4 mb-12">
										<div class="image-box" style="position: relative;">
											<div class="image-box">
												<c:choose>
											    <c:when test="${empty partsDTO.filename}">
											        <!-- 파일명이 없으면 기본 이미지 -->
											        <img id="partImage" src="${pageContext.request.contextPath}/upload/default.jpg" alt="기본이미지">
											    </c:when>
											    <c:otherwise>
											        <!-- 파일명이 있으면 먼저 부품 이미지로 시도 -->
											        <img id="partImage" src="${pageContext.request.contextPath}/upload/s_${partsDTO.filename}" alt="부품이미지">
											    </c:otherwise>
											</c:choose>
											
											<script>
											    const img = document.getElementById('partImage');
											
											    // 이미지 로딩 실패 시 기본 이미지로
											    img.onerror = function() {
											        this.src = "${pageContext.request.contextPath}/upload/default.jpg";
											    };
											
											    // 파일 크기 체크 (이미지가 있더라도 0이면 기본 이미지)
											    fetch(img.src, { method: 'HEAD' })
											        .then(response => {
											            const size = response.headers.get('Content-Length');
											            if (!size || parseInt(size) === 0) {
											                img.src = "${pageContext.request.contextPath}/upload/default.jpg";
											            }
											        })
											        .catch(() => {
											            img.src = "${pageContext.request.contextPath}/upload/default.jpg";
											        });
											</script>
												<!-- X 삭제 버튼 -->
												<c:if test="${!empty partsDTO.filename}">
													<i class="bi bi-x"
														onclick="deleteFile(${partsDTO.parts_no})"
														style="position: absolute; background-color: red; top: 0px; right: 0px; font-size: 30px; border: solid; border-width: 2px; width: 30px; height: 30px; display: flex; align-items: center; justify-content: center; line-height: 40px; border-radius: 2px;"></i>
												</c:if>
											</div>
										</div>
										<input type="file" class="form-control form-control-sm"
											id="partsfile" name="file">
									</div>







									<!-- 부품 -->
									<div class="col-md-8 mb-12">
										<div class="parent-container">
											<!-- 부품명 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">부품명</span>
												<input type="text" class="form-control form-control-sm"
													id="partsName" name="parts_name"
													value="${partsDTO.parts_name}" readonly="readonly" required>
											</div>

											<!-- 부품구분 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">구분</span>
												<select class="form-control form-control-sm"
													id="partsStatus" name="parts_status" required>
													<option value="">== 선택 ==</option>
													<option value="0"
														${partsDTO.parts_status == 0 ? 'selected' : ''}>메인보드</option>
													<option value="1"
														${partsDTO.parts_status == 1 ? 'selected' : ''}>CPU</option>
													<option value="2"
														${partsDTO.parts_status == 2 ? 'selected' : ''}>GPU</option>
													<option value="3"
														${partsDTO.parts_status == 3 ? 'selected' : ''}>메모리</option>
													<option value="4"
														${partsDTO.parts_status == 4 ? 'selected' : ''}>파워</option>
													<option value="5"
														${partsDTO.parts_status == 5 ? 'selected' : ''}>HDD</option>
													<option value="6"
														${partsDTO.parts_status == 6 ? 'selected' : ''}>SSD</option>
													<option value="7"
														${partsDTO.parts_status == 7 ? 'selected' : ''}>케이스</option>
													<option value="8"
														${partsDTO.parts_status == 8 ? 'selected' : ''}>쿨러</option>
												</select>
											</div>




											<!-- 제조사 -->
											<div class="input-group">

												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">제조사</span><input
													type="text" class="form-control form-control-sm"
													id="partsmanufacture" name="manufacture"
													value="${partsDTO.manufacture }">
											</div>


											<!-- 등록자 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">등록자</span>
												<select class="form-control form-control-sm" name="emp_no"
													id="empNo">
													<c:forEach var="emp" items="${EmpList}">
														<option value="${emp.empNo }"
															${emp.empNo == partsDTO.emp_no ? 'selected' : ''}>${emp.empName }</option>
													</c:forEach>
												</select>
											</div>


											<!-- 등록일 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">등록일</span>
												<input type="date" class="form-control form-control-sm"
													id="partsIndate" name="in_date" readonly="readonly"
													value="${partsDTO.in_date }">
											</div>
										</div>
									</div>
								</div>

								<!-- 부품설명 -->
								<div class="row">
									<div class="col-md-12 mb-12 pt-5">
										<div class="input-group">
											<span class="input-group-text autospace"
												style="width: 100px; display: flex; justify-content: center;">부품설명</span>
											<textarea class="form-control form-control-sm" rows="8"
												id="partsContext" name="parts_context">${partsDTO.parts_context }</textarea>
										</div>
									</div>
								</div>

								<div class="row mt-4 g-2">
									<%------------------------------------------------------------------------------
					                     		4. Bootstrap 버튼 클릭
					                     			 - 초기화   : 화면 Clear
					                     			 - XX 등록 : 등록 이벤트
					                    	------------------------------------------------------------------------------%>
									<div class="col-md-4 d-grid">
										<button type="button" id="deleteBtn" class="btn btn-danger">
											<i class="bi bi-trash me-2"></i>삭제
										</button>
									</div>
									<div class="col-md-8 d-grid">
										<button type="submit" class="btn btn-success">
											<i class="bi bi-check-lg me-2"></i>정보 수정
										</button>
									</div>
								</div>
							</form>
							<%------------------------------------------------------------------------------
				                   		5. 삭제 처리를 위한 별도 form
				                  	------------------------------------------------------------------------------%>
							<form id="deleteForm" action="${pageContext.request.contextPath}/parts/partsDeletePro"
								method="post" class="d-none">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden" name="parts_no"
									value="${partsDTO.parts_no}">
							</form>
						</div>

					</div>
				</div>
				<!-- 이곳에 자신의 코드를 작성하세요 -->

			</div>
			<jsp:include page="/foot.jsp" />
		</div>
	</div>

	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
	<script>
	 // 삭제 버튼 확인 스크립트
    const deleteBtn = document.getElementById('deleteBtn');
    if(deleteBtn) {
        deleteBtn.addEventListener('click', function() {
            if(confirm('정말로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                document.getElementById('deleteForm').submit();
            }
        });
    }
</script>
</body>
</html>
