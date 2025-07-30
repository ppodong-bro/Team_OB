<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
				<div class="container mt-4 ml-10">
					<div class="d-flex justify-content-between align-items-end mb-4">
						<h2 class="mb-0">제품관리</h2>

						<!-- 검색 폼 시작 -->
						<form class="row gx-2 gy-1 align-items-end ">
							<!-- 제품명 -->
							<div class="col-auto">
								<label for="searchName" class="form-label small mb-1">제품명</label>
								<input type="text" id="searchName" name="name"
									class="form-control form-control-sm" placeholder="제품명 검색">
							</div>
							<!-- StartDate -->
							<div class="col-auto">
								<label for="startDate" class="form-label small mb-1">시작일</label>
								<input type="date" id="startDate" name="startDate"
									class="form-control form-control-sm">
							</div>
							<!-- EndDate -->
							<div class="col-auto">
								<label for="endDate" class="form-label small mb-1">종료일</label> <input
									type="date" id="endDate" name="endDate"
									class="form-control form-control-sm">
							</div>
							<!-- 제품구분 -->
							<div class="col-auto">
								<label for="type" class="form-label small mb-1">제품유형</label> <select
									id="type" name="type" class="form-select form-select-sm">
									<option value="0">DestTop</option>
									<option value="1">NoteBook</option>
									<option value="2">WorkStation</option>
								</select>
							</div>
							<div class="col-auto">
								<button type="submit" class="btn btn-primary btn-sm w-100">
									조회</button>
							</div>
						</form>
						<!-- 검색 폼 마지막 -->
					</div>
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
								<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
									<a class="page-link"
									href="productList?currentPage=${page.startPage-1}"
									aria-label="Previous">‹</a>
								</li>



								<!-- 페이지 번호들 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
									<li class="page-item ${page.currentPage == p ? 'active' : ''}">
										<a class="page-link" href="productList?currentPage=${p}">${p}</a>
									</li>
								</c:forEach>

								<!-- 다음 블록/페이지 -->
								<li
									class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}">
									<a class="page-link"
									href="productList?currentPage=${page.endPage+1}"
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
	<script src="…bootstrap.js"></script>

</body>
</html>