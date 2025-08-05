<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css'/>" />
<meta charset="UTF-8">
<title>Insert title here</title>
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
				<div class="container-fluid px-4">
					<form action="${pageContext.request.contextPath}/sales/create"
						method="post" class="needs-validation" novalidate>

						<!-- 수주 / 거래처 기본 정보 -->
						<section class="info-card mb-4">
							<div class="info-card-title mb-2">수주 / 거래처 정보</div>
							<div class="row g-3">

								<!-- 거래처 이름 (직접 입력 또는 추후 select로 바꾸기) -->
								<div class="col-md-4">
									<label class="form-label">거래처 이름<span
										class="text-danger">*</span></label> <input type="text"
										class="form-control form-control-sm"
										name="sales_OrderDto.clientDto.client_Name"
										value="${sales_OrderDto.clientDto.client_Name}" required />
									<div class="invalid-feedback">거래처 이름은 필수입니다.</div>
								</div>

								<!-- 거래처 주소 -->
								<div class="col-md-4">
									<label class="form-label">주소</label> <input type="text"
										class="form-control form-control-sm"
										name="sales_OrderDto.clientDto.client_Address"
										value="${sales_OrderDto.clientDto.client_Address}" />
								</div>

								<!-- 이메일 -->
								<div class="col-md-4">
									<label class="form-label">이메일</label>
									<div class="input-group input-group-sm">
										<span class="input-group-text">@</span> <input type="email"
											class="form-control"
											name="sales_OrderDto.clientDto.client_Email"
											value="${sales_OrderDto.clientDto.client_Email}" />
									</div>
								</div>

								<!-- 거래처 담당자 -->
								<div class="col-md-4">
									<label class="form-label">거래처 담당자</label> <input type="text"
										class="form-control form-control-sm"
										name="sales_OrderDto.clientDto.client_Man"
										value="${sales_OrderDto.clientDto.client_Man}" />
								</div>

								<!-- 내부 담당자 (로그인 사용자로 자동 채우는 게 좋음) -->
								<div class="col-md-4">
									<label class="form-label">담당자 이름</label> <input type="text"
										readonly class="form-control form-control-sm"
										name="sales_OrderDto.empDTO.empName"
										value="${sales_OrderDto.empDTO.empName}" />
								</div>

								<!-- 수주일자 / 등록일자 -->
								<div class="col-md-4">
									<label class="form-label">등록 일자</label> <input type="date"
										class="form-control form-control-sm"
										name="sales_OrderDto.in_Date"
										value="${fn:substring(sales_OrderDto.in_Date,0,10)}" />
								</div>

							</div>
						</section>

						<!-- 제품 항목 추가 -->
						<section class="info-card mb-4">
							<div
								class="info-card-title mb-2 d-flex justify-content-between align-items-center">
								<div>제품 목록</div>
								<button type="button" id="add-item-btn"
									class="btn btn-sm btn-outline-secondary">항목 추가</button>
							</div>

							<div class="table-responsive"
								style="max-height: 360px; overflow: auto;">
								<table
									class="table table-sm table-bordered align-middle mb-0 product-table"
									id="items-table">
									<caption class="visually-hidden">등록할 제품 목록</caption>
									<thead class="table-light">
										<tr>
											<th scope="col">제품</th>
											<th scope="col" class="numeric">요청수량</th>
											<th scope="col" class="numeric">출고수량</th>
											<th scope="col" class="numeric">출고대기</th>
											<th scope="col" class="numeric">제품 단가</th>
											<th scope="col" class="numeric">출고 기준 총액</th>
											<th scope="col" class="numeric">요청 기준 총액</th>
											<th scope="col">삭제</th>
										</tr>
									</thead>
									<tbody>
										<!-- 초기에는 한 줄 비어있게 -->
										<tr class="item-row">
											<td><select
												name="sales_OrderDto.sales_Item[0].productDto.product_no"
												class="form-select form-select-sm" required>
													<option value="">선택</option>
													<c:forEach var="prod" items="${products}">
														<option value="${prod.product_no}">${prod.product_name}</option>
													</c:forEach>
											</select></td>
											<td><input type="number" min="0"
												name="sales_OrderDto.sales_Item[0].sales_Item_Cnt"
												class="form-control form-control-sm qty-input" required /></td>
											<td><input type="number" min="0"
												name="sales_OrderDto.sales_Item[0].sales_Item_OutCnt"
												class="form-control form-control-sm outcnt-input" value="0"
												required /></td>
											<td><input type="number" readonly
												class="form-control form-control-sm waiting-input" value="0" />
											</td>
											<td><input type="number" step="0.01" min="0"
												name="sales_OrderDto.sales_Item[0].sales_Item_Cost"
												class="form-control form-control-sm cost-input" required />
											</td>
											<td><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm tot-outcost" />
											</td>
											<td><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm tot-cost" />
											</td>
											<td class="text-center">
												<button type="button"
													class="btn btn-sm btn-outline-danger remove-item-btn">&times;</button>
											</td>
										</tr>
									</tbody>
									<tfoot>
										<tr class="total-row">
											<td>합계</td>
											<td class="numeric"><span id="sum-req">0</span></td>
											<td class="numeric"><span id="sum-out">0</span></td>
											<td class="numeric"><span id="sum-wait">0</span></td>
											<td></td>
											<td class="numeric"><span id="sum-outcost">0</span></td>
											<td class="numeric"><span id="sum-cost">0</span></td>
											<td></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</section>

						<!-- 액션 -->
						<div class="d-flex justify-content-end gap-2">
							<a href="${pageContext.request.contextPath}/sales/list"
								class="btn btn-outline-secondary btn-sm px-4">취소</a>
							<button type="submit" class="btn btn-primary btn-sm px-4">등록</button>
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