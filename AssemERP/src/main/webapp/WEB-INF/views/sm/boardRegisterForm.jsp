<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>AssemERP - 공지사항 작성</title>
<style>
    body { background-color: #f8f9fa; }
    .card-header { background-color: #0d6efd; color: white; }
</style>
</head>
<!-- <body class="py-5"> -->
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
				                <div class="card-header d-flex justify-content-between align-items-center">
				                    <a href="/board/boardListForm" class="btn btn-outline-light btn-sm"><i class="bi bi-list-ul me-1"></i> 목록</a>
				                    <h4 class="card-title mb-0"><i class="bi bi-pencil-fill me-2"></i>공지사항 작성</h4>
				                    <div style="width: 90px;"></div>
				                </div>
				                <div class="card-body p-4">
				                    <form action="/board/boardSavePro" method="post">
				                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				                        
										<sec:authentication property="principal.account.empNo" var="loginEmpNo" />
										
										<input type="hidden" name="empNo" value="${loginEmpNo}">
				                        
				                        <div class="mb-3">
				                            <label for="title" class="form-label">제목</label>
				                            <input type="text" class="form-control" id="title" name="title" required>
				                        </div>
				
				                        <div class="mb-4">
				                            <label for="boardContent" class="form-label">내용</label>
				                            <textarea class="form-control" id="boardContent" name="boardContent" style="height: 250px" required></textarea>
				                        </div>
				                        
				                        <div class="row mt-4 g-2">
				                            <div class="col-6 d-grid">
				                                <button type="reset" class="btn btn-outline-secondary"><i class="bi bi-arrow-counterclockwise me-2"></i>초기화</button>
				                            </div>
				                            <div class="col-6 d-grid">
				                                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-2"></i>등록</button>
				                            </div>
				                        </div>
				                    </form>
				                </div>
				            </div>
				        </div>
				   <!--  </div>
				</div> -->
			
			</div>
			<!-- 이곳에 자신의 코드를 작성하세요 -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>

	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
</body>
</html>