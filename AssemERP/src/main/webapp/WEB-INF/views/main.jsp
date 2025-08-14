<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<!-- 차트를 위한 JS라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 캘린더를 위한 flatpickr JS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- 캘린더의 한국어 지원 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<!-- 캘린더의 구글폰트링크 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap"
	rel="stylesheet">

<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.dashboard {
	display: grid;
	gap: 20px;
	padding: 0px;
	height: 100%;
	box-sizing: border-box; /* 패딩까지 포함해서 높이 계산하도록 설정 */
	/* 큰 화면용 그리드 설정 */
	grid-template-columns: repeat(8, 1fr);
	/* 8개 열, 각각 동일한 비율(1fr)로 설정 */
	grid-template-rows: repeat(7, calc(( 100% - 140px)/7));
	/* 5개 행, 최소 100px에서 내용에 맞게 늘어남 */
	grid-template-areas: "one 	one 	one 	two 	two 	two 	two 	two"
		"one 	one 	one 	two 	two 	two 	two 	two"
		"one 	one 	one 	two 	two 	two 	two 	two"
		"three 	three 	three 	two 	two 	two 	two 	two"
		"three 	three 	three 	four 	four 	four 	five 	five"
		"three 	three 	three 	four 	four 	four 	five 	five"
		"three 	three 	three 	four 	four 	four 	five 	five";
}

/* 작은 화면용 미디어 쿼리 */
@media ( max-width : 768px) {
	.dashboard {
		grid-template-columns: 1fr;
		grid-template-areas: "one" "one" "two" "two" "two" "three" "three"
			"three" "four" "four" "five" "five";
	}
}

/* 각 영역 스타일링 */
.dashboard .item {
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 24px;
	font-weight: bold;
	color: black;
	box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.1);
	padding: 10px;
}

.dashboard .item-1 {
	grid-area: one;
	background-color: #F0F0F0;
	display: flex;
	justify-content: center; /* 수평 방향 가운데 정렬 */
	align-items: center;
	/* 수직 방향 가운데 정렬 */
	flex-direction: column;
	align-items: center; /* 내용이 세로로 쌓이게 (선택 사항) */
	padding: 0px;
}

.dashboard .item-2 {
	grid-area: two;
	background-color: #F0F0F0;
}

.dashboard .item-3 {
	grid-area: three;
	background-color: #F0F0F0;
}

.dashboard .item-4 {
	grid-area: four;
	background-color: #F0F0F0;
}

.dashboard .item-5 {
	grid-area: five;
	background-color: #F0F0F0;
 	height: 100%; /* 혹시 부모도 높이 제한이 있다면 채우기 */
 	
    background: rgba(255,255,255,0.2);
    border-radius: 10px;
    text-align: center;
    padding: 0px;
}

.weather-widget {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column; /* 세로 배치 */
    border-radius: 15px;
    color: white;
    font-family: Arial, sans-serif;
    background: linear-gradient(to bottom, #4facfe, #00f2fe);
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    box-sizing: border-box;
    padding: 10px 20px;
    
}

.weather-header {
    flex: 0 0 15%; /* 헤더 비율 */
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
}

.weather-main {
    flex: 0 0 55%; /* 메인 비율 */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.weather-details {
    flex: 0 0 30%; /* 디테일 비율 */
    display: flex;
    justify-content: space-around;
    align-items: center;
    font-size: 24px;
}

.weather-main img {
    width: 150px;
    height: 150px;
}

.weather-main h2 {
    font-size: 40px;
    margin: 5px 0;
}

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
				<div class="dashboard container-fluid px-4 py-4">
					<!-- 캘린더 -->
					<div class="item item-1">
						<div id="fullCalendar"></div>
						<jsp:include page="/WEB-INF/views/sh/calender.jsp" />
					</div>
					<!-- 매출매입실적 -->
					<div class="item item-2">
						<canvas id="yearsperformChartCanvas"></canvas>
						<jsp:include page="/WEB-INF/views/sh/yearsperformance.jsp" />
					</div>
					<!-- 재고현황 -->
					<div class="item item-3">
						<canvas id="doughnutChart"></canvas>
						<jsp:include page="/WEB-INF/views/dg/doughnutChart.jsp" />
					</div>
					<!-- 거래처실적 -->
					<div class="item item-4">
						<canvas id="clientChart"></canvas>
						<jsp:include page="/WEB-INF/views/sh/clientChart.jsp" />
					</div>
					<!-- 날씨 -->
					<div class="item item-5">
						<div class="weather-widget" id="weather-widget">
							<div class="weather-header">
								<div id="location">위치 불러오는 중...</div>
								<button
									style="background: none; border: none; color: white; cursor: pointer;"
									onclick="loadWeather()">⟳ 새로고침</button>
							</div>
							<div class="weather-main" id="current-weather">
								<p>날씨 데이터를 불러오는 중...</p>
							</div>
							<div class="weather-details" id="weather-details"></div>
							<jsp:include page="/WEB-INF/views/sh/weather.jsp" />
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