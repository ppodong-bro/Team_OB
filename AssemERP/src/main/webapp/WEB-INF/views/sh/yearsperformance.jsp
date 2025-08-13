<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    	            text: '거래실적',
    	            font: {
    	                size: 18
    	            },
    	            padding: {
    	                top: 10,
    	                bottom: 30
    	            }
    	        },
    	        legend: {
    	            position: 'right', // ✅ 범례를 오른쪽으로 이동
    	            labels: {
    	            	usePointStyle: true,     	            	
    	                pointStyle: 'line',
    	                boxWidth: 20,
    	                padding: 15
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