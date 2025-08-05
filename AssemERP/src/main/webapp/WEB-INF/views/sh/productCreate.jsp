<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품 등록</title>
<jsp:include page="/common.jsp" />
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
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
<script type="text/javascript">
	function validatePartsSelection() {
	    const partLabels = {
	        mainboard: "메인보드",
	        CPU: "CPU",
	        GPU: "GPU",
	        memory: "메모리",
	        power: "파워",
	        HDD: "HDD",
	        SSD: "SSD",
	        case: "케이스",
	        cooler: "쿨러"
	    };
	
	    const partIds = Object.keys(partLabels);
	    let emptyParts = [];
	
	    for (let id of partIds) {
	        const select = document.getElementById(id);
	        if (!select || !select.value || select.value.trim() === "") {
	            emptyParts.push(partLabels[id]);
	        }
	    }
	
	    console.log("비어있는 부품 리스트:", emptyParts);
	
	    if (emptyParts.length > 0) {
	        const partNames = emptyParts.join(', ');
	        console.log("부품명 문자열:", partNames);
	        const proceed = confirm(partNames+"부품이 선택되지 않았습니다.\n계속 진행하시겠습니까?");
	        return proceed;
	    }
	
	    return true;
	}
	
	
	document.addEventListener("DOMContentLoaded", function() {
	    const selects = document.querySelectorAll(".parts-select");

	    selects.forEach(select => {
	        select.addEventListener("change", function() {
	        	const wrapper = this.closest(".d-flex");
	            const input = wrapper.querySelector(".parts-count");
	            if (this.value !== "") {
	                // 부품을 선택했을 경우
	                if (input && (!input.value || parseInt(input.value) <= 0)) {
	                    input.value = 1;
	                }
	            } else {
	                // 선택 해제된 경우 수량도 0으로
	                if (input) {
	                    input.value = "";
	                }
	            }
	        });
	    });
	});
</script>
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
									<h4 class="card-title mb-0">신규 제품 등록</h4>
									<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
									<div style="width: 90px;"></div>
								</div>
								<div class="card-body p-4">
									<form method="post"
										action="${pageContext.request.contextPath}/product/productCreate"
										enctype="multipart/form-data"
										onsubmit="return validatePartsSelection()">
										<div class="row">
											<!-- 제품박스 -->
											<div class="col-md-4 border-end pe-4">

												<!-- 제품명 -->
												<div class="mb-3">
													<label for="productName" class="fo rm-label">제품명</label>
													<div class="input-group">
														<span class="input-group-text"> <i
															class="bi bi-tag"></i>
														</span> <input type="text" class="form-control form-control-sm"
															id="productName" name="product_name" required>
													</div>
												</div>

												<!-- 제품종류 -->
												<div class="mb-3">
													<label for="productStatus" class="form-label">종류</label>
													<div class="input-group">
														<span class="input-group-text"> <i
															class="bi bi-grid"></i></span> <select
															class="form-select form-select-sm w-auto"
															id="productStatus" name="product_status" required>
															<option value="">선택</option>
															<option value="0">데스크탑</option>
															<option value="1">노트북</option>
															<option value="2">워크스테이션</option>
														</select>
													</div>
												</div>

												<!-- 등록자 -->
												<div class="mb-3">
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
														id="productfile" name="file">
												</div>
											</div>

											<!-- Bom박스 -->
											<div class="col-md-8 ps-4">
												<div class="mb-3">
													<label for="mainboard" class="form-label">메인보드</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-motherboard"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="mainboard" name="productBOM[0].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 0}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[0].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="CPU" class="form-label">CPU</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-cpu"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="CPU" name="productBOM[1].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 1}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[1].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="GPU" class="form-label">GPU</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-gpu-card"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="GPU" name="productBOM[2].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 2}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[2].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="memory" class="form-label">메모리</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-memory"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="memory" name="productBOM[3].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 3}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[3].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="power" class="form-label">파워</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-plug"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="power" name="productBOM[4].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 4}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[4].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="HDD" class="form-label">HDD</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-device-hdd"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="HDD" name="productBOM[5].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 5}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[5].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="SSD" class="form-label">SSD</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-device-ssd"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="SSD" name="productBOM[6].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 6}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[6].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="case" class="form-label">케이스</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><svg
																	xmlns="http://www.w3.org/2000/svg" width="16"
																	height="16" viewBox="0 0 24 40" fill="none"
																	stroke="currentColor" stroke-width="1.5"
																	stroke-linejoin="round">
																	  <!-- 본체 외곽 -->
																	  <rect x="4" y="2" width="16" height="36" rx="2"
																		ry="2" fill="none" />
																	  <!-- 전원 버튼 -->
																	  <circle cx="12" cy="10" r="2" fill="currentColor" />
																	  <!-- 디스크 드라이브 슬롯 -->
																	  <rect x="6" y="18" width="12" height="4" rx="1"
																		ry="1" fill="currentColor" />
																	  <!-- 통풍구 -->
																	  <line x1="6" y1="26" x2="18" y2="26"
																		stroke="currentColor" stroke-width="1" />
																	  <line x1="6" y1="29" x2="18" y2="29"
																		stroke="currentColor" stroke-width="1" />
																	  <line x1="6" y1="32" x2="18" y2="32"
																		stroke="currentColor" stroke-width="1" />
																	</svg> </span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="case" name="productBOM[7].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 7}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[7].cnt" min="0">
													</div>
												</div>
												<div class="mb-3">
													<label for="cooler" class="form-label">쿨러</label>
													<div class="d-flex align-items-center gap-2">
														<div class="input-group">
															<span class="input-group-text"><i
																class="bi bi-fan"></i></span> <select
																class="parts-select form-select form-select-sm flex-grow-1"
																id="cooler" name="productBOM[8].parts_no">
																<option value="">--부품을 선택해주세요--</option>
																<c:forEach items="${partsDTOs}" var="parts">
																	<c:if test="${parts.parts_status == 8}">
																		<option value="${parts.parts_no}">${parts.parts_name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
														<input type="number"
															class="parts-count form-control form-control-sm"
															style="width: 50px;" name="productBOM[8].cnt" min="0">
													</div>
												</div>
											</div>



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
													<i class="bi bi-check-lg me-2"></i>사원 등록
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