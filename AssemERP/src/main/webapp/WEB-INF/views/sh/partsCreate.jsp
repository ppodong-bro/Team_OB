<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부품 등록</title>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<style>
	body {
		background-color: #f8f9fa;
	}
	
	.card-header {
		background-color: #0d6efd;
		color: white;
	}
	
	.required-field::after {
		content: " *";
		color: red;
	}
</style>
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
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-8">
							<div class="card shadow-sm">
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
									<h4 class="card-title mb-0">신규 부품 등록</h4>
									<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
									<div style="width: 90px;"></div>
								</div>
								<div class="card-body">
									<form method="post" enctype="multipart/form-data"
										action="${pageContext.request.contextPath}/parts/partsCreate">

										<!-- 부품명 -->
										<h5 class="mb-3">기본 정보</h5>
										<div class="row">
											<div class="col-md-6 mb-3">
												<label for="partsName" class="form-label">부품명</label>
												<div class="input-group">
													<span class="input-group-text"> <i class="bi bi-tag"></i>
													</span> <input type="text" class="form-control form-control-sm"
														id="partsName" name="parts_name" required>
												</div>
											</div>

											<!-- 부품구분 -->
											<div class="col-md-6 mb-3">
												<label for="partsStatus" class="form-label">구분</label>
												<div class="input-group">
													<span class="input-group-text"> <i
														class="bi bi-grid"></i></span> <select
														class="form-control form-control-sm" id="partsStatus"
														name="parts_status" required>
														<option value="">부품을 선택하세요</option>
														<option value="0">매인보드</option>
														<option value="1">CPU</option>
														<option value="2">GPU</option>
														<option value="3">메모리</option>
														<option value="4">파워</option>
														<option value="5">HDD</option>
														<option value="6">SSD</option>
														<option value="7">케이스</option>
														<option value="8">쿨러</option>
													</select>
													<div class="invalid-feedback">부서를 선택해주세요.</div>
												</div>
											</div>
										</div>

										<!-- 제조사 -->
										<div class="row">
											<div class="col-md-6 mb-3">
												<label for="partsmanufacture" class="form-label">부품제조사</label>
												<div class="input-group">
													<span class="input-group-text"><i
														class="bi bi-buildings"></i></span> <input type="text"
														class="form-control form-control-sm" id="partsmanufacture"
														name="manufacture">
												</div>
											</div>

											<!-- 등록자 -->
											<div class="col-md-6 mb-3">

												<label for="empNo" class="form-label">등록자</label>
												<div class="input-group">
													<span class="input-group-text"><i
														class="bi bi-person"></i></span> <select
														class="form-control form-control-sm" name="emp_no"
														id="empNo">
														<%-- <c:forEach var="emp">
											<option value="${emp.emp_no }">${emp.emp_name }</option>
										</c:forEach> --%>
													</select>
												</div>
											</div>
										</div>

										<!-- 부품설명 -->
										<div class="mb-3">
											<label for="partsContext" class="form-label">부품설명</label>
											<textarea class="form-control form-control-sm" rows="5"
												id="partsContext" name="parts_context"
												placeholder="설명란에 정보를 입력해주세요"></textarea>

										</div>

										<!-- 이미지 -->
										<div class="mb-3">
											<label for="partsfile" class="form-label">부품이미지</label> <input
												type="file" class="form-control form-control-sm"
												id="partsfile" name="file">
										</div>

										<div class="row mt-4 g-2">
											<%------------------------------------------------------------------------------
					                     		4. Bootstrap 버튼 클릭
					                     			 - 초기화   : 화면 Clear
					                     			 - XX 등록 : 등록 이벤트
					                    	------------------------------------------------------------------------------%>
											<div class="col-6 d-grid">
												<button type="reset" class="btn btn-outline-secondary">
													<i class="bi bi-arrow-counterclockwise me-2"></i>초기화
												</button>
											</div>
											<div class="col-6 d-grid">
												<button type="submit" class="btn btn-primary">
													<i class="bi bi-check-lg me-2"></i>등록
												</button>
											</div>
										</div>

									</form>
								</div>
							</div>
						</div>
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
