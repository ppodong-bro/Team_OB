<%-- <%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>거래처 등록</title>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
</head>
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
				<!-- <div class="container px-4"> -->
				<!-- 기존영역 주석처리 -->
				<div class="container-fluid px-4">
					<!-- container-fluid 추가 -->
					<!-- <div class="row justify-content-center">
				        <div class="col-lg-8">-->
					<!-- 기존영역 주석처리 -->
					<div class="card shadow-sm">
						----------------------------------------------------------------------------
				                		1. Card Header 정중앙
				                 ----------------------------------------------------------------------------
						<div
							class="card-header d-flex justify-content-between align-items-center">
							----------------------------------------------------------------------------
				                		1-1. 목록 버튼 스타일
				                 	----------------------------------------------------------------------------
							<a href="/sales/list" class="btn btn-outline-dark btn-sm">
								<i class="bi bi-list-ul me-1"></i> 목록
							</a>
							----------------------------------------------------------------------------
				                		1-2. 타이틀 중앙 정렬 스타일
				                 	----------------------------------------------------------------------------
							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>거래처 등록
							</h4>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body">
							<form method="post"
								action="${pageContext.request.contextPath}/client/create">

								<!-- 직원 선택 -->
								<div class="mb-3">
									<label class="form-label">담당 직원</label>
									<div class="input-group input-group-sm">
										<!-- 서버로 제출되는 값 -->
										<input type="hidden"
											class="form-control form-control-sm w-auto" id="empNo"
											name="empDTO.empNo" placeholder="사원번호" readonly required />
										<input type="text" class="form-control form-control-sm"
											id="empName" placeholder="이름" readonly />
										<button type="button" class="btn btn-outline-secondary"
											onclick="openEmpPopup()">조회</button>
									</div>
								</div>

								<!-- 거래처명 -->
								<div class="mb-3">
									<label for="clientName" class="form-label">거래처명</label> <input
										type="text" class="form-control form-control-sm"
										id="clientName" name="client_Name" required>
								</div>

								<!-- 거래처 유형 -->
								<div class="mb-3">
									<label for="clientGubun" class="form-label">거래처 유형</label> <select
										class="form-select form-select-sm w-auto" id="clientGubun"
										name="client_Gubun" required>
										<option value="">선택</option>
										<option value="0">구매처</option>
										<option value="1">판매처</option>
									</select>
								</div>

								<!-- 주소 -->
								<div class="mb-3">
									<label for="clientAddress" class="form-label">주소</label> <input
										type="text" class="form-control form-control-sm"
										id="clientAddress" name="client_Address">
								</div>

								<!-- 이메일 -->
								<div class="mb-3">
									<label for="clientEmail" class="form-label">이메일</label> <input
										type="email" class="form-control form-control-sm"
										id="clientEmail" name="client_Email">
								</div>
								<!-- 거래처 전화번호 -->
								<div class="mb-3">
									<label for="clientTel" class="form-label">거래처 전화번호</label> <input
										type="text" class="form-control form-control-sm"
										id="clientTel" name="client_Tel">
								</div>

								<!-- 거래처 담당자 -->
								<div class="mb-3">
									<label for="clientMan" class="form-label">거래처 담당자</label> <input
										type="text" class="form-control form-control-sm"
										id="clientMan" name="client_Man">
								</div>

								<!-- 삭제 상태 (숨김) -->
								<input type="hidden" name="del_Status" value="0" />

								<!-- 제출 버튼 -->
								<div class="text-end mt-4">
									<button type="submit" class="btn btn-primary btn-sm px-4">
										등록</button>
									<a href="${pageContext.request.contextPath}/client/list"
										class="btn btn-outline-secondary btn-sm px-4"> 취소 </a>
								</div>

							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 이곳에 자신의 코드를 작성하세요 -->
			<!-- 부트스트랩 CDN -->
			<jsp:include page="/common_cdn.jsp" />
			<jsp:include page="/foot.jsp" />
		</div>
	</div>
	<script src="…bootstrap.js"></script>
	<script>
		// 팝업 열기
		function openEmpPopup() {
			window.open('${pageContext.request.contextPath}/client/empPopup?empName=',
					'empPopup', 'width=700,height=600,scrollbars=yes');
		}

		// 팝업에서 호출하는 콜백: 부모 폼 채우기
		function fillEmp(empNo, empName) {
			document.getElementById('empNo').value = empNo;
			document.getElementById('empName').value = empName;
			const h = document.getElementById('empNameHidden');
			if (h)
				h.value = empName;
		}
		// 전역에 노출 (팝업에서 window.opener.fillEmp 호출)
		window.fillEmp = fillEmp;
	</script>
</body>
</html>
 --%>

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
								class="btn btn-outline-dark btn-sm"> <i
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
								<div class="text-end mt-4 d-flex justify-content-end gap-2">
									<a href="<c:url value='/client/list'/>"
										class="btn btn-outline-secondary btn-sm px-4">취소</a>
									<button type="submit" class="btn btn-primary btn-sm px-4">등록</button>
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
					'empPopup', 'width=700,height=600,scrollbars=yes');
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
