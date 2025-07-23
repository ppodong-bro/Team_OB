<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.header {
	position: fixed; /* 스크롤 해도 항상 위에 위치 하도록 */
	background-color: #fff; /* 배경색 필수: 아래 내용이 비쳐 보이는 걸 방지 */
	top: 0;
	left: 200px;
	right: 0; /* right값 지정해서 width를 결정 */
	height: 60px;
	margin: 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
	
	border-bottom: #CCE4F6 solid 3px;
}

.header .auth-links {
	display: flex;
	align-items: center;
	margin-left: auto; /* 오른쪽 정렬 */
}

.header .auth-links img {
	height: 40px;
}

.header .auth-links a {
	color: black;
	text-decoration: none;
	margin-left: auto; /* 오른쪽 정렬 */
	margin-right: 15px; /* 오른쪽 여백 추가 */
	font-size: 0.9rem;
	margin-right: 15px;
}

.header .auth-links span {
	margin-left: auto; /* 오른쪽 정렬 */
	margin-right: 15px; /* 오른쪽 여백 추가 */
	font-size: 0.9rem;
}
</style>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		// 햄버거 메뉴
		const hamburger = document.querySelector(".hamburger-btn");
		const navMenu = document.querySelector(".hamburger-nav");

		hamburger.addEventListener("click", function() {
			hamburger.classList.toggle("active"); // 햄버거 아이콘 애니메이션
			navMenu.classList.toggle("active"); // 메뉴 슬라이드 토글
		});
		
		// 햄버거 서브 메뉴
		const menuItems = document.querySelectorAll(".hamburger-nav li > span");

		menuItems.forEach((span) => {
			span.addEventListener("click", function () {
				// 1. 현재 클릭된 li
				const parentLi = this.parentElement;
				const submenu = parentLi.querySelector(".hamburger-nav .submenu");

				// 2. 모든 submenu 닫기 (자기 자신 제외)
				document.querySelectorAll(".hamburger-nav .submenu").forEach((ul) => {
					if (ul !== submenu) ul.classList.remove("active");
				});

				// 3. 현재 submenu 토글
				if (submenu) {
					submenu.classList.toggle("active");
				}
			});
		});
	});
</script>
<body>
	<div class="header">
		<!-- 로그인/회원가입 영역 -->
		<div class="auth-links">
			<c:choose>
				<c:when test="${empty sessionScope.user}">
					<span>관리자${sessionScope.user.name}님 환영합니다!</span>
					<a href="<c:url value='/login'/>"> <img alt="마이페이지"
						src="<%=request.getContextPath()%>/img/login.png">
					</a>
					<a href="<c:url value='/logout'/>"> <img alt="로그아웃"
						src="<%=request.getContextPath()%>/img/logout.png">
					</a>
				</c:when>
				<c:otherwise>
					<a href="<c:url value='/register'/>">회원가입</a>
					<a href="<c:url value='/login'/>"> <img alt="로그인"
						src="<%=request.getContextPath()%>/img/login.png">
					</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>