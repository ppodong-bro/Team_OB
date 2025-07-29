<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="sidebar flex-shrink-0 p-3" style="width: 250px;">
	<a href="/"
		class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
		<svg class="bi pe-none me-2" width="30" height="24" aria-hidden="true">
			<use xlink:href="#bootstrap"></use></svg> <span class="fs-5 fw-semibold">AssemERP</span>
	</a>
	<ul class="list-unstyled ps-0">
		<li class="mb-1">
			<button
				class="btn btn-toggle d-inline-flex align-items-center rounded border-0"
				data-bs-toggle="collapse" data-bs-target="#humanresource-collapse"
				aria-expanded="false">인사</button>
			<div class="collapse" id="humanresource-collapse" style="">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">부서 관리</a></li>
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">사원 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button
				class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
				data-bs-toggle="collapse" data-bs-target="#item-collapse"
				aria-expanded="false">부품/제품</button>
			<div class="collapse" id="item-collapse" style="">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">부품 관리</a></li>
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">제품 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button
				class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
				data-bs-toggle="collapse" data-bs-target="#orders-collapse"
				aria-expanded="false">수주/발주</button>
			<div class="collapse" id="orders-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">수주 관리</a></li>
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">발주 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button
				class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
				data-bs-toggle="collapse" data-bs-target="#client-collapse"
				aria-expanded="false">거래처</button>
			<div class="collapse" id="client-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="${pageContext.request.contextPath}/business/clientList"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">거래처 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="mb-1">
			<button
				class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
				data-bs-toggle="collapse" data-bs-target="#inventory-collapse"
				aria-expanded="false">물류</button>
			<div class="collapse" id="inventory-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">재고 관리</a></li>
				</ul>
			</div>
		</li>
		<li class="border-top my-3"></li>
		<li class="mb-1">
			<button
				class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
				data-bs-toggle="collapse" data-bs-target="#board-collapse"
				aria-expanded="false">게시판</button>
			<div class="collapse" id="board-collapse">
				<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
					<li><a href="#"
						class="link-body-emphasis d-inline-flex text-decoration-none rounded">공지사항</a></li>
				</ul>
			</div>
		</li>
	</ul>
</div>