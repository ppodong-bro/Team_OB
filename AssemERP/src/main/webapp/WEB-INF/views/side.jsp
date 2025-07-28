<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-bs-theme="light">
<head>
<meta charset="UTF-8">
<title>Collapsible Sidebar</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	overflow-x: hidden;
}

.sidebar {
	width: 250px;
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	background-color: #f8f9fa;
	padding: 1rem;
	border-right: 1px solid #dee2e6;
	z-index: 1100;
}

.sidebar h5 {
	font-weight: bold;
}

.sh {
	color: black;
}

</style>
</head>
<body>

	<div class="sidebar">
		<h5 style="padding-bottom: 0.5em;">
			<img
				src="https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo.svg"
				alt="Logo" width="30"> Collapsible
		</h5>
		<hr>
		<ul class="nav flex-column mb-2">
			<li class="nav-item"><a class="nav-link active sh" href="#">Home</a>
			</li>
			<li class="nav-item"><a class="nav-link sh" href="#">Overview</a></li>
			<li class="nav-item"><a class="nav-link sh" href="#">Updates</a></li>
			<li class="nav-item"><a class="nav-link sh" href="#">Reports</a></li>
		</ul>

		<hr>

		<ul class="nav flex-column mb-2">
			<li class="nav-item"><a class="nav-link sh" href="#">Dashboard</a>
			</li>
			<li class="nav-item"><a class="nav-link sh" href="#">Orders</a></li>
		</ul>

		<hr>

		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link sh" href="#">Account</a></li>
		</ul>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>