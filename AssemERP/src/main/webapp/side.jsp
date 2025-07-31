<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- lg사이즈 이상일 경우 -->
<div class="sidebar flex-shrink-0 p-3 d-none d-lg-block">
	<a href="/" class="d-flex justify-content-center align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom"> <img
		alt="AssemERP" src="${pageContext.request.contextPath}/img/Logo.png" style="width: 150px; height: 50px; object-fit: fill;">
	</a>
	<ul class="list-unstyled ps-0">
		<li class="mb-1">
			<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#humanresource-collapse"
				aria-expanded="false">인사</button>
			<div class="collapse" id="humanresource-collapse" style="">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">부서 관리</a></li>
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">사원 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
				data-bs-target="#item-collapse" aria-expanded="false">부품/제품</button>
			<div class="collapse" id="item-collapse" style="">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="${pageContext.request.contextPath}/parts/partsList " class="link-body-emphasis d-inline-flex text-decoration-none rounded">부품
							관리</a></li>
					<li><a href="${pageContext.request.contextPath}/product/productList " class="link-body-emphasis d-inline-flex text-decoration-none rounded">제품
							관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
				data-bs-target="#orders-collapse" aria-expanded="false">수주/발주</button>
			<div class="collapse" id="orders-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="${pageContext.request.contextPath}/sales/list" class="link-body-emphasis d-inline-flex text-decoration-none rounded">수주 관리</a></li>
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">발주 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
				data-bs-target="#client-collapse" aria-expanded="false">거래처</button>
			<div class="collapse" id="client-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="${pageContext.request.contextPath}/client/list" 
					class="link-body-emphasis d-inline-flex text-decoration-none rounded">거래처관리</a></li>
					<li><a href="${pageContext.request.contextPath}/client/createStart"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">거래처 등록</a></li>
					
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
				data-bs-target="#inventory-collapse" aria-expanded="false">물류</button>
			<div class="collapse" id="inventory-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="${pageContext.request.contextPath}/inventory" class="link-body-emphasis d-inline-flex text-decoration-none rounded">재고 관리</a></li>
					<li><a href="${pageContext.request.contextPath}/inventory" class="link-body-emphasis d-inline-flex text-decoration-none rounded">재고 입출고
							이력</a></li>
					<li><a href="${pageContext.request.contextPath}/inventory" class="link-body-emphasis d-inline-flex text-decoration-none rounded">마감 이력</a></li>
				</ul>
			</div>
		</li>
		<li class="border-top my-3"></li>
		<li class="mb-1">
			<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
				data-bs-target="#board-collapse" aria-expanded="false">게시판</button>
			<div class="collapse" id="board-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">공지사항</a></li>
				</ul>
			</div>
		</li>
	</ul>
</div>
<!-- lg사이즈 이하일 경우 -->
<div class="minisidebar flex-shrink-0 p-3 d-block d-lg-none">
	<a href="/" class="d-flex justify-content-center align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom"> <img
		alt="AssemERP" src="${pageContext.request.contextPath}/img/Logo_mini.png" style="width: 50px; height: 50px; object-fit: fill;">
	</a>
	<ul class="list-unstyled ps-0">
		<li class="mb-1"><a href="#" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
				class="bi bi-person" style="font-size: 24px"></i>
		</a></li>
		<li class="mb-1"><a href="#" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
				class="bi bi-cpu" style="font-size: 24px"></i>
		</a></li>
		<li class="mb-1"><a href="#" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
				class="bi bi-file-earmark-text" style="font-size: 24px"></i>
		</a></li>
		<li class="mb-1"><a href="#" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
				class="bi bi-building" style="font-size: 24px"></i>
		</a></li>
		<li class="mb-1"><a href="${pageContext.request.contextPath}/inventory" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
				class="bi bi-box-seam" style="font-size: 24px"></i>
		</a></li>
		<li class="border-top my-3"></li>
		<li class="mb-1"><a href="#" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
				class="bi bi-chat-left-text" style="font-size: 24px"></i>
		</a></li>
	</ul>
</div>
