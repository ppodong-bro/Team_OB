<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>거래처 상세</title>
<style>
.product-table {
	width: 100%;
	border-collapse: collapse;
	table-layout: auto; /* 자동으로 컨텐츠에 맞게 너비 조정 */
}

.product-table thead th {
	position: sticky;
	top: 0;
	background: #f8f9fa;
	z-index: 2;
	vertical-align: bottom;
	padding: 0.6rem;
}

.product-table tbody td, .product-table tfoot td {
	padding: 0.5rem 0.6rem;
	vertical-align: middle;
}

.numeric {
	text-align: right;
	white-space: nowrap;
}

.name {
	white-space: nowrap;
}

.total-row {
	font-weight: 600;
	background-color: #e9ecef;
}

.info-card {
	background: #fff;
	border: 1px solid #d8e0ea;
	border-radius: 0.75rem;
	padding: 1rem 1.25rem;
	margin-bottom: 1.5rem;
	max-width: 100%;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
}

.info-card-title {
	font-weight: 700;
	font-size: 1.1rem;
	margin-bottom: .75rem;
	letter-spacing: .5px;
}

.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 1rem 1.25rem;
}

.field {
	display: flex;
	flex-direction: column;
}

.field-label {
	font-size: .65rem;
	font-weight: 600;
	text-transform: uppercase;
	margin-bottom: .25rem;
	color: #515a6b;
	letter-spacing: .5px;
}

.field-box {
	background: #f7f9fc;
	border: 1px solid #dfe4ea;
	border-radius: .5rem;
	padding: 0.4rem .75rem;
	display: flex;
	align-items: center;
	gap: .5rem;
}

.field-box input {
	border: none;
	background: transparent;
	padding: 0;
	margin: 0;
	font-size: .95rem;
	width: 100%;
	outline: none;
}

.small-addon {
	flex: 0 0 auto;
	font-size: .9rem;
	color: #495057;
	padding-right: 4px;
}
</style>
</head>
<body>
	<div id="layout">
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>
		<div id="main-area">
			<jsp:include page="/header.jsp" />
			<!-- 이곳에 자신의 코드를 작성하세요 -->
			<div id="contents">
				<div class="container px-3 py-4">
					<!-- info-card (중복된 아래 row 부분 제거된 상태) -->
					<div class="info-card">
						<div class="info-card-title">수주 / 거래처 정보</div>
						<div class="info-grid">
							<div class="field">
								<label class="field-label" for="salesNo">수주 번호</label>
								<div class="field-box">
									<input id="salesNo" type="text" readonly
										value="${sales_OrderDto.sales_No}" />
								</div>
							</div>
							<div class="field">
								<label class="field-label" for="clientName">거래처 이름</label>
								<div class="field-box">
									<input id="clientName" type="text" readonly
										value="${sales_OrderDto.clientDto.client_Name}" />
								</div>
							</div>
							<div class="field">
								<label class="field-label" for="clientAddress">주소</label>
								<div class="field-box">
									<input id="clientAddress" type="text" readonly
										value="${sales_OrderDto.clientDto.client_Address}" />
								</div>
							</div>
							<div class="field">
								<label class="field-label" for="clientEmail">이메일</label>
								<div class="field-box">
									<span class="small-addon">@</span> <input id="clientEmail"
										type="email" readonly
										value="${sales_OrderDto.clientDto.client_Email}" />
								</div>
							</div>
							<div class="field">
								<label class="field-label" for="clientMan">거래처 담당자</label>
								<div class="field-box">
									<input id="clientMan" type="text" readonly
										value="${sales_OrderDto.clientDto.client_Man}" />
								</div>
							</div>
							<div class="field">
								<label class="field-label" for="empName">담당자 이름</label>
								<div class="field-box">
									<input id="empName" type="text" readonly
										value="${sales_OrderDto.empDTO.empName}" />
								</div>
							</div>
							<div class="field">
								<label class="field-label" for="inDate">등록 일자</label>
								<div class="field-box">
									<input id="inDate" type="text" readonly
										value="${fn:substring(sales_OrderDto.in_Date, 0, 10)}" />
								</div>
							</div>
							<c:if test="${not empty sales_OrderDto.clientDto.modify_Date}">
								<div class="field">
									<label class="field-label" for="modDate">수정 일자</label>
									<div class="field-box">
										<input id="modDate" type="text" readonly
											value="${fn:substring(sales_OrderDto.clientDto.modify_Date, 0, 10)}" />
									</div>

								</div>
							</c:if>
						</div>
					</div>
					<!-- 여기 아래에 기존 제품 목록 테이블이 온다 -->

					<!-- 제품 목록 -->
					<!-- 제품 목록 카드 -->
					<div class="info-card">
						<div class="info-card-title">제품 목록</div>
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
					</div>

					<!-- 버튼 그룹: 목록, 수정 -->
					<div class="text-end mt-4 d-flex justify-content-end gap-2">
						<a href="${pageContext.request.contextPath}/client/list"
							class="btn btn-outline-secondary btn-sm px-4">목록</a> <a
							href="${pageContext.request.contextPath}/client/modifyStart?client_No=${clientDto.client_No}"
							class="btn btn-outline-primary btn-sm px-4">수정</a>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<jsp:include page="/foot.jsp" />
	</div>
	</div>
</body>
</html>
 --%>
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
<meta charset="UTF-8">
<!-- 반응형 대응: 모바일 등에서 제대로 보이게 하는 뷰포트 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>거래처 상세</title>

<!-- 이 페이지 전용 스타일: 카드형 상세, 테이블 정렬, 숫자 정리 등 -->
<style>
/* 제품 목록 테이블 기본 설정 */
.product-table {
	width: 100%;
	border-collapse: collapse;
	table-layout: auto;
}

/* 헤더 고정, 배경, 패딩 */
.product-table thead th {
	position: sticky;
	top: 0;
	background: #f8f9fa;
	z-index: 2;
	vertical-align: bottom;
	padding: 0.6rem;
}

/* 본문/풋터 셀 패딩 정리 */
.product-table tbody td, .product-table tfoot td {
	padding: 0.5rem 0.6rem;
	vertical-align: middle;
}

/* 숫자 정렬 스타일 */
.numeric {
	text-align: right;
	white-space: nowrap;
}

/* 이름 등 줄바꿈 막기 */
.name {
	white-space: nowrap;
}

/* 합계 행 강조 */
.total-row {
	font-weight: 600;
	background-color: #e9ecef;
}

/* 카드 스타일 (정보 블록 감싸는 용도) */
.info-card {
	background: #fff;
	border: 1px solid #d8e0ea;
	border-radius: 0.75rem;
	padding: 1rem 1.25rem;
	margin-bottom: 1.5rem;
	max-width: 100%;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
}

/* 카드 제목 스타일 */
.info-card-title {
	font-weight: 700;
	font-size: 1.1rem;
	margin-bottom: .75rem;
	letter-spacing: .5px;
}

/* 2열 그리드 배치 (필드들) */
.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 1rem 1.25rem;
}

/* 각 필드(레이블+값) 컨테이너 */
.field {
	display: flex;
	flex-direction: column;
}

/* 필드 레이블 스타일 */
.field-label {
	font-size: .65rem;
	font-weight: 600;
	text-transform: uppercase;
	margin-bottom: .25rem;
	color: #515a6b;
	letter-spacing: .5px;
}

/* 값 영역 박스 */
.field-box {
	background: #f7f9fc;
	border: 1px solid #dfe4ea;
	border-radius: .5rem;
	padding: 0.4rem .75rem;
	display: flex;
	align-items: center;
	gap: .5rem;
	min-height: 32px;
}

/* 이메일 앞부분 등 보조 텍스트 */
.small-addon {
	flex: 0 0 auto;
	font-size: .9rem;
	color: #495057;
	padding-right: 4px;
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
