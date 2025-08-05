<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>AssemERP - 부서 목록</title>
</head>
<!-- <body class="py-4 bg-light"> -->
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
						    <h4 class="card-title mb-0"><i class="bi bi-list-ul"></i> 부서 목록</h4>
		    				<a href="/dept/deptRegisterForm" class="btn btn-primary"><i class="bi bi-plus-lg"></i> 등록</a>
						</div>
				        <div class="card-body">
				        	<div class="d-flex justify-content-end mb-3">
							    <form action="/dept/deptListForm" method="get" class="d-flex align-items-center">
							        <!-- 검색 타입 셀렉트 -->
							        <select name="searchType" id="searchType" class="form-select me-2" style="width: auto;">
							            <option value="deptCode" ${searchType == 'deptCode' ? 'selected' : ''}>부서코드</option>
							            <option value="deptName" ${searchType == 'deptName' ? 'selected' : ''}>부서명</option>
							        </select>
							
							        <!-- 부서코드 입력 (숫자) -->
							        <input 
							            type="number" 
							            name="searchKeyword" 
							            id="numInput" 
							            class="form-control me-2" 
							            placeholder="부서코드 입력" 
							            value="${searchType == 'deptCode' ? searchKeyword : ''}"
							        >
							
							        <!-- 부서명 입력 (텍스트) -->
							        <input 
							            type="text" 
							            name="searchKeyword" 
							            id="textInput" 
							            class="form-control me-2" 
							            placeholder="부서명 입력" 
							            value="${searchType == 'deptName' ? searchKeyword : ''}"
							            style="display: none;"
							        >
							
							        <button type="submit" class="btn btn-secondary text-nowrap">
							            <i class="bi bi-search"></i> 검색
							        </button>
							    </form>
							</div>
				             <!-- <table class="table table-hover table-striped text-center align-middle"> -->
				            <table class="table table-bordered align-middle text-center">
				                <thead class="table-light">
				                <!-- <thead class="table-dark"> -->
				                    <tr>
				                        <th style="width: 10%;">부서코드</th>
				                        <th style="width: 25%;">부서명</th>
				                        <th style="width: 15%;">부서장(사번)</th>
				                        <th style="width: 20%;">위치</th>
				                        <th style="width: 15%;">위치상세</th>
				                        <th style="width: 15%;">수정</th>
				                    </tr>
				                </thead>
				                <tbody>
				                    <c:forEach var="dept" items="${deptList}">
				                        <tr>
				                            <td>${dept.deptCode}</td>
				                            <td align="left">${dept.deptName}</td>
				                            <td>${dept.deptCaptain}</td>
				                            <td align="left">${dept.deptLoc}</td>
				                            <td align="left">${dept.locDetail}</td>
				                            <td>
				                                <a href="/dept/deptModifyForm?deptCode=${dept.deptCode}" class="btn btn-sm btn-outline-success">
				                                    <i class="bi bi-pencil-square"></i> 수정
				                                </a>
				                            </td>
				                        </tr>
				                    </c:forEach>
				                    <c:if test="${empty deptList}">
				                        <tr>
				                            <td colspan="6" class="text-muted py-4">등록된 부서 정보가 없습니다.</td>
				                        </tr>
				                    </c:if>
				                </tbody>
				            </table>
				        </div>
				        <div class="card-footer d-flex justify-content-center">
				        
							<nav aria-label="Page navigation">
							    <ul class="pagination justify-content-center mb-0">
							
							        <c:choose>
							            <c:when test="${paging.currentPage > 1}">
							                <li class="page-item">
							                    <a class="page-link" href="/dept/deptListForm?currentPage=1&searchType=${searchType}&searchKeyword=${searchKeyword}" aria-label="First">
							                        <i class="bi bi-chevron-double-left"></i>
							                    </a>
							                </li>
							                <li class="page-item">
							                    <a class="page-link" href="/dept/deptListForm?currentPage=${paging.currentPage - 1}&searchType=${searchType}&searchKeyword=${searchKeyword}" aria-label="Previous">
							                        <i class="bi bi-chevron-left"></i>
							                    </a>
							                </li>
							            </c:when>
							            <c:otherwise>
							                <li class="page-item disabled">
							                    <a class="page-link" href="#" aria-label="First"><i class="bi bi-chevron-double-left"></i></a>
							                </li>
							                <li class="page-item disabled">
							                    <a class="page-link" href="#" aria-label="Previous"><i class="bi bi-chevron-left"></i></a>
							                </li>
							            </c:otherwise>
							        </c:choose>
							
							        <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
							            <li class="page-item ${paging.currentPage == page ? 'active' : ''}">
							                <a class="page-link" href="/dept/deptListForm?currentPage=${page}&searchType=${searchType}&searchKeyword=${searchKeyword}">${page}</a>
							            </li>
							        </c:forEach>
							
							        <c:choose>
							            <c:when test="${paging.currentPage < paging.totalPage}">
							                <li class="page-item">
							                    <a class="page-link" href="/dept/deptListForm?currentPage=${paging.currentPage + 1}&searchType=${searchType}&searchKeyword=${searchKeyword}" aria-label="Next">
							                        <i class="bi bi-chevron-right"></i>
							                    </a>
							                </li>
							                <li class="page-item">
							                    <a class="page-link" href="/dept/deptListForm?currentPage=${paging.totalPage}&searchType=${searchType}&searchKeyword=${searchKeyword}" aria-label="Last">
							                        <i class="bi bi-chevron-double-right"></i>
							                    </a>
							                </li>
							            </c:when>
							            <c:otherwise>
							                <li class="page-item disabled">
							                    <a class="page-link" href="#" aria-label="Next"><i class="bi bi-chevron-right"></i></a>
							                </li>
							                <li class="page-item disabled">
							                    <a class="page-link" href="#" aria-label="Last"><i class="bi bi-chevron-double-right"></i></a>
							                </li>
							            </c:otherwise>
							        </c:choose>
							
							    </ul>
							</nav>
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
				
<!--  부서관리 javaScript function 구현  -->			
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const sel = document.getElementById('searchType');
        const numInput = document.getElementById('numInput');
        const textInput = document.getElementById('textInput');

        function toggleInputs() {
            if (sel.value === 'deptCode') {
                numInput.style.display = '';
                numInput.disabled = false;
                textInput.style.display = 'none';
                textInput.disabled = true;
            } else {
                numInput.style.display = 'none';
                numInput.disabled = true;
                textInput.style.display = '';
                textInput.disabled = false;
            }
        }

        // 초기 토글
        toggleInputs();
        // 변경 시마다 토글
        sel.addEventListener('change', toggleInputs);
    });
</script>
</body>
</html>