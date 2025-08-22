<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
/* $(document).ready(function() {
	// JSP 변수를 JavaScript 변수로 저장
	const contextPath = "${pageContext.request.contextPath}";
	
	fetch(contextPath + "/common/700")
	.then(response => response.json())
	.then(data => {
		// console.log("불러온 데이터:", data);
		// <select>에 값 채우기
		const select = document.getElementById("close_status");
		data.forEach(item => {
			const option = document.createElement("option");
			option.value = item.middle_status;
			option.text = item.context;

			if (item.middle_status == closeStatusSelect) {
                option.selected = true;
            }

			select.appendChild(option);
		});
	})
	.catch(error => console.error("/common 호출 오류:", error));
} */
</script>