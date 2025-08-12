<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<!-- jquery 선언 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%------------------------------------------------------------------------------
   		- Bootstrap CSS
    ------------------------------------------------------------------------------%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<%------------------------------------------------------------------------------
   		- Bootstrap Min Icons CSS
    ------------------------------------------------------------------------------%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%------------------------------------------------------------------------------
   		- Bootstrap Sidebars CSS
    ------------------------------------------------------------------------------%>
<link href="${pageContext.request.contextPath}/sidebars.css" rel="stylesheet">

<%------------------------------------------------------------------------------
   		- 레이아웃 CSS
    ------------------------------------------------------------------------------%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/layout.css">


<%------------------------------------------------------------------------------
   		- Style body 적용
    ------------------------------------------------------------------------------%>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	/*  
	    개별화면 header별 색상이 달라 
	    개별화면별 적용이 필요해서 주석처리함.(sm)
	*/
	/* background-color: #198754; 
	   color: white; */
}   /* Green theme for editing */
.required-field::after {
	content: " *";
	color: red;
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem
	}
}

.b-example-divider {
	width: 100%;
	height: 3rem;
	background-color: #0000001a;
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em #0000001a, inset 0 .125em .5em #00000026
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh
}

.bi {
	vertical-align: -.125em;
	fill: currentColor
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch
}

.btn-bd-primary {
	--bd-violet-bg: #712cf9;
	--bd-violet-rgb: 112.520718, 44.062154, 249.437846;
	--bs-btn-font-weight: 600;
	--bs-btn-color: var(--bs-white);
	--bs-btn-bg: var(--bd-violet-bg);
	--bs-btn-border-color: var(--bd-violet-bg);
	--bs-btn-hover-color: var(--bs-white);
	--bs-btn-hover-bg: #6528e0;
	--bs-btn-hover-border-color: #6528e0;
	--bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
	--bs-btn-active-color: var(--bs-btn-hover-color);
	--bs-btn-active-bg: #5a23c8;
	--bs-btn-active-border-color: #5a23c8
}

.bd-mode-toggle {
	z-index: 1500
}

.bd-mode-toggle .bi {
	width: 1em;
	height: 1em
}

.bd-mode-toggle .dropdown-menu .active .bi {
	display: block !important
}

/* 페이징 크기 조절 */
.page-link {
  height: 100%;
}

/* Common Table 상태별 UI 지정 */
.status-text {
	display: inline-flex;
	align-items: center;
	font-size: 0.9rem;
	gap: 4px;
}
.status-text .dot {
	width: 8px;
	height: 8px;
	border-radius: 50%;
	display: inline-block;
}

/* 700 : 마감 구분 */
.status-text-close[data-status="0"] .dot {
	background: #ffc107;//마감 시작
}
.status-text-close[data-status="1"] .dot {
	background: #0d6efd;//마감 완료
}
.status-text-close[data-status="2"] .dot {
	background: #198754;//월마감 완료
}
.status-text-close[data-status="3"] .dot {
	background: #dc3545;//마감 오류
}

/* 리스트에 대한 공통 정의 */
.list-table {
  table-layout: auto;
  width: 100%;
  border-collapse: collapse;
}
/* 셀 내 텍스트가 넘칠 경우 ... 처리 */
.list-table th {
	text-align: center;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
.list-table td {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	max-width: 250px;
}

/* 읽기전용 속성 disable처럼 만들기 */
.readonly {
	background-color: #e9ecef; /* disabled 배경색과 비슷하게 */
}

/* 대시보드관련 css */
/* 헤더(월 이름 등) 글자 크기 조절 */
.fc-header-toolbar {
	font-size: 16px;
}

/* 요일 헤더 글자 크기 조절 */
.fc-col-header-cell-cushion {
	font-size: 14px;
}

/* 날짜 숫자 크기 조절 */
.fc-daygrid-day-number {
	font-size: 14px;
}
/* 헤더 툴바 영역 전체 크기 축소 */
.fc-toolbar {
	font-size: 12px; /* 폰트 크기 줄이기 */
	padding: 4px 8px; /* 위아래, 좌우 패딩 조정 */
}

/* 툴바 버튼 크기 축소 */
.fc-toolbar button {
	padding: 4px 8px; /* 버튼 내부 패딩 줄이기 */
	font-size: 12px; /* 버튼 텍스트 폰트 크기 */
	min-width: auto; /* 기본 최소 너비 없애기 */
}

/* 헤더 중앙 제목 크기 조정 */
.fc-toolbar-title {
	font-size: 14px; /* 제목 폰트 크기 */
	padding: 0;
	margin: 0 5px;
}

.dashboard {
	height: 400px;
	
}

.dashboard .row {
	height: 100%;
}

.dashboard .row>[class^="col-"] {
	height: 100%;
}

.graphBox {
	display: flex;
	align-items: center; /* 세로 중앙정렬 */
	justify-content: center; /* 가로 중앙정렬 */
	border: solid 2px;
	border-radius: 7px;
	border-color: #23292E;
	width: 100%; /* 가로 폭 꽉 채우기 */
	height: 100%; /* 필요 시 부모 높이 꽉 채우기 */
	box-sizing: border-box; /* border 포함 */
	background-color: white;
}
/* 대시보드관련 css */

</style>