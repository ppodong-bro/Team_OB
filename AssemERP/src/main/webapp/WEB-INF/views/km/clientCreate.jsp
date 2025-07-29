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
			<div id="contents">
				<div class="container px-3 py-4">
					<div class="card shadow-sm border-1px bg-white col-md-6 mx-auto">
						<div class="card-header shadow-sm border-bottom bg-light ">
							<h5 class="mb-0">거래처 등록</h5>
						</div>

						<div class="card-body px-4 py-3">
							<form method="post" action="/client/insert">
								<!-- 거래처 유형 -->
								<div class="mb-3">
									<label for="clientType" class="form-label">거래처 유형</label> <select
										class="form-select form-select-sm w-auto" id="clientType"
										name="clientType" required>
										<option value="">선택</option>
										<option value="소매">소매</option>
										<option value="도매">도매</option>
										<option value="공장">공장</option>
									</select>
								</div>


								<!-- 거래처명 -->
								<div class="mb-3">
									<label for="clientName" class="form-label">거래처명</label> <input
										type="text" class="form-control form-control-sm"
										id="clientName" name="clientName" required>
								</div>

								<!-- 주소 -->
								<div class="mb-3">
									<label for="clientAddress" class="form-label">주소</label> <input
										type="text" class="form-control form-control-sm"
										id="clientAddress" name="clientAddress">
								</div>

								<!-- 이메일 -->
								<div class="mb-3">
									<label for="clientEmail" class="form-label">이메일</label> <input
										type="email" class="form-control form-control-sm"
										id="clientEmail" name="clientEmail">
								</div>

								<!-- 담당자 -->
								<div class="mb-3">
									<label for="clientManager" class="form-label">거래처 담당자</label> <input
										type="text" class="form-control form-control-sm"
										id="clientManager" name="clientManager">
								</div>
								<!-- 담당자 -->
								<div class="mb-3">
									<label for="clientType" class="form-label">담당자</label> <select
										class="form-select form-select-sm w-auto" id="clientType"
										name="clientType" required>
										<option value="">선택</option>
										<option value="소매">소매</option>
										<option value="도매">도매</option>
										<option value="공장">공장</option>
									</select>
								</div>



								<!-- 상태 -->
								<div class="mb-3">
									<label for="clientStatus" class="form-label">상태</label> <select
										class="form-select form-select-sm w-auto" id="clientStatus"
										name="clientStatus">
										<option value="">선택</option>
										<option value="0">요청</option>
										<option value="1">승인</option>
										<option value="2">완료</option>
										<option value="3">마감</option>
									</select>
								</div>


								<div class="text-end mt-4 pb-1 d-flex justify-content-end gap-2">
									<!-- 취소 버튼 (예: 목록 페이지 이동) -->

									<!-- 등록 버튼 -->
									<button type="submit"
										class="btn btn-outline-primary btn-sm px-4">등록</button>

									<a href="/business/clientStartList"
										class="btn btn-outline-danger btn-sm px-4">취소</a>


									<!-- 초기화 버튼 -->
									<button type="reset"
										class="btn btn-outline-secondary btn-sm px-4">초기화</button>

								</div>

							</form>
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
