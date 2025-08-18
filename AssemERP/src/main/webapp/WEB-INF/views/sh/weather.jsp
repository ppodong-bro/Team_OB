<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
var apiKey = "3762f8ee478a85fab073fbe9eab9fce3";

function loadWeather() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            function(pos) {
                fetchWeather(pos.coords.latitude, pos.coords.longitude);
            },
            function() {
                fetchWeather(37.5665, 126.9780);
            }
        );
    } else {
        fetchWeather(37.5665, 126.9780);
    }
}

function fetchWeather(lat, lon) {
    console.log("위도, 경도:", lat, lon);

    var currentUrl = "https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon +
                     "&appid=" + apiKey + "&units=metric&lang=kr";
    console.log("현재 날씨 API 호출:", currentUrl);

    fetch(currentUrl)
        .then(res => {
            console.log("현재 날씨 응답 상태:", res.status);
            return res.json();
        })
        .then(data => {
            console.log("현재 날씨 데이터:", data);
            if (!data.weather) {
                document.getElementById("current-weather").innerHTML = "<p>날씨 데이터를 불러올 수 없습니다.</p>";
                return;
            }
            document.getElementById("location").innerHTML = data.name;
            document.getElementById("current-weather").innerHTML =
                "<img src='https://openweathermap.org/img/wn/" + data.weather[0].icon + "@2x.png'>" +
                "<h2>" + Math.round(data.main.temp) + "°C</h2>"; 
                /* + "<p>" + data.weather[0].description + "</p>"; */ // 영문 번역 이슈. 
            document.getElementById("weather-details").innerHTML =
                "<div>습도<br>" + data.main.humidity + "%</div>" +
                "<div>풍속<br>" + data.wind.speed + " m/s</div>" +
                "<div>체감온도<br>" + Math.round(data.main.feels_like) + "°C</div>";
        })
        .catch(err => {
            console.error("현재 날씨 API 오류:", err);
            document.getElementById("current-weather").innerHTML = "<p>API 요청 실패</p>";
        });
}

// 페이지 로드 시 자동 실행
loadWeather();
</script>