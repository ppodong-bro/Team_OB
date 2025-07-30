<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>거래처 등록</title>
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
					<div class="card-header bg-light">
						<h5 class="mb-0">제품 등록</h5>
					</div>
					<div class="card-body">
						<form method="post"
							action="${pageContext.request.contextPath}/product/productCreate">
							<div class="row">
								<!-- 제품박스 -->
								<div class="col-md-4 border-end pe-4">

									<!-- 제품명 -->
									<div class="mb-3">
										<label for="productName" class="fo rm-label">제품명</label> <input
											type="text" class="form-control form-control-sm"
											id="productName" name="product_name" required>
									</div>

									<!-- 제품종류 -->
									<div class="mb-3">
										<label for="productStatus" class="form-label">종류</label> <select
											class="form-select form-select-sm w-auto" id="productStatus"
											name="product_status" required>
											<option value="">선택</option>
											<option value="0">데스크탑</option>
											<option value="1">노트북</option>
											<option value="2">워크스테이션</option>
										</select>
									</div>

									<!-- 등록자 -->
									<div class="mb-3">
										<label for="empNo" class="form-label">등록자</label> <select
											class="form-control form-control-sm" name="emp_no" id="empNo">
											<%-- <c:forEach var="emp">
											<option value="${emp.emp_no }">${emp.emp_name }</option>
										</c:forEach> --%>
										</select>

									</div>

									<!-- 부품설명 -->
									<div class="mb-3">
										<label for="productContext" class="form-label">제품설명</label>
										<textarea class="form-control form-control-sm" rows="5"
											id="productContext" name="product_context"
											placeholder="설명란에 정보를 입력해주세요"></textarea>

									</div>

									<!-- 이미지 -->
									<div class="mb-3">
										<label for="productfile" class="form-label">부품이미지</label> <input
											type="file" class="form-control form-control-sm"
											id="productfile" name="filename">
									</div>
								</div>

								<!-- Bom박스 -->
								<div class="col-md-8 ps-4">
									<div class="mb-3">
										<label for="mainboard" class="form-label">메인보드</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="mainboard" name="productBOM[0].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 0}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[0].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="CPU" class="form-label">CPU</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="CPU" name="productBOM[1].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 1}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[1].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="GPU" class="form-label">GPU</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="GPU" name="productBOM[2].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 2}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[2].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="memory" class="form-label">메모리</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="memory" name="productBOM[3].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 3}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[3].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="power" class="form-label">파워</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="power" name="productBOM[4].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 4}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[4].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="HDD" class="form-label">HDD</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="HDD" name="productBOM[5].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 5}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[5].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="SSD" class="form-label">SSD</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="SSD" name="productBOM[6].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 6}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[6].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="case" class="form-label">케이스</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="case" name="productBOM[7].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 7}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[7].cnt" id="count">
										</div>
									</div>
									<div class="mb-3">
										<label for="cooler" class="form-label">쿨러</label>
										<div class="d-flex align-items-center gap-2">
											<select class="form-select form-select-sm flex-grow-1"
												id="cooler" name="productBOM[8].parts_no">
												<c:forEach items="${partsDTOs}" var="parts">
													<c:if test="${parts.parts_status == 8}">
														<option value="${parts.parts_no}">${parts.parts_name}</option>
													</c:if>
												</c:forEach>
											</select> <input type="number" class="form-control form-control-sm"
												style="width: 50px;" name="productBOM[8].cnt" id="count">
										</div>
									</div>
								</div>



							</div>

							<!-- 삭제 상태 (숨김) -->
							<input type="hidden" name="del_Status" value="0" />

							<!-- 제출 버튼 -->
							<div class="text-end mt-4">
								<button type="submit" class="btn btn-primary btn-sm px-4">
									등록</button>
								<a href="${pageContext.request.contextPath}/product/productList"
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
