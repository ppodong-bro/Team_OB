<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>제품관리</title>
<!-- 공통 CSS -->
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


					<!-- 검색 폼 시작 -->
					<div class="card shadow-sm">
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<h4 class="card-title mb-0">제품목록</h4>
							<a href="/product/create" class="btn btn-primary"><i class="bi bi-plus-lg"></i> 등록</a>
						</div>
						<div class="card-body">
							<form method="get" action="searchProductList"
								class="row gx-2 gy-1 align-items-end mb-4 justify-content-end">
								
								<!-- 제품구분 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">구분</span> <select
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
											class="form-control form-control-sm"
											value="${productDTO.startDate }">
									</div>
								</div>
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">종료일</span><input type="date"
											id="endDate" name="endDate"
											class="form-control form-control-sm"
											value="${productDTO.endDate }">
									</div>
								</div>
								<!-- 날짜검색종료 -->

								<div class="col-auto">
									<button type="submit" class="btn btn-secondary text-nowrap">
							            <i class="bi bi-search"></i> 검색
							        </button>
								</div>

							</form>
							<!-- 검색 폼 마지막 -->

							<!-- List 테이블 시작 -->
							<div class="table-responsive">
								<table class="table table-bordered align-middle">
									<thead class="table-light">
										<tr style="text-align: center;">
											<th>제품번호</th>
											<th>제품명</th>
											<th>종류</th>
											<th>등록자</th>
											<th>등록일</th>
											<th class="text-center">수정</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="productDTO" items="${productDTOs}">
											<tr>
												<td style="text-align: center;">${productDTO.product_no}</td>
												<td>${productDTO.product_name}</td>
												<td style="text-align: center;">${productDTO.product_statusName}</td>
												<td style="text-align: center;">${productDTO.emp_name}</td>
												<td style="text-align: center;">${productDTO.in_date}</td>
												<td class="text-center">
													<button type="button"
														onclick="location.href='/product/productModify/${productDTO.product_no}'"
														class="btn btn-sm btn-outline-success">
														<i class="bi bi-pencil-square"></i> 수정
													</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						<div class="card-footer d-flex justify-content-center">
							<!-- List 테이블 마지막 -->
							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center mb-0">

									<c:choose>
										<c:when test="${productDTO.currentPage > 1}">

											<!-- 첫페이지 버튼-->
											<c:url var="firstUrl" value="searchProductList">
												<c:param name="currentPage" value="1" />
												<c:param name="product_status"
													value="${productDTO.product_status}" />
												<c:param name="product_name"
													value="${productDTO.product_name}" />
												<c:param name="startDate" value="${productDTO.startDate}" />
												<c:param name="endDate" value="${productDTO.endDate}" />
											</c:url>
											<li class="page-item"><a class="page-link"
												href="${firstUrl}" aria-label="First"><i
													class="bi bi-chevron-double-left"></i></a></li>
											<!-- 이전페이지 -->
											<c:url var="prevUrl" value="searchProductList">
												<c:param name="currentPage" value="${page.currentPage - 1}" />
												<c:param name="product_status"
													value="${productDTO.product_status}" />
												<c:param name="product_name"
													value="${productDTO.product_name}" />
												<c:param name="startDate" value="${productDTO.startDate}" />
												<c:param name="endDate" value="${productDTO.endDate}" />
											</c:url>
											<li class="page-item"><a class="page-link"
												href="${prevUrl}" aria-label="Previous"><i
													class="bi bi-chevron-left"></i></a></li>

										</c:when>
										<c:otherwise>	
											<li class="page-item disabled"><a class="page-link"
												href="#" aria-label="First"><i
													class="bi bi-chevron-double-left"></i></a></li>
											<li class="page-item disabled"><a class="page-link"
												href="#" aria-label="Previous"><i
													class="bi bi-chevron-left"></i></a></li>
										</c:otherwise>
									</c:choose>

									<!-- 블럭페이지 -->
									<c:forEach begin="${page.startPage}" end="${page.endPage}"
										var="p">
										<c:url var="pageUrl" value="searchProductList">
											<c:param name="currentPage" value="${p}" />
											<c:param name="product_status"
												value="${productDTO.product_status}" />
											<c:param name="product_name"
												value="${productDTO.product_name}" />
											<c:param name="startDate" value="${productDTO.startDate}" />
											<c:param name="endDate" value="${productDTO.endDate}" />
										</c:url>
										<li class="page-item ${page.currentPage == p ? 'active' : ''}">
											<a class="page-link" href="${pageUrl}">${p}</a>
										</li>
									</c:forEach>
									
									<!-- 다음페이지 -->
									<c:choose>
										<c:when test="${page.currentPage < page.totalPage}">
											<!-- 다음 블록 -->
											<c:url var="nextUrl" value="searchProductList">
												<c:param name="currentPage" value="${page.currentPage + 1}" />
												<c:param name="product_status"
													value="${productDTO.product_status}" />
												<c:param name="product_name"
													value="${productDTO.product_name}" />
												<c:param name="startDate" value="${productDTO.startDate}" />
												<c:param name="endDate" value="${productDTO.endDate}" />
											</c:url>
											<li class="page-item"><a class="page-link"
												href="${nextUrl}" aria-label="Next"> <i
													class="bi bi-chevron-right"></i></a></li>
													
											<!-- 마지막페이지 -->
											<c:url var="finishUrl" value="searchProductList">
												<c:param name="currentPage" value="${page.totalPage}" />
												<c:param name="product_status"
													value="${productDTO.product_status}" />
												<c:param name="product_name"
													value="${productDTO.product_name}" />
												<c:param name="startDate" value="${productDTO.startDate}" />
												<c:param name="endDate" value="${productDTO.endDate}" />
											</c:url>
											<li class="page-item"><a class="page-link"
												href="${finishUrl}" aria-label="Next"> <i
													class="bi bi-chevron-double-right"></i></a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item disabled"><a class="page-link"
												href="#" aria-label="Next"><i
													class="bi bi-chevron-right"></i></a></li>
											<li class="page-item disabled"><a class="page-link"
												href="#" aria-label="Last"><i
													class="bi bi-chevron-double-right"></i></a></li>
										</c:otherwise>
									</c:choose>
								</ul>
							</nav>
						</div>
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