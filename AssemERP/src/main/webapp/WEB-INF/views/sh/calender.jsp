<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
  flatpickr("#fullCalendar", {
  	
    locale: "ko",
    dateFormat: "Y-m-d",
    defaultDate: "today",
    inline: true,
    disableMobile: true,
    onReady: function(selectedDates, dateStr, instance) {
  	    // 초기 로딩 시 스타일 적용
  	    applyStyles(instance);
  	  },
  	  onMonthChange: function(selectedDates, dateStr, instance) {
  	    // 월이 변경될 때마다 스타일 재적용
  	    setTimeout(function() {
  	      applyStyles(instance);
  	    }, 10);
  	  },
  	  onYearChange: function(selectedDates, dateStr, instance) {
  		    // 년도가 변경될 때마다 스타일 재적용
  		    setTimeout(function() {
  		      applyStyles(instance);
  		    }, 10);
 		  },
 		  onChange: function(selectedDates, dateStr, instance) {
 			    // 날짜 선택 변경 시에도 스타일 재적용
 			    setTimeout(function() {
 			      applyStyles(instance);
 			    }, 10);
			  }
  	});

  	// 스타일 적용 함수를 별도로 분리
  	function applyStyles(instance) {
  	  const cal = instance.calendarContainer;
  	  // 기본 컨테이너 설정
  	  cal.style.position = "relative";
  	  cal.style.top = "0";
  	  cal.style.left = "0";
  	  cal.style.width = "100%";
  	  cal.style.height = "100%";
  	  cal.style.maxWidth = "none";
  	  cal.style.backgroundColor = "transparent"; // 투명
		cal.style.borderRadius = "10px";
  	  
  	  // 내부 컨테이너 조정
  	  const monthsElement = cal.querySelector('.flatpickr-months');
  	  if (monthsElement) {
  		  monthsElement.style.width = "100%";
  	  }
  	  
  	  const weekdaysElement = cal.querySelector('.flatpickr-weekdays');
  	  if (weekdaysElement) {
  		  weekdaysElement.style.width = "100%";
  	  }
  	  
  	  const rContainer = cal.querySelector('.flatpickr-rContainer');
  	  if (rContainer) {
  	    rContainer.style.width = "100%";
  	    rContainer.style.flex = "1";
  	    rContainer.style.display = "flex";
  	    rContainer.style.flexDirection = "column";
  	  }
  	  
  	  const daysElement = cal.querySelector('.flatpickr-days');
  	  if (daysElement) {
  	    daysElement.style.width = "100%";
  	    daysElement.style.height = "100%";
  	    daysElement.style.display = "flex";
  	    daysElement.style.flexDirection = "column";
  	  }
  	  
  	  const daysContainer = cal.querySelector('.dayContainer');
  	  if (daysContainer) {
  	    daysContainer.style.width = "100%";
  	    daysContainer.style.minWidth = "100%";
  	    daysContainer.style.maxWidth = "100%";
  	    daysContainer.style.display = "flex";
  	    daysContainer.style.flexWrap = "wrap";
  	    daysContainer.style.flex = "1";
  	    daysContainer.style.alignContent = "stretch";
  	  }
  	  
  	  // 날짜 박스 조정
  	  const days = cal.querySelectorAll('.flatpickr-day');
  	  const totalWeeks = Math.ceil(days.length / 7);
  	  
  	  days.forEach(day => {
  	    day.style.maxWidth = "100%";
  	    day.style.flexBasis = "14.28%";
  	    day.style.height = `calc((100% - ${monthsElement.offsetHeight}px - ${weekdaysElement.offsetHeight}px) / ${totalWeeks})`;
  	    day.style.lineHeight = "normal";
  	    day.style.display = "flex";
  	    day.style.justifyContent = "center";
  	    day.style.alignItems = "center";
  	    day.style.margin = "0";
  	    day.style.padding = "0";
  	    day.style.boxSizing = "border-box";
  	  });
  	  
  	  // 전체 캘린더를 flex 컨테이너로 설정
  	  cal.style.display = "flex";
  	  cal.style.flexDirection = "column";
  	}
 </script>
