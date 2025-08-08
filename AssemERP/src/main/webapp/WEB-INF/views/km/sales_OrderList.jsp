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
				    <div class="card shadow-sm">
				        <div class="card-header d-flex justify-content-between align-items-center">
				            <h4 class="card-title mb-0"><i class="bi bi-list-ul"></i> 수주 목록</h4>
            					<a href="/sales/createStart" class="btn btn-primary"><i class="bi bi-plus-lg"></i>등록</a>
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
											value="${Sales_OrderSearchDto.client_Name}">
									</div>
								</div>

								<!-- 유형 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">출고상태</span> <select
											name="out_Status" class="form-select">
											<option value="">전체</option>
											<option value="0"
												${Sales_OrderSearchDto.out_Status == 0 ? 'selected' : ''}>요청</option>
											<option value="1"
												${Sales_OrderSearchDto.out_Status == 1 ? 'selected' : ''}>승인</option>
											<option value="2"
												${Sales_OrderSearchDto.out_Status == 2 ? 'selected' : ''}>완료</option>
											<option value="3"
												${Sales_OrderSearchDto.out_Status == 3 ? 'selected' : ''}>마감</option>
										</select>
									</div>
								</div>

								<!-- 담당자 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">담당자명</span> <input type="text"
											name="empName" class="form-control" placeholder="담당자 검색"
											value="${Sales_OrderSearchDto.empName}">
									</div>
								</div>

								<!-- 납기완료일 범위 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">납기완료일</span> <input type="date"
											name="sales_Date_Start" class="form-control"
											placeholder="시작일"
											value="${Sales_OrderSearchDto.sales_Date_Start}" /> <span
											class="input-group-text">~</span> <input type="date"
											name="sales_Date_End" class="form-control" placeholder="종료일"
											value="${Sales_OrderSearchDto.sales_Date_End}" />
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
											<th class="text-center">#</th>
											<th class="text-center">수주번호</th>
											<th class="text-center">거래처명</th>
											<th class="text-center">제품명</th>
											<th class="text-center">요청수량</th>
											<th class="text-center">출고수량</th>
											<th class="text-center">총액</th>
											<th class="text-center">납기완료일</th>
											<th class="text-center">출고상태</th>
											<th class="text-center">담당자</th>
											<th class="text-center">수정/삭제</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="order" items="${listSales}" varStatus="st">
											<tr style="cursor: pointer;"
												onclick="location.href='<c:url value='/sales/detail?sales_No=${order.sales_No}'/>'">
												<!-- 순번 -->
												<td class="text-center">${st.index + 1}</td>

												<!-- 수주번호 (detail 링크) -->
												<td class="text-center">${order.sales_No}</td>

												<!-- client → clientName -->
												<td>${order.clientDto.client_Name}</td>


												<%-- 		<!-- salesItems 컬렉션 출력 -->
										<td><c:forEach var="item" items="${order.sales_Item}"
												varStatus="ist">
												<!-- 예: 상품번호(수량) 형태로 표시 -->
												${ist.index + 1}. ${item.productDto.product_name}
										        (요청수량: ${item.sales_Item_Cnt},
										         출고수량: ${item.sales_Item_OutCnt})<br />
											</c:forEach></td> --%>


												<c:choose>
													<c:when test="${not empty order.sales_Item}">
														<c:set var="first" value="${order.sales_Item[0]}" />
														<c:set var="othersCount"
															value="${fn:length(order.sales_Item) - 1}" />

														<!-- 제품명 -->
														<td><c:out value="${first.productDto.product_name}" />
															<c:if test="${othersCount > 0}">
													 &nbsp;외 ${othersCount}종
													</c:if></td>

														<!-- 요청수량 (총합) -->
														<td class="text-center"><c:out
																value="${order.totCnt}" /></td>

														<!-- 출고수량 (총합) -->
														<td class="text-center"><c:out
																value="${order.totOutCnt}" /></td>
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
												<td>${order.sales_Date}</td>

												<!-- 출고 상태 -->
												<td class="text-center"><span class="status-text"
													data-status="${order.out_Status}"> <span class="dot"></span>
														<c:choose>
															<c:when test="${order.out_Status == 0}">요청</c:when>
															<c:when test="${order.out_Status == 1}">승인</c:when>
															<c:when test="${order.out_Status == 2}">완료</c:when>
															<c:when test="${order.out_Status == 3}">마감</c:when>
														</c:choose>
												</span></td>

												<!-- client → clientMan -->
												<td class="text-center">${order.empDTO.empName}</td>


												<!-- 수정/삭제 버튼 -->
												<td class="text-center">
													<!-- 수정 버튼 --> <a
													href="<c:url value='/sales/modifyStart?sales_No=${order.sales_No}'/>"
													class="btn btn-sm btn-outline-primary me-1"
													onclick="event.stopPropagation();">수정</a> <!-- 삭제 버튼 -->
													<form
														action="${pageContext.request.contextPath}/sales/delete"
														method="post" style="display: inline;"
														onclick="event.stopPropagation();">
														<input type="hidden" name="sales_No"
															value="${order.sales_No}" />
														<button type="submit"
															class="btn btn-sm btn-outline-danger">삭제</button>
													</form>
												</td>
											</tr>
										</c:forEach>

										<!-- 조회 결과 없을 때 -->
										<c:if test="${empty listSales}">
											<tr>
												<td colspan="10" class="text-center">조회된 데이터가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>


								<!-- 검색 조건을 포함한 기본 URL 구성 -->
								<c:url var="pageUrl" value="/sales/list">
									<c:param name="client_Name"
										value="${Sales_OrderSearchDto.client_Name}" />
									<c:param name="out_Status"
										value="${Sales_OrderSearchDto.out_Status}" />
									<c:param name="empName" value="${Sales_OrderSearchDto.empName}" />
									<c:param name="sales_Date_Start"
										value="${Sales_OrderSearchDto.sales_Date_Start}" />
									<c:param name="sales_Date_End"
										value="${Sales_OrderSearchDto.sales_Date_End}" />
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
						<!-- 이곳에 자신의 코드를 작성하세요 -->
						<!-- 부트스트랩 CDN -->
						<jsp:include page="/common_cdn.jsp" />
						<jsp:include page="/foot.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="…bootstrap.js"></script>
</body>
</html>

