<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS 및 헤더 포함 (공통 레이아웃/스타일) -->
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css' />" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>거래처 상세</title>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #C0C0C0;
	color: white;
}

.required-field::after {
	content: " *";
	color: red;
}

.image-box {
	width: auto; /* 원하는 가로 크기 */
	height: 300px; /* 원하는 세로 크기 */
	overflow: hidden;
}

.image-box img {
	width: 100%;
	height: 100%;
	display: block; /* 여백 제거 */
}
.parent-container {
  display: flex;
  flex-direction: column;
  gap: 15px; /* 항목들 사이 간격을 균일하게 12px 설정 */
}
</style>
</head>
<body>
	<div id="layout">
		<!-- 사이드 내비게이션 -->
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>

		<div id="main-area">
			<!-- 상단 헤더 -->
			<jsp:include page="/header.jsp" />

			<!-- 컨텐츠 -->
			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty success}">
				<div class="alert alert-success">${success}</div>
			</c:if>
			<div id="contents">

				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<!-- 카드 헤더: 좌측 검정 '목록' 버튼 + 중앙 타이틀 -->
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<a href="<c:url value='/client/list'/>"
								class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>거래처 상세
							</h4>
							<div style="width: 90px;"></div>
						</div>

						<div class="card-body p-4">
							<!-- 거래처 정보 -->
							<section aria-labelledby="client-info-title" class="info-card"
								aria-label="거래처 정보">
								<div id="client-info-title" class="info-card-title">거래처 정보</div>

								<div class="info-grid">
									<!-- 거래처 번호 -->
									<div class="field">
										<div class="field-label">거래처 번호</div>
										<div class="field-box">
											<span><c:out value="${clientDto.client_No}" /></span>
										</div>
									</div>

									<!-- 담당자 이름(내부) -->
									<div class="field">
										<div class="field-label">담당자 이름</div>
										<div class="field-box">
											<span><c:out value="${clientDto.empDTO.empName}" /></span>
										</div>
									</div>

									<!-- 거래처 유형 -->
									<div class="field">
										<div class="field-label">거래처 유형</div>
										<div class="field-box">
											<span><c:out value="${clientDto.context}" /></span>
										</div>
									</div>

									<!-- 거래처명 -->
									<div class="field">
										<div class="field-label">거래처명</div>
										<div class="field-box">
											<span><c:out value="${clientDto.client_Name}" /></span>
										</div>
									</div>

									<!-- 주소 -->
									<div class="field">
										<div class="field-label">주소</div>
										<div class="field-box">
											<span><c:out value="${clientDto.client_Address}" /></span>
										</div>
									</div>

									<!-- 이메일 (수주 상세와 동일하게 @ 보조 표기) -->
									<div class="field">
										<div class="field-label">이메일</div>
										<div class="field-box">
											 <span><c:out
													value="${clientDto.client_Email}" /></span>
										</div>
									</div>

									<!-- 거래처 전화번호 -->
									<div class="field">
										<div class="field-label">거래처 전화번호</div>
										<div class="field-box">
											<span><c:out value="${clientDto.client_Tel}" /></span>
										</div>
									</div>

									<!-- 거래처 담당자 -->
									<div class="field">
										<div class="field-label">거래처 담당자</div>
										<div class="field-box">
											<span><c:out value="${clientDto.client_Man}" /></span>
										</div>
									</div>

									<!-- 최근 수정 일자 (있을 때만) -->
									<c:if test="${not empty clientDto.modify_Date}">
										<div class="field">
											<div class="field-label">최근 수정 일자</div>
											<div class="field-box">
												<!-- LocalDateTime 문자열/타입 모두 대응: 문자열이면 substring, 타입이면 컨트롤러에서 String으로 넘겨주는 걸 권장 -->
												<span>${fn:substring(clientDto.modify_Date, 0, 10)}</span>
											</div>
										</div>
									</c:if>

									<!-- 등록 일자 -->
									<div class="field">
										<div class="field-label">등록 일자</div>
										<div class="field-box">
											<span>${fn:substring(clientDto.in_Date, 0, 10)}</span>
										</div>
									</div>
								</div>
							</section>
							<div class="row mt-4 g-2">
								<!-- 삭제 (POST) -->
								<div class="col-md-4 d-grid">
									<form id="deleteForm" class="m-0" method="post"
										action="<c:url value='/client/delete'/>"
										onsubmit="return confirm('거래처를 삭제 하시겠습니까?');">
										<input type="hidden" name="client_No"
											value="${clientDto.client_No}" /> <input type="hidden"
											name="${_csrf.parameterName}" value="${_csrf.token}" />
										<button type="submit" id="deleteBtn"
											class="btn btn-danger btn-sm px-4 w-100">
											<i class="bi bi-trash me-2"></i>삭제
										</button>
									</form>
								</div>

								<!-- 정보 수정 (GET 이동) -->
								<div class="col-md-8 d-grid">
									<button type="button" id="moditfyBtn"
										class="btn btn-success btn-sm px-4 w-100"
										onclick="if (confirm('거래처를 수정 하시겠습니까?')) {location.href = '<c:url value='/client/modifyStart?client_No=${clientDto.client_No}'/>';}">
										<i class="bi bi-check-lg me-2"></i>거래처 수정
									</button>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 푸터 -->
			<jsp:include page="/foot.jsp" />
			<!-- 부트스트랩 JS -->
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		</div>
	</div>
</body>
</html>
