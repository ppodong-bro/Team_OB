<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.footer {
	position: fixed; /* 스크롤 해도 항상 위에 위치 하도록 */
	background-color: #FFF; /* 배경색 필수: 아래 내용이 비쳐 보이는 걸 방지 */
	height: 60px;
	bottom: 0;
	left: 200px;
	right: 0; /* right값 지정해서 width를 결정 */
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	
	border-top: #CCE4F6 solid 3px;
}

.footer span {
	font-size: 0.7rem;

}

/* 모바일 화면 */
@media ( max-width : 768px) {
	.footer {
		left: 0px;
	}
}
</style>
<body>
	<div class="footer">
	<span>※Create By : WiseForce</span>
	</div>
</body>
</html>