<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부품관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
:root {
	--header-h: 60px;
} /* header 높이 맞춰 주세요 */
body.has-fixed-header {
	padding-top: calc(var(--header-h)+ 16px);
}

.status-text {
	display: inline-flex;
	align-items: center;
	font-size: 0.9rem;
	gap: 4px;
}

.status-text .dot {
	width: 8px;
	height: 8px;
	border-radius: 50%;
	display: inline-block;
}

/* 상태별 색상 */
.status-text[data-status="0"] .dot {
	background: #ffc107;
}
/* 상태별 색상 */
.status-text[data-status="1"] .dot {
	background: #66ff66;
}
/* 상태별 색상 */
.status-text[data-status="2"] .dot {
	background: #33bbff;
}
/* 상태별 색상 */
.status-text[data-status="3"] .dot {
	background: #bfbfbf;
}
/* 요청 */
#contents {
	margin-top: 70px;
	margin-left: 250px;
	margin-bottom: 60px;
	padding: 20px; /* 내부 여백 */
}
</style>
</head>
<body class="has-fixed-header">
	<%@ include file="../header.jsp"%>
	<%@ include file="../side.jsp"%>
	<div id="contents">
		<div class="container mt-4 ml-10">
			<div class="d-flex justify-content-between align-items-end mb-4">
				<h2 class="mb-0">부품관리</h2>

				<!-- 검색 폼 시작 -->
				<form class="row gx-2 gy-1 align-items-end ">
					<div class="col-auto">
						<label for="searchName" class="form-label small mb-1">부품명</label>
						<input type="text" id="searchName" name="name"
							class="form-control form-control-sm" placeholder="거래처명 검색">
					</div>
					<div class="col-auto">
						<label for="startDate" class="form-label small mb-1">시작일</label> <input
							type="date" id="startDate" name="startDate"
							class="form-control form-control-sm">
					</div>
					<div class="col-auto">
						<label for="endDate" class="form-label small mb-1">종료일</label> <input
							type="date" id="endDate" name="endDate"
							class="form-control form-control-sm">
					</div>
					<div class="col-auto">
						<label for="type" class="form-label small mb-1">부품유형</label> <select
							id="type" name="type" class="form-select form-select-sm">
							<option value="0">메인보드</option>
							<option value="1">CPU</option>
							<option value="2">GPU</option>
							<option value="3">메모리</option>
							<option value="4">파워</option>
							<option value="5">HDD</option>
							<option value="6">SSD</option>
							<option value="7">케이스</option>
							<option value="8">쿨러</option>
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
								<td>${partsDTO.parts_status}</td>
								<td>${partsDTO.manufacture}</td>
								<td>${partsDTO.registrar}</td>
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
						<!-- 이전 블록/페이지 -->
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true">‹</a></li>

						<!-- 페이지 번호들 -->
						<li class="page-item active"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item"><a class="page-link" href="#">4</a></li>
						<li class="page-item"><a class="page-link" href="#">5</a></li>

						<!-- 다음 블록/페이지 -->
						<li class="page-item"><a class="page-link" href="#">›</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<%@ include file="../foot.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>