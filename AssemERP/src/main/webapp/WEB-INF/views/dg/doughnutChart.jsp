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
			/* 'rgba(144, 238, 144, 0.7)',
			'rgba(124, 252, 0, 0.7)',
			'rgba(100, 180, 100, 0.7)',
			'rgba(60, 179, 113, 0.7)',
			'rgba(75, 192, 192, 0.7)',
			'rgba(34, 139, 34, 0.7)',
			'rgba(0, 100, 0, 0.7)',
			'rgba(107, 142, 35, 0.7)', */
			// 제품 색상(주황)
			'rgba(255, 229, 180, 0.7)',
			/* 'rgba(255, 180, 80, 0.7)',
			'rgba(255, 140, 0, 0.7)', */
			// 여유 공간
			'rgba(180, 180, 180, 0.7)'
			],
			borderColor: [
			//부품 색상(초록)
			'rgba(173, 230, 173, 1)',
			/* 'rgba(144, 238, 144, 1)',
			'rgba(124, 252, 0, 1)',
			'rgba(100, 180, 100, 1)',
			'rgba(60, 179, 113, 1)',
			'rgba(75, 192, 192, 1)',
			'rgba(34, 139, 34, 1)',
			'rgba(0, 100, 0, 1)',
			'rgba(107, 142, 35, 1)', */
			// 제품 색상(주황)
			'rgba(255, 229, 180, 1)',
			/* 'rgba(255, 180, 80, 1)',
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
				font: {size: 18 },
				padding: {top: 10, bottom: 20 }
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