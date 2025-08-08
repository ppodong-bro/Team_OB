<%@ page contentType="text/html; charset=UTF-8"%>
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
			<div class="container px-3 py-4">
				<div class="card shadow-sm bg-white col-md-6 mx-auto">
					<div class="card-header bg-light">
						<h5 class="mb-0">거래처 등록</h5>
					</div>
					<div class="card-body">
						<form method="post"
							action="${pageContext.request.contextPath}/client/create">

							<!-- 직원 번호 -->
							<div class="mb-3">
								<label for="empNo" class="form-label">직원 번호</label> <input
									type="number" class="form-control form-control-sm w-auto"
									id="empNo" name="empDTO.empNo" required>
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
									type="text" class="form-control form-control-sm" id="clientMan"
									name="client_Man">
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

			<!-- 이곳에 자신의 코드를 작성하세요 -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>


	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
</body>
</html>
