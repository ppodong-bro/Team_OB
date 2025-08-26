<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(document).ready(function() {
	// JSP 변수를 JavaScript 변수로 저장
	const contextPath = "${pageContext.request.contextPath}";

	// 경영본부 : 1000 => admin으로 저장되어 있어서 인사팀 부서장으로 임시 변경
	// 인사팀 : 1001
	const representative = document.getElementById("representative");
	fetch(contextPath + "/getdept/1001")
	.then(response => response.json())
	.then(dept => {
		// console.log(dept.deptLoc);
		representative.innerText = "주소 : " + dept.deptLoc;
	})
	.catch(error => console.error("/emp 호출 오류:", error));
	// 대표자(경영본부 부서장) : 1001 => admin으로 저장되어 있어서 인사팀 부서장으로 임시 변경
	// 대표자(인사팀 부서장) : 1005
	const ceo = document.getElementById("ceo");
	fetch(contextPath + "/getemp/1005")
	.then(response => response.json())
	.then(emp => {
		// console.log(emp.empName);
		ceo.innerText = "대표자 : " + emp.empName;
	})
	.catch(error => console.error("/emp 호출 오류:", error));

	// 국내 영업(국내영업팀 부서장) : 1003 => 
	const domesticBusiness = document.getElementById("domesticBusiness");
	fetch(contextPath + "/getemp/1003")
	.then(response => response.json())
	.then(emp => {
		// console.log(emp.empName);
		domesticBusiness.innerText = "국내문의 : " + emp.empName + " | " + emp.empTel + " | " + emp.email;
	})
	.catch(error => console.error("/emp 호출 오류:", error));

	// 해외 영업(해외영업팀 부서장) : 1006 => 
	const seaoverBusiness = document.getElementById("seaoverBusiness");
	fetch(contextPath + "/getemp/1006")
	.then(response => response.json())
	.then(emp => {
		// console.log(emp.empName);
		seaoverBusiness.innerText = "해외문의 : " + emp.empName + " | " + emp.empTel + " | " + emp.email;
	})
	.catch(error => console.error("/emp 호출 오류:", error));
})
</script>