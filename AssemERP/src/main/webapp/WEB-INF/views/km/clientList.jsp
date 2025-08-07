<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<link href="/css/list.css" rel="stylesheet">
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
				            <h4 class="card-title mb-0"><i class="bi bi-list-ul"></i> 거래처 목록</h4>
            					<a href="/client/createStart" class="btn btn-primary"><i class="bi bi-plus-lg"></i>등록</a>
				        </div>
				        <div class="card-body">

							<!-- 검색 폼 -->
							<!-- 검색 폼: 전체를 오른쪽으로 정렬 -->
							<form method="get" action="list"
								class="row gx-2 gy-1 align-items-end mb-4 justify-content-end">

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
										<span class="input-group-text">유형</span> <select
											name="client_Gubun" class="form-select">
											<option value="">전체</option>
											<option value="0"
												${ClientSearchDto.client_Gubun == 0 ? 'selected' : ''}>구매</option>
											<option value="1"
												${ClientSearchDto.client_Gubun == 1 ? 'selected' : ''}>판매</option>
										</select>
									</div>
								</div>

								<!-- 주소 -->
								<%-- 		<div class="col-auto">
					<div class="input-group input-group-sm">
						<span class="input-group-text">주소</span> <input type="text"
							name="client_Address" class="form-control" placeholder="주소 검색"
							value="${searchDto.client_Address}">
					</div>
				</div> --%>

								<!-- 담당자 -->
								<div class="col-auto">
									<div class="input-group input-group-sm">
										<span class="input-group-text">담당자</span> <input type="text"
											name="client_Man" class="form-control" placeholder="담당자 검색"
											value="${ClientSearchDto.client_Man}">
									</div>
								</div>

								<!-- 검색 버튼 -->
								<div class="col-auto">
									<button type="submit" class="btn btn-primary btn-sm">검색</button>
								</div>
							</form>


							<!-- List 테이블 시작 -->
							<div class="table-responsive">
								<table class="table table-bordered align-middle list-table">
									<thead class="table-light">
										<tr>
											<th class="text-center">#</th>
											<th class="text-center">거래처번호</th>
											<th class="text-center">거래처명</th>
											<th class="text-center">유형</th>
											<th class="text-center">주소</th>
											<th class="text-center">이메일</th>
											<th class="text-center">거래처 담당자</th>
											<th class="text-center">수정/삭제</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="client" items="${clientList}" varStatus="st">
											<tr style="cursor: pointer;"
												onclick="location.href='<c:url value='/client/detail?client_No=${client.client_No}'/>'">
												<td class="text-center">${st.index + 1}</td>
												<td class="text-center">${client.client_No}</td>
												<td>${client.client_Name}</td>
												<td class="text-center"><c:choose>
														<c:when test="${client.client_Gubun == 0}">구매</c:when>
														<c:when test="${client.client_Gubun == 1}">판매</c:when>
														<c:otherwise>기타</c:otherwise>
													</c:choose></td>
												<td>${client.client_Address}</td>
												<td>${client.client_Email}</td>
												<td class="text-center">${client.client_Man}</td>
												<td class="text-center">
													<!-- 수정 버튼 --> <a
													href="<c:url value='/client/modifyStart?client_No=${client.client_No}'/>"
													class="btn btn-sm btn-outline-primary me-1"
													onclick="event.stopPropagation();">수정</a> <!-- 삭제 버튼 -->
													<form
														action="${pageContext.request.contextPath}/client/delete"
														method="post" style="display: inline;"
														onclick="event.stopPropagation();">
														<input type="hidden" name="client_No"
															value="${client.client_No}" />
														<button type="submit"
															class="btn btn-sm btn-outline-danger">삭제</button>
													</form>
												</td>
											</tr>
										</c:forEach>

										<!-- 조회 결과 없을 때 -->
										<c:if test="${empty clientList}">
											<tr>
												<td colspan="9" class="text-center">조회된 데이터가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>

								<!-- 검색 조건을 포함한 기본 URL 구성 -->
								<c:url var="pageUrl" value="/client/list">
									<c:param name="client_Name"
										value="${clientSearchDto.client_Name}" />
									<c:param name="client_Gubun"
										value="${clientSearchDto.client_Gubun}" />
									<c:param name="client_Man"
										value="${clientSearchDto.client_Man}" />
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

