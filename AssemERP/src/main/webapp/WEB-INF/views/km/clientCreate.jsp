<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>거래처 등록</title>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css'/>" />
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #0d6efd;
	color: white;
}

.required-field::after {
	content: " *";
	color: red;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
	<div id="layout">
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>

		<div id="main-area">
			<jsp:include page="/header.jsp" />

			<div id="contents">
				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<!-- 카드 헤더: 좌측 검정 '목록' + 중앙 타이틀 -->
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<a href="<c:url value='/client/list'/>"
								class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>거래처 등록
							</h4>
							<div style="width: 90px;"></div>
						</div>

						<div class="card-body p-4">
							<form id="clientCreateForm" method="post"
								action="<c:url value='/client/create'/>">
								<!-- 기본 정보 -->
								<section aria-labelledby="client-create-title" class="info-card"
									aria-label="거래처 기본 정보">
									<div id="client-create-title" class="info-card-title">기본
										정보</div>

									<div class="info-grid">
										<!-- 담당 직원 -->
										<div class="field">
											<div class="field-label">
												담당 직원 <span class="text-danger">*</span>
											</div>

											<div class="input-group input-group-sm"
												style="max-width: 460px;">
												<!-- 서버로 제출되는 값 -->
												<input type="hidden" id="empNo" name="empDTO.empNo" required />
												<!-- 표시용 -->
												<input type="text" id="empName"
													class="form-control form-control-sm" placeholder="직원 선택"
													readonly />
												<button type="button" class="btn btn-outline-secondary"
													onclick="openEmpPopup()">조회</button>

											</div>
										</div>

										<!-- 거래처명 -->
										<div class="field">
											<div class="field-label">
												거래처명 <span class="text-danger">*</span>
											</div>

											<input type="text" class="form-control form-control-sm"
												name="client_Name" required />

										</div>

										<!-- 거래처 유형 -->
										<div class="field">
											<div class="field-label">
												거래처 유형 <span class="text-danger">*</span>
											</div>

											<select class="form-select form-select-sm w-auto"
												name="client_Gubun" required>
												<option value="">선택</option>
												<option value="0">구매처</option>
												<option value="1">판매처</option>
											</select>

										</div>

										<!-- 주소 -->
										<div class="field">
											<div class="field-label">주소</div>

											<input type="text" class="form-control form-control-sm"
												name="client_Address" />

										</div>

										<!-- 이메일 -->
										<div class="field">
											<div class="field-label">이메일</div>

											<input type="email" class="form-control form-control-sm"
												name="client_Email" />

										</div>

										<!-- 거래처 전화번호 -->
										<div class="field">
											<div class="field-label">거래처 전화번호</div>

											<input type="text" class="form-control form-control-sm"
												name="client_Tel" />

										</div>

										<!-- 거래처 담당자 -->
										<div class="field">
											<div class="field-label">거래처 담당자</div>

											<input type="text" class="form-control form-control-sm"
												name="client_Man" />

										</div>
									</div>
								</section>

								<!-- 숨김 필드 -->
								<input type="hidden" name="del_Status" value="0" />

								<!-- 액션 버튼 -->
								<%-- 	<div class="text-end mt-4 d-flex justify-content-end gap-2">
									<a href="<c:url value='/client/list'/>"
										class="btn btn-outline-secondary btn-sm px-4">취소</a>
									<button type="submit" class="btn btn-primary btn-sm px-4">등록</button>
								</div> --%>
								<div class="row mt-4 g-2">
									<!-- 취소: 링크 -->
									<div class="col-md-4 d-grid">
										<a href="<c:url value='/client/list'/>"
											class="btn btn-outline-secondary btn-sm px-4" role="button">
											<i class="bi bi-x-circle me-2"></i>취소
										</a>
									</div>

									<!-- 수정: 폼 제출 -->
									<div class="col-md-8 d-grid">
										<button type="submit" id="modifyBtn"
											class="btn btn-primary btn-sm px-4">
											<i class="bi bi-check-lg me-2"></i>등록
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>

			<!-- 푸터 및 JS -->
			<jsp:include page="/foot.jsp" />
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		</div>
	</div>

	<script>
		// 팝업 열기
		function openEmpPopup() {
			window.open('<c:url value="/client/empPopup"/>?empName=',
					'empPopup', 'width=1800,height=600,scrollbars=yes');
		}
		// 팝업에서 호출하는 콜백
		function fillEmp(empNo, empName) {
			document.getElementById('empNo').value = empNo;
			document.getElementById('empName').value = empName;
		}
		window.fillEmp = fillEmp;

		// 제출 전 검증: 담당 직원 선택 확인
		document
				.getElementById('clientCreateForm')
				.addEventListener(
						'submit',
						function(e) {
							const empNo = document.getElementById('empNo').value
									.trim();
							if (!empNo) {
								alert('담당 직원을 선택하세요.');
								e.preventDefault();
							}
						});
	</script>
</body>
</html>
