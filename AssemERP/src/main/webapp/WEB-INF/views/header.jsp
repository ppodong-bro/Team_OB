<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.header {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	height: 70px;
	width: 100%;
	background-color: #fff;
	border-bottom: #CCE4F6 solid 3px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 20px; /* 좌우 여백 */
	z-index: 1000;
}

.header .auth-buttons {
	display: flex;
	gap: 10px;
}

.header .auth-links {
	display: flex;
	align-items: center;
	margin-left: auto; /* 오른쪽 정렬 */
}

.header .auth-links img {
	height: 40px;
}

.header .auth-links a {
	color: black;
	text-decoration: none;
	margin-left: auto; /* 오른쪽 정렬 */
	margin-right: 15px; /* 오른쪽 여백 추가 */
	font-size: 0.9rem;
	margin-right: 15px;
}

.header .auth-links span {
	margin-left: auto; /* 오른쪽 정렬 */
	margin-right: 15px; /* 오른쪽 여백 추가 */
	font-size: 0.9rem;
}
</style>
<script type="text/javascript">
</script>
<body>
<body>
	<div class="header">
		<div class="auth-buttons">
			<button type="button" class="btn btn-outline-primary">Login</button>
			<button type="button" class="btn btn-primary">Sign-up</button>
		</div>
	</div>
</body>
</body>
</html>