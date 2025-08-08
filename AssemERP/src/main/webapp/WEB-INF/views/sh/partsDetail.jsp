<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품 상세</title>
<jsp:include page="/common.jsp" />
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #C0C0C0;
	color: white;
}

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
	object-fit: cover; /* 비율 유지 + 잘라서 꽉 채움 */
	display: block; /* 여백 제거 */
}
.parent-container {
  display: flex;
  flex-direction: column;
  gap: 15px; /* 항목들 사이 간격을 균일하게 12px 설정 */
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
							<a href="/product/productList"
								class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<%------------------------------------------------------------------------------
                						1-2. 타이틀 중앙 정렬 스타일
                 					------------------------------------------------------------------------------%>
							<h4 class="card-title mb-0">제품 상세</h4>
							<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body p-4">
							<form action="/product/productUpdate" method="post"
								class="needs-validation" enctype="multipart/form-data"
								novalidate>

								<!-- 제품박스 -->
								<h5 class="mb-3">기본 정보</h5>
								<div class="row">
									<!-- 이미지 -->
									<div class="col-md-4 mb-12">
										<div class="image-box">
											<c:choose>
												<c:when test="${empty productDTO.filename}">
													<img
														src="${pageContext.request.contextPath}/upload/default.jpg"
														alt="기본이미지">
												</c:when>
												<c:otherwise>
													<img
														src="${pageContext.request.contextPath}/upload/s_${productDTO.filename}"
														alt="부품이미지">
												</c:otherwise>
											</c:choose>
										</div>
									</div>


									<div class="col-md-8 mb-12">
										<div class="parent-container">
											<!-- 제품명 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">제품번호</span>
												<input type="text" class="form-control form-control-sm"
													name="product_no" value="${productDTO.product_no }"
													readonly="readonly">
											</div>


											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">제품명</span>
												<input type="text" class="form-control form-control-sm"
													id="productName" name="product_name"
													value="${productDTO.product_name }" readonly="readonly">

											</div>

											<!-- 제품구분 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">구분</span>
												<input type="text" class="form-control form-control-sm"
													id="productStatus" name="product_status"
													value="${productDTO.product_statusName }"
													readonly="readonly">
											</div>
											
											<!-- 제조사 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">제조사</span>
												<input type="text" class="form-control form-control-sm"
													id="empNo" name="emp_no" value="${productDTO.emp_name }"
													readonly="readonly">
											</div>
											
											<!-- 등록자 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">등록자</span>
												<input type="text" class="form-control form-control-sm"
													id="empNo" name="emp_no" value="${productDTO.emp_name }"
													readonly="readonly">
											</div>

											<!-- 등록일 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">등록일</span>
												<input type="date" class="form-control form-control-sm"
													id="productIndate" name="in_date" readonly="readonly"
													value="${productDTO.in_date }">
											</div>
										</div>
									</div>
								</div>


								<div class="row">
									<div class="col-md-6 mb-12 pt-5">
										<!-- 부품설명 -->
										<div class="input-group">
											<span class="input-group-text autospace"
												style="width: 100px; display: flex; justify-content: center;">제품설명</span>
											<textarea class="form-control form-control-sm" rows="8"
												id="productContext" name="product_context"
												placeholder="설명란에 정보를 입력해주세요">${productDTO.product_context }</textarea>
										</div>
									</div>

									<div class="col-md-6 mb-12 pt-5">
										<div class="parent-container">
											<!-- 재고량 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">재고</span>
												<input type="text" class="form-control form-control-sm"
													id="" name="" value="" readonly="readonly">
											</div>

											<!-- 최근거래가 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">최근거래가</span>
												<input type="text" class="form-control form-control-sm"
													id="" name="" value="" readonly="readonly">
											</div>

											<!-- 최근판매량 -->
											<div class="input-group">
												<span class="input-group-text autospace"
													style="width: 100px; display: flex; justify-content: center;">최근구매량</span>
												<input type="text" class="form-control form-control-sm"
													id="" name="" value="" readonly="readonly">
											</div>
										</div>
									</div>
								</div>
								
								<div class="row mt-4 g-2">
									<%------------------------------------------------------------------------------
					                     		4. Bootstrap 버튼 클릭
					                     			 - 삭제	: 삭제 이벤트
					                     			 - 수정	: 수정 이벤트
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
							<form id="deleteForm" action="/product/productDeletePro"
								method="post" class="d-none">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="product_no" value="${productDTO.product_no}">
							</form>
						</div>
					</div>
				</div>
			</div>


			<jsp:include page="/foot.jsp" />
		</div>
	</div>


	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />

	<script>

</script>
</body>
</html>