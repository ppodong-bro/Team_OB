<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS 및 헤더 포함 (공통 레이아웃/스타일) -->
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css' />" />
<meta charset="UTF-8">
<!-- 반응형 대응: 모바일 등에서 제대로 보이게 하는 뷰포트 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>발주 상세</title>
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
	display: block; /* 여백 제거 */
}

.parent-container {
	display: flex;
	flex-direction: column;
	gap: 15px; /* 항목들 사이 간격을 균일하게 12px 설정 */
}

/* 기본은 스크롤 없음(수평은 table-responsive가 처리), 세로만 제어 */
.product-table-wrap { overflow-y: hidden; }

/* 헤더 고정 */
.product-table thead th {
  position: sticky; top: 0; z-index: 2;
  background: var(--bs-light, #f8f9fa);
}

/* 작은 화면 가로 스크롤 보장 */
.product-table { min-width: 720px; }
@media (max-width: 768px) { .product-table { min-width: 640px; } }

</style>
<script>
(function () {
  function apply7RowScroll() {
    const wrap  = document.getElementById('productTableWrap');
    if (!wrap) return;
    const table = wrap.querySelector('.product-table');
    if (!table) return;

    const thead = table.tHead;
    const tbody = table.tBodies[0];
    if (!tbody) return;

    const rows = Array.from(tbody.rows).filter(r => r.offsetParent !== null);

    // 초기화: 기본은 스크롤 없음
    wrap.style.maxHeight = '';
    wrap.style.overflowY = 'hidden';

    if (rows.length <= 7) return; // 7행 이하면 스크롤 X

    // 7행 높이 + 헤더 높이만큼 컨테이너 고정 → 넘치면 스크롤
    const headH = thead ? thead.getBoundingClientRect().height : 0;
    let bodyH = 0;
    for (let i = 0; i < 7 && i < rows.length; i++) {
      bodyH += rows[i].getBoundingClientRect().height;
    }
    const buffer = 2; // 보더 여유
    wrap.style.maxHeight = Math.ceil(headH + bodyH + buffer) + 'px';
    wrap.style.overflowY = 'auto';
  }

  // 최초/리사이즈 시 반영
  let raf = null;
  function onResize() {
    if (raf) cancelAnimationFrame(raf);
    raf = requestAnimationFrame(apply7RowScroll);
  }
  window.addEventListener('load', apply7RowScroll);
  window.addEventListener('resize', onResize);

  // 동적 행 변경 시 호출할 수 있게 공개
  window.refreshProductTableScroll = apply7RowScroll;
})();
</script>

</head>
<body>
	<div id="layout">
		<!-- 사이드 내비게이션 포함 -->
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>

		<div id="main-area">
			<!-- 헤더 포함 (상단 공통 네비/로고 등) -->
			<jsp:include page="/header.jsp" />

			<!-- 컨텐츠 영역 시작 -->
			<div id="contents">
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>
				<c:if test="${not empty success}">
					<div class="alert alert-success">${success}</div>
				</c:if>
				<!-- <div class="container px-4"> -->
				<!-- 기존영역 주석처리 -->
				<div class="container-fluid px-4">
					<!-- container-fluid 추가 -->
					<!-- <div class="row justify-content-center">
				        <div class="col-lg-8">-->
					<!-- 기존영역 주석처리 -->
					<div class="card shadow-sm">
						<%------------------------------------------------------------------------------
				                		1. Card Header 정중앙
				                 ------------------------------------------------------------------------------%>
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<%------------------------------------------------------------------------------
                						1-1. 목록 버튼 스타일
                 					------------------------------------------------------------------------------%>
							<a href="/sales/list" class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<%------------------------------------------------------------------------------
                						1-2. 타이틀 중앙 정렬 스타일
                 					------------------------------------------------------------------------------%>

							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>발주 상세
							</h4>
							<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body p-4">
							<!-- 수주 / 거래처 정보 (읽기 전용 상세) -->
							<section aria-labelledby="order-info-title" class="info-card"
								aria-label="발주 및 거래처 정보">
								<div id="order-info-title" class="info-card-title">발주 /
									거래처 정보</div>
								<div class="info-grid">
									<!-- 발주 제목: 상단 전체 폭 -->
									<div class="field" style="grid-column: 1/-1;">
										<div class="field-label">발주 제목</div>
										<div class="field-box">
											<span>${empty Purchase_OrderDto.purchase_Title ? '-' : Purchase_OrderDto.purchase_Title}</span>
										</div>
									</div>
									<!-- 수주 번호 -->
									<div class="field">
										<div class="field-label">발주 번호</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.purchase_No}</span>
										</div>
									</div>

									<!-- 거래처 이름 -->
									<div class="field">
										<div class="field-label">거래처 이름</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.clientDto.client_Name}</span>
										</div>
									</div>

									<!-- 거래처 주소 -->
									<div class="field">
										<div class="field-label">주소</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.clientDto.client_Address}</span>
										</div>
									</div>

									<!-- 이메일 (앞에 @ 아이콘 스타일로 보조) -->
									<div class="field">
										<div class="field-label">이메일</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.clientDto.client_Email}</span>
										</div>
									</div>

									<!-- 거래처 전화번호 -->
									<div class="field">
										<div class="field-label">거래처 전화번호</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.clientDto.client_Tel}</span>
										</div>
									</div>


									<!-- 거래처 담당자 -->
									<div class="field">
										<div class="field-label">거래처 담당자</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.clientDto.client_Man}</span>
										</div>
									</div>


									<!-- 내부 담당자 이름 -->
									<div class="field">
										<div class="field-label">담당자 이름</div>
										<div class="field-box">
											<span>${Purchase_OrderDto.empDTO.empName}</span>
										</div>
									</div>
									<!-- 수정 일자: 존재할 때만 보여줌 -->
									<c:if test="${not empty Purchase_OrderDto.complete_Date}">
										<div class="field">
											<div class="field-label">완료 일자</div>
											<div class="field-box">

												<span>${fn:substring(Purchase_OrderDto.complete_Date, 0, 10)}</span>
											</div>
										</div>
									</c:if>
									<!-- 수정 일자: 존재할 때만 보여줌 -->
									<c:if test="${not empty Purchase_OrderDto.modify_Date}">
										<div class="field">
											<div class="field-label">최근 수정 일자</div>
											<div class="field-box">

												<span>${fn:substring(Purchase_OrderDto.modify_Date, 0, 10)}</span>
											</div>
										</div>
									</c:if>

									<!-- 등록 일자: 날짜 포맷 처리 -->
									<div class="field">
										<div class="field-label">등록 일자</div>
										<div class="field-box">
											<span>${fn:substring(Purchase_OrderDto.in_Date, 0, 10)}</span>
										</div>
									</div>
								</div>
							</section>

							<!-- 제품 목록: 수주에 포함된 아이템을 테이블 형식으로 보여줌 -->
							<section aria-labelledby="product-list-title"
								class="info-card mt-4" aria-label="부품 목록">
								<div id="product-list-title" class="info-card-title">부품 목록</div>
							<div id="productTableWrap" class="table-responsive product-table-wrap">
									<table
										class="table table-sm table-bordered align-middle mb-0 product-table">
										<caption class="visually-hidden">발주한 부품 목록과 입고/요청 기준
											금액</caption>
										<thead class="table-light">
											<tr>
												<th scope="col">부품명</th>
												<th scope="col" class="numeric">요청수량</th>
												<th scope="col" class="numeric">입고수량</th>
												<th scope="col" class="numeric">입고대기</th>
												<th scope="col" class="numeric">부품 단가</th>
												<th scope="col" class="numeric">입고 기준 총액</th>
												<th scope="col" class="numeric">요청 기준 총액</th>
											</tr>
										</thead>
										<tbody>
											<!-- sales_Item이 존재하면 반복, 없으면 안내 메시지 -->
											<c:choose>
												<c:when test="${not empty Purchase_OrderDto.purchase_Item}">
													<c:forEach var="item"
														items="${Purchase_OrderDto.purchase_Item}">
														<tr>
															<td class="name text-truncate"
																title="<c:out value='${item.partsDTO != null ? item.partsDTO.parts_name : "-"}'/>"><c:out
																	value="${item.partsDTO != null ? item.partsDTO.parts_name : '-'}" />
															</td>
															<td class="numeric"><c:out
																	value="${item.purchase_Item_Cnt != null ? item.purchase_Item_Cnt : 0}" />
															</td>
															<td class="numeric"><c:out
																	value="${item.purchase_Item_InCnt != null ? item.purchase_Item_InCnt : 0}" />
															</td>
															<td class="numeric"><c:out
																	value="${item.purchase_Item_WaitingCnt != null ? item.purchase_Item_WaitingCnt : 0}" />
															</td>
															<td class="numeric"><fmt:formatNumber
																	value="${item.purchase_Item_Cost != null ? item.purchase_Item_Cost : 0}"
																	type="number" groupingUsed="true" /></td>
															<td class="numeric"><fmt:formatNumber
																	value="${item.purchase_Item_TotInCost != null ? item.purchase_Item_TotInCost : 0}"
																	type="number" groupingUsed="true" /></td>
															<td class="numeric"><fmt:formatNumber
																	value="${item.purchase_Item_TotCost != null ? item.purchase_Item_TotCost : 0}"
																	type="number" groupingUsed="true" /></td>
														</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="7" class="text-center">상품이 없습니다.</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</tbody>
										<tfoot>
											<!-- 합계 행: 수량/금액 총합 -->
											<tr class="total-row">
												<td>합계</td>
												<td class="numeric">${Purchase_OrderDto.totCnt}</td>
												<td class="numeric">${Purchase_OrderDto.totInCnt}</td>
												<td class="numeric">${Purchase_OrderDto.totWaitingCnt}</td>
												<td class="numeric"></td>
												<td class="numeric"><fmt:formatNumber
														value="${Purchase_OrderDto.totInCost}" type="number"
														groupingUsed="true" /></td>
												<td class="numeric"><fmt:formatNumber
														value="${Purchase_OrderDto.totCost}" type="number"
														groupingUsed="true" /></td>
											</tr>
										</tfoot>
									</table>
								</div>
							</section>
							<div class="mt-4">
								<div class="row g-2">
									<c:choose>

										<%-- in_Status == 0 : 승인(3) / 수정(6) / 발주 취소(3) --%>
										<c:when test="${Purchase_OrderDto.in_Status == 0}">
											<!-- 승인 -->
											<div class="col-12 col-md-6 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/modifyStatus"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-primary btn-sm px-4 w-100"
														onclick="return confirm('발주를 승인 하시겠습니까?');">
														<i class="bi bi-check2-circle me-1"></i>승인
													</button>
												</form>
											</div>

											<!-- 수정 -->
											<div class="col-12 col-md-3 d-grid">
												<a
													href="${pageContext.request.contextPath}/purchase/modifyStart?purchase_No=${Purchase_OrderDto.purchase_No}"
													class="btn btn-outline-primary btn-sm px-4 w-100"
													onclick="return confirm('발주를 수정 하시겠습니까?');"> <i
													class="bi bi-pencil-square me-1"></i>수정
												</a>
											</div>

											<!-- 발주 취소 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/delete"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-danger btn-sm px-4 w-100"
														onclick="return confirm('발주를 취소 하시겠습니까?');">
														<i class="bi bi-trash me-1"></i>발주 취소
													</button>
												</form>
											</div>
										</c:when>

										<%-- in_Status == 1 : 완료 / 재발주 요청 / 승인 취소 / 발주 취소 (3-3-3-3) --%>
										<c:when test="${Purchase_OrderDto.in_Status == 1}">
											<!-- 완료 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/modifyStatus"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-primary btn-sm px-4 w-100"
														onclick="return confirm('발주를 완료 하시겠습니까?');">
														<i class="bi bi-check-lg me-1"></i>완료
													</button>
												</form>
											</div>

											<!-- 재발주 요청 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/accessModify"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-outline-primary btn-sm px-4 w-100"
														onclick="return confirm('정말 재발주 요청하시겠습니까? 요청 상태로 변환 후 해당 발주 수정 페이지로 이동합니다.');">
														<i class="bi bi-arrow-repeat me-1"></i>재발주 요청
													</button>
												</form>
											</div>

											<!-- 승인 취소 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/returnStatus"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-secondary btn-sm px-4 w-100"
														onclick="return confirm('정말 승인 상태를 취소 하시겠습니까? 요청 상태로 변환 후 해당 발주 상세 페이지로 이동합니다.');">
														<i class="bi bi-x-circle me-1"></i>승인 취소
													</button>
												</form>
											</div>

											<!-- 발주 취소 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/delete"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-danger btn-sm px-4 w-100"
														onclick="return confirm('발주를 취소 하시겠습니까?');">
														<i class="bi bi-trash me-1"></i>발주 취소
													</button>
												</form>
											</div>
										</c:when>

										<%-- in_Status == 2 : 완료 취소(풀폭) --%>
										<c:when test="${Purchase_OrderDto.in_Status == 2}">
											<div class="col-12 d-grid">
												<form
													action="${pageContext.request.contextPath}/purchase/returnStatus"
													method="post" class="m-0">
													<input type="hidden" name="purchase_No"
														value="${Purchase_OrderDto.purchase_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-secondary btn-sm px-4 w-100"
														onclick="return confirm('정말 완료 상태를 취소 하시겠습니까? 승인 상태로 변환 후 해당 발주 상세 페이지로 이동합니다.');">
														<i class="bi bi-arrow-counterclockwise me-1"></i>완료 취소
													</button>
												</form>
											</div>
										</c:when>

									</c:choose>
								</div>
							</div>

						</div>
					</div>
				</div>
				<!-- .container -->
			</div>
			<!-- #contents -->

			<!-- 부트스트랩 JS (버튼/툴팁 등 동적 UI) -->
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
			<!-- 공통 푸터 포함 -->
			<jsp:include page="/foot.jsp" />
		</div>
		<!-- #main-area -->
	</div>
	<!-- #layout -->
</body>
</html>
