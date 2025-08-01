<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부품관리</title>
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
					<h2 class="mb-3 mt-2">부품관리</h2>

					<!-- 검색 폼 시작 -->
					<form method="get" action="searchPartsList"
						class="row gx-2 gy-1 align-items-end mb-4 justify-content-end">
						<!-- 부품종류 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">종류</span> <select
									name="parts_status" class="form-select form-select-sm">
									<option value="" selected="selected">전체</option>
									<option value="0"
										${partsDTO.parts_status == 0 ? 'selected' : '' }>메인보드</option>
									<option value="1"
										${partsDTO.parts_status == 1 ? 'selected' : '' }>CPU</option>
									<option value="2"
										${partsDTO.parts_status == 2 ? 'selected' : '' }>GPU</option>
									<option value="3"
										${partsDTO.parts_status == 3 ? 'selected' : '' }>메모리</option>
									<option value="4"
										${partsDTO.parts_status == 4 ? 'selected' : '' }>파워</option>
									<option value="5"
										${partsDTO.parts_status == 5 ? 'selected' : '' }>HDD</option>
									<option value="6"
										${partsDTO.parts_status == 6 ? 'selected' : '' }>SSD</option>
									<option value="7"
										${partsDTO.parts_status == 7 ? 'selected' : '' }>케이스</option>
									<option value="8"
										${partsDTO.parts_status == 8 ? 'selected' : '' }>쿨러</option>
								</select>
							</div>
						</div>
						<!-- 부품명 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">부품명</span> <input type="text"
									name="parts_name" class="form-control" placeholder="부품명 검색"
									value="${partsDTO.parts_name }">
							</div>
						</div>
						<!-- 날짜검색 -->
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">시작일</span> <input type="date"
									id="startDate" name="startDate"
									class="form-control form-control-sm" value="${partsDTO.startDate }">
							</div>
						</div>
						<div class="col-auto">
							<div class="input-group input-group-sm">
								<span class="input-group-text">종료일</span><input type="date"
									id="endDate" name="endDate"
									class="form-control form-control-sm" value="${partsDTO.endDate }">
							</div>
						</div>
						<!-- 날짜검색종료 -->
						<div class="col-auto">
							<button type="submit" class="btn btn-primary btn-sm w-100">
								조회</button>
						</div>
						<!-- 신규 등록 버튼 -->
						<div class="col-auto">
							<a href="<c:url value='/parts/create'/>"
								class="btn btn-success btn-sm"> 등록 </a>
						</div>
						<!-- 등록 버튼 마지막 -->
					</form>
					<!-- 검색 폼 마지막 -->


					<!-- List 테이블 시작 -->
					<div class="table-responsive">
						<table class="table table-bordered align-middle">
							<thead class="table-light">
								<tr>
									<th>부품번호</th>
									<th>부품명</th>
									<th>종류</th>
									<th>제조사</th>
									<th>등록자</th>
									<th>등록일</th>
									<th class="text-center">수정/삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="partsDTO" items="${partsDTOs}">
									<tr>
										<td>${partsDTO.parts_no}</td>
										<td>${partsDTO.parts_name}</td>
										<td>${partsDTO.parts_statusName}</td>
										<td>${partsDTO.manufacture}</td>
										<td>${partsDTO.emp_no}</td>
										<td>${partsDTO.in_date}</td>
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
								<!-- 이전 블록 -->
								<c:url var="prevUrl" value="searchPartsList">
									<c:param name="currentPage" value="${page.startPage - 1}" />
										<c:param name="parts_status" value="${partsDTO.parts_status}" />
										<c:param name="parts_name" value="${partsDTO.parts_name}" />
										<c:param name="startDate" value="${partsDTO.startDate}" />
										<c:param name="endDate" value="${partsDTO.endDate}" />
								</c:url>
								<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
									<a class="page-link" href="${prevUrl}" aria-label="Previous">‹</a>
								</li>



								<!-- 페이지 번호들 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}"
									var="p">
									<c:url var="pageUrl" value="searchPartsList">
										<c:param name="currentPage" value="${p}" />
											<c:param name="parts_status" value="${partsDTO.parts_status}" />
											<c:param name="parts_name" value="${partsDTO.parts_name}" />
											<c:param name="startDate" value="${partsDTO.startDate}" />
											<c:param name="endDate" value="${partsDTO.endDate}" />
									</c:url>
									<li class="page-item ${page.currentPage == p ? 'active' : ''}">
										<a class="page-link" href="${pageUrl}">${p}</a>
									</li>
								</c:forEach>
								<!-- 다음 블록/페이지 -->
								<!-- 다음 블록 -->
								<c:url var="nextUrl" value="searchPartsList">
									<c:param name="currentPage" value="${page.endPage + 1}" />
										<c:param name="parts_status" value="${partsDTO.parts_status}" />
										<c:param name="parts_name" value="${partsDTO.parts_name}" />
										<c:param name="startDate" value="${partsDTO.startDate}" />
										<c:param name="endDate" value="${partsDTO.endDate}" />
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