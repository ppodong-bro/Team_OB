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
<title>수주 상세</title>
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
</style>
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
			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty success}">
				<div class="alert alert-success">${success}</div>
			</c:if>
			<c:if test="${not empty fail}">
				<div class="alert alert-danger">${fail}</div>
			</c:if>
			<div id="contents">
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
								<i class="bi bi-pencil-square me-2"></i>수주 상세
							</h4>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body p-4">
							<!-- 수주 / 거래처 정보 (읽기 전용 상세) -->
							<section aria-labelledby="order-info-title" class="info-card"
								aria-label="수주 및 거래처 정보">
								<div id="order-info-title" class="info-card-title">수주 /
									거래처 정보</div>
								<div class="info-grid">
									<!-- 발주 제목: 상단 전체 폭 -->
									<div class="field" style="grid-column: 1/-1;">
										<div class="field-label">수주 제목</div>
										<div class="field-box">
											<span>${empty sales_OrderDto.sales_Title ? '-' : sales_OrderDto.sales_Title}</span>
										</div>
									</div>
									<!-- 수주 번호 -->
									<div class="field">
										<div class="field-label">수주 번호</div>
										<div class="field-box">
											<span>${sales_OrderDto.sales_No}</span>
										</div>
									</div>

									<!-- 거래처 이름 -->
									<div class="field">
										<div class="field-label">거래처 이름</div>
										<div class="field-box">
											<span>${sales_OrderDto.clientDto.client_Name}</span>
										</div>
									</div>

									<!-- 거래처 주소 -->
									<div class="field">
										<div class="field-label">주소</div>
										<div class="field-box">
											<span>${sales_OrderDto.clientDto.client_Address}</span>
										</div>
									</div>

									<!-- 이메일 (앞에 @ 아이콘 스타일로 보조) -->
									<div class="field">
										<div class="field-label">이메일</div>
										<div class="field-box">
											<span>${sales_OrderDto.clientDto.client_Email}</span>
										</div>
									</div>

									<!-- 거래처 전화번호 -->
									<div class="field">
										<div class="field-label">거래처 전화번호</div>
										<div class="field-box">
											<span>${sales_OrderDto.clientDto.client_Tel}</span>
										</div>
									</div>


									<!-- 거래처 담당자 -->
									<div class="field">
										<div class="field-label">거래처 담당자</div>
										<div class="field-box">
											<span>${sales_OrderDto.clientDto.client_Man}</span>
										</div>
									</div>


									<!-- 내부 담당자 이름 -->
									<div class="field">
										<div class="field-label">담당자 이름</div>
										<div class="field-box">
											<span>${sales_OrderDto.empDTO.empName}</span>
										</div>
									</div>

									<!-- 수정 일자: 존재할 때만 보여줌 -->
									<c:if test="${not empty sales_OrderDto.complete_Date}">
										<div class="field">
											<div class="field-label">완료 일자</div>
											<div class="field-box">

												<span>${fn:substring(sales_OrderDto.complete_Date, 0, 10)}</span>
											</div>
										</div>
									</c:if>
									<!-- 수정 일자: 존재할 때만 보여줌 -->
									<c:if test="${not empty sales_OrderDto.modify_Date}">
										<div class="field">
											<div class="field-label">최근 수정 일자</div>
											<div class="field-box">

												<span>${fn:substring(sales_OrderDto.modify_Date, 0, 10)}</span>
											</div>
										</div>
									</c:if>

									<!-- 등록 일자: 날짜 포맷 처리 -->
									<div class="field">
										<div class="field-label">등록 일자</div>
										<div class="field-box">

											<span>${fn:substring(sales_OrderDto.in_Date, 0, 10)}</span>
										</div>
									</div>


								</div>
							</section>

							<!-- 제품 목록: 수주에 포함된 아이템을 테이블 형식으로 보여줌 -->
							<section aria-labelledby="product-list-title"
								class="info-card mt-4" aria-label="제품 목록">
								<div id="product-list-title" class="info-card-title">제품 목록</div>
								<div class="table-responsive"
									style="max-height: 360px; overflow: auto;">
									<table
										class="table table-sm table-bordered align-middle mb-0 product-table">
										<caption class="visually-hidden">수주한 제품 목록과 출고/요청 기준
											금액</caption>
										<thead class="table-light">
											<tr>
												<th scope="col">제품명</th>
												<th scope="col" class="numeric">요청수량</th>
												<th scope="col" class="numeric">출고수량</th>
												<th scope="col" class="numeric">출고대기</th>
												<th scope="col" class="numeric">제품 단가</th>
												<th scope="col" class="numeric">출고 기준 총액</th>
												<th scope="col" class="numeric">요청 기준 총액</th>
											</tr>
										</thead>
										<tbody>
											<!-- sales_Item이 존재하면 반복, 없으면 안내 메시지 -->
											<c:choose>
												<c:when test="${not empty sales_OrderDto.sales_Item}">
													<c:forEach var="item" items="${sales_OrderDto.sales_Item}">
														<tr>
															<td class="name text-truncate"
																title="<c:out value='${item.productDto != null ? item.productDto.product_name : "-"}'/>"><c:out
																	value="${item.productDto != null ? item.productDto.product_name : '-'}" />
															</td>
															<td class="numeric"><c:out
																	value="${item.sales_Item_Cnt != null ? item.sales_Item_Cnt : 0}" />
															</td>
															<td class="numeric"><c:out
																	value="${item.sales_Item_OutCnt != null ? item.sales_Item_OutCnt : 0}" />
															</td>
															<td class="numeric"><c:out
																	value="${item.sales_Item_WaitingCnt != null ? item.sales_Item_WaitingCnt : 0}" />
															</td>
															<td class="numeric"><fmt:formatNumber
																	value="${item.sales_Item_Cost != null ? item.sales_Item_Cost : 0}"
																	type="number" groupingUsed="true" /></td>
															<td class="numeric"><fmt:formatNumber
																	value="${item.sales_Item_TotOutCost != null ? item.sales_Item_TotOutCost : 0}"
																	type="number" groupingUsed="true" /></td>
															<td class="numeric"><fmt:formatNumber
																	value="${item.sales_Item_TotCost != null ? item.sales_Item_TotCost : 0}"
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
												<td class="numeric">${sales_OrderDto.totCnt}</td>
												<td class="numeric">${sales_OrderDto.totOutCnt}</td>
												<td class="numeric">${sales_OrderDto.totWaitingCnt}</td>
												<td class="numeric"></td>
												<td class="numeric"><fmt:formatNumber
														value="${sales_OrderDto.totOutCost}" type="number"
														groupingUsed="true" /></td>
												<td class="numeric"><fmt:formatNumber
														value="${sales_OrderDto.totCost}" type="number"
														groupingUsed="true" /></td>
											</tr>
										</tfoot>
									</table>
								</div>
							</section>

							<%-- 	<div class="mt-4 d-flex justify-content-end flex-wrap gap-2">

								<c:choose>
								
									<c:when test="${sales_OrderDto.out_Status == 0}">
										
										<form
											action="${pageContext.request.contextPath}/sales/modifyStatus"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-success btn-sm px-4"
												onclick="return confirm('수주를 승인 하시겠습니까?');">
												<i class="bi bi-check2-circle me-1"></i>승인
											</button>
										</form>

									
										<a
											href="${pageContext.request.contextPath}/sales/detailPageModifyStart?sales_No=${sales_OrderDto.sales_No}"
											class="btn btn-outline-primary btn-sm px-4"
											onclick="return confirm('수주를 수정 하시겠습니까?');"> <i
											class="bi bi-pencil-square me-1"></i>수정
										</a>

									
										<form action="${pageContext.request.contextPath}/sales/delete"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-danger btn-sm px-4"
												onclick="return confirm('수주 취소 하시겠습니까?');">
												<i class="bi bi-trash me-1"></i>수주 취소
											</button>
										</form>
									</c:when>

								
									<c:when test="${sales_OrderDto.out_Status == 1}">
									
										<form
											action="${pageContext.request.contextPath}/sales/modifyStatus"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-primary btn-sm px-4"
												onclick="return confirm('수주를 완료 하시겠습니까?');">
												<i class="bi bi-check-lg me-1"></i>완료
											</button>
										</form>

								
										<form
											action="${pageContext.request.contextPath}/sales/accessModify"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" /> <input type="hidden"
												name="out_Status" value="${sales_OrderDto.out_Status}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-warning btn-sm px-4"
												onclick="return confirm('정말 재수주 요청하시겠습니까? 요청 상태로 변경 후 해당 수주 수정 창으로 이동합니다.');">
												<i class="bi bi-arrow-repeat me-1"></i>재수주 요청
											</button>
										</form>

								
										<form
											action="${pageContext.request.contextPath}/sales/returnStatus"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-secondary btn-sm px-4"
												onclick="return confirm('정말 승인 상태를 취소 하시겠습니까? 요청 상태로 변환 후 해당 수주 상세 페이지로 이동합니다.');">
												<i class="bi bi-x-circle me-1"></i>승인 취소
											</button>
										</form>

										<!-- 수주 취소(POST) -->
										<form action="${pageContext.request.contextPath}/sales/delete"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-danger btn-sm px-4"
												onclick="return confirm('수주 취소 하시겠습니까?');">
												<i class="bi bi-trash me-1"></i>수주 취소
											</button>
										</form>
									</c:when>

								
									<c:when test="${sales_OrderDto.out_Status == 2}">
										<form
											action="${pageContext.request.contextPath}/sales/returnStatus"
											method="post" class="m-0 d-inline-block">
											<input type="hidden" name="sales_No"
												value="${sales_OrderDto.sales_No}" />
											<c:if test="${not empty _csrf}">
												<input type="hidden" name="${_csrf.parameterName}"
													value="${_csrf.token}" />
											</c:if>
											<button type="submit" class="btn btn-primary btn-sm px-4"
												onclick="return confirm('정말 완료 상태를 취소 하시겠습니까? 승인 상태로 변환 후 해당 수주 상세 페이지로 이동합니다.');">
												<i class="bi bi-arrow-counterclockwise me-1"></i>완료 취소
											</button>
										</form>
									</c:when>
								</c:choose>

							</div> --%>
							<!-- 액션 바: 전체 폭 꽉 차게 + 반응형 비율 -->
							<div class="mt-4">
								<div class="row g-2">
									<c:choose>

										<%-- out_Status == 0 : 승인(3) / 수정(6) / 수주 취소(3) --%>
										<c:when test="${sales_OrderDto.out_Status == 0}">
											<!-- 승인 -->
											<div class="col-12 col-md-6 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/modifyStatus"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-primary btn-sm px-4 w-100"
														onclick="return confirm('수주를 승인 하시겠습니까?');">
														<i class="bi bi-check2-circle me-1"></i>승인
													</button>
												</form>
											</div>

											<!-- 수정 -->
											<div class="col-12 col-md-3 d-grid">
												<a
													href="${pageContext.request.contextPath}/sales/detailPageModifyStart?sales_No=${sales_OrderDto.sales_No}"
													class="btn btn-outline-primary btn-sm px-4 w-100"
													onclick="return confirm('수주를 수정 하시겠습니까?');"> <i
													class="bi bi-pencil-square me-1"></i>수정
												</a>
											</div>

											<!-- 수주 취소 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/delete"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-danger btn-sm px-4 w-100"
														onclick="return confirm('수주를 취소 하시겠습니까?');">
														<i class="bi bi-trash me-1"></i>수주 취소
													</button>
												</form>
											</div>
										</c:when>

										<%-- out_Status == 1 : 완료 / 재수주 요청 / 승인 취소 / 수주 취소 (균등 3-3-3-3) --%>
										<c:when test="${sales_OrderDto.out_Status == 1}">
											<!-- 완료 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/modifyStatus"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-primary btn-sm px-4 w-100"
														onclick="return confirm('수주를 완료 하시겠습니까?');">
														<i class="bi bi-check-lg me-1"></i>완료
													</button>
												</form>
											</div>

											<!-- 재수주 요청 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/accessModify"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" /> <input
														type="hidden" name="out_Status"
														value="${sales_OrderDto.out_Status}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-outline-primary btn-sm px-4 w-100"
														onclick="return confirm('정말 재수주 요청하시겠습니까? 요청 상태로 변경 후 해당 수주 수정 페이지로 이동합니다.');">
														<i class="bi bi-arrow-repeat me-1"></i>재수주 요청
													</button>
												</form>
											</div>

											<!-- 승인 취소 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/returnStatus"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-secondary btn-sm px-4 w-100"
														onclick="return confirm('정말 승인 상태를 취소 하시겠습니까? 요청 상태로 변환 후 해당 수주 상세 페이지로 이동합니다.');">
														<i class="bi bi-x-circle me-1"></i>승인 취소
													</button>
												</form>
											</div>

											<!-- 수주 취소 -->
											<div class="col-12 col-md-3 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/delete"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-danger btn-sm px-4 w-100"
														onclick="return confirm('수주를 취소 하시겠습니까?');">
														<i class="bi bi-trash me-1"></i>수주 취소
													</button>
												</form>
											</div>
										</c:when>

										<%-- out_Status == 2 : 완료 취소(풀폭) --%>
										<c:when test="${sales_OrderDto.out_Status == 2}">
											<div class="col-12 d-grid">
												<form
													action="${pageContext.request.contextPath}/sales/returnStatus"
													method="post" class="m-0">
													<input type="hidden" name="sales_No"
														value="${sales_OrderDto.sales_No}" />
													<c:if test="${not empty _csrf}">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
													</c:if>
													<button type="submit"
														class="btn btn-secondary btn-sm px-4 w-100"
														onclick="return confirm('정말 완료 상태를 취소 하시겠습니까? 승인 상태로 변환 후 해당 수주 상세 페이지로 이동합니다.');">
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
