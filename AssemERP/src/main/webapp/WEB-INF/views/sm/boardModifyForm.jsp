<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>ERP - 공지사항 수정</title>
<style>
    body { background-color: #f8f9fa; }
    .card-header { background-color: #198754; color: white; }
</style>
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
			
			    <div class="container-fluid px-4">
			    	<div class="card shadow-sm"> 
			                <div class="card-header d-flex justify-content-between align-items-center">
			                    <a href="/board/boardListForm" class="btn btn-outline-light btn-sm"><i class="bi bi-list-ul me-1"></i> 목록</a>
			                    <h4 class="card-title mb-0"><i class="bi bi-pencil-square me-2"></i>공지사항 수정</h4>
			                    <div style="width: 90px;"></div>
			                </div>
			                <div class="card-body p-4">
			                    <form id="updateForm" action="/board/boardModifyPro" method="post">
			                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			                        <input type="hidden" name="boardNo" value="${board.boardNo}">
			
			                        <div class="mb-3">
			                            <label for="title" class="form-label">제목</label>
			                            <input type="text" class="form-control" id="title" name="title" value="${board.title}" required>
			                        </div>
			
			                        <div class="mb-4">
			                            <label for="boardContent" class="form-label">내용</label>
			                            <textarea class="form-control" id="boardContent" name="boardContent" style="height: 250px" required>${board.boardContent}</textarea>
			                        </div>
			                        
			                        <div class="row mt-4 g-2">
			                             <div class="col-md-4 d-grid">
			                                <button type="button" id="deleteBtn" class="btn btn-danger"><i class="bi bi-trash me-2"></i>삭제</button>
			                            </div>
			                            <div class="col-md-8 d-grid">
			                                <button type="submit" class="btn btn-success"><i class="bi bi-check-lg me-2"></i>수정 완료</button>
			                            </div>
			                        </div>
			                    </form>

			                    <form id="deleteForm" action="/board/boardDeletePro" method="post" class="d-none">
			                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			                         <input type="hidden" name="boardNo" value="${board.boardNo}">
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
	
<script>
    const deleteBtn = document.getElementById('deleteBtn');
    if(deleteBtn) {
        deleteBtn.addEventListener('click', function() {
            if(confirm('정말로 이 게시글을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                document.getElementById('deleteForm').submit();
            }
        });
    }
</script>
</body>
</html>