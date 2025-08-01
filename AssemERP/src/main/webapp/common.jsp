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
</style>