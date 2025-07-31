<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

					<!-- <div class="card">
				<div 
					class="card-header d-flex justify-content-between align-items-center">
					<h4 class="card-title mb-0">
						<i class="bi bi-people-fill me-2"></i>거래처 관리
					</h4>
				</div>
			</div>	 -->

					<h2 class="mb-3 mt-2">수주 관리</h2>

					<%-- <!-- 검색 폼 -->
					<form method="get" action="searchList"
						class="row gx-2 gy-1 align-items-end mb-4">
						<!-- 거래처명 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">거래처명</span> <input type="text"
									name="client_Name" class="form-control" placeholder="거래처명 검색"
									value="${ClientSearchDto.client_Name}">
							</div>
						</div>

						<!-- 유형 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">출고상태</span> <select
									name="out_Status" class="form-select">
									<option value="">전체</option>
									<option value="0"
										${ClientSearchDto.client_Gubun == 0 ? 'selected' : ''}>요청</option>
									<option value="1"
										${ClientSearchDto.client_Gubun == 1 ? 'selected' : ''}>승인</option>
									<option value="2"
										${ClientSearchDto.client_Gubun == 2 ? 'selected' : ''}>완료</option>
									<option value="3"
										${ClientSearchDto.client_Gubun == 3 ? 'selected' : ''}>마감</option>

								</select>
							</div>
						</div>

						<!-- 주소 -->
								<div class="col-auto">
					<div class="input-group input-group-sm">
						<span class="input-group-text">주소</span> <input type="text"
							name="client_Address" class="form-control" placeholder="주소 검색"
							value="${searchDto.client_Address}">
					</div>
				</div>

						<!-- 담당자 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">거래처 담당자</span> <input type="text"
									name="client_Man" class="form-control" placeholder="거래처 담당자 검색"
									value="${ClientSearchDto.client_Man}">
							</div>
						</div>

						<!-- 검색 버튼 -->
						<div class="col-auto">
							<button type="submit" class="btn btn-primary btn-sm">검색</button>
						</div>
					</form>
 --%>

					<!-- List 테이블 시작 -->
					<div class="table-responsive">
						<table class="table table-bordered align-middle">
							<thead class="table-light">
								<tr>
									<th class="text-center">#</th>
									<th class="text-center">수주번호</th>
									<th class="text-center">거래처명</th>
									<th class="text-center">제품명</th>
									<th class="text-center">납기완료일</th>
									<th class="text-center">출고상태</th>
									<th class="text-center">담당자</th>
									<th class="text-center">수정/삭제</th>
								</tr>
							</thead>
							<tbody>
								<%-- <c:forEach var="sales" items="${sales_OrderList}" varStatus="st">
									<tr>
										<td class="text-center">${st.index + 1}</td>
										<td class="text-center"><a
											href="<c:url value='/sales/detail?sales_No=${sales.sales_No}'/>">
												${sales.sales_No} </a></td>
										<td>${sales.client_Name}</td>
										<td class="text-center">${sales.client_Gubun == 0 ? '구매' : '판매'}
										</td>
										<td>${sales.client_Address}</td>
										<td>${sales.client_Email}</td>
										<td class="text-center">${sales.client_Man}</td>
										<td class="text-center"><a
											href="<c:url value='/business/modifyClientStart?client_No=${sales.client_No}'/>"
											class="btn btn-sm btn-outline-primary me-1">수정</a>
											<form
												action="${pageContext.request.contextPath}/business/deleteClient"
												method="post" style="display: inline;">
												<input type="hidden" name="client_No"
													value="${client.client_No}" />
												<button type="submit" class="btn btn-sm btn-outline-danger">
													삭제</button>
											</form>
									</tr>
								</c:forEach> --%>

								<c:forEach var="order" items="${listSales}" varStatus="st">
									<tr>
										<!-- 순번 -->
										<td class="text-center">${st.index + 1}</td>

										<!-- 수주번호 (detail 링크) -->
										<td class="text-center"><a
											href="<c:url value='/sales/detail?sales_No=${order.sales_No}'/>">
												${order.sales_No} </a></td>

										<!-- client → clientName -->
										<td>${order.clientDto.client_Name}</td>


										<!-- salesItems 컬렉션 출력 -->
										<td><c:forEach var="item" items="${order.sales_Item}"
												varStatus="ist">
												<!-- 예: 상품번호(수량) 형태로 표시 -->
										        <%-- ${ist.index + 1}. --%> ${item.productDto.product_name}
										        (요청수량: ${item.sales_Item_Cnt},
										         출고수량: ${item.sales_Item_OutCnt})<br />
											</c:forEach></td>

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
										<td class="text-center"><a
											href="<c:url value='/sales/modify?sales_No=${order.sales_No}'/>"
											class="btn btn-sm btn-outline-primary me-1"> 수정 </a>
											<form
												action="${pageContext.request.contextPath}/sales/delete"
												method="post" style="display: inline">
												<input type="hidden" name="sales_No"
													value="${order.sales_No}" />
												<button type="submit" class="btn btn-sm btn-outline-danger">
													삭제</button>
											</form></td>
									</tr>
								</c:forEach>
								<c:if test="${empty listSales}">
									<tr>
										<td colspan="9" class="text-center">조회된 데이터가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>

						
						<nav aria-label="Page navigation" class="mt-3">
							<ul class="pagination pagination-sm justify-content-center">
								<!-- 이전 -->
								<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
									<c:url var="prevUrl" value="/business/clientSearchList">
										<c:param name="currentPage" value="${page.startPage - 1}" />
										<c:if test="${not empty clientSearchDto.client_Name}">
											<c:param name="client_Name"
												value="${clientSearchDto.client_Name}" />
										</c:if>
										<c:if test="${clientSearchDto.client_Gubun != null}">
											<c:param name="client_Gubun"
												value="${clientSearchDto.client_Gubun}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.client_Man}">
											<c:param name="client_Man"
												value="${clientSearchDto.client_Man}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.inDate_Start}">
											<c:param name="inDate_Start"
												value="${clientSearchDto.inDate_Start}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.inDate_End}">
											<c:param name="inDate_End"
												value="${clientSearchDto.inDate_End}" />
										</c:if>
									</c:url> <a class="page-link" href="${prevUrl}" aria-label="Previous">‹</a>
								</li>

								<!-- 숫자 페이지 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}"
									var="p">
									<li class="page-item ${page.currentPage == p ? 'active' : ''}">
										<c:url var="pageUrl" value="/business/clientSearchList">
											<c:param name="currentPage" value="${p}" />
											<!-- 검색 DTO 파라미터들 동일하게 추가 -->
											<c:if test="${not empty clientSearchDto.client_Name}">
												<c:param name="client_Name"
													value="${clientSearchDto.client_Name}" />
											</c:if>
											<c:if test="${clientSearchDto.client_Gubun != null}">
												<c:param name="client_Gubun"
													value="${clientSearchDto.client_Gubun}" />
											</c:if>
											<c:if test="${not empty clientSearchDto.client_Man}">
												<c:param name="client_Man"
													value="${clientSearchDto.client_Man}" />
											</c:if>
											<c:if test="${not empty clientSearchDto.inDate_Start}">
												<c:param name="inDate_Start"
													value="${clientSearchDto.inDate_Start}" />
											</c:if>
											<c:if test="${not empty clientSearchDto.inDate_End}">
												<c:param name="inDate_End"
													value="${clientSearchDto.inDate_End}" />
											</c:if>
										</c:url> <a class="page-link" href="${pageUrl}">${p}</a>
									</li>
								</c:forEach>

								<!-- 다음 -->
								<li
									class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}">
									<c:url var="nextUrl" value="/business/clientSearchList">
										<c:param name="currentPage" value="${page.endPage + 1}" />
										<!-- 검색 DTO 파라미터들 똑같이 추가 -->
										<c:if test="${not empty clientSearchDto.client_Name}">
											<c:param name="client_Name"
												value="${clientSearchDto.client_Name}" />
										</c:if>
										<c:if test="${clientSearchDto.client_Gubun != null}">
											<c:param name="client_Gubun"
												value="${clientSearchDto.client_Gubun}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.client_Man}">
											<c:param name="client_Man"
												value="${clientSearchDto.client_Man}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.inDate_Start}">
											<c:param name="inDate_Start"
												value="${clientSearchDto.inDate_Start}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.inDate_End}">
											<c:param name="inDate_End"
												value="${clientSearchDto.inDate_End}" />
										</c:if>
									</c:url> <a class="page-link" href="${nextUrl}" aria-label="Next">›</a>
								</li>
							</ul>
						</nav>



					</div>


				</div>
				<!-- 이곳에 자신의 코드를 작성하세요 -->
				<!-- 부트스트랩 CDN -->
				<jsp:include page="/common_cdn.jsp" />
				<jsp:include page="/foot.jsp" />
			</div>
		</div>
	</div>


	<script src="…bootstrap.js"></script>
</body>
</html>

