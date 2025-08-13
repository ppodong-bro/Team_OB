<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            legend: {
	            display : false
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