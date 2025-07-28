<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
#contents {
	margin-top: 70px;
	margin-left: 250px;
	margin-bottom: 60px;
	padding: 20px; /* 내부 여백 */
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div id="header">
		<%@ include file="header.jsp"%>
	</div>
	<div id="side">
		<%@ include file="side.jsp"%>
	</div>
	<div id="contents">
		<h3>main Page</h3>
	</div>
	<div id="footer">
		<%@ include file="foot.jsp"%>
	</div>
</body>
</html>