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
<style>
/* 기본 상태 (선택되지 않은 부품/제품)의 폰트 색상을 회색으로 */
.btn-outline-primary {
	color: #6c757d; /* 짙은 회색 */
	border-color: #0d6efd; /* 원래 부트스트랩 primary 색상 테두리 유지 */
}
</style>
<script type="text/javascript">
	// 부품,제품 구분
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

				<div class="container-fluid">
					<div class="card shadow-sm">
						<div class="card-header d-flex justify-content-between align-items-center">
							<h4 class="card-title mb-0">
								<!-- me-2 : margin-end: 0.5rem -->
								<i class="bi bi-box-seam me-2"></i>재고 관리
							</h4>
						</div>
						<div class="card-body">
							<!-- 검색 폼 시작 -->
							<form method="get" action="inventory" class="row gx-2 gy-1 align-items-center mb-4">
								<!-- 부품/제품 -->
								<div class="col-auto">
									<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
										<input type="radio" class="btn-check" name="item_type" value="0" id="btnradio_parts" onchange="inventoryTypeToggle(this);"
											<c:if test="${search.item_type == 0}">checked</c:if>> <label class="btn btn-outline-primary" for="btnradio_parts">부품</label> <input
											type="radio" class="btn-check" name="item_type" value="1" id="btnradio_product" onchange="inventoryTypeToggle(this);"
											<c:if test="${search.item_type == 1}">checked</c:if>> <label class="btn btn-outline-primary" for="btnradio_product">제품</label>
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
									<!-- 구분 -->
									<div class="col-auto">
										<div class="input-group input-group-sm">
											<span class="input-group-text">${item_type } 구분</span> <select id="item_status" name="item_status_select" class="form-select">
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
											<th class="text-center" style="white-space: nowrap;">${item_type }번호</th>
											<th class="text-center" style="min-width: 115px; white-space: nowrap;">${item_type }구분</th>
											<th class="text-center" style="white-space: nowrap;">${item_type }명</th>
											<th class="text-center" style="white-space: nowrap;">수량</th>
											<th class="text-center" style="white-space: nowrap;">수정</th>
											<th class="text-center" style="display: none;">적정 수량</th>
											<th class="text-center" style="display: none;">편차</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="realInventory" items="${realInventoryList}" varStatus="index">
											<tr>
												<td class="text-center">${(paging.currentPage - 1) * paging.rowPage + index.index + 1}</td>
												<td class="text-center">${realInventory.item_no}</td>
												<td class="text-center">${realInventory.item_status}</td>
												<td>${realInventory.item_name}</td>
												<td class="text-center">${realInventory.cnt}</td>
												<td class="text-center">
					                                <a href="${pageContext.request.contextPath}/inventory/adjust?item_type=${search.item_type}&item_no=${realInventory.item_no}" class="btn btn-sm btn-outline-success">
					                                    <i class="bi bi-pencil-square"></i> 수정
					                                </a>
				                                </td>
												<td class="text-center" style="display: none;">${realInventory.proper_cnt}</td>
												<td class="text-center" style="display: none;">${realInventory.diff_cnt}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<!-- List 테이블 마지막 -->
							</div>
						</div>
						<!-- 페이징에서 사용하는 경로 변수 -->
						<c:set var="pagingPath" value="${pageContext.request.contextPath}/inventory?item_type=${search.item_type}" />
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

						<div class="card-footer d-flex justify-content-center">
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