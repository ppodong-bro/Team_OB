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
               placeholder="품목이름을 검색해주세요" autocomplete="off">
               
               
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

    fetch("${pageContext.request.contextPath}/perform/itemInitialData")
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
                renderChart(stats[0].itemName, stats);
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
            url: "${pageContext.request.contextPath}/perform/searchItem",
            method: "GET",
            data: { keyword: query },
            success: function(data){
                let resultHtml = "";
                if(data.length > 0){
                    data.forEach(function(item){
                        resultHtml += "<div class='resultItem' data-id='"+item.id+"' data-name='"+item.name+"' data-status='"+item.status+"'>"
                                   + item.status + " [품목번호 : "+item.id+"] " + item.name
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
    $(document).on("click", ".resultItem", function(){
        let itemId = $(this).data("id");
        let itemName = $(this).data("name");
        let itemType = $(this).data("status");
    
        console.log("선택된 ID:", itemId);
        console.log("선택된 Type:", itemType);
        
        $("#searchInput").val(itemName);
        $("#searchResults").empty();

        // 두 번째 AJAX 호출
        $.ajax({
            url: "${pageContext.request.contextPath}/perform/getItemPerform",
            method: "GET",
            data: { 
                id: itemId,
                type: itemType
            },
            success: function(stats){
                console.log("서버 응답 확인:", stats);
                // 그래프 렌더링 함수 호출 (구현 필요)
                renderChart(itemName, stats);
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", status, error);
                alert("데이터를 불러오는 중 오류가 발생했습니다.");
            }
        });
    });
});

// 방향키 이벤트
let selectedIndex = -1; // 현재 선택된 인덱스

$("#searchInput").on("keydown", function(e){
    let results = $("#searchResults div.resultItem");
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

//검색 입력 시 highlight 초기화
$("#searchInput").on("input", function(){
    selectedIndex = -1;
});


function renderChart(itemName, stats) {
    // monthLabel 배열 추출
    const labels = stats.map(s => s.monthLabel);

    // itemData 배열 추출
    const data = stats.map(s => s.itemData);

    const color = stats.map(s => s.borderColor);
    // 기존 차트가 있으면 삭제 후 새로 생성 (중복 방지)
    if (window.myChart) {
        window.myChart.destroy();
    }
    console.log("서버 응답:", stats);
    
    console.log("타입:", typeof stats);
    
    console.log("isArray?", Array.isArray(stats));
    
    console.log("서버 응답:", stats, typeof stats, Array.isArray(stats));
    
    console.log("칼라 : ", color[0]);
    
    const ctx = document.createElement("canvas");
    document.getElementById("chartArea").innerHTML = ""; // 초기화
    document.getElementById("chartArea").appendChild(ctx);

    window.myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: itemName,
                data: data,
                fill: false,
                borderColor: color[0]
            }]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: itemName + " 월별 실적"
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