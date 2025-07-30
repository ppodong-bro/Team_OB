<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
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
				<div class="container mt-4 ml-10">
					<div class="d-flex justify-content-between align-items-end mb-4">
						<h2 class="mb-0">재고 관리</h2>

						<!-- 검색 폼 시작 -->
						<!-- 검색 폼 마지막 -->
					</div>
					<!-- List 테이블 시작 -->
					<div class="table-responsive">
						<table class="table table-bordered align-middle">
							<thead class="table-light">
								<tr>
									<th>#</th>
									<th>부품 번호</th>
									<th>부품 분류</th>
									<th>부품 명</th>
									<th>수량</th>
									<th style="display: none;">적정 수량</th>
									<th style="display: none;">편차</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="realInventory" items="${realInventoryList}" varStatus="index">
									<tr>
										<td>${(page.currentPage - 1) * page.rowPage + index.index + 1}</td>
										<td>${realInventory.item_no}</td>
										<td>${realInventory.item_status}</td>
										<td>${realInventory.item_name}</td>
										<td>${realInventory.cnt}</td>
										<td style="display: none;">${realInventory.proper_cnt}</td>
										<td style="display: none;">${realInventory.diff_cnt}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- List 테이블 마지막 -->
						
						<nav aria-label="Page navigation" class="mt-3">
							<ul class="pagination pagination-sm justify-content-center">
								<!-- 이전 블록/페이지 -->
								<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
									<a class="page-link"
									href="partsList?currentPage=${page.startPage-1}"
									aria-label="Previous">‹</a>
								</li>

								<!-- 페이지 번호들 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
									<li class="page-item ${page.currentPage == p ? 'active' : ''}">
										<a class="page-link" href="${pageContext.request.contextPath}/inventory?currentPage=${p}">${p}</a>
									</li>
								</c:forEach>

								<!-- 다음 블록/페이지 -->
								<li
									class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}">
									<a class="page-link"
									href="partsList?currentPage=${page.endPage+1}"
									aria-label="Next">›</a>
								</li>
							</ul>
						</nav>
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