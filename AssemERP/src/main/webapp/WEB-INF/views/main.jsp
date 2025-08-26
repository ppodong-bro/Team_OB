<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<!-- 차트를 위한 JS라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>

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

<jsp:include page="/common.jsp" />
<style>
.dashboard {
	display: grid;
	gap: 20px;
	padding: 0px;
	height: 100%;
	box-sizing: border-box; /* 패딩까지 포함해서 높이 계산하도록 설정 */
	/* 큰 화면용 그리드 설정 */
	grid-template-columns: repeat(8, 1fr);
	grid-template-rows: repeat(7, calc(( 100% - 140px)/7));
	grid-template-areas: 
	"two 	two 	two 	two 	two 	three 	three 	three"
	"two 	two 	two 	two 	two 	three 	three 	three"
	"two 	two 	two 	two 	two 	three 	three 	three"
	"two 	two 	two 	two 	two 	three 	three 	three"
	"four 	four 	four 	four 	one 	one 	five 	five"
	"four 	four 	four 	four 	one 	one 	five 	five"
	"four 	four 	four 	four 	one 	one 	five 	five";
}

/* 작은 화면용 미디어 쿼리 */
@media ( max-width : 992px) {
	.dashboard {
		/* 작은 화면용 그리드 설정 */
		grid-template-columns: 1fr;
		grid-template-rows: repeat(8, 1fr);
		grid-template-areas: "two" "two" "three" "three" "four" "four" "one" "five";
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
    border-radius: 10px;
}

.dashboard .item-1 {
	grid-area: one;
	background: linear-gradient(to bottom, #D3DEEC, #f1f4f8); // 그라데이션
	display: flex;
	justify-content: center; /* 수평 방향 가운데 정렬 */
	align-items: center;
	/* 수직 방향 가운데 정렬 */
	flex-direction: column;
	align-items: center; /* 내용이 세로로 쌓이게 (선택 사항) */
	padding: 10px;
}

.dashboard .item-2 {
	grid-area: two;
	background: linear-gradient(to bottom, #e1e8f0, #f1f4f8); // 그라데이션
}

.dashboard .item-3 {
	grid-area: three;
	background: linear-gradient(to bottom, #e1e8f0, #f1f4f8); // 그라데이션
}

.dashboard .item-4 {
	grid-area: four;
	background: linear-gradient(to bottom, #e1e8f0, #f1f4f8); // 그라데이션
}

.dashboard .item-5 {
	grid-area: five;
    background: linear-gradient(to bottom, #D3DEEC, #f1f4f8); // 그라데이션
 	height: 100%; /* 혹시 부모도 높이 제한이 있다면 채우기 */
    text-align: center;
    padding: 0px;
}

.weather-widget {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column; /* 세로 배치 */
    color: black;
    font-family: Arial, sans-serif;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    box-sizing: border-box;
    padding: 10px 20px;
    border-radius: 10px;
}

.weather-header {
    flex: 0 0 15%; /* 헤더 비율 */
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
}

.weather-main {
    flex: 0 0 60%; /* 메인 비율 */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.weather-details {
    flex: 0 0 25%; /* 디테일 비율 */
    display: flex;
    justify-content: space-around;
    align-items: center;
    font-size: 24px;
}

.boardTitle {
	height: auto;
	padding: 10px;
}

.boardList {
	flex-grow: 1;
	font-size: 14px;
}
.boardList tr {
    cursor: pointer;
    transition: background-color 0.3s ease; /* 색상 변경 시 부드러운 전환 효과 */
}
/* 마우스 오버 시 배경색 변경 (하이라이트 효과) */
.boardList tr:hover {
    background-color: #c2cbd6;
}	

</style>
<script>
function openyearsPerformDetail() {
  window.open(
    "perform/yearsPerform", // 팝업에 띄울 페이지
    "팝업창",
    "width=1000,height=1000,scrollbars=yes,resizable=yes"
  );
}
function openClientPerformDetail() {
	  window.open(
	    "perform/clientPerform", // 팝업에 띄울 페이지
	    "팝업창",
	    "width=1000,height=1000,scrollbars=yes,resizable=yes"
	  );
	}
</script>
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
				<div class="dashboard container-fluid">
					<!-- 캘린더 -->
					<%-- 
					<div class="item item-1">
						<div id="fullCalendar"></div>
						<jsp:include page="/WEB-INF/views/sh/calender.jsp" />
					</div> 
					--%>
					<!-- 매출매입실적 -->
					<div class="item item-2" onclick="openyearsPerformDetail()">
						<canvas id="yearsperformChartCanvas"></canvas>
						<jsp:include page="/WEB-INF/views/sh/yearsperformance.jsp" />
					</div>
					<!-- 재고현황 -->
					<div class="item item-3">
						<canvas id="doughnutChart"></canvas>
						<jsp:include page="/WEB-INF/views/dg/js_inventoryCurrent.jsp" />
					</div>
					<!-- 거래처실적 -->
					<div class="item item-4" onclick="openClientPerformDetail()">
						<canvas id="clientChart"></canvas>
						<jsp:include page="/WEB-INF/views/sh/clientChart.jsp" />
					</div>
					<!-- 날씨 -->
					<div class="item item-5">
						<div class="weather-widget" id="weather-widget">
							<div class="weather-header">
								<div id="location">위치 불러오는 중...</div>
								<button
									style="background: none; border: none; cursor: pointer;"
									onclick="loadWeather()">⟳</button>
							</div>
							<div class="weather-main" id="current-weather">
								<p>날씨 데이터를 불러오는 중...</p>
							</div>
							<div class="weather-details" id="weather-details"></div>
							<jsp:include page="/WEB-INF/views/sh/weather.jsp" />
						</div>
					</div>
					<div class="item item-1">
						<h4 class="boardTitle" style="font-weight: 900;">공지사항</h4>
						<table class="boardList list-table">
						<c:forEach var="board" items="${boardList}" varStatus="index">
							<tr onclick="location.href='${pageContext.request.contextPath}/board/boardModifyForm?boardNo=${board.boardNo}';">
								<td>${board.title}</td>
							</tr>
						</c:forEach>
						</table>
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