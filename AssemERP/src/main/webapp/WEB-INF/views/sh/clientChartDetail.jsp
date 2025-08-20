<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 검색</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
/* 검색창 감싸는 박스 */
.search-box {
    position: relative;
    display: flex;
    width: 100%;
}

/* 자동완성 박스 */
#searchResults {
    position: absolute;
    top: 50px;
    left: 0;
    background: white;
    border: 1px solid #ccc;
    width: 100%;
    max-height: 200px;
    overflow-y: auto;
    z-index: 9999;
}
#searchResults div {
    padding: 8px;
    cursor: pointer;
}
#searchResults div:hover {
    background: #f0f0f0;
}

/* 그래프 출력 영역 */
#chartArea {
    margin-top: 100px;
    width: 100%;
    height: 100%;
}
#searchResults div.highlight {
    background: #d0e7ff; /* 파란색 하이라이트 */
}
</style>
</head>
<body>
	<!-- 검색박스 -->
    <div class="search-box">
        
        <input type="text" id="searchInput" 
               style="flex: 1; height: 50px; box-sizing: border-box; font-size: 20px;"
               placeholder="거래처이름을 검색해주세요" autocomplete="off">
               
               
        <!-- 검색목록 -->
        <div id="searchResults"></div>
    </div>
	
	<!-- 선그래프 -->
	<div id="chartArea">
        <!-- 여기에 그래프 출력 -->
    </div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log("DOMContentLoaded 이벤트 발생!"); // 이 메시지가 찍히는지 확인

    fetch("${pageContext.request.contextPath}/perform/clientInitialData")
        .then(response => {
            console.log("Fetch 응답 도착! 응답 상태:", response.status, response.ok); // 응답 상태 확인
            if (!response.ok) {
                // 응답이 성공(2xx)이 아닐 경우, 응답 본문을 읽어서 에러 메시지를 얻어내는 것이 좋습니다.
                return response.text().then(text => { // 응답 텍스트를 읽어서 에러로 던짐
                    throw new Error('네트워크 응답 오류: ' + response.status + ' ' + response.statusText + ' - ' + text);
                });
            }
            return response.json(); // JSON으로 파싱 시도
        })
        .then(stats => {
            console.log("초기 데이터 로드 완료:", stats); // stats 값이 드디어 찍히는가!
            // 여기서 데이터 처리 및 차트 렌더링 등 작업
            if(stats.length > 0) {
                renderChart(stats[0].clientName, stats);
            }
        })
        .catch(error => {
            console.error("초기 데이터 로드 실패:", error); // 어떤 오류가 발생했는지 확인
        });
});




$(document).ready(function(){
    // 검색 입력 이벤트
    $("#searchInput").on("input", function(){
        let query = $(this).val().trim();
        if(query.length < 1){ 
            $("#searchResults").empty();
            return;
        }
        
        // 첫 번째 AJAX 호출
        $.ajax({
            url: "${pageContext.request.contextPath}/perform/searchClient",
            method: "GET",
            data: { keyword: query },
            success: function(data){
                let resultHtml = "";
                if(data.length > 0){
                    data.forEach(function(client){
                        resultHtml += "<div class='resultClient' data-id='"+client.id+"' data-name='"+client.name+"' data-status='"+client.status+"'>"
                                   + client.status + " [거래처번호 : "+client.id+"] " + client.name
                                   + "</div>";
                    });
                } else {
                    resultHtml = "<div>검색 결과 없음</div>";
                }
                
                $("#searchResults").html(resultHtml);
            },
            error: function(xhr, status, error) {
                console.error("검색 요청 실패:", status, error);
                $("#searchResults").html("<div>검색 중 오류 발생</div>");
            }
        });
    });

    // 결과 클릭 이벤트 - 별도로 분리
    $(document).on("click", ".resultClient", function(){
        let clientId = $(this).data("id");
        let clientName = $(this).data("name");
        let clientType = $(this).data("status");
    
        console.log("선택된 ID:", clientId);
        console.log("선택된 Type:", clientType);
        
        $("#searchInput").val(clientName);
        $("#searchResults").empty();

        // 두 번째 AJAX 호출
        $.ajax({
            url: "${pageContext.request.contextPath}/perform/getClientPerform",
            method: "GET",
            data: { 
                id: clientId,
                type: clientType
            },
            success: function(stats){
                console.log("서버 응답 확인:", stats);
                // 그래프 렌더링 함수 호출 (구현 필요)
                renderChart(clientName, stats);
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", status, error);
                alert("데이터를 불러오는 중 오류가 발생했습니다.");
            }
        });
    });
});
let selectedIndex = -1; // 현재 선택된 인덱스

$("#searchInput").on("keydown", function(e){
    let results = $("#searchResults div.resultClient");
    if(results.length === 0) return;

    if(e.key === "ArrowDown"){ // ↓
        e.preventDefault();
        selectedIndex = (selectedIndex + 1) % results.length;
        results.removeClass("highlight");
        $(results[selectedIndex]).addClass("highlight");
        results[selectedIndex].scrollIntoView({ block: 'nearest' });
    } else if(e.key === "ArrowUp"){ // ↑
        e.preventDefault();
        selectedIndex = (selectedIndex - 1 + results.length) % results.length;
        results.removeClass("highlight");
        $(results[selectedIndex]).addClass("highlight");
        results[selectedIndex].scrollIntoView({ block: 'nearest' });
    } else if(e.key === "Enter"){ // Enter
        e.preventDefault();
        if(selectedIndex >= 0){
            $(results[selectedIndex]).click();
            selectedIndex = -1;
        }
    }
});

// 검색 입력 시 highlight 초기화
$("#searchInput").on("input", function(){
    selectedIndex = -1;
});


function renderChart(clientName, stats) {
    // monthLabel 배열 추출
    const labels = stats.map(s => s.monthLabel);
	
    // clientData 배열 추출
    const data = stats.map(s => s.clientData);
    
    // clientType 배열 추출
    const type = stats.map(s => s.type)

     // type에 따라 색상 지정 (0 → 빨강, 1 → 파랑)
    const colors = type.map(t => t === 0 ? 'rgba(255, 99, 132, 0.7)' : 'rgba(54, 162, 235, 0.7)');
    
    console.log("labels :", labels);
    console.log("data :", data);
    console.log("type :", type);
    console.log("colors :", colors);

    
    // 기존 차트가 있으면 삭제 후 새로 생성 (중복 방지)
    if (window.myChart) {
        window.myChart.destroy();
    }
       
    const ctx = document.createElement("canvas");
    document.getElementById("chartArea").innerHTML = ""; // 초기화
    document.getElementById("chartArea").appendChild(ctx);

    window.myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: clientName,
                data: data,
                fill: false,
                backgroundColor: colors,  // 막대별 색상 적용
                borderColor: colors.map(c => c.replace('0.7', '1')), // 테두리는 불투명하게
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: clientName + " 월별 거래실적"
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}
</script>
</body>
</html>