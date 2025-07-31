<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품관리</title>
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
				<div class="container-fluid px-4">
					<h2 class="mb-3 mt-2">제품관리</h2>

					<!-- 검색 폼 시작 -->
					<form method="get" action="searchProductList"
						class="row gx-2 gy-1 align-items-end mb-4 justify-content-end">
						<!-- 제품구분 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">종류</span> <select
									name="product_status" class="form-select form-select-sm">
									<option value="">전체</option>
									<option value="0"
										${productDTO.product_status == 0 ? 'selected' : ''}>데스크탑</option>
									<option value="1"
										${productDTO.product_status == 1 ? 'selected' : ''}>노트북</option>
									<option value="2"
										${productDTO.product_status == 2 ? 'selected' : ''}>워크스테이션</option>
								</select>
							</div>
						</div>
						<!-- 제품명 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">제품명</span> <input type="text"
									name="product_name" class="form-control" placeholder="제품명 검색"
									value="${productDTO.product_name }">
							</div>
						</div>
						<!-- 날짜검색 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">시작일</span> <input type="date"
									id="startDate" name="startDate"
									class="form-control form-control-sm" value="${productDTO.startDate }">
							</div>
						</div>
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">종료일</span><input type="date"
									id="endDate" name="endDate"
									class="form-control form-control-sm" value="${productDTO.endDate }">
							</div>
						</div>
						<!-- 날짜검색종료 -->

						<div class="col-auto">
							<button type="submit" class="btn btn-primary btn-sm w-100">
								조회</button>
						</div>
						<!-- 신규 등록 버튼 -->
						<div class="col-auto">
							<a href="<c:url value='/product/create'/>"
								class="btn btn-success btn-sm"> 등록 </a>
						</div>
					</form>
					<!-- 검색 폼 마지막 -->

					<!-- List 테이블 시작 -->
					<div class="table-responsive">
						<table class="table table-bordered align-middle">
							<thead class="table-light">
								<tr>
									<th>제품번호</th>
									<th>제품명</th>
									<th>종류</th>
									<th>등록자</th>
									<th>등록일</th>
									<th class="text-center">수정/삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="productDTO" items="${productDTOs}">
									<tr>
										<td>${productDTO.product_no}</td>
										<td>${productDTO.product_name}</td>
										<td>${productDTO.product_statusName}</td>
										<td>${productDTO.emp_no}</td>
										<td>${productDTO.in_date}</td>
										<td class="text-center">
											<button type="button"
												class="btn btn-sm btn-outline-primary me-1">수정</button>
											<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- List 테이블 마지막 -->
						<nav aria-label="Page navigation" class="mt-3">
							<ul class="pagination pagination-sm justify-content-center">
								<!-- 이전 블록/페이지 -->
								<!-- 이전 블록 -->
								<c:url var="prevUrl" value="searchProductList">
									<c:param name="currentPage" value="${page.startPage - 1}" />
										<c:param name="product_status" value="${productDTO.product_status}" />
										<c:param name="product_name" value="${productDTO.product_name}" />
										<c:param name="startDate" value="${productDTO.startDate}" />
										<c:param name="endDate" value="${productDTO.endDate}" />
								</c:url>
								<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
									<a class="page-link" href="${prevUrl}" aria-label="Previous">‹</a>
								</li>



								<!-- 페이지 번호들 -->
								<!-- 페이지 번호들 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}"
									var="p">
									<c:url var="pageUrl" value="searchProductList">
										<c:param name="currentPage" value="${p}" />
											<c:param name="product_status" value="${productDTO.product_status}" />
											<c:param name="product_name" value="${productDTO.product_name}" />
											<c:param name="startDate" value="${productDTO.startDate}" />
											<c:param name="endDate" value="${productDTO.endDate}" />
									</c:url>
									<li class="page-item ${page.currentPage == p ? 'active' : ''}">
										<a class="page-link" href="${pageUrl}">${p}</a>
									</li>
								</c:forEach>
								<!-- 다음 블록/페이지 -->
								<!-- 다음 블록 -->
								<c:url var="nextUrl" value="searchProductList">
									<c:param name="currentPage" value="${page.endPage + 1}" />
										<c:param name="product_status" value="${productDTO.product_status}" />
										<c:param name="product_name" value="${productDTO.product_name}" />
										<c:param name="startDate" value="${productDTO.startDate}" />
										<c:param name="endDate" value="${productDTO.endDate}" />
								</c:url>
								<li
									class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}">
									<a class="page-link" href="${nextUrl}" aria-label="Next">›</a>
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
		<script src="…bootstrap.js"></script>
</body>
</html>