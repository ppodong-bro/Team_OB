<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<!-- JS라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- flatpickr JS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!-- 한국어 지원 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<!-- 구글폰트링크 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">

<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.graphBox canvas {
	width: 100% !important;
	height: 100% !important; /* 높이는 자동으로 비율 맞춤 */
	aspect-ratio: auto;
	margin: 0 auto; /* 가운데 정렬 */
}
/* 명언이 담길 섹션 */
.quote-section {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 300px;
    width: 100%;
    padding: 40px;
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
    font-size: 3em;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 25px;
    line-height: 1.3;
    letter-spacing: -0.03em;
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
    font-size: 1.4em;
    font-weight: 500;
    color: #7f8c8d;
    margin-top: 0;
    line-height: 1.5;
    letter-spacing: 0.02em;
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
				<div class="container-fluid px-4 py-4">

					<div class="row">
						<div class="col-md-4">
							<div class="graphBox"
								style="height: 300px; width: 100%; position: relative;">
								<div id="fullCalendar" style="height: 100%; width: 100%;"></div>
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
								    	  cal.style.position = "absolute";
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
							<div class="graphBox mt-3" style="height: 460px;">
								<div style="width: 90%; height: 90%; margin: auto;">
									<canvas id="doughnutChart"></canvas>
									<script>
											const sectorLabelPlugin = {
												  id: 'sectorLabel',
												  afterDraw(chart) {
												    const { ctx, chartArea } = chart;
												    const dataset = chart.data.datasets[0];
												    const meta = chart.getDatasetMeta(0);
												    const labels = chart.data.labels;
										
												    ctx.save();
												    ctx.fillStyle = 'black';
												    ctx.font = 'bold 14px Arial';
												    ctx.textAlign = 'center';
												    ctx.textBaseline = 'middle';
										
												    meta.data.forEach((arc, index) => {
												      const center = arc.getCenterPoint(); // 조각 중심 좌표
												      const label = labels[index];
												      ctx.fillText(label, center.x, center.y);
												    });
										
												    ctx.restore();
												}
											};
										
										
										    // 서버에서 전달한 데이터 예시 (JSP 변수로 대체)
										    const doughnutLabels = JSON.parse('${inventoryLabels}'); // ["A", "B", "C", "D"]
										    const doughnutData = JSON.parse('${inventoryData}');     // [10, 20, 30, 40]
										
										    const ctx4 = document.getElementById('doughnutChart').getContext('2d');
										    const doughnutChart = new Chart(ctx4, {
										        type: 'doughnut',
										        data: {
										            labels: doughnutLabels,
										            datasets: [{
										                label: '재고현황',
										                data: doughnutData,
										                backgroundColor: [
										                    'rgba(255, 99, 132, 0.7)',
										                    'rgba(54, 162, 235, 0.7)'
										                ],
										                borderColor: [
										                    'rgba(255, 99, 132, 1)',
										                    'rgba(54, 162, 235, 1)'
										                ],
										                borderWidth: 1
										            }]
										        },
										        options: {
										            responsive: true,
										            plugins: {
										                title: {
										                    display: true,
										                    text: '재고현황',
										                    font: { size: 18 },
										                    padding: { top: 10, bottom: 20 }
										                },
										                legend: {
										                    display: true,
										                    position: 'bottom'
										                }
										            }
										        },
										        plugins: [sectorLabelPlugin]
										    });
										</script>
								</div>

							</div>
						</div>







						<div class="col-md-8">
							<div class="graphBox" style="height: 420px;">
								<div style="width: 90%; height: 90%; margin: auto;">
									<canvas id="yearsperformChartCanvas"></canvas>
									<script>
								    const yearsperformlabels = JSON.parse('${yearsperformlabels}');
								    const yearsperformdata = JSON.parse('${yearsperformdata}');
								
								    const ctx3 = document.getElementById('yearsperformChartCanvas').getContext('2d');
								    const yearsPerformChart = new Chart(ctx3, {
								        type: 'line',
								        data: {
								            labels: yearsperformlabels,
								            datasets: [{
								                label: '가격변동',
								                data: yearsperformdata,
								                fill: true,
								                borderColor: 'rgba(75, 192, 192, 1)',
								                backgroundColor: 'rgba(75, 192, 192, 0.2)'
								            }]
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
								                    max: 500,
								                    ticks: {
								                    	display: true,
								                    	autoSkip: false,
								                        stepSize: 100,
								                        precision: 0, // 👈 추가!
								                        callback: function(value, index) {
								                        	  return value % 100 === 0 ? value : ''; // 100 단위만 보이게
								                       	}
								                    }
								                }
								            }
								        }
								    });
								</script>
								</div>
							</div>


							<div class="row mt-3">

								<div class="col-md-6">
									<div class="graphBox" style="height: 340px;">
										<div style="width: 90%; height: 90%; margin: auto;">
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
											        	maintainAspectRatio: false,
											            responsive: true,
											            scales: {
											                x: { grid: { display: false } },
											                y: { beginAtZero: true, grid: { display: false } }
											            },
											            plugins: {
											                title: {
											                    display: true,
											                    text: '거래처실적',
											                    font: { size: 18 },
											                    padding: { top: 10, bottom: 30 }
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
									</div>
								</div>
								<div class="col-md-6">
									<div class="graphBox" style="height: 340px;">
										<div style="width: 90%; height: 90%; margin: auto;">
											<div class="quote-section">
												<h1 class="quote-text">뿌리깊은 나무는 흔들리지 않는다</h1>
												<p class="quote-author">- 이승희 -</p>
											</div>
										</div>
									</div>
								</div>
							</div>
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