<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
var apiKey = "3762f8ee478a85fab073fbe9eab9fce3";
var widget = document.getElementById("weather-widget");

function getWeather(lat, lon) {
    var url = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat 
            + "&lon=" + lon + "&appid=" + apiKey + "&units=metric&lang=kr";

    fetch(url)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            var iconUrl = "https://openweathermap.org/img/wn/" + data.weather[0].icon + "@2x.png";
            widget.innerHTML = ""
                + "<h3>" + data.name + " 날씨</h3>"
                + "<img src='" + iconUrl + "' alt='" + data.weather[0].description + "' style='width:60px; height:60px;'>"
                + "<p>🌡️ " + data.main.temp + "°C</p>"
                + "<p>☁️ " + data.weather[0].description + "</p>"
                + "<p>💧 습도: " + data.main.humidity + "%</p>";
        })
        .catch(function(err) {
            console.error(err);
            widget.innerHTML = "<p>날씨 정보를 불러올 수 없습니다.</p>";
        });
}

// 현재 위치 가져오기
if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
        function(pos) { getWeather(pos.coords.latitude, pos.coords.longitude); },
        function(err) {
            console.warn("위치 접근 거부됨. 기본 위치로 Seoul 사용");
            getWeather(37.5665, 126.9780); // 서울 좌표
        }
    );
} else {
    alert("브라우저에서 위치 정보를 지원하지 않습니다.");
    getWeather(37.5665, 126.9780); // 서울 좌표
}
</script>