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

const labels = JSON.parse('${barlabels}');
const data = JSON.parse('${bardata}');

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


//최고/최저 색상 (최저: 빨강, 최고: 연한 초록)
const startColor = [255, 100, 0];     // Red (RGB) - 최저값
const endColor   = [144, 238, 144]; // LightGreen (RGB) - 최고값


// 최대/최소값 구하기
const maxValue = Math.max(...data);
const minValue = Math.min(...data);

// 값에 따른 색상 보간 함수
function interpolateColor(start, end, factor) {
    return start.map((startVal, i) =>
        Math.round(startVal + factor * (end[i] - startVal))
    );
}


//데이터별 색상 배열 생성
const colors = data.map(value => {
 const ratio = (value - minValue) / (maxValue - minValue || 1); // 0~1 사이
 const [r, g, b] = interpolateColor(startColor, endColor, ratio);
 return "rgb("+[r]+","+[g]+","+[b]+")";
});

//막대 그림자 플러그인
const shadowPlugin = {
    id: 'shadowPlugin',
    beforeDatasetsDraw(chart, args, pluginOptions) {
        const { ctx, chartArea: { top, bottom, left, right }, scales: { x, y } } = chart;

        chart.data.datasets.forEach((dataset, i) => {
            const meta = chart.getDatasetMeta(i);
            meta.data.forEach(bar => {
                ctx.save();
                ctx.shadowColor = 'rgba(0,0,0,0.5)';  // 그림자 색
                ctx.shadowBlur = 11;                   // 번짐 정도
                ctx.shadowOffsetX = 3;                 // X축 이동
                
                ctx.fillStyle = bar.options.backgroundColor;
                ctx.fillRect(
                    bar.x - bar.width / 2,
                    bar.y,
                    bar.width,
                    bottom - bar.y
                );
                ctx.restore();
            });
        });

        // 기본 막대 그리기 방지
        args.cancel = true;
    }
};


const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: '거래총액',
            data: data,
            backgroundColor: colors
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
    plugins: [shadowPlugin, unitPlugin]
});
</script>