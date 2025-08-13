<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<!-- 차트를 위한 JS라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- 캘린더를 위한 flatpickr JS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- 캘린더의 한국어 지원 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<!-- 캘린더의 구글폰트링크 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">

<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.dashboard {
	display: grid;
	gap: 10px;
	padding: 0px;
	height: 100%;
	box-sizing: border-box; /* 패딩까지 포함해서 높이 계산하도록 설정 */
	/* 큰 화면용 그리드 설정 */
	grid-template-columns: repeat(8, 1fr);
	/* 8개 열, 각각 동일한 비율(1fr)로 설정 */
	grid-template-rows: repeat(7, calc((100% - 70px) / 7)); 
	/* 5개 행, 최소 100px에서 내용에 맞게 늘어남 */
	grid-template-areas: 
		"one 	one 	one 	two 	two 	two 	two 	two"
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
}

/* 명언이 담길 섹션 */
.quote-section {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    box-sizing: border-box;
    background: linear-gradient(135deg, #f0f4f8, #e8f0f6);
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    text-align: center;
    /* hover 효과 제거 - 섹션은 움직이지 않음 */
}

/* 명언 텍스트에만 들썩거림 효과 추가 */
.quote-text {
    font-family: 'Noto Sans KR', sans-serif;
    color: #2c3e50;
    max-width: 90%;
    text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease; /* 부드러운 애니메이션 효과 */
}

/* 텍스트에 호버 효과 추가 */
.quote-section:hover .quote-text {
    transform: translateY(-5px); /* 텍스트만 위로 살짝 이동 */
    color: #1a2a3a; /* 색상 약간 더 진하게 */
    text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.12); /* 그림자 더 선명하게 */
}

/* 작가 이름 */
.quote-author {
    font-family: 'Noto Sans KR', sans-serif;
    color: #7f8c8d;
    transition: all 0.3s ease; /* 부드러운 애니메이션 효과 */
}

/* 작가 이름도 함께 움직이게 하기 */
.quote-section:hover .quote-author {
    transform: translateY(-5px);
    color: #5f6c6d; /* 색상 약간 더 진하게 */
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
						<script>
								    flatpickr("#fullCalendar", {
								    	
								      locale: "ko",
								      dateFormat: "Y-m-d",
								      defaultDate: "today",
								      inline: true,
								      disableMobile: true,
								      onReady: function(selectedDates, dateStr, instance) {
								    	    // 초기 로딩 시 스타일 적용
								    	    applyStyles(instance);
								    	  },
								    	  onMonthChange: function(selectedDates, dateStr, instance) {
								    	    // 월이 변경될 때마다 스타일 재적용
								    	    setTimeout(function() {
								    	      applyStyles(instance);
								    	    }, 10);
								    	  },
								    	  onYearChange: function(selectedDates, dateStr, instance) {
								    		    // 년도가 변경될 때마다 스타일 재적용
								    		    setTimeout(function() {
								    		      applyStyles(instance);
								    		    }, 10);
							    		  },
							    		  onChange: function(selectedDates, dateStr, instance) {
							    			    // 날짜 선택 변경 시에도 스타일 재적용
							    			    setTimeout(function() {
							    			      applyStyles(instance);
							    			    }, 10);
						    			  }
								    	});

								    	// 스타일 적용 함수를 별도로 분리
								    	function applyStyles(instance) {
								    	  const cal = instance.calendarContainer;
								    	  // 기본 컨테이너 설정
								    	  cal.style.position = "relative";
								    	  cal.style.top = "0";
								    	  cal.style.left = "0";
								    	  cal.style.width = "100%";
								    	  cal.style.height = "100%";
								    	  cal.style.maxWidth = "none";
								    	  
								    	  // 내부 컨테이너 조정
								    	  const monthsElement = cal.querySelector('.flatpickr-months');
								    	  if (monthsElement) monthsElement.style.width = "100%";
								    	  
								    	  const weekdaysElement = cal.querySelector('.flatpickr-weekdays');
								    	  if (weekdaysElement) weekdaysElement.style.width = "100%";
								    	  
								    	  const rContainer = cal.querySelector('.flatpickr-rContainer');
								    	  if (rContainer) {
								    	    rContainer.style.width = "100%";
								    	    rContainer.style.flex = "1";
								    	    rContainer.style.display = "flex";
								    	    rContainer.style.flexDirection = "column";
								    	  }  
								    	  
								    	  const daysElement = cal.querySelector('.flatpickr-days');
								    	  if (daysElement) {
								    	    daysElement.style.width = "100%";
								    	    daysElement.style.height = "100%";
								    	    daysElement.style.display = "flex";
								    	    daysElement.style.flexDirection = "column";
								    	  }
								    	  
								    	  const daysContainer = cal.querySelector('.dayContainer');
								    	  if (daysContainer) {
								    	    daysContainer.style.width = "100%";
								    	    daysContainer.style.minWidth = "100%";
								    	    daysContainer.style.maxWidth = "100%";
								    	    daysContainer.style.display = "flex";
								    	    daysContainer.style.flexWrap = "wrap";
								    	    daysContainer.style.flex = "1";
								    	    daysContainer.style.alignContent = "stretch";
								    	  }
								    	  
								    	  // 날짜 박스 조정
								    	  const days = cal.querySelectorAll('.flatpickr-day');
								    	  const totalWeeks = Math.ceil(days.length / 7);
								    	  
								    	  days.forEach(day => {
								    	    day.style.maxWidth = "100%";
								    	    day.style.flexBasis = "14.28%";
								    	    day.style.height = `calc((100% - ${monthsElement.offsetHeight}px - ${weekdaysElement.offsetHeight}px) / ${totalWeeks})`;
								    	    day.style.lineHeight = "normal";
								    	    day.style.display = "flex";
								    	    day.style.justifyContent = "center";
								    	    day.style.alignItems = "center";
								    	    day.style.margin = "0";
								    	    day.style.padding = "0";
								    	    day.style.boxSizing = "border-box";
								    	  });
								    	  
								    	  // 전체 캘린더를 flex 컨테이너로 설정
								    	  cal.style.display = "flex";
								    	  cal.style.flexDirection = "column";
								    	}
							    </script>
					</div>
					<!-- 매출매입실적 -->
					<div class="item item-2">
						<canvas id="yearsperformChartCanvas"></canvas>
						<script>
					    const yearsperformlabels = JSON.parse('${yearsperformlabels}');
					    const yearsperformSaledata = JSON.parse('${yearsperformSaledata}');
					    const yearsperformPurchasedata = JSON.parse('${yearsperformPurchasedata}');
					    
					    const ctx3 = document.getElementById('yearsperformChartCanvas').getContext('2d');
					    const yearsPerformChart = new Chart(ctx3, {
					        type: 'line',
					        data: {
					            labels: yearsperformlabels,
					            datasets: [
					                {
					                    label: '매출액',
					                    data: yearsperformSaledata,
					                    fill: true,
					                    borderColor: 'rgba(75, 192, 192, 1)',
					                    backgroundColor: 'rgba(75, 192, 192, 0)'
					                },
					                {
					                    label: '매입액',  // 새로운 데이터셋의 이름
					                    data: yearsperformPurchasedata,  // 이미 있는 매입 데이터 변수 사용
					                    fill: true,
					                    borderColor: 'rgba(255, 99, 132, 1)',  // 다른 색상 사용
					                    backgroundColor: 'rgba(255, 99, 132, 0)'
					                }
					            ]
					        },
					        options: {
					        	plugins: {
					        	    title: {
					        	      display: true,
					        	      text: '거래실적', // ✅ 여기에 제목
					        	      font: {
					        	        size: 18
					        	      },
					        	      padding: {
					        	        top: 10,
					        	        bottom: 30
					        	      }
					        	    }
					       	  	},
					            responsive: true,
					            maintainAspectRatio: false,
					            scales: {
					            	x: {
					            		grid:{display :false}
					            	},
					                y: {
					                	type: 'linear',
					                    beginAtZero: true,
					                    grid: {display :false},
					                    min: 0,
					                    max: 200000,
					                    ticks: {
					                    	display: true,
					                    	autoSkip: false,
					                        stepSize: 50000,
					                        precision: 0, // 👈 추가!
					                        callback: function(value, index) {
					                        	  return value % 50000 === 0 ? value : ''; // 50000 단위만 보이게
					                       	}
					                    }
					                }
					            }
					        }
					    });
					</script>
					</div>
					<!-- 재고현황 -->
					<div class="item item-3">
						<canvas id="doughnutChart"></canvas>
						<jsp:include page="/WEB-INF/views/dg/doughnutChart.jsp" />
					</div>
					<!-- 거래처실적 -->
					<div class="item item-4">
						<canvas id="clientChart"></canvas>
						<script>
						    const unitPlugin = {
						    		  id: 'unitPlugin',
						    		  afterDraw(chart, args, options) {
						    		    const {ctx, chartArea, scales} = chart;
						    		    const yScale = scales.y;
					
						    		    ctx.save();
						    		    ctx.font = options.font || '12px Arial';
						    		    ctx.fillStyle = options.color || 'black';
						    		    ctx.textAlign = 'center';
						    		    ctx.textBaseline = 'bottom';
					
						    		    // y축 왼쪽, 그래프 영역 위쪽 바로 위 위치 지정
						    		    const xPos = yScale.left + 30;  // y축 
						    		    const yPos = chartArea.top - 10; // 그래프 영역 위쪽에서 10px 위
					
						    		    ctx.fillText(options.text || '단위: 만원', xPos, yPos);
					
						    		    ctx.restore();
						    		  }
					   		};
						    
						    const labels = ${barlabels};
						    const data = ${bardata};
						    
						    console.log('barlabels raw:', '${barlabels}');
						    console.log('bardata raw:', '${bardata}');
		
						    try {
						        const labels = JSON.parse('<c:out value="${barlabels}" escapeXml="false"/>');
						        const data = JSON.parse('<c:out value="${bardata}" escapeXml="false"/>');
						        console.log('labels parsed:', labels);
						        console.log('data parsed:', data);
		
						        // 차트 생성 코드 여기에 이어서 작성
						    } catch(e) {
						        console.error('JSON parse error:', e);
						    }
						    // ctx 선언 위치 꼭 여기!
						    const ctx = document.getElementById('clientChart').getContext('2d');
						    
						    const myChart = new Chart(ctx, {
						        type: 'bar',
						        data: {
						            labels: labels,
						            datasets: [{
						                label: '거래총액',
						                data: data,
						                backgroundColor: 'rgba(54, 162, 235, 0.7)'
						            }]
						        },
						        options: {
						            responsive: true,
						        	maintainAspectRatio: false,
						            scales: {
						                x: { grid: { display: false } },
						                y: { beginAtZero: true, grid: { display: false } }
						            },
						            plugins: {
						                title: {
						                    display: true,
						                    text: '거래처실적',
						                    font: { size: 18 },
						                    padding: { top: 10, bottom: 10 }
						                },
						                unitPlugin: {
						                    text: '단위: 만원',
						                    font: '14px Arial',
						                    color: 'gray'
						                }
						            }
						        },
						        plugins: [unitPlugin]
						    });
						</script>
					</div>
					<!-- 명언 -->
					<div class="quote-section item item-5">
							<h1 class="quote-text">뿌리깊은 나무는 흔들리지 않는다</h1>
							<p class="quote-author">- 이승희 -</p>
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