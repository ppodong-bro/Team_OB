<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- ���� CSS -->
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
	<!-- ��ü ���̾ƿ� -->
	<div id="layout">
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>
		<div id="main-area">
			<jsp:include page="/header.jsp" />

			<!-- �̰��� �ڽ��� �ڵ带 �ۼ��ϼ��� -->
			<div id="contents">
				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<div class="card-header d-flex justify-content-between align-items-center position-relative">
							<a href="/emp/empListForm" class="btn btn-outline-light btn-sm"> <i class="bi bi-list-ul me-1"></i> ���
							</a>
							<!-- 
							position-absolute : ��ü�� �θ� ��ġ�� �������� ������ ������ �����̵���
							start-50 : 50%��ġ���� �����ϵ���
							translate-middle-x : ��ü�� x�߽��� ����� ��ġ�ϵ��� -->
							<h4 class="card-title mb-0 position-absolute start-50 translate-middle-x">
								<i class="bi bi-pencil-square me-2"></i>��� ����
							</h4>
						</div>
						<div class="card-body p-4">
							<!-- ȭ�鿡�� ��ü������ ����ϴ� ��ǰ/��ǰ ���� ���� -->
							<c:set var="item_type" value="${inventory.item_type == 0 ? '��ǰ' : '��ǰ'}" />

							<form id="updateForm" action="/inventory/adjust" method="post" class="needs-validation" novalidate>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">��� ����</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-box"></i></span> <input type="text" class="form-control" id="item_type" name="item_type"
												value="${item_type }" disabled>
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">${item_type } ��ȣ</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-hash"></i></span> <input type="text" class="form-control" id="item_no" name="item_no"
												value="${inventory.item_no }" disabled>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">${item_type } ����</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-grid"></i></span> <input type="text" class="form-control" id="item_status"
												name="item_status" value="${inventory.item_status }" disabled>
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">${item_type } ��</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-tag"></i></span> <input type="text" class="form-control" id="item_name" name="item_name"
												value="${inventory.item_name }" disabled>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">���� ����</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-stack"></i></span> <input type="text" class="form-control" id="item_cnt" name="item_cnt"
												value="${inventory.cnt }" disabled>
										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="item_type" class="form-label">���� ����</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-pencil-square"></i></span> <input type="text" class="form-control" id="item_adjustcnt"
												name="item_adjustcnt" value="${inventory.cnt }">
										</div>
									</div>
								</div>
								<div class="row mt-4 g-2">
									<div class="d-grid">
										<button type="submit" class="btn btn-success">
											<i class="bi bi-check-lg me-2"></i>��� ����
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- �̰��� �ڽ��� �ڵ带 �ۼ��ϼ��� -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>

	<!-- ��Ʈ��Ʈ�� CDN -->
	<jsp:include page="/common_cdn.jsp" />
</body>
</html>