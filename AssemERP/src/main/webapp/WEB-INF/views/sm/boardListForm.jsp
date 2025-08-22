<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>AssemERP - 공지사항</title>
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
				            <h4 class="card-title mb-0"><i class="bi bi-megaphone-fill me-2"></i>공지사항</h4>
				            <a href="/board/boardRegisterForm" class="btn btn-primary"><i class="bi bi-plus-lg"></i> 등록</a>
				        </div>
				        <div class="card-body">
				            <table class="table table-bordered align-middle text-center">
				            	<thead class="table-light">
				                    <tr>
				                        <th style="width: 8%;">번호</th>
				                        <th style="width: 40%;">제목</th>
				                        <th style="width: 10%;">작성자(사번)</th>
				                        <th style="width: 15%;">작성자명</th>
				                        <th style="width: 10%;">작성일</th>
				                        <th style="width: 10%;">조회수</th>
				                        <th style="width: 7%;">수정</th>
				                    </tr>
				                </thead>
				                <tbody>
				                    <c:forEach var="board" items="${boardList}">
				                        <tr>
				                            <td>${board.boardNo}</td>
				                            <td class="text-start">
				                                <a href="/board/boardModifyForm?boardNo=${board.boardNo}" class="text-decoration-none text-dark">${board.title}</a>
				                            </td>
				                            <td>${board.empNo}</td>
				                            <td>${board.empName}</td>
				                            <td><fmt:formatDate value="${board.inDate}" pattern="yyyy-MM-dd"/></td>
				                            <td>${board.readCount}</td>
				                            <td>
				                                <a href="/board/boardModifyForm?boardNo=${board.boardNo}" class="btn btn-sm btn-outline-success">
				                                    <i class="bi bi-pencil-square"></i> 수정
				                                </a>
				                            </td>
				                        </tr>
				                    </c:forEach>
				                    <c:if test="${empty boardList}">
				                        <tr>
				                            <td colspan="7" class="text-muted py-4">등록된 게시글이 없습니다.</td>
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
							                    <a class="page-link" href="/board/boardListForm?currentPage=1" aria-label="First">
							                        <i class="bi bi-chevron-double-left"></i>
							                    </a>
							                </li>
							                <li class="page-item">
							                    <a class="page-link" href="/board/boardListForm?currentPage=${paging.currentPage - 1}" aria-label="Previous">
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
							                <a class="page-link" href="/board/boardListForm?currentPage=${page}&searchType=${searchType}&searchKeyword=${searchKeyword}">${page}</a>
							            </li>
							        </c:forEach>
							
							        <c:choose>
							            <c:when test="${paging.currentPage < paging.totalPage}">
							                <li class="page-item">
							                    <a class="page-link" href="/board/boardListForm?currentPage=${paging.currentPage + 1}" aria-label="Next">
							                        <i class="bi bi-chevron-right"></i>
							                    </a>
							                </li>
							                <li class="page-item">
							                    <a class="page-link" href="/board/boardListForm?currentPage=${paging.totalPage}" aria-label="Last">
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
				
</body>
</html>