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
<link href="/css/list.css" rel="stylesheet">


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
							<h4 class="card-title mb-0">부품목록</h4>
							<a href="/parts/create" class="btn btn-primary"><i
								class="bi bi-plus-lg"></i> 등록</a>
						</div>

						<div class="card-body">
							<form method="get" action="searchPartsList"
								class="row gx-2 gy-1 align-items-end mb-4 justify-content-end">
								<!-- 부품구분 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">구분</span> <select
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
											class="form-control form-control-sm"
											value="${partsDTO.startDate }">
									</div>
								</div>
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">종료일</span><input type="date"
											id="endDate" name="endDate"
											class="form-control form-control-sm"
											value="${partsDTO.endDate }">
									</div>
								</div>
								<!-- 날짜검색종료 -->
								<!-- 검색버튼 -->
								<div class="col-auto">
									<button type="submit" class="btn btn-secondary text-nowrap">
							            <i class="bi bi-search"></i> 검색
							        </button>
								</div>
							</form>
							<!-- 검색 폼 마지막 -->


							<!-- List 테이블 시작 -->
							<div class="table-responsive">
								<table class="table table-bordered align-middle list-table">
									<thead class="table-light">
										<tr style="text-align: center;">
											<th style="width: 10%;">부품번호</th>
											<th style="width: 40%;">부품명</th>
											<th style="width: 10%;">종류</th>
											<th style="width: 10%;">제조사</th>
											<th style="width: 10%;">등록자</th>
											<th style="width: 15%;">등록일</th>
											<th style="width: 10%;" class="text-center" >수정</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="partsDTO" items="${partsDTOs}">
											<tr style="cursor: pointer;"
												onclick="location.href='<c:url value='/parts/partsDetail/${partsDTO.parts_no}'/>'">
												<td style="text-align: center;">${partsDTO.parts_no}</td>
												<td>${partsDTO.parts_name}</td>
												<td style="text-align: center;">${partsDTO.parts_statusName}</td>
												<td style="text-align: center;">${partsDTO.manufacture}</td>
												<td style="text-align: center;">${partsDTO.emp_name}</td>
												<td style="text-align: center;">${partsDTO.in_date}</td>
												<td class="text-center">
													<button type="button"
														onclick="event.stopPropagation(); location.href='/parts/partsModify/${partsDTO.parts_no}'"
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
							<!-- List 테이블 마지막 -->
							
						<div class="card-footer d-flex justify-content-center">
							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center mb-0">
									<c:choose>
										<c:when test="${partsDTO.currentPage > 1}">

											<!-- 첫페이지 블록 -->
											<c:url var="firstUrl" value="searchPartsList">
												<c:param name="currentPage" value="1" />
												<c:param name="parts_status"
													value="${partsDTO.parts_status}" />
												<c:param name="parts_name" value="${partsDTO.parts_name}" />
												<c:param name="startDate" value="${partsDTO.startDate}" />
												<c:param name="endDate" value="${partsDTO.endDate}" />
											</c:url>
											<li class="page-item"><a class="page-link"
												href="${firstUrl}" aria-label="First"><i
													class="bi bi-chevron-double-left"></i></a></li>
											<!-- 이전페이지 -->
											<c:url var="prevUrl" value="searchPartsList">
												<c:param name="currentPage" value="${page.currentPage - 1}" />
												<c:param name="parts_status"
													value="${partsDTO.parts_status}" />
												<c:param name="parts_name" value="${partsDTO.parts_name}" />
												<c:param name="startDate" value="${partsDTO.startDate}" />
												<c:param name="endDate" value="${partsDTO.endDate}" />
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

									<c:choose>
										<c:when test="${page.currentPage < page.totalPage}">
											<!-- 다음 블록 -->
											<c:url var="nextUrl" value="searchPartsList">
												<c:param name="currentPage" value="${page.currentPage + 1}" />
												<c:param name="parts_status"
													value="${partsDTO.parts_status}" />
												<c:param name="parts_name" value="${partsDTO.parts_name}" />
												<c:param name="startDate" value="${partsDTO.startDate}" />
												<c:param name="endDate" value="${partsDTO.endDate}" />
											</c:url>
											<li class="page-item"><a class="page-link"
												href="${nextUrl}" aria-label="Next"> <i
													class="bi bi-chevron-right"></i></a></li>
											<!-- 마지막페이지 -->
											<c:url var="finishUrl" value="searchPartsList">
												<c:param name="currentPage" value="${page.totalPage}" />
												<c:param name="parts_status"
													value="${partsDTO.parts_status}" />
												<c:param name="parts_name" value="${partsDTO.parts_name}" />
												<c:param name="startDate" value="${partsDTO.startDate}" />
												<c:param name="endDate" value="${partsDTO.endDate}" />
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