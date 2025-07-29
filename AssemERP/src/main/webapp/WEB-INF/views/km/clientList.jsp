<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  …
</head>
<body>
  <%@ include file="../header.jsp" %>
  <%@ include file="../side.jsp" %>

  <div class="main-content" style="margin-left: 260px;">
    <div class="container-fluid px-4">
      <h2 class="mb-3 mt-2">거래처 관리</h2>

      <!-- 검색 폼 (생략) … -->

      <!-- List 테이블 시작 -->
      <div class="table-responsive">
        <table class="table table-bordered align-middle">
          <thead class="table-light">
            <tr>
              <th class="text-center">#</th>
              <th class="text-center">거래처번호</th>
              <th class="text-center">거래처명</th>
              <th class="text-center">유형</th>
              <th class="text-center">주소</th>
              <th class="text-center">이메일</th>
              <th class="text-center">담당자</th>
              <th class="text-center">수정/삭제</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="client" items="${clientList}" varStatus="st">
              <tr>
                <td class="text-center">${st.index + 1}</td>
                <td class="text-center">${client.client_No}</td>
                <td>${client.client_Name}</td>
                <td class="text-center">${client.client_Gubun}</td>
                <td>${client.client_Address}</td>
                <td>${client.client_Email}</td>
                <td>${client.client_Man}</td>
                <td class="text-center">
                  <a href="<c:url value='/client/edit/${client.client_No}'/>" 
                     class="btn btn-sm btn-outline-primary me-1">수정</a>
                  <a href="<c:url value='/client/delete/${client.client_No}'/>" 
                     class="btn btn-sm btn-outline-danger">삭제</a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty clientList}">
              <tr>
                <td colspan="9" class="text-center">조회된 데이터가 없습니다.</td>
              </tr>
            </c:if>
          </tbody>
        </table>

        <!-- 페이징 -->
        <nav aria-label="Page navigation" class="mt-3">
          <ul class="pagination pagination-sm justify-content-center">
            <li class="page-item ${page.startPage == 1 ? 'disabled' : ''}">
              <a class="page-link" href="?page=${page.startPage-1}" aria-label="Previous">‹</a>
            </li>
            <c:forEach begin="${page.startPage}" end="${page.endPage}" var="p">
              <li class="page-item ${page.currentPage == p ? 'active' : ''}">
                <a class="page-link" href="?page=${p}">${p}</a>
              </li>
            </c:forEach>
            <li class="page-item ${page.endPage == page.totalPage ? 'disabled' : ''}">
              <a class="page-link" href="?page=${page.endPage+1}" aria-label="Next">›</a>
            </li>
          </ul>
        </nav>

      </div>
    </div>
  </div>
  <%@ include file="../foot.jsp"%>
  <script src="…bootstrap.js"></script>
</body>
</html>
