<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	// 1. 현재 URL 경로 가져오기
	const currentPath = window.location.pathname;
	// 정규식 사용하기
	const match = currentPath.match(/\/([^\/]+)/);
	const parentPath = match ? match[1] : '';
	
	// console.log(parentPath); 
	
	// 2. 사이드바의 모든 메뉴(collapse) 가져오기
	const collapses = document.querySelectorAll('.collapse');
	
	// 3. 각 메뉴가 현재 URL과 일치하는지 확인
	collapses.forEach(menu => {
		// console.log(menu.id);
		// 메인 화면 일경우
		if(parentPath == ""){
			// 아무것도 열지 않음 
		}
		else if(menu.id.includes(parentPath)){
			// Bootstrap Collapse 객체 생성 후 show() 호출
	        const bsCollapse = new bootstrap.Collapse(menu, {
	            toggle: false // 자동으로 토글하지 않음
	        });
	        bsCollapse.show();
		}
	});
	
});

function toggleSidebar() {
	// 닫기
	if($('.sidebartoggle').text().trim() === '◀'){
		$('.sidebartoggle').text('▶');
		
		//id가 side인 항목을 찾아서 width를 100px로 고정
		$('#side').css('width', '100px');

		//사이드바 닫기
		$('.sidebar').removeClass('d-block');
		$('.sidebar').addClass('d-none');
		//미니 사이드바 열기
		$('.minisidebar').removeClass('d-none');
		$('.minisidebar').addClass('d-block');

		// 상태 저장 (사이드바 닫힘)
		localStorage.setItem('sidebarState', 'closed');
	}
	//열기
	else{
		$('.sidebartoggle').text('◀');

		//id가 side인 항목을 찾아서 width를 100px로 고정
		$('#side').css('width', '250px');

		//미니 사이드바 닫기
		$('.minisidebar').removeClass('d-block');
		$('.minisidebar').addClass('d-none');
		//미니 사이드바 열기
		$('.sidebar').removeClass('d-none');
		$('.sidebar').addClass('d-block');

		// 상태 저장 (사이드바 닫힘)
		localStorage.setItem('sidebarState', 'open');
	}
}

//페이지 로드 시 사이드바 상태 복원
$(document).ready(function() {
	const sidebarState = localStorage.getItem('sidebarState');
	
	// 저장된 상태가 '닫힘'이면
	if(sidebarState === 'closed') {
		$('.sidebartoggle').text('▶');
		$('#side').css('width', '100px');
		$('.sidebar').removeClass('d-block').addClass('d-none');
		$('.minisidebar').removeClass('d-none').addClass('d-block');
	} else {
		// 기본 상태 또는 '열림' 상태
		$('.sidebartoggle').text('◀');
		$('#side').css('width', '250px');
		$('.minisidebar').removeClass('d-block').addClass('d-none');
		$('.sidebar').removeClass('d-none').addClass('d-block');
	}
});
</script>

<div class="side d-flex flex-row">
	<!-- lg사이즈 이상일 경우 -->
	<div class="sidebar flex-shrink-0 p-3 d-block">
		<a href="${pageContext.request.contextPath}/"
			class="d-flex justify-content-center align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom"> <img alt="AssemERP"
			src="${pageContext.request.contextPath}/img/logo.png" style="width: 150px; height: 50px; object-fit: fill;">
		</a>
		<ul class="list-unstyled ps-0">
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0" data-bs-toggle="collapse" data-bs-target="#deptemp-collapse"
					aria-expanded="false">인사</button>
				<div class="collapse" id="deptemp-collapse" style="">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small list-group">
						<li><a href="${pageContext.request.contextPath}/dept/deptListForm" class="link-body-emphasis d-inline-flex text-decoration-none rounded">부서
								관리</a></li>
						<li><a href="${pageContext.request.contextPath}/emp/empListForm" class="link-body-emphasis d-inline-flex text-decoration-none rounded">사원
								관리</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
					data-bs-target="#partsproduct-collapse" aria-expanded="false">부품/제품</button>
				<div class="collapse" id="partsproduct-collapse" style="">
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
					data-bs-target="#client-collapse" aria-expanded="false">거래처</button>
				<div class="collapse" id="client-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="${pageContext.request.contextPath}/client/list" class="link-body-emphasis d-inline-flex text-decoration-none rounded">거래처
								관리</a></li>
						<li><a href="${pageContext.request.contextPath}/client/createStart" class="link-body-emphasis d-inline-flex text-decoration-none rounded">거래처
								등록</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
					data-bs-target="#salespurchase-collapse" aria-expanded="false">수주/발주</button>
				<div class="collapse" id="salespurchase-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="${pageContext.request.contextPath}/sales/list" class="link-body-emphasis d-inline-flex text-decoration-none rounded">수주 관리</a></li>
						<li><a href="${pageContext.request.contextPath}/purchase/list" class="link-body-emphasis d-inline-flex text-decoration-none rounded">발주 관리</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
					data-bs-target="#inventory-collapse" aria-expanded="false">물류</button>
				<div class="collapse" id="inventory-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="${pageContext.request.contextPath}/inventory" class="link-body-emphasis d-inline-flex text-decoration-none rounded">재고 관리</a></li>
						<li><a href="${pageContext.request.contextPath}/inventory/history" class="link-body-emphasis d-inline-flex text-decoration-none rounded">입출고 이력</a></li>
						<li><a href="${pageContext.request.contextPath}/inventory/close" class="link-body-emphasis d-inline-flex text-decoration-none rounded">월마감
								이력</a></li>
					</ul>
				</div>
			</li>
			<li class="border-top my-3"></li>
			<li class="mb-1">
				<button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse"
					data-bs-target="#board-collapse" aria-expanded="false">게시판</button>
				<div class="collapse" id="board-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="${pageContext.request.contextPath}/board/boardListForm" class="link-body-emphasis d-inline-flex text-decoration-none rounded">공지사항</a></li>
					</ul>
				</div>
			</li>
		</ul>
	</div>
	<!-- lg사이즈 이하일 경우 -->
	<div class="minisidebar flex-shrink-0 p-3 d-none">
		<a href="/" class="d-flex justify-content-center align-items-center pb-3 mb-3 text-decoration-none border-bottom"> <img alt="AssemERP"
			src="${pageContext.request.contextPath}/img/Logo_mini.png" style="width: 50px; height: 50px; object-fit: fill;">
		</a>
		<ul class="list-unstyled ps-0">
			<!-- 인사 -->
			<li class="mb-1"><a href="${pageContext.request.contextPath}/emp/empListForm" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded"
				style="height: 32px"> <i class="bi bi-person" style="font-size: 24px"></i>
			</a></li>
			<!-- 부품/제품 -->
			<li class="mb-1"><a href="${pageContext.request.contextPath}/parts/partsList" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded"
				style="height: 32px"> <i class="bi bi-cpu" style="font-size: 24px"></i>
			</a></li>
			<!-- 거래처 -->
			<li class="mb-1"><a href="${pageContext.request.contextPath}/client/list" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded"
				style="height: 32px"> <i class="bi bi-building" style="font-size: 24px"></i>
			</a></li>
			<!-- 수주/발주 -->
			<li class="mb-1"><a href="${pageContext.request.contextPath}/sales/list" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded"
				style="height: 32px"> <i class="bi bi-file-earmark-text" style="font-size: 24px"></i>
			</a></li>
			<!-- 물류 -->
			<li class="mb-1"><a href="${pageContext.request.contextPath}/inventory"
				class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded" style="height: 32px"> <i
					class="bi bi-box-seam" style="font-size: 24px"></i>
			</a></li>
			<!-- 게시판 -->
			<li class="border-top my-3"></li>
			<li class="mb-1"><a href="${pageContext.request.contextPath}/board/boardListForm" class="link-body-emphasis d-flex justify-content-center align-items-center text-decoration-none rounded"
				style="height: 32px"> <i class="bi bi-chat-left-text" style="font-size: 24px"></i>
			</a></li>
		</ul>
	</div>
	<!-- 사이드바 전환 버튼 -->
	<div class="sidebartoggle flex-shrink-0 p-0" onclick="toggleSidebar()">◀</div>
</div>