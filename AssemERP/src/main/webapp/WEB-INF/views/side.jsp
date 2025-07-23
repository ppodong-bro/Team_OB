<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 
사용한 색상
배경
	#FFF
	#347691
테두리
	#CCE4F6
	#A3D8F4
	#7ECFF2
마우스오버
	#EAF6FB
	#3A8299
선택
	#3F97AF
폰트
	#000
	#E0FFFF
	#F2F2F2
	
*/
.side {
	position: fixed; /* 스크롤 해도 항상 위에 위치 하도록 */
	background-color: #347691; /* 배경색 필수: 아래 내용이 비쳐 보이는 걸 방지 */
	color: #F2F2F2;
	top: 0;
	left: 0;
	width: 200px;
	height: 100%;
	margin: 0;
	align-items: center; /* 좌우 가운데 정렬 */
	display: flex;
	flex-direction: column; /* 로고 아래에 nav 오게 함 */
	border-right: #CCE4F6 solid 3px;
}

/* AI 로고 만드는 명령어 
'AssemERP' 로고, 배경 흰색, 하늘색 파스텔톤, 컴퓨터 조립 상징
*/
.side .logo {
	width: 100%;
	text-align: center;
	background-color: #347691; /* 배경색 필수: 아래 내용이 비쳐 보이는 걸 방지 */
	z-index: 200; /* 다른 요소 위에 위치하도록 */
}

.side .logo img {
	height: 50px;
	width: auto;
	margin: 5px 5px 0px 5px;
}

.side .main-nav {
	width: 100%;
}

.side ul {
	list-style: none;
	padding: 0;
	margin: 10px;
}

.side .menu span {
	cursor: pointer; /* 선택가능한 포인터 */
	width: auto;
	margin: 0;
	padding: 0;
	font-size: 1.5rem;
	display: flex;
	position: relative;
}

/* '>' 마크 추가 */
.side .menu span::after {
	content: "〉";
	display: inline-block;
	margin: 0px 10px 0px auto;
	transition: transform 0.3s ease;
	align-self: center;
}

.side .menu span:hover {
	background-color: #3A8299; /* 호버 시 배경색 변경 */
}

.side .menu.active span {
	background-color: #3F97AF; /* 선택 시 배경색 변경 */
}

/* 활성화된 메뉴의 마크 회전 */
.side .menu.active span::after {
	transform: rotate(90deg);
}

/* 비 활성화된 서브메뉴 */
.side .menu .submenu {
	padding: 0;
	margin: 0;
	font-size: 1rem;
	max-height: 0; /* 높이를 0으로 설정 */
	overflow: hidden; /* 넘치는 부분 숨기기 */
	transition: max-height 0.3s ease;
	padding-left: 15px;
	margin: 0; /* 들여쓰기 */
}

/* 활성화된 서브메뉴 */
.side .menu.active .submenu {
	max-height: 200px; /* 충분한 높이 값 설정 */
}
/* 서브메뉴 항목 스타일 */
.side .menu .submenu li {
	opacity: 0;
	transform: translateY(-10px); /* 위로 이동하는 애니메이션 */
	transition: opacity 0.3s ease, transform 0.3s ease;
	transition-delay: 0.1s;
}

/* 활성화된 서브메뉴 항목 스타일 */
.side .menu.active .submenu li {
	opacity: 1;
	transform: translateY(0); /* 원래 위치로 */
}

/* 서브메뉴 링크 스타일 */
.side .menu .submenu a {
	text-decoration: none; /* 링크 효과 삭제 */
	color: #F2F2F2;
	display: block;
}

.side .menu .submenu a:hover {
	background-color: #3A8299;
}

.side .menu .submenu a:hover {
	background-color: #3A8299; /* 호버 시 배경색 변경 */
}

.side .menu .submenu.active a {
	background-color: #3F97AF; /* 선택 시 배경색 변경 */
}

/* 햄버거 메뉴 */
.side .hamburger-btn {
	display: none; /* 기본적으로는 숨김 상태 */
	cursor: pointer;
	z-index: 101; /* 메뉴보다 위에 표시되도록 */
	background-color: #347691; /* 배경색 필수: 아래 내용이 비쳐 보이는 걸 방지 */
	color: #F2F2F2;
	width: 100%;
	height: 25px;
	border-top: 0px;
	border-bottom: #3A8299 solid 2px;
	border-right: #3A8299 solid 2px;
	border-left: #3A8299 solid 2px;
	/* 하단만 둥글게 처리 */
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	border-bottom: #3A8299 solid 2px;
	/* 애니메이션을 위한 설정 */
	transition: transform 0.5s ease;
	transform: translateY(0) rotate(0deg);
}

.side .hamburger-btn.active {
	/* 이동거리 = 25(버튼높이) + 60(푸터높이) + 60(헤더높이) */
	transform: translateY(calc(100vh - 145px)) rotate(180deg);
}

.side .hamburger-nav {
	display: none;
	position: fixed;
	top: -100%;
	left: 0px;
	width: 200px;
	height: calc(100vh - 60px);
	overflow: hidden; /* 넘치는 내용 숨김 */
	background-color: #347691;
	flex-direction: column;
	z-index: 100; /* 다른 요소 위에 위치하도록 */
	/* 애니메이션 */
	transition: top 0.5s ease;
	display: flex;
}

.side .hamburger-nav.active {
	display: flex;
	top: 60px;
}

/* 모바일 화면 */
@media ( max-width : 768px) {
	.side {
		height: 60px;
	}
	.side .main-nav {
		display: none;
	}
	.side .hamburger-btn {
		display: block;
	}
}
</style>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		/* 메뉴 */
		// 모든 메뉴 항목 가져오기
		const menuItems = document.querySelectorAll('.menu');
		
		// 각 메뉴 항목에 클릭 이벤트 추가
		menuItems.forEach(function(item) {
			item.addEventListener('click', function() {
				// 현재 클릭한 메뉴가 이미 활성화되어 있는지 확인
				const isActive = this.classList.contains('active');

				// 먼저 모든 메뉴의 active 클래스 제거
				menuItems.forEach(function(menu) {
					menu.classList.remove('active');
				});

				// 이미 활성화되어 있지 않았을 때만 active 클래스 추가
				if (!isActive) {
					this.classList.add('active');
				}
			});
		});

		/* 햄버거 메뉴 */
		const hamburgerBtn = document.querySelector('.hamburger-btn');
		const hamburgerNav = document.querySelector('.hamburger-nav');
		
		hamburgerBtn.addEventListener('click', () => {
			hamburgerBtn.classList.toggle('active');
			hamburgerNav.classList.toggle('active');
		});
	});
</script>
</head>
<body>
	<div class="side">
		<!-- 로고 영역 -->
		<div class="logo">
			<a href="<c:url value='/'/>"> <img alt="로고"
				src="<%=request.getContextPath()%>/img/RM_Logo.png">
			</a>
		</div>

		<!-- 메뉴 영역 -->
		<nav class="main-nav">
			<ul>
				<li class="menu"><span>인사</span>
					<ul class="submenu">
						<li><a href="<c:url value='/humanresource/dept'/>">부서</a></li>
						<li><a href="<c:url value='/humanresource/emp'/>">직원</a></li>
					</ul></li>
				<li class="menu"><span>제품/부품</span>
					<ul class="submenu">
						<li><a href="<c:url value='/production/product'/>">제품</a></li>
						<li><a href="<c:url value='/production/gear'/>">부품</a></li>
					</ul></li>
				<li class="menu"><span>재고</span>
					<ul class="submenu">
						<li><a href="<c:url value='/inventory/inven'/>">재고</a></li>
						<li><a href="<c:url value='/inventory/pricehistory'/>">가격변동이력</a></li>
					</ul></li>
				<li class="menu"><span>거래처</span>
					<ul class="submenu">
						<li><a href="<c:url value='/business/customer'/>">거래처</a></li>
					</ul></li>
				<li class="menu"><span>발주</span>
					<ul class="submenu">
						<li><a href="<c:url value='/order/receive'/>">발주</a></li>
					</ul></li>
				<li class="menu"><span>수주</span>
					<ul class="submenu">
						<li><a href="<c:url value='/order/send'/>">수주</a></li>
					</ul></li>
				<li class="menu"><span>실적</span>
					<ul class="submenu">
						<li><a href="<c:url value='/performance/purchase'/>">매입실적</a></li>
						<li><a href="<c:url value='/performance/sales'/>">매출실적</a></li>
						<li><a href="<c:url value='/performance/business'/>">거래처실적</a></li>
					</ul></li>
				<li class="menu"><span>게시판</span>
					<ul class="submenu">
						<li><a href="<c:url value='/board/notice'/>">공지</a></li>
					</ul></li>
			</ul>
		</nav>

		<button class="hamburger-btn">▼</button>
		<nav class="hamburger-nav">
			<ul>
				<li class="menu"><span>인사</span>
					<ul class="submenu">
						<li><a href="<c:url value='/humanresource/dept'/>">부서</a></li>
						<li><a href="<c:url value='/humanresource/emp'/>">직원</a></li>
					</ul></li>
				<li class="menu"><span>제품/부품</span>
					<ul class="submenu">
						<li><a href="<c:url value='/production/product'/>">제품</a></li>
						<li><a href="<c:url value='/production/gear'/>">부품</a></li>
					</ul></li>
				<li class="menu"><span>재고</span>
					<ul class="submenu">
						<li><a href="<c:url value='/inventory/inven'/>">재고</a></li>
						<li><a href="<c:url value='/inventory/pricehistory'/>">가격변동이력</a></li>
					</ul></li>
				<li class="menu"><span>거래처</span>
					<ul class="submenu">
						<li><a href="<c:url value='/business/customer'/>">거래처</a></li>
					</ul></li>
				<li class="menu"><span>발주</span>
					<ul class="submenu">
						<li><a href="<c:url value='/order/receive'/>">발주</a></li>
					</ul></li>
				<li class="menu"><span>수주</span>
					<ul class="submenu">
						<li><a href="<c:url value='/order/send'/>">수주</a></li>
					</ul></li>
				<li class="menu"><span>실적</span>
					<ul class="submenu">
						<li><a href="<c:url value='/performance/purchase'/>">매입실적</a></li>
						<li><a href="<c:url value='/performance/sales'/>">매출실적</a></li>
						<li><a href="<c:url value='/performance/business'/>">거래처실적</a></li>
					</ul></li>
				<li class="menu"><span>게시판</span>
					<ul class="submenu">
						<li><a href="<c:url value='/board/notice'/>">공지</a></li>
					</ul></li>
			</ul>
		</nav>
	</div>
</body>
</html>