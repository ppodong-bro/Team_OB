<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
const sectorLabelPlugin = {
	id: 'sectorLabel',
	afterDraw(chart) {
	    const {ctx, chartArea} = chart;
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


//도넛 그림자 플러그인
const doughnutShadowPlugin = {
    id: 'doughnutShadow',
    beforeDraw(chart) {
        const ctx = chart.ctx;
        const meta = chart.getDatasetMeta(0);

        ctx.save();

        meta.data.forEach((arc) => {
            ctx.shadowColor = 'rgba(0, 0, 0, 0.4)'; // 그림자 색상
            ctx.shadowBlur = 10;                    // 그림자 번짐
            ctx.shadowOffsetX = 4;                  // X축 오프셋
            ctx.shadowOffsetY = 4;                  // Y축 오프셋

            arc.draw(ctx); // 섹터 다시 그리기

            // 그림자 초기화
            ctx.shadowColor = 'transparent';
            ctx.shadowBlur = 0;
            ctx.shadowOffsetX = 0;
            ctx.shadowOffsetY = 0;
        });

        ctx.restore();
    }
};


const doughnutCombinedData = JSON.parse('${inventoryCurrent}');

// 이제 이 데이터를 차트에 맞게 분리
const doughnutLabels = doughnutCombinedData.map(item => item.LABEL);
const doughnutData = doughnutCombinedData.map(item => item.VALUE);

const ctx4 = document.getElementById('doughnutChart').getContext('2d');
const doughnutChart = new Chart(ctx4, {
	type: 'doughnut',
	data: {
		labels: doughnutLabels,
		datasets: [{
			label: '재고현황',
			data: doughnutData,
			backgroundColor: [
				//부품 색상(초록)
				'rgba(173, 230, 173, 0.7)',
				'rgba(144, 238, 144, 0.7)',
				'rgba(124, 252, 0, 0.7)',
				'rgba(100, 180, 100, 0.7)',
				'rgba(60, 179, 113, 0.7)',
				'rgba(75, 192, 192, 0.7)',
				'rgba(34, 139, 34, 0.7)',
				'rgba(0, 100, 0, 0.7)',
				// 제품 색상(주황)
				/* 'rgba(255, 229, 180, 0.7)',
				'rgba(255, 180, 80, 0.7)',
				'rgba(255, 140, 0, 0.7)', */
				// 여유 공간
				'rgba(180, 180, 180, 0.7)'
			],
			borderColor: [
				//부품 색상(초록)
				'rgba(173, 230, 173, 1)',
				'rgba(144, 238, 144, 1)',
				'rgba(124, 252, 0, 1)',
				'rgba(100, 180, 100, 1)',
				'rgba(60, 179, 113, 1)',
				'rgba(75, 192, 192, 1)',
				'rgba(34, 139, 34, 1)',
				'rgba(0, 100, 0, 1)',
				// 제품 색상(주황)
				/* 'rgba(255, 229, 180, 1)',
				'rgba(255, 180, 80, 1)',
				'rgba(255, 140, 0, 1)', */
				// 여유 공간
				'rgba(180, 180, 180, 1)'
			],
			borderWidth: 1
		}]
	},
	options: {
		responsive: true,
		maintainAspectRatio: false,
		plugins: {
			title: {
				display: true,
				text: '재고현황',
				font: {size: 20 },
				padding: {top: 10, bottom: 20 }
			},
			legend: {
				display: true,
				position: 'bottom'
			},
       		datalabels: { // 이 부분이 datalabels 플러그인 설정이야
       			display: function(context) {
       	            const value = context.dataset.data[context.dataIndex];
       	            const total = context.dataset.data.reduce((a, b) => a + b, 0);
       	            const percentage = (value / total) * 100;

       	            // 기준값(예: 퍼센트 3% 미만이면 숨김)
       	            const thresholdPercentage = 3; 

       	            return percentage >= thresholdPercentage; 
       	        },
       	        color: '#000', // 기본 표시 색상
       	        font: {
       	            weight: 'bold'
       	        },
				formatter: (value, context) => {
					return context.chart.data.labels[context.dataIndex]; 
				}
    		}
		},
	},
	plugins: [ChartDataLabels, doughnutShadowPlugin]
});
</script>
