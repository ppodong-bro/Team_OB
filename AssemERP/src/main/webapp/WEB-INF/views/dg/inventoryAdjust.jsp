<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #198754;
	color: white;
} /* Green theme for editing */
.required-field::after {
	content: " *";
	color: red;
}
</style>
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
				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<div class="card-header d-flex justify-content-between align-items-center position-relative">
							<a href="/emp/empListForm" class="btn btn-outline-light btn-sm"> <i class="bi bi-list-ul me-1"></i> 목록
							</a>
							<!-- 
							position-absolute : 객체가 부모 위치를 기준으로 잡으며 개별로 움직이도록
							start-50 : 50%위치에서 시작하도록
							translate-middle-x : 객체의 x중심이 가운데에 위치하도록 -->
							<h4 class="card-title mb-0 position-absolute start-50 translate-middle-x">
								<i class="bi bi-pencil-square me-2"></i>재고 수정
							</h4>
						</div>
						<div class="card-body p-4">
							<!-- 화면에서 전체적으로 사용하는 부품/제품 구분 변수 -->
							<c:set var="item_type" value="${inventory.item_type == 0 ? '부품' : '제품'}" />

							<form id="updateForm" action="/inventory/adjust" method="post" class="needs-validation" novalidate>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">재고 구분</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-box"></i></span> <input type="text" class="form-control" id="item_type" name="item_type"
												value="${item_type }" disabled>
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">${item_type } 번호</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-hash"></i></span> <input type="text" class="form-control" id="item_no" name="item_no"
												value="${inventory.item_no }" disabled>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">${item_type } 구분</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-grid"></i></span> <input type="text" class="form-control" id="item_status"
												name="item_status" value="${inventory.item_status }" disabled>
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">${item_type } 명</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-tag"></i></span> <input type="text" class="form-control" id="item_name" name="item_name"
												value="${inventory.item_name }" disabled>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">현재 수량</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-stack"></i></span> <input type="text" class="form-control" id="item_cnt" name="item_cnt"
												value="${inventory.cnt }" disabled>
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">수정 수량</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-pencil-square"></i></span> <input type="text" class="form-control" id="item_adjustcnt"
												name="item_adjustcnt" value="${inventory.cnt }">
										</div>
									</div>
								</div>
								<div class="row mt-4 g-2">
									<div class="d-grid">
										<button type="submit" class="btn btn-success">
											<i class="bi bi-check-lg me-2"></i>재고 수정
										</button>
									</div>
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