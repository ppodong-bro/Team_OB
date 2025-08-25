<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>사원 선택</title>
<jsp:include page="/common.jsp" />
<style>
body {
	padding: 12px
}

.table-sm td, .table-sm th {
	padding: .35rem .5rem;
}

/* 세로선만 표시 (Bootstrap 5 기준) */ .table.table-vert-only>:not(caption)>*>*
	{
	border-left: 1px solid var(--bs-table-border-color);
	border-right: 1px solid var(--bs-table-border-color);
	border-top: 0; /* 가로선 제거 */
	border-bottom: 0; /* 가로선 제거 */
}

.table thead th {
	border-bottom-width: 2px !important;
}
/* 바깥쪽 좌우 테두리(선택) */
.table.table-vert-only {
	border-left: 1px solid var(--bs-table-border-color);
	border-right: 1px solid var(--bs-table-border-color);
}
</style>
</head>
<body>
	<h6 class="mb-3">사원 선택</h6>

	<!-- (옵션) 간단 검색 폼 -->
	<form method="get" class="mb-2">
		<div class="input-group input-group-sm">
			<input type="text" class="form-control" name="empName"
				value="${param.empName}" placeholder="사원번호/이름 검색" />
			<button class="btn btn-outline-secondary" type="submit">검색</button>
		</div>
	</form>

	<table class="table table-sm table-hover align-middle table-bordered">
		<thead class="table-light">
			<tr>
				<th style="width: 110px" class="text-center">사원번호</th>
				<th class="text-center">사원명</th>
				<th class="text-center">이메일</th>
				<th class="text-center">부서명</th>
				<th style="width: 90px" class="text-center">선택</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="e" items="${empList}">
				<tr>
					<td class="text-center">${e.empNo}</td>
					<td class="text-center">${fn:escapeXml(e.empName)}</td>
					<td class="text-center">${fn:escapeXml(e.email)}</td>
					<td class="text-center">${fn:escapeXml(DeptName)}</td>
					<td class="text-center">
						<button type="button" class="btn btn-primary btn-sm selectBtn"
							data-emp-no="${e.empNo}"
							data-emp-name="${fn:escapeXml(e.empName)}">선택</button>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty empList}">
				<tr>
					<td colspan="3" class="text-center text-muted">결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<script>
		document.addEventListener('click', function(e) {
			if (!e.target.classList.contains('selectBtn'))
				return;
			const no = e.target.dataset.empNo;
			const name = e.target.dataset.empName;

			if (window.opener && !window.opener.closed
					&& typeof window.opener.fillEmp === 'function') {
				window.opener.fillEmp(no, name); // 부모 채우기
			}
			window.close();
		});
	</script>
</body>
</html>