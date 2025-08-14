<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 선택</title>
<style>
body {
	padding: 1rem;
	font-family: sans-serif;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 1rem;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

tr:hover {
	background: #f1f1f1;
	cursor: pointer;
}
</style>
<script>
	// 부모창으로 값 전달
	function selectParts(parts_no, parts_name) {
		if (window.opener && !window.opener.closed) {
			window.opener.setPartsInfo(parts_no, parts_name // 제품 정보 전달
			);
		}
		window.close();
	}
</script>
</head>
<body>
	<h4>부품 선택</h4>
	<table>
		<thead>
			<tr>
				<th>부품코드</th>
				<th>부품명</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="parts" items="${listParts}">
				<tr
					onclick="selectParts(
         '${parts.parts_no}',
         '${fn:escapeXml(parts.parts_name)}'
 					)">
					<td><c:out value="${parts.parts_no}" /></td>
					<td><c:out value="${parts.parts_name}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
