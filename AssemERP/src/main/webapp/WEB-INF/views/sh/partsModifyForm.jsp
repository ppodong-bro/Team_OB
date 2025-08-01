<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부품 등록</title>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
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
			<div class="container px-3 py-4">
				<div class="card shadow-sm bg-white col-md-6 mx-auto">
					<%------------------------------------------------------------------------------
                			1. Card Header 정중앙
                	 ------------------------------------------------------------------------------%>
					<div
						class="card-header d-flex justify-content-between align-items-center">
						<%------------------------------------------------------------------------------
                			1-1. 목록 버튼 스타일
                 		------------------------------------------------------------------------------%>
						<a href="/parts/partsList" class="btn btn-outline-light btn-sm">
							<i class="bi bi-list-ul me-1"></i> 목록
						</a>
						<%------------------------------------------------------------------------------
                			1-2. 타이틀 중앙 정렬 스타일
                 		------------------------------------------------------------------------------%>
						<h4 class="card-title mb-0">부품 수정</h4>
						<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
						<div style="width: 90px;"></div>
					</div>
					<div class="card-body">
						<form method="post"
							action="${pageContext.request.contextPath}/parts/partsUpdate">
							<input type="hidden" value="${partsDTO.parts_no }">
							<!-- 부품명 -->
							<div class="mb-3">
								<label for="partsName" class="form-label">부품명</label>
								<div class="input-group">
									<span class="input-group-text"> <i class="bi bi-tag"></i>
									</span> <input type="text" class="form-control form-control-sm"
										id="partsName" name="parts_name" value="${partsDTO.parts_name}" required>
								</div>
							</div>

							<!-- 부품종류 -->
							<div class="mb-3">
								<label for="partsStatus" class="form-label">종류</label>
								<div class="input-group">
									<span class="input-group-text"> <i class="bi bi-grid"></i></span>
									<select class="form-control form-control-sm" id="partsStatus" name="parts_status" required>
										<option value="">== 선택 ==</option>
										<option value="0" ${partsDTO.parts_status == 0 ? 'selected' : ''}>메인보드</option>
										<option value="1" ${partsDTO.parts_status == 1 ? 'selected' : ''}>CPU</option>
										<option value="2" ${partsDTO.parts_status == 2 ? 'selected' : ''}>GPU</option>
										<option value="3" ${partsDTO.parts_status == 3 ? 'selected' : ''}>메모리</option>
										<option value="4" ${partsDTO.parts_status == 4 ? 'selected' : ''}>파워</option>
										<option value="5" ${partsDTO.parts_status == 5 ? 'selected' : ''}>HDD</option>
										<option value="6" ${partsDTO.parts_status == 6 ? 'selected' : ''}>SSD</option>
										<option value="7" ${partsDTO.parts_status == 7 ? 'selected' : ''}>케이스</option>
										<option value="8" ${partsDTO.parts_status == 8 ? 'selected' : ''}>쿨러</option>
									</select>
								</div>
							</div>

							<!-- 제조사 -->
							<div class="mb-3">
								<label for="partsmanufacture" class="form-label">부품제조사</label>
								<div class="input-group">
									<span class="input-group-text"><i
										class="bi bi-buildings"></i></span> <input type="text"
										class="form-control form-control-sm" id="partsmanufacture"
										name="manufacture" value="${partsDTO.manufacture }">
								</div>
							</div>

							<!-- 등록자 -->
							<div class="mb-3">

								<label for="empNo" class="form-label">등록자</label>
								<div class="input-group">
									<span class="input-group-text"><i class="bi bi-person"></i></span>
									<select class="form-control form-control-sm" name="emp_no"
										id="empNo">
										<%-- <c:forEach var="emp">
											<option value="${emp.emp_no }">${emp.emp_name }</option>
										</c:forEach> --%>
									</select>
								</div>
							</div>

							<!-- 부품설명 -->
							<div class="mb-3">
								<label for="partsContext" class="form-label">부품설명</label>
								<textarea class="form-control form-control-sm" rows="5"
									id="partsContext" name="parts_context"
									>${partsDTO.parts_context }</textarea>

							</div>

							<!-- 이미지 -->
							<div class="mb-3">
								<label for="partsfile" class="form-label">부품이미지</label> <input
									type="file" class="form-control form-control-sm" id="partsfile"
									name="filename" value="${partsDTO.filename}">
							</div>

							<!-- 삭제 상태 (숨김) -->
							<input type="hidden" name="del_Status" value="0" />

							<!-- 제출 버튼 -->
							<div class="text-end mt-4">
								<button type="submit" class="btn btn-success btn-sm px-4 ">
									등록</button>
								<a href="${pageContext.request.contextPath}/parts/partsList"
									class="btn btn-outline-secondary btn-sm px-4"> 취소 </a>
							</div>

						</form>
					</div>
				</div>
			</div>

			<!-- 이곳에 자신의 코드를 작성하세요 -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>


	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
</body>
</html>
