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
<title>거래처 상세</title>
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
				<div class="container px-3 py-4">

					<!-- 수주 / 거래처 정보 (읽기 전용 상세) -->
					<section aria-labelledby="order-info-title" class="info-card"
						aria-label="수주 및 거래처 정보">
						<div id="order-info-title" class="info-card-title">수주 / 거래처
							정보</div>
						<div class="info-grid">
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
									<span class="small-addon">@</span> <span>${sales_OrderDto.clientDto.client_Email}</span>
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

							<!-- 등록 일자: 날짜 포맷 처리 -->
							<div class="field">
								<div class="field-label">등록 일자</div>
								<div class="field-box">
									<span>${fn:substring(sales_OrderDto.in_Date, 0, 10)}</span>
								</div>
							</div>

							<!-- 수정 일자: 존재할 때만 보여줌 -->
							<c:if test="${not empty sales_OrderDto.clientDto.modify_Date}">
								<div class="field">
									<div class="field-label">수정 일자</div>
									<div class="field-box">
									
										<span>${formattedModDate}</span>
									</div>
								</div>
							</c:if>
						</div>
					</section>

					<!-- 제품 목록: 수주에 포함된 아이템을 테이블 형식으로 보여줌 -->
					<section aria-labelledby="product-list-title" class="info-card"
						aria-label="제품 목록">
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
													<td class="name"><c:out
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

					<!-- 하단 액션 버튼: 목록으로 돌아가기 / 수주 수정 -->
					<div class="text-end mt-4 d-flex justify-content-end gap-2">
						<!-- 수주 목록 페이지로 복귀 -->
						<a href="${pageContext.request.contextPath}/sales/list"
							class="btn btn-outline-secondary btn-sm px-4">목록</a>

						<!-- 이 수주를 수정하는 화면으로 이동 -->
						<a
							href="${pageContext.request.contextPath}/sales/modifyStart?sales_No=${sales_OrderDto.sales_No}"
							class="btn btn-outline-primary btn-sm px-4">수정</a>
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
