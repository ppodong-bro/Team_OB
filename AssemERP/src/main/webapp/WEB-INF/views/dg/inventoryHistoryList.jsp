<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>Assem ERP</title>
</head>
<script type="text/javascript">
//거래 구분 검색
const orderStatusSelect = ${search.order_status_select != null ? search.order_status_select : 999};
const itemStatusSelect = ${search.item_status_select != null ? search.item_status_select : 999};

	document.addEventListener("DOMContentLoaded", function () {
		//거래 구분 가져오기
		fetch("/common/1100")
			.then(response => response.json())
			.then(data => {
				console.log(data);
				
				// <select>에 값 채우기
				const select = document.getElementById("order_status");
				data.forEach(item => {
					const option = document.createElement("option");
					option.value = item.middle_status;
					option.text = item.context;
					
					if (item.middle_status == orderStatusSelect) {
	                    option.selected = true;
	                }
					
					select.appendChild(option);
				});
			})
			.catch(error => console.error("/common 호출 오류:", error));
		
		//재고 구분 가져오기
		fetch("/common/600")
			.then(response => response.json())
			.then(data => {
				console.log(data);
				
				// <select>에 값 채우기
				const select = document.getElementById("item_status");
				data.forEach(item => {
					const option = document.createElement("option");
					option.value = item.middle_status;
					option.text = item.context;
					
					if (item.middle_status == itemStatusSelect) {
	                    option.selected = true;
	                }
					
					select.appendChild(option);
				});
			})
			.catch(error => console.error("/common 호출 오류:", error));
	});
</script>
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
				<div class="container-fluid">
					<div class="card shadow-sm">
						<div class="card-header d-flex justify-content-between align-items-center">
							<h4 class="card-title mb-0">
								<i class="bi bi-calendar-check me-2"></i>재고 입출고 이력
							</h4>
						</div>
						<div class="card-body">
							<!-- 검색 폼 시작 -->
							<form method="get" action="${pageContext.request.contextPath}/inventory/history" class="row gx-2 gy-1 align-items-center mb-4">
								<div class="col d-flex flex-wrap justify-content-end align-items-center gap-2">
									<!-- 거래 구분(수주/발주) -->
									<div class="col-auto">
										<div class="input-group input-group-sm">
											<span class="input-group-text">거래</span> <select id="order_status" name="order_status_select" class="form-select"
												style="width: auto !important; min-width: 90px; max-width: 90px;">
												<option value="999">전체</option>
											</select> <input type="text" name="order_no_text" class="form-control" placeholder="거래 번호 입력" value="${search.order_no_text }"
												style="width: auto !important; min-width: 120px; max-width: 120px;">
										</div>
									</div>
									<!-- 재고 구분(부품/제품) -->
									<div class="col-auto">
										<div class="input-group input-group-sm">
											<span class="input-group-text">재고</span> <select id="item_status" name="item_status_select" class="form-select"
												style="width: auto !important; min-width: 90px; max-width: 90px;">
												<option value="999">전체</option>
											</select> <input type="text" name="item_no_text" class="form-control" placeholder="재고 명 입력" value="${search.item_no_text }">
										</div>
									</div>
									<!-- 검색 버튼 -->
									<div class="col-auto">
										<button type="submit" class="btn btn-secondary btn-sm text-nowrap">
											<i class="bi bi-search"></i> 검색
										</button>
									</div>
								</div>
							</form>
							<!-- 검색 폼 마지막 -->

							<!-- List 테이블 시작 -->
							<div class="table-responsive">
								<table class="table table-bordered align-middle">
									<thead class="table-light">
										<tr>
											<th class="text-center" style="white-space: nowrap;">#</th>
											<th class="text-center" style="white-space: nowrap;">거래 구분</th>
											<th class="text-center" style="white-space: nowrap;">거래 번호</th>
											<th class="text-center" style="white-space: nowrap;">재고 구분</th>
											<th class="text-center" style="white-space: nowrap;">재고 명</th>
											<th class="text-center" style="white-space: nowrap;">총수량</th>
											<th class="text-center" style="white-space: nowrap;">변동수량</th>
											<th class="text-center" style="white-space: nowrap;">입출고 일시</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="inventoryHistory" items="${InventoryHistoryList}" varStatus="index">
											<tr>
												<td class="text-center">${(paging.currentPage - 1) * paging.rowPage + index.index + 1}</td>
												<td class="text-center">
													<c:import url="${pageContext.request.contextPath}/commonText/1100/${inventoryHistory.order_status}" var="order_status_text" charEncoding="UTF-8"/>${order_status_text}
												</td>
												<td class="text-center">
													<c:choose>
														<c:when test="${inventoryHistory.order_no != -1}">
														${inventoryHistory.order_no}
														</c:when>
														<c:otherwise>
														-
														</c:otherwise>
													</c:choose>
													
												</td>
												<td class="text-center">
													<c:import url="${pageContext.request.contextPath}/commonText/600/${inventoryHistory.item_status}" var="order_status_text" charEncoding="UTF-8"/>${order_status_text}
												</td>
												<td>${inventoryHistory.item_no_text}</td>
												<td class="text-end">${inventoryHistory.item_totalcnt}</td>
												<td class="text-end">
													<c:choose>
														<c:when test="${inventoryHistory.inout_status == 0}">
															<span style="color: red;">+${inventoryHistory.item_cnt}</span>
														</c:when>
														<c:otherwise>
															<span style="color: blue;">-${inventoryHistory.item_cnt}</span>
														</c:otherwise>
													</c:choose>
												</td>
												<!-- 입출고 구분에 따라 +,- 및 색상 변경 -->
												<td class="text-center">${inventoryHistory.inout_date_text}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- List 테이블 마지막 -->
						</div>
						<div class="card-footer d-flex justify-content-center">
							<!-- 페이징에서 사용하는 경로 변수 -->
							<c:set var="pagingPath" value="${pageContext.request.contextPath}/inventory/history?" />
							<!-- 검색 조건 추가 -->
							<c:if test="${search.order_status_select != 999}">
								<c:set var="pagingPath" value="${pagingPath}&order_status_select=${search.order_status_select}" />
							</c:if>
							<c:if test="${not empty search.order_no_text}">
								<c:set var="pagingPath" value="${pagingPath}&order_no_text=${search.order_no_text}" />
							</c:if>
							<c:if test="${search.item_status_select != 999}">
								<c:set var="pagingPath" value="${pagingPath}&item_status_select=${search.item_status_select}" />
							</c:if>
							<c:if test="${not empty search.item_no_text}">
								<c:set var="pagingPath" value="${pagingPath}&item_no_text=${search.item_no_text}" />
							</c:if>

							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center mb-0">
									<li class="page-item ${paging.currentPage > 1 ? '' : 'disabled'}"><a class="page-link" href="${pagingPath}&currentPage=1"
										aria-label="First"><i class="bi bi-chevron-double-left"></i></a></li>
									<li class="page-item ${paging.currentPage > 1 ? '' : 'disabled'}"><a class="page-link"
										href="${pagingPath}&currentPage=${paging.currentPage - 1}" aria-label="Previous"><i class="bi bi-chevron-left"></i></a></li>
									<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
										<li class="page-item ${paging.currentPage == page ? 'active' : ''}"><a class="page-link" href="${pagingPath}&currentPage=${page}">${page}</a></li>
									</c:forEach>
									<li class="page-item ${paging.currentPage < paging.totalPage ? '' : 'disabled'}"><a class="page-link"
										href="${pagingPath}&currentPage=${paging.currentPage + 1}" aria-label="Next"><i class="bi bi-chevron-right"></i></a></li>
									<li class="page-item ${paging.currentPage < paging.totalPage ? '' : 'disabled'}"><a class="page-link"
										href="${pagingPath}&currentPage=${paging.totalPage}" aria-label="Last"><i class="bi bi-chevron-double-right"></i></a></li>
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
</body>
</html>