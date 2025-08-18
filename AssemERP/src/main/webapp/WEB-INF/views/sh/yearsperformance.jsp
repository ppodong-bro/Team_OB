<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
const yearsperformlabels = JSON.parse('${yearsperformlabels}');
const yearsperformSaledata = JSON.parse('${yearsperformSaledata}');
const yearsperformPurchasedata = JSON.parse('${yearsperformPurchasedata}');

const combinedData = [...yearsperformSaledata, ...yearsperformPurchasedata];

const dataMax = Math.max(...combinedData);

function calculateNiceStep(maxVal, desiredTicks) {
    if (desiredTicks <= 1) return maxVal; // 눈금이 1개 이하면 의미 없음
    const intervals = desiredTicks - 1; // 간격 개수 (0 포함 시)
    const approximateStep = maxVal / intervals;

    // 대략적인 스케일(10, 100, 1000, ...)을 찾습니다.
    const exponent = Math.floor(Math.log10(approximateStep));
    const factor = Math.pow(10, exponent);

    // 스케일에 맞춰 '예쁜' 숫자로 조정합니다. (1, 2, 5, 10, 20, 50, ...)
    let niceStep;
    if (approximateStep / factor <= 1) niceStep = factor;
    else if (approximateStep / factor <= 2) niceStep = 2 * factor;
    else if (approximateStep / factor <= 5) niceStep = 5 * factor;
    else niceStep = 10 * factor; // 5보다 크면 다음 스케일로

    return niceStep;
}

const desiredTicksCount = 5;
const calculatedNiceStep = calculateNiceStep(dataMax, desiredTicksCount);

const adjustedMax = Math.ceil(dataMax / calculatedNiceStep) * calculatedNiceStep;

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
            	display: true,
            	min: 0,
                max: adjustedMax,
            	type: 'linear',
                beginAtZero: true,
                grid: {display :false},
                autoSkip: false, // 5개 눈금을 모두 표시하기 위해 false 유지
                ticks: {
                    precision: 0,
                    // callback: function(value, index, values) {
                    //    // stepSize가 잘 계산되었다면 이 콜백은 필요 없습니다.
                    //    // 굳이 필요한 경우: return value;
                    // }
                }
            }
        }
    }
});
</script>