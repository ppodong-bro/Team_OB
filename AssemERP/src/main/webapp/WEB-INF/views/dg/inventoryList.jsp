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
									<th>부품 번호</th>
									<th>부품 분류</th>
									<th>부품 명</th>
									<th>수량</th>
									<th style="display: none;">적정 수량</th>
									<th style="display: none;">편차</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="realInventory" items="${realInventoryList}">
									<tr>
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