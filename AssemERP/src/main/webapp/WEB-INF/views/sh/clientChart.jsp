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


const labels = JSON.parse('${barlabels}');
const data = JSON.parse('${bardata}');

// 앞 5개 판매처, 뒤 5개 구매처
const salesData = data.map((v, i) => i < 5 ? v : 0);
const purchaseData = data.map((v, i) => i >= 5 ? v : 0);

const ctx = document.getElementById('clientChart').getContext('2d');

const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [
            {
                label: '거래처 실적',
                data: data,
                backgroundColor: data.map((_, i) => i < 5 ? 
               		'rgba(255, 99, 132, 1)' : // 앞 5개는 연한 빨강 (판매처)
                   	'rgba(75, 192, 192, 0.8)'   // 뒤 5개는 연한 파랑 (구매처)
                )
            }
        ]
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
                display: true,
                position: 'top',
                labels: {
                    generateLabels: function(chart) {
                        // 커스텀 범례 생성
                        return [
                            {
                                text: '판매처',
                                fillStyle: 'rgba(255, 99, 132, 0.8)',
                                strokeStyle: 'rgba(255, 99, 132, 1)',
                                lineWidth: 1,
                                hidden: false
                            },
                            {
                                text: '구매처',
                                fillStyle: 'rgba(75, 192, 192, 0.8)',
                                strokeStyle: 'rgba(75, 192, 192, 1)',
                                lineWidth: 1,
                                hidden: false
                            }
                        ];
                    }
                },
                onClick: function(e, legendItem, legend) {
                    // 범례 클릭 시 필터링 처리
                    const index = legendItem.index;
                    const chart = legend.chart;
                    
                    chart.data.datasets.forEach(dataset => {
                        // 모든 데이터 포인트에 대해 처리
                        const meta = chart.getDatasetMeta(0);
                        
                        for (let i = 0; i < meta.data.length; i++) {
                            const isVisible = (index === 0 && i < 5) || (index === 1 && i >= 5);
                            meta.data[i].hidden = !isVisible;
                        }
                    });
                    
                    chart.update();
                }
            },
            unitPlugin: {
                text: '단위: 만원',
                font: '12px Arial',
                color: '#666'
            }
        }
    },
    plugins: [shadowPlugin, unitPlugin]
});
</script>