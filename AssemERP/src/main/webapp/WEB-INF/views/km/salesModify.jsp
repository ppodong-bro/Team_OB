<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp">
<link rel="stylesheet" href="<c:url value='/css/list.css'/>" />
	<meta charset="UTF-8">
	<title>Insert title here</title></head>
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
				<div class="container-fluid px-4">

					<!-- 수주 수정 폼 -->
					<form action="${pageContext.request.contextPath}/sales/save"
						method="post" class="needs-validation" novalidate>

						<!-- 수주 / 거래처 정보 -->
						<section aria-labelledby="order-info-title" class="info-card mb-4">
							<div id="order-info-title" class="info-card-title mb-2">수주
								/ 거래처 정보</div>
							<div class="row g-3">

								<!-- 수주 번호 (읽기전용) -->
								<div class="col-md-3">
									<label class="form-label">수주 번호</label> <input type="text"
										readonly class="form-control form-control-sm"
										name="sales_OrderDto.sales_No"
										value="${sales_OrderDto.sales_No}" />
								</div>

								<!-- 거래처 선택 -->
								<div class="col-md-3">
									<label class="form-label">거래처 이름</label>
									<!-- 예: select로 바꾸면 실제 거래처 목록으로 반복할 것 -->
									<input type="text" class="form-control form-control-sm"
										name="sales_OrderDto.clientDto.client_Name"
										value="${sales_OrderDto.clientDto.client_Name}" required />
									<div class="invalid-feedback">거래처 이름을 입력해주세요.</div>
								</div>

								<!-- 거래처 주소 -->
								<div class="col-md-6">
									<label class="form-label">주소</label> <input type="text"
										class="form-control form-control-sm"
										name="sales_OrderDto.clientDto.client_Address"
										value="${sales_OrderDto.clientDto.client_Address}" />
								</div>

								<!-- 이메일 -->
								<div class="col-md-3">
									<label class="form-label">이메일</label>
									<div class="input-group input-group-sm">
										<span class="input-group-text">@</span> <input type="email"
											class="form-control"
											name="sales_OrderDto.clientDto.client_Email"
											value="${sales_OrderDto.clientDto.client_Email}" />
									</div>
								</div>

								<!-- 거래처 담당자 -->
								<div class="col-md-3">
									<label class="form-label">거래처 담당자</label> <input type="text"
										class="form-control form-control-sm"
										name="sales_OrderDto.clientDto.client_Man"
										value="${sales_OrderDto.clientDto.client_Man}" />
								</div>

								<!-- 내부 담당자 -->
								<div class="col-md-3">
									<label class="form-label">담당자 이름</label> <input type="text"
										readonly class="form-control form-control-sm"
										name="sales_OrderDto.empDTO.empName"
										value="${sales_OrderDto.empDTO.empName}" />
								</div>

								<!-- 등록 일자 -->
								<div class="col-md-3">
									<label class="form-label">등록 일자</label> <input type="date"
										class="form-control form-control-sm"
										name="sales_OrderDto.in_Date"
										value="${fn:substring(sales_OrderDto.in_Date,0,10)}" />
								</div>

								<!-- 수정 일자 (있으면 보여줌) -->
								<c:if test="${not empty sales_OrderDto.clientDto.modify_Date}">
									<div class="col-md-3">
										<label class="form-label">수정 일자</label> <input type="text"
											readonly class="form-control form-control-sm"
											value="${formattedModDate}" />
									</div>
								</c:if>

							</div>
						</section>

						<!-- 제품 항목 수정 테이블 -->
						<section aria-labelledby="product-list-title" class="info-card">
							<div id="product-list-title" class="info-card-title mb-2">제품
								목록</div>
							<div class="table-responsive"
								style="max-height: 360px; overflow: auto;">
								<table
									class="table table-sm table-bordered align-middle mb-0 product-table">
									<caption class="visually-hidden">수주한 제품 목록</caption>
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
												<c:forEach var="item" items="${sales_OrderDto.sales_Item}"
													varStatus="status">
													<tr>
														<td class="name"><input type="hidden"
															name="sales_OrderDto.sales_Item[${status.index}].productDto.product_no"
															value="${item.productDto.product_no}" /> <input
															type="text" readonly
															class="form-control form-control-plaintext form-control-sm"
															value="${item.productDto != null ? item.productDto.product_name : '-'}" />
														</td>

														<td class="numeric"><input type="number" min="0"
															class="form-control form-control-sm"
															name="sales_OrderDto.sales_Item[${status.index}].sales_Item_Cnt"
															value="${item.sales_Item_Cnt}" /></td>

														<td class="numeric"><input type="number" min="0"
															class="form-control form-control-sm"
															name="sales_OrderDto.sales_Item[${status.index}].sales_Item_OutCnt"
															value="${item.sales_Item_OutCnt}" /></td>

														<td class="numeric">
															<!-- 출고대기 = 요청 - 출고 (읽기 전용으로 보여주기) --> <input
															type="number" readonly
															class="form-control form-control-sm"
															value="${item.sales_Item_Cnt != null && item.sales_Item_OutCnt != null ? item.sales_Item_Cnt - item.sales_Item_OutCnt : 0}" />
														</td>

														<td class="numeric"><input type="number" step="0.01"
															class="form-control form-control-sm"
															name="sales_OrderDto.sales_Item[${status.index}].sales_Item_Cost"
															value="${item.sales_Item_Cost}" /></td>

														<td class="numeric"><input type="text" readonly
															class="form-control form-control-plaintext form-control-sm"
															value="<fmt:formatNumber value='${item.sales_Item_TotOutCost}' type='number' groupingUsed='true' />" />
														</td>

														<td class="numeric"><input type="text" readonly
															class="form-control form-control-plaintext form-control-sm"
															value="<fmt:formatNumber value='${item.sales_Item_TotCost}' type='number' groupingUsed='true' />" />
														</td>
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
											<td class="numeric"><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm"
												value="${sales_OrderDto.totCnt}" /></td>
											<td class="numeric"><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm"
												value="${sales_OrderDto.totOutCnt}" /></td>
											<td class="numeric"><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm"
												value="${sales_OrderDto.totWaitingCnt}" /></td>
											<td class="numeric"></td>
											<td class="numeric"><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm"
												value="<fmt:formatNumber value='${sales_OrderDto.totOutCost}' type='number' groupingUsed='true' />" />
											</td>
											<td class="numeric"><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm"
												value="<fmt:formatNumber value='${sales_OrderDto.totCost}' type='number' groupingUsed='true' />" />
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</section>

						<!-- 액션 버튼 -->
						<div class="d-flex justify-content-end gap-2 mt-4">
							<a href="${pageContext.request.contextPath}/sales/list"
								class="btn btn-outline-secondary btn-sm px-4">취소</a>
							<button type="submit" class="btn btn-primary btn-sm px-4">저장</button>
						</div>

					</form>

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