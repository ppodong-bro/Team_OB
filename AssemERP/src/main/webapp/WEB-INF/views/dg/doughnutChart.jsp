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