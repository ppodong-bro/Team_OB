<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
</head>
<style>
/* 기본 상태 (선택되지 않은 부품/제품)의 폰트 색상을 회색으로 */
.btn-outline-primary {
	color: #6c757d; /* 짙은 회색 */
	border-color: #0d6efd; /* 원래 부트스트랩 primary 색상 테두리 유지 */
}
</style>
<script type="text/javascript">
	// 부품,제품 분류
	const itemType = ${search.item_type != null ? search.item_type : 0};
	const itemStatusSelect = ${search.item_status_select != null ? search.item_status_select : 999};
	
	document.addEventListener("DOMContentLoaded", function () {
		// 부품 : 900
		// 제품 : 800
		const itemType_common = itemType == 0 ? 900 : 800;
		// console.log(itemType_common);
		
		// common의 내용 가져오기 
		fetch("/common/" + itemType_common)
			.then(response => response.json())
			.then(data => {
				// console.log("불러온 데이터:", data);
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

	// 부품,제품 전체 재고 조회 함수 
	function inventoryTypeToggle(radio) {
		var item_type = 0;
		switch (radio.id) {
		case "btnradio_parts":
			item_type = 0;
			break;//부품
		case "btnradio_product":
			item_type = 1;
			break;//제품
		default:
			itemStatus = 0;
			break;
		}

		var link = "/inventory?item_type=" + item_type;
		//console.log("link", link)
		location.href = link;
	}
</script>
<body>
	<!-- 화면에서 전체적으로 사용하는 부품/제품 구분 변수 -->
	<c:set var="item_type" value="${search.item_type == 0 ? '부품' : '제품'}" />

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
					<h2 class="mb-3 mt-2">재고 관리</h2>

					<!-- 검색 폼 시작 -->
					<form method="get" action="inventory" class="row gx-2 gy-1 align-items-center mb-4">
						<!-- 부품/제품 -->
						<div class="col-auto">
							<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
								<input type="radio" class="btn-check" name="item_type" value="0" id="btnradio_parts" onchange="inventoryTypeToggle(this);"
									<c:if test="${search.item_type == 0}">checked</c:if>> 
									<label class="btn btn-outline-primary" for="btnradio_parts">부품</label> 
								<input type="radio" class="btn-check" name="item_type" value="1" id="btnradio_product" onchange="inventoryTypeToggle(this);"
									<c:if test="${search.item_type == 1}">checked</c:if>> 
									<label class="btn btn-outline-primary" for="btnradio_product">제품</label>
							</div>
						</div>

						<div class="col d-flex flex-wrap justify-content-end align-items-center gap-2">
							<!-- 번호 -->
							<div class="col-auto">
								<div class="input-group input-group-sm">
									<span class="input-group-text">${item_type } 번호</span> <input type="text" name="item_no_text" class="form-control"
										placeholder="${item_type } 번호 조회" value="${search.item_no_text}">
								</div>
							</div>
							<!-- 분류 -->
							<div class="col-auto">
								<div class="input-group input-group-sm">
									<span class="input-group-text">${item_type } 분류</span>
									<select id="item_status" name="item_status_select" class="form-select">
										<option value="999">전체</option>
									</select>
								</div>
							</div>
							<!-- 명 -->
							<div class="col-auto">
								<div class="input-group input-group-sm">
									<span class="input-group-text">${item_type } 명</span> <input type="text" name="item_name_text" class="form-control"
										placeholder="${item_type } 명 조회" value="${search.item_name_text}">
								</div>
							</div>
							<!-- 검색 버튼 -->
							<div class="col-auto">
								<button type="submit" class="btn btn-primary btn-sm">검색</button>
							</div>
						</div>
					</form>
					<!-- 검색 폼 마지막 -->
					<!-- List 테이블 시작 -->
					<div class="table-responsive">
						<table class="table table-bordered align-middle">
							<thead class="table-light">
								<tr>
									<th style="white-space: nowrap;">#</th>
									<th style="white-space: nowrap;">${item_type } 번호</th>
									<th style="min-width: 115px; white-space: nowrap;">${item_type } 분류</th>
									<th style="white-space: nowrap;">${item_type } 명</th>
									<th style="white-space: nowrap;">수량</th>
									<th style="display: none;">적정 수량</th>
									<th style="display: none;">편차</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="realInventory" items="${realInventoryList}" varStatus="index">
									<tr>
										<td>${(page.currentPage - 1) * page.rowPage + index.index + 1}</td>
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
					
						<!-- 페이징에서 사용하는 경로 변수 -->
						<c:set var="pagingPath" value="${pageContext.request.contextPath}/inventory?item_type=${search.item_type}"/>
						<!-- 검색 조건 추가 -->
						<c:if test="${not empty search.item_no_text}">
							<c:set var="pagingPath" value="${pagingPath}&item_no_text=${search.item_no_text}" />
						</c:if>
						<c:if test="${search.item_status_select != 999}">
							<c:set var="pagingPath" value="${pagingPath}&item_status_select=${search.item_status_select}" />
						</c:if>
						<c:if test="${not empty search.item_name_text}">
							<c:set var="pagingPath" value="${pagingPath}&item_name_text=${search.item_name_text}" />
						</c:if>

						<nav aria-label="Page navigation" class="mt-3">
							<ul class="pagination pagination-sm justify-content-center">
								<!-- 이전 블록/페이지 -->
								<li class="page-item ${page.startPage == 1 ? 'disabled' : ''}"><a class="page-link"
									href="${pagingPath}&currentPage=${page.startPage-1}" aria-label="Previous">‹</a></li>

								<!-- 페이지 번호들 -->
								<c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
									<li class="page-item ${page.currentPage == p ? 'active' : ''}"><a class="page-link"
										href="${pagingPath}&currentPage=${p}">${p}</a></li>
								</c:forEach>

								<!-- 다음 블록/페이지 -->
								<li class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}"><a class="page-link"
									href="${pagingPath}&currentPage=${page.endPage+1}" aria-label="Next">›</a></li>
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
</body>
</html>