<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>…
</head>
<body>
	<%@ include file="../header.jsp"%>
	<%@ include file="../side.jsp"%>

	<div class="main-content" style="margin-left: 260px;">
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
			<form method="get" action="clientList"
				class="row gx-2 gy-1 align-items-end mb-4">
				<!-- 거래처명 -->
				<div class="col-auto">
					<div class="input-group input-group-sm">
						<span class="input-group-text">거래처명</span> <input type="text"
							name="client_Name" class="form-control" placeholder="거래처명 검색"
							value="${searchDto.client_Name}">
					</div>
				</div>

				<!-- 유형 -->
				<div class="col-auto">
					<div class="input-group input-group-sm">
						<span class="input-group-text">유형</span> <select
							name="client_Gubun" class="form-select">
							<option value="">전체</option>
							<option value="0"
								${searchDto.client_Gubun == 0 ? 'selected' : ''}>구매</option>
							<option value="1"
								${searchDto.client_Gubun == 1 ? 'selected' : ''}>판매</option>
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
						<span class="input-group-text">거래처 담당자</span> <input type="text"
							name="client_Man" class="form-control" placeholder="거래처 담당자 검색"
							value="${searchDto.client_Man}">
					</div>
				</div>

				<!-- 검색 버튼 -->
				<div class="col-auto">
					<button type="submit" class="btn btn-primary btn-sm">검색</button>
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
							<tr>
								<td class="text-center">${st.index + 1}</td>
								<td class="text-center">${client.client_No}</td>
								<td>${client.client_Name}</td>
								<td class="text-center">${client.client_Gubun == 0 ? '구매' : '판매'}
								</td>
								<td>${client.client_Address}</td>
								<td>${client.client_Email}</td>
								<td class="text-center">${client.client_Man}</td>
								<td class="text-center"><a
									href="<c:url value='/client/edit/${client.client_No}'/>"
									class="btn btn-sm btn-outline-primary me-1">수정</a> <a
									href="<c:url value='/client/delete/${client.client_No}'/>"
									class="btn btn-sm btn-outline-danger">삭제</a></td>
							</tr>
						</c:forEach>
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
						<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
							<a class="page-link"
							href="clientList?currentPage=${page.startPage-1}"
							aria-label="Previous">‹</a>
						</li>

						<!-- 숫자 -->
						<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
							<li class="page-item ${page.currentPage == p ? 'active' : ''}">
								<a class="page-link" href="clientList?currentPage=${p}">${p}</a>
							</li>
						</c:forEach>

						<!-- 다음 -->
						<li
							class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}">
							<a class="page-link"
							href="clientList?currentPage=${page.endPage+1}" aria-label="Next">›</a>
						</li>
					</ul>
				</nav>

			</div>
		</div>
	</div>
	<%@ include file="../foot.jsp"%>
	<script src="…bootstrap.js"></script>
</body>
</html>
