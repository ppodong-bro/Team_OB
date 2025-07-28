<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ERP</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
:root {
	--header-h: 60px; /* header 높이 맞춰 주세요 */
}

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
</style>
<script type="text/javascript">
// 월마감 진행
function confirmMonthCloseClick() {
    /* fetch('/api/month/close', {  // 컨트롤러 엔드포인트 URL
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            // CSRF 토큰이 필요한 경우 추가
            // 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        // 필요한 데이터가 있다면 JSON으로 전송
        body: JSON.stringify({
            yearMonth: '202507'  // 필요한 데이터 (예: 년월)
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('서버 응답 오류');
        }
        return response.json();
    })
    .then(data => {
        // 성공 시 처리
        alert('월 마감 처리가 완료되었습니다.');
        
        // 모달 닫기
        const modal = bootstrap.Modal.getInstance(document.getElementById('monthCloseModal'));
        modal.hide();
        
        // 필요하다면 페이지 새로고침
        // location.reload();
    })
    .catch(error => {
        // 오류 처리
        console.error('월 마감 처리 중 오류 발생:', error);
        alert('월 마감 처리 중 오류가 발생했습니다.');
    }); */
}
</script>
</head>
<body class="has-fixed-header">
	<%@ include file="../header.jsp"%>
	<%@ include file="../side.jsp"%>
	<div class="container mt-4">
		<h2 class="mb-4 mt-5">재고 관리</h2>

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
			<div class="col-auto">
				<button type="button" class="btn btn-primary btn-sm w-100"
					data-bs-toggle="modal" data-bs-target="#monthCloseModal">
					월마감</button>
			</div>
		</form>
		<!-- 검색 폼 마지막 -->

		<!-- List 테이블 시작 -->
		<div class="table-responsive">
			<table class="table table-bordered align-middle">
				<thead class="table-light">
					<tr>
						<th>번호</th>
						<th>명</th>
						<th>수량</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="month_Inventory" items="${month_Inventories }"
						varStatus="status">
						<tr>
							<td>${month_Inventory.month_Inventory_ID.item_status }</td>
							<td>${month_Inventory.month_Inventory_ID.item_no }</td>
							<td>${month_Inventory.cnt }</td>
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

		<!-- 모달 창 코드 -->
		<div class="modal fade" id="monthCloseModal" tabindex="-1"
			aria-labelledby="monthCloseModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="monthCloseModalLabel">월마감 확인</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">정말 월마감 처리하시겠습니까?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary"
							id="confirmMonthClose" onclick="confirmMonthCloseClick">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../foot.jsp"%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>