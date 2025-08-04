<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
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

					<h2 class="mb-3 mt-2">거래처 관리</h2>

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

						<!-- 신규 등록 버튼 -->
						<div class="col-auto">
							<a href="<c:url value='/client/createStart'/>"
								class="btn btn-success btn-sm"> 등록 </a>
						</div>
					</form>


					<!-- List 테이블 시작 -->
					<div class="table-responsive">
						<table class="table table-bordered align-middle">
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
												<button type="submit" class="btn btn-sm btn-outline-danger">삭제</button>
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

						<!-- 페이징 -->
						<nav aria-label="Page navigation" class="mt-3">
							<ul class="pagination pagination-sm justify-content-center">
								<!-- 이전 -->
								<li class="page-item ${page.currentPage == 1 ? 'disabled' : ''}">
									<c:url var="prevUrl" value="/client/list">
										<c:param name="currentPage" value="${page.currentPage - 1}" />
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
										<%-- 		<c:if test="${not empty clientSearchDto.inDate_Start}">
											<c:param name="inDate_Start"
												value="${clientSearchDto.inDate_Start}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.inDate_End}">
											<c:param name="inDate_End"
												value="${clientSearchDto.inDate_End}" />
										</c:if> --%>
									</c:url> <a class="page-link" href="${prevUrl}" aria-label="Previous">‹</a>
								</li>

								<!-- 숫자 페이지 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}"
									var="p">
									<li class="page-item ${page.currentPage == p ? 'active' : ''}">
										<c:url var="pageUrl" value="/client/list">
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
											<%-- 	<c:if test="${not empty clientSearchDto.inDate_Start}">
												<c:param name="inDate_Start"
													value="${clientSearchDto.inDate_Start}" />
											</c:if>
											<c:if test="${not empty clientSearchDto.inDate_End}">
												<c:param name="inDate_End"
													value="${clientSearchDto.inDate_End}" />
											</c:if> --%>
										</c:url> <a class="page-link" href="${pageUrl}">${p}</a>
									</li>
								</c:forEach>

								<!-- 다음 -->
								<li
									class="page-item ${page.currentPage == page.totalPage ? 'disabled' : ''}">
									<c:url var="nextUrl" value="/client/list">
										<c:param name="currentPage" value="${page.currentPage + 1}" />
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
										<%-- 	<c:if test="${not empty clientSearchDto.inDate_Start}">
											<c:param name="inDate_Start"
												value="${clientSearchDto.inDate_Start}" />
										</c:if>
										<c:if test="${not empty clientSearchDto.inDate_End}">
											<c:param name="inDate_End"
												value="${clientSearchDto.inDate_End}" />
										</c:if --%>>
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

