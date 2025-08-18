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
			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty success}">
				<div class="alert alert-success">${success}</div>
			</c:if>
			<div id="contents">

				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<h4 class="card-title mb-0">
								<i class="bi bi-list-ul"></i> 발주 목록
							</h4>
							<a href="/purchase/createStart" class="btn btn-primary"><i
								class="bi bi-plus-lg"></i>등록</a>
						</div>
						<div class="card-body">

							<!-- 검색 폼 -->
							<form method="get" action="list"
								class="row gx-2 gy-1 align-items-end mb-4 justify-content-end">
								<!-- 거래처명 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">거래처명</span> <input type="text"
											name="client_Name" class="form-control" placeholder="거래처명 검색"
											value="${Purchase_OrderSearchDto.client_Name}">
									</div>
								</div>

								<!-- 유형 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">입고상태</span> <select
											name="in_Status" class="form-select">
											<option value="">전체</option>
											<option value="0"
												${Purchase_OrderSearchDto.in_Status == 0 ? 'selected' : ''}>요청</option>
											<option value="1"
												${Purchase_OrderSearchDto.in_Status == 1 ? 'selected' : ''}>승인</option>
											<option value="2"
												${Purchase_OrderSearchDto.in_Status == 2 ? 'selected' : ''}>완료</option>
											<option value="3"
												${Purchase_OrderSearchDto.in_Status == 3 ? 'selected' : ''}>마감</option>
										</select>
									</div>
								</div>

								<!-- 담당자 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">담당자명</span> <input type="text"
											name="empName" class="form-control" placeholder="담당자 검색"
											value="${Purchase_OrderSearchDto.empName}">
									</div>
								</div>

								<!-- 납기완료일 범위 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">납기완료일</span> <input type="date"
											name="purchase_Date_Start" class="form-control"
											placeholder="시작일"
											value="${Purchase_OrderSearchDto.purchase_Date_Start}" /> <span
											class="input-group-text">~</span> <input type="date"
											name="purchase_Date_End" class="form-control"
											placeholder="종료일"
											value="${Purchase_OrderSearchDto.purchase_Date_End}" />
									</div>
								</div>

								<!-- 검색 버튼 -->
								<div class="col-auto">
									<button type="submit" class="btn btn-primary btn-sm">검색</button>
								</div>
							</form>

							<!-- List 테이블 시작 -->
							<div class="table-responsive">
								<table class="table table-bordered align-middle ">
									<thead class="table-light">
										<tr>
											<th style="width: 5%;" class="text-center">#</th>
											<th style="width: 7%;" class="text-center">발주번호</th>
											<th style="width: 10%;" class="text-center">거래처명</th>
											<th style="width: 23%;" class="text-center">부품명</th>
											<th style="width: 6%;" class="text-center">요청수량</th>
											<th style="width: 6%;" class="text-center">입고수량</th>
											<th style="width: 7%;" class="text-center">총액</th>
											<th style="width: 10%;" class="text-center">납기완료일</th>
											<th style="width: 6%;" class="text-center">입고상태</th>
											<th style="width: 8%;" class="text-center">담당자</th>
											<th style="width: 10%;" class="text-center">등록일</th>
											<th style="width: 8%;" class="text-center">수정</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${listPurchase}" varStatus="st">
											<tr style="cursor: pointer;"
												onclick="location.href='<c:url value='/purchase/detail?purchase_No=${order.purchase_No}'/>'">
												<!-- 순번 -->
												<td class="text-center">${st.index + 1}</td>

												<!-- 발주번호 (detail 링크) -->
												<td class="text-center">${order.purchase_No}</td>

												<!-- client → clientName -->
												<td>${order.clientDto.client_Name}</td>

												<c:choose>
													<c:when test="${not empty order.purchase_Item}">
														<c:set var="first" value="${order.purchase_Item[0]}" />
														<c:set var="othersCount"
															value="${fn:length(order.purchase_Item) - 1}" />

														<!-- 부품명 -->
														<td><c:out value="${first.partsDTO.parts_name}" /> <c:if
																test="${othersCount > 0}">
													 &nbsp;외 ${othersCount}종
													</c:if></td>

														<!-- 요청수량 (총합) -->
														<td class="text-center"><c:out
																value="${order.totCnt}" /></td>

														<!-- 입고수량 (총합) -->
														<td class="text-center"><c:out
																value="${order.totInCnt}" /></td>
													</c:when>
													<c:otherwise>
														<td>-</td>
														<td class="text-center">0</td>
														<td class="text-center">0</td>
													</c:otherwise>
												</c:choose>

												<!-- 총액 -->
												<td class="text-end"><fmt:formatNumber
														value="${order.totCost}" type="number" groupingUsed="true" />
												</td>

												<!-- 납기 완료일 -->
												<td class="text-center">${order.purchase_Date}</td>

												<!-- 입고 상태 -->
												<td class="text-center"><span class="status-text"
													data-status="${order.in_Status}"> <span class="dot"></span>
														<c:choose>
															<c:when test="${order.in_Status == 0}">요청</c:when>
															<c:when test="${order.in_Status == 1}">승인</c:when>
															<c:when test="${order.in_Status == 2}">완료</c:when>
															<c:when test="${order.in_Status == 3}">마감</c:when>
														</c:choose>
												</span></td>

												<!-- client → clientMan -->
												<td class="text-center">${order.empDTO.empName}</td>

												<td class="text-center">${fn:substring(order.in_Date, 0, 10)}</td>


												<!-- 수정/삭제 버튼 -->
												<c:choose>
													<c:when
														test="${order.in_Status == 0 or order.in_Status == 1}">
														<td class="text-center">
															<!-- 수정 버튼 --> <a
															href="/purchase/modifyStart?purchase_No=${order.purchase_No}"
															class="btn btn-sm btn-outline-success"> <i
																class="bi bi-pencil-square"></i> 수정
														</a>
														</td>
													</c:when>
												</c:choose>
												<c:choose>
													<c:when
														test="${order.in_Status == 2 or order.in_Status == 3}">
														<td class="text-center"><a href="#"
															class="btn btn-sm btn-outline-success disabled keep-look"
															role="button" aria-disabled="true" tabindex="-1"> <i
																class="bi bi-pencil-square"></i> 수정
														</a></td>
													</c:when>
												</c:choose>
											</tr>
										</c:forEach>

										<!-- 조회 결과 없을 때 -->
										<c:if test="${empty listPurchase}">
											<tr>
												<td colspan="10" class="text-center">조회된 데이터가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>


								<!-- 검색 조건을 포함한 기본 URL 구성 -->
								<c:url var="pageUrl" value="/purchase/list">
									<c:param name="client_Name"
										value="${Purchase_OrderSearchDto.client_Name}" />
									<c:param name="in_Status"
										value="${Purchase_OrderSearchDto.in_Status}" />
									<c:param name="empName" value="${Sales_OrderSearchDto.empName}" />
									<c:param name="purchase_Date_Start"
										value="${Purchase_OrderSearchDto.purchase_Date_Start}" />
									<c:param name="purchase_Date_End"
										value="${Purchase_OrderSearchDto.purchase_Date_End}" />
								</c:url>
								<!-- 페이징 -->
								<!-- 페이징 -->
								<div class="card-footer d-flex justify-content-center">
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center mb-0">

											<!-- ◀◀ 처음 / ◀ 이전 -->
											<c:choose>
												<c:when test="${paging.currentPage > 1}">
													<li class="page-item"><a class="page-link"
														href="${pageUrl}&currentPage=1" aria-label="First"> <i
															class="bi bi-chevron-double-left"></i>
													</a></li>
													<li class="page-item"><a class="page-link"
														href="${pageUrl}&currentPage=${paging.currentPage - 1}"
														aria-label="Previous"> <i class="bi bi-chevron-left"></i>
													</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item disabled"><a class="page-link"><i
															class="bi bi-chevron-double-left"></i></a></li>
													<li class="page-item disabled"><a class="page-link"><i
															class="bi bi-chevron-left"></i></a></li>
												</c:otherwise>
											</c:choose>

											<!-- 페이지 번호 -->
											<c:forEach begin="${paging.startPage}"
												end="${paging.endPage}" var="page">
												<li
													class="page-item ${paging.currentPage == page ? 'active' : ''}">
													<a class="page-link" href="${pageUrl}&currentPage=${page}">${page}</a>
												</li>
											</c:forEach>

											<!-- ▶ 다음 / ▶▶ 마지막 -->
											<c:choose>
												<c:when test="${paging.currentPage < paging.totalPage}">
													<li class="page-item"><a class="page-link"
														href="${pageUrl}&currentPage=${paging.currentPage + 1}"
														aria-label="Next"> <i class="bi bi-chevron-right"></i>
													</a></li>
													<li class="page-item"><a class="page-link"
														href="${pageUrl}&currentPage=${paging.totalPage}"
														aria-label="Last"> <i
															class="bi bi-chevron-double-right"></i>
													</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item disabled"><a class="page-link"><i
															class="bi bi-chevron-right"></i></a></li>
													<li class="page-item disabled"><a class="page-link"><i
															class="bi bi-chevron-double-right"></i></a></li>
												</c:otherwise>
											</c:choose>

										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 이곳에 자신의 코드를 작성하세요 -->
			<!-- 부트스트랩 CDN -->
			<jsp:include page="/common_cdn.jsp" />
			<jsp:include page="/foot.jsp" />
		</div>
	</div>
	<script src="…bootstrap.js"></script>
</body>
</html>

