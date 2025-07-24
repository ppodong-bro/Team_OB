<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>거래처 관리</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
:root { --header-h: 60px; }               /* header 높이 맞춰 주세요 */
body.has-fixed-header { padding-top: calc(var(--header-h) + 16px); }

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
} /* 요청 */
</style>
</head>
<body class="has-fixed-header">
	<%@ include file="../header.jsp"%>
	<%@ include file="../side.jsp" %>
	<div class="container mt-4">
		<h2 class="mb-4 mt-5" >거래처 관리</h2>

		<!-- 검색 폼 시작 -->
		<form class="row gx-2 gy-1 align-items-end mb-4">
			<div class="col-auto">
				<label for="searchName" class="form-label small mb-1">거래처명</label> <input
					type="text" id="searchName" name="name"
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
				<label for="type" class="form-label small mb-1">유형</label> <select
					id="type" name="type" class="form-select form-select-sm">
					<option value="">전체</option>
					<option value="소매">소매</option>
					<option value="도매">도매</option>
					<option value="공장">공장</option>
				</select>
			</div>
			<div class="col-auto">
				<label for="status" class="form-label small mb-1">상태</label> <select
					id="status" name="status" class="form-select form-select-sm">
					<option value="">전체</option>
					<option value="0">요청</option>
					<option value="1">승인</option>
					<option value="2">완료</option>
					<option value="3">마감</option>
				</select>
			</div>
			<div class="col-auto">
				<button type="submit" class="btn btn-primary btn-sm w-100">
					조회</button>
			</div>
		</form>
		<!-- 검색 폼 마지막 -->

		<!-- List 테이블 시작 -->
		<div class="table-responsive">
			<table class="table table-bordered align-middle">
				<thead class="table-light">
					<tr>
						<th>#</th>
						<th>거래처번호</th>
						<th>거래처명</th>
						<th>유형</th>
						<th>주소</th>
						<th>이메일</th>
						<th>담당자</th>
						<th class="text-center">상태</th>
						<th class="text-center">수정/삭제</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>1001</td>
						<td>롯데마트</td>
						<td>소매</td>
						<td>서울특별시 중구 을지로 100</td>
						<td>contact@lottemart.co.kr</td>
						<td>김경민</td>
						<td class="text-center"><span class="status-text"
							data-status="0"><span class="dot"></span>요청</span></td>
						<td class="text-center">
							<button type="button" class="btn btn-sm btn-outline-primary me-1">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>
						</td>
					</tr>
					<tr>
						<td>2</td>
						<td>1002</td>
						<td>신세계백화점</td>
						<td>도매</td>
						<td>서울특별시 강남구 압구정로 343</td>
						<td>info@shinsegae.com</td>
						<td>김모씨</td>
						<td class="text-center"><span class="status-text"
							data-status="1"><span class="dot"></span>승인</span></td>
						</td>
						<td class="text-center">
							<button type="button" class="btn btn-sm btn-outline-primary me-1">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>
						</td>
					</tr>
					<tr>
						<td>3</td>
						<td>1003</td>
						<td>홈플러스</td>
						<td>공장</td>
						<td>경기도 김포시 김포대로 159</td>
						<td>support@homeplus.co.kr</td>
						<td>박철수</td>
						<td class="text-center"><span class="status-text"
							data-status="2"><span class="dot"></span>완료</span></td>
						</td>
						<td class="text-center">
							<button type="button" class="btn btn-sm btn-outline-primary me-1">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>
						</td>
					</tr>
					<tr>
						<td>4</td>
						<td>1004</td>
						<td>홈플러스2</td>
						<td>공장2</td>
						<td>경기도 김포시 김포대로 159</td>
						<td>support@homeplus.co.kr</td>
						<td>박철수</td>
						<td class="text-center"><span class="status-text"
							data-status="3"><span class="dot"></span>마감</span></td>
						</td>
						<td class="text-center">
							<button type="button" class="btn btn-sm btn-outline-primary me-1">수정</button>
							<button type="button" class="btn btn-sm btn-outline-danger">삭제</button>
						</td>
					</tr>
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
	<%@ include file="../foot.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>