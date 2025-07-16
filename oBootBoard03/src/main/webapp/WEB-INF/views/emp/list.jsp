<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- 부트스트랩 CSS CDN 링크 -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>
<body>
	<div id="header">
		<%@ include file="../header.jsp" %>
	</div>
	
	<div class="container my-5 bg-warning ">
        <h2 class="text-center mb-4">사원목록</h2>

        <!-- 목록 헤더 (레이블) -->
        <div class="row fw-bold py-2 border-bottom bg-primary">
            <div class="col-1">사진</div>
            <div class="col-1">사원번호</div>
            <div class="col-1">사원이름</div>
            <div class="col-2">전화번호</div>
            <div class="col-2">이메일</div>
            <div class="col-1">급여</div>
            <div class="col-3">입사일</div>
            <div class="col-1">부서</div>
        </div>

        <!-- 데이터 목록 컨테이너 -->
        <!-- 중요: nth-of-type이 제대로 작동하도록 c:forEach를 감싸는 div에 클래스 추가 -->
        <div class="data-list-wrapper ">
            <c:forEach var="empDto" items="${empDtoList }" varStatus="status">
  
                <!-- <a> 태그로 전체 row를 감싸는 방식 -->
                <a href="${pageContext.request.contextPath}/emp/empDetail?emp_no=${empDto.emp_no}" class="text-decoration-none text-reset">
                    <div class="row py-2 border-bottom list-item-row">
                        <div class="col-1"><img alt="프로필" src="${pageContext.request.contextPath}/upload/s_${empDto.simage}"> </div>
                        <div class="col-1">${empDto.emp_no }</div>
                        <div class="col-1">${empDto.emp_name }</div>
                        <div class="col-2">${empDto.emp_tel }</div>
                        <div class="col-2">${empDto.email }</div>
                        <div class="col-1">${empDto.sal }</div>
                        <div class="col-3">${empDto.in_date }</div>
                        <div class="col-1">${empDto.dept_name }</div>
                   </div>
                </a>

            </c:forEach>
        </div> <%-- 데이터 목록 컨테이너 끝 --%>

        <!-- 목록이 비어있을 경우 메시지 -->
        <c:if test="${empty deptDtoList}">
            <div class="row">
                <div class="col text-center py-4 text-muted">등록된 부서가 없습니다.</div>
            </div>
        </c:if>
		</div>
		<!-- 페이징 -->
		<nav aria-label="Page navigation">
		    <ul class="pagination justify-content-center">
		      <c:if test="${page.startPage > page.pageBlock}">
		        <li class="page-item">
		          <a class="page-link" href="/emp/list?currentPage=${page.startPage - page.pageBlock}" aria-label="Previous">
		            &laquo; 이전
		          </a>
		        </li>
		      </c:if>
		
		      <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
		        <li class="page-item ${i == page.currentPage ? 'active' : ''}">
		          <a class="page-link" href="/emp/list?currentPage=${i}">${i}</a>
		        </li>
		      </c:forEach>
		
		      <c:if test="${page.endPage < page.totalPage}">
		        <li class="page-item">
		          <a class="page-link" href="/emp/list?currentPage=${page.startPage + page.pageBlock}" aria-label="Next">
		            다음 &raquo;
		          </a>
		        </li>
		      </c:if>
		    </ul>
		 </nav>
	</div>
		
	</div>
	<div id="footer">
		<%@ include file="../foot.jsp" %>
	</div>
	<!-- 부트스트랩 JS CDN 링크 (<body> 태그 닫기 직전에!) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
</body>
</body>
</html>