<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>Insert title here</title>
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
						<%------------------------------------------------------------------------------
				                		1. Card Header 정중앙
				                 ------------------------------------------------------------------------------%>
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<%------------------------------------------------------------------------------
				                		1-1. 목록 버튼 스타일
				                 	------------------------------------------------------------------------------%>
							<a href="/sales/list" class="btn btn-outline-light btn-sm">
								<i class="bi bi-list-ul me-1"></i> 목록
							</a>
							<%------------------------------------------------------------------------------
				                		1-2. 타이틀 중앙 정렬 스타일
				                 	------------------------------------------------------------------------------%>
							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>거래처 상세
							</h4>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body p-4">
							<form>
								<!-- 거래처 번호 -->
								<div class="mb-3">
									<label class="form-label">거래처 번호</label> <input type="text"
										readonly class="form-control form-control-sm w-auto"
										value="${clientDto.client_No}" />
								</div>

								<!-- 직원 번호 -->
								<div class="mb-3">
									<label class="form-label">담당자 이름</label> <input type="text"
										readonly class="form-control form-control-sm w-auto"
										<%-- value="${clientDto.emp_No}" --%> 
										value="${clientDto.empDTO.empName}"/>
								</div>

								<!-- 거래처 유형 -->
								<div class="mb-3">

									<label class="form-label">거래처 유형</label> <input type="text"
										readonly class="form-control form-control-sm w-auto"
										value="${clientDto.client_Gubun == 0 ? '구매' : '판매'}" />

								</div>

								<!-- 거래처명 -->
								<div class="mb-3">
									<label class="form-label">거래처명</label> <input type="text"
										readonly class="form-control form-control-sm"
										value="${clientDto.client_Name}" />
								</div>

								<!-- 주소 -->
								<div class="mb-3">
									<label class="form-label">주소</label> <input type="text"
										readonly class="form-control form-control-sm"
										value="${clientDto.client_Address}" />
								</div>

								<!-- 이메일 -->
								<div class="mb-3">
									<label class="form-label">이메일</label> <input type="email"
										readonly class="form-control form-control-sm"
										value="${clientDto.client_Email}" />
								</div>
								
									<!-- 거래처전화번호 -->
								<div class="mb-3">
									<label class="form-label">거래처 전화번호</label> <input type="text"
										readonly class="form-control form-control-sm"
										value="${clientDto.client_Tel}" />
								</div>

								<!-- 거래처 담당자 -->
								<div class="mb-3">
									<label class="form-label">거래처 담당자</label> <input type="text"
										readonly class="form-control form-control-sm"
										value="${clientDto.client_Man}" />
								</div>

								<!-- 수정 일자 -->
								<c:if test="${not empty clientDto.modify_Date}">
									<!-- 수정 일자 -->
									<div class="mb-3">
										<label class="form-label">수정 일자</label> <input type="text"
											readonly class="form-control form-control-sm w-auto"
											value="${clientDto.modify_Date}" />
									</div>
								</c:if>

								<!-- 등록 일자 -->
								<div class="mb-3">
									<label class="form-label">등록 일자</label> <input type="text"
										readonly class="form-control form-control-sm w-auto"
										value="${clientDto.in_Date}" />
								</div>

								<!-- 버튼 그룹: 목록, 수정 -->
								<div class="text-end mt-4 d-flex justify-content-end gap-2">
									<a
										href="${pageContext.request.contextPath}/client/list"
										class="btn btn-outline-secondary btn-sm px-4">목록</a> <a
										href="${pageContext.request.contextPath}/client/modifyStart?client_No=${clientDto.client_No}"
										class="btn btn-outline-primary btn-sm px-4">수정</a>
								</div>

							</form>
						</div>
					</div>
				</div>
			</div>

			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


			<jsp:include page="/foot.jsp" />
		</div>
	</div>
</body>
</html>