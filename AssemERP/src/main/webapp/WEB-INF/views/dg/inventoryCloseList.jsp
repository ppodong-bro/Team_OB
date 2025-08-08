<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>Assem ERP</title>
</head>
<script type="text/javascript">
//현재시각 갱신하는 함수
function updateCurrentTime() {
	const now = new Date();
	
	const year   = now.getFullYear();
	const month  = (now.getMonth() + 1).toString().padStart(2, "0");
	const day    = now.getDate().toString().padStart(2, "0");
	const hour   = now.getHours().toString().padStart(2, "0");
	const minute = now.getMinutes().toString().padStart(2, "0");
	const second = now.getSeconds().toString().padStart(2, "0");
	
	// console.log(year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second);
	const formatted = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
	
	document.getElementById("currentTime").textContent = formatted;
}

document.addEventListener('DOMContentLoaded', function() {
	/* 마감 상태 검색 콤보박스 AJAX */
	const closeStatusSelect = ${search.close_status != null ? search.close_status : 999};
	// 마감 상태 : 700
	fetch("/common/700")
		.then(response => response.json())
		.then(data => {
			// console.log("불러온 데이터:", data);
			// <select>에 값 채우기
			const select = document.getElementById("close_status");
			data.forEach(item => {
				const option = document.createElement("option");
				option.value = item.middle_status;
				option.text = item.context;

				if (item.middle_status == closeStatusSelect) {
                    option.selected = true;
                }

				select.appendChild(option);
			});
		})
		.catch(error => console.error("/common 호출 오류:", error));
	
	/* 마감 상태 값 AJAX */
	// 마감 상태 클래스들을 모두 가져와서
    const statusElements = document.querySelectorAll('.status-text-close');
    
	// 각 마감 상태별로
    statusElements.forEach(function(element) {
    	// 값
        const statusValue = element.getAttribute('data-status');
    	// 텍스트
        const statusTextElement = element.querySelector('.text');
        
        // Ajax 요청 보내기(700 : 마감상태)
        fetch('/common/700/' + statusValue)
            .then(response => response.json())
            .then(data => {
                // 서버에서 받은 데이터로 텍스트 변경
                statusTextElement.textContent = data.context;
            })
            .catch(error => {
                console.error('상태 정보를 가져오는 중 오류 발생:', error);
            });
    });
});

$(document).ready(function() {
	const modalEl = document.getElementById("modalMonthClose");
	let timeInterval = null;
	// 모달 열릴 때 시작
	modalEl.addEventListener("shown.bs.modal", function () {
	    updateCurrentTime();
	    timeInterval = setInterval(updateCurrentTime, 1000);
	});

	// 모달 닫힐 때 중단
	modalEl.addEventListener("hidden.bs.modal", function () {
	    clearInterval(timeInterval);
	    timeInterval = null;
	    document.getElementById("currentTime").textContent = ""; // 초기화
	    
	    location.reload(); // 페이지 새로고침
	});

    // 가마감 버튼 클릭
    $("#btnFakeMonthClose").click(function() {
    	// 년월 구하기
    	const now = new Date();
    	const year = now.getFullYear().toString().slice(2); // YY
    	const month = (now.getMonth() + 1).toString().padStart(2, "0"); // MM
    	const yymm = year + month; //
    	
    	// 월마감 진행중 화면으로 변경
    	$("#modalMonthCloseText").text("가마감 진행중입니다...");
    	$("#spinner").removeClass("d-none");// 스피너 보이기
    	$("#btnMonthClose").hide();// 월마감 버튼 비활성화
    	$("#btnFakeMonthClose").hide();// 가마감 버튼 비활성화
    	
        // Ajax 요청 보내기
        $.ajax({
            url: "/inventory/monthClose/1", // 가마감
            type: "PUT",
            dataType: "json",
            contentType: "application/json", // JSON 데이터 전송시 필요
            data: JSON.stringify({
            	yearmonth: yymm,
            	emp_no: 1001//담당자
            }),
            success: function(response) {
            	if(response.result === true) {
                	$("#modalMonthCloseText").text("가마감이 완료되었습니다.");
                	$("#spinner").addClass("d-none");// 스피너 보이기
            	}
            	else {
                	$("#modalMonthCloseText").text("가마감이 실패했습니다.");
                	$("#spinner").addClass("d-none");// 스피너 보이기
            	}
            },
            error: function(xhr, status, error) {
            	$("#modalMonthCloseText").text("가마감이 오류가 발생했습니다.");
            	$("#spinner").addClass("d-none");// 스피너 보이기
            }
        });
    });
    // 월마감 버튼 클릭
    $("#btnMonthClose").click(function() {
    	// 년월 구하기
    	const now = new Date();
    	const year = now.getFullYear().toString().slice(2); // YY
    	const month = (now.getMonth() + 1).toString().padStart(2, "0"); // MM
    	const yymm = year + month; //
    	
    	// 월마감 진행중 화면으로 변경
    	$("#modalMonthCloseText").text("월마감 진행중입니다...");
    	$("#spinner").removeClass("d-none");// 스피너 보이기
    	$("#btnMonthClose").hide();// 월마감 버튼 비활성화
    	$("#btnFakeMonthClose").hide();// 가마감 버튼 비활성화
    	
        // Ajax 요청 보내기
        $.ajax({
            url: "/inventory/monthClose/2", // (진)월마감
            type: "PUT",
            dataType: "json",
            contentType: "application/json", // JSON 데이터 전송시 필요
            data: JSON.stringify({
            	yearmonth: yymm,
            	emp_no: 1001//담당자
            }),
            success: function(response) {
            	if(response.result === true) {
                	$("#modalMonthCloseText").text("월마감이 완료되었습니다.");
                	$("#spinner").addClass("d-none");// 스피너 보이기
            	}
            	else {
                	$("#modalMonthCloseText").text("월마감이 실패했습니다.");
                	$("#spinner").addClass("d-none");// 스피너 보이기
            	}
            },
            error: function(xhr, status, error) {
            	$("#modalMonthCloseText").text("월마감이 오류가 발생했습니다.");
            	$("#spinner").addClass("d-none");// 스피너 보이기
            }
        });
    });

    /* Modal 창 초기화 : Modal 창을 닫을 때 이벤트 발생 */
    $('#modalMonthClose').on('hidden.bs.modal', function () {
        // 초기 모달 텍스트 복원
        $('#modalMonthCloseText').text('월마감을 진행하시겠습니까?');

        // 버튼 보이게 & 활성화
        $('#btnMonthClose').show();
    });
});

</script>
<body>
	<!-- 전체 레이아웃 -->
	<div id="layout">
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>
		<div id="main-area">
			<jsp:include page="/header.jsp" />

			<!-- 이곳에 자신의 코드를 작성하세요 -->
			<div id="contents">
				<div class="container-fluid">
					<div class="card shadow-sm">
						<div class="card-header d-flex justify-content-between align-items-center">
							<h4 class="card-title mb-0">
								<i class="bi bi-calendar-check me-2"></i>월마감 이력
							</h4>
							<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalMonthClose">월마감</button>
						</div>
						<div class="card-body">
							<!-- 검색 폼 시작 -->
							<form method="get" action="${pageContext.request.contextPath}/inventory/close" class="row gx-2 gy-1 align-items-center mb-4">
								<div class="col d-flex flex-wrap justify-content-end align-items-center gap-2">
									<!-- 년월 -->
									<div class="col-auto d-flex gap-1">
										<div class="input-group input-group-sm" style="width: auto;">
											<span class="input-group-text">년월</span> <input type="text" name="yearmonth_start_text" class="form-control"
												placeholder="${search.sample_yearmonth_start_text }" value="${search.yearmonth_start_text }" style="width: 50px"> <span
												class="px-1">~</span> <input type="text" name="yearmonth_end_text" class="form-control" placeholder="${search.sample_yearmonth_end_text }"
												value="${search.yearmonth_end_text }" style="width: 50px">
										</div>
									</div>
									<!-- 마감일 -->
									<div class="col-auto d-flex gap-1">
										<div class="input-group input-group-sm" style="width: auto;">
											<span class="input-group-text">마감일</span> <input type="date" id="startDate" name="startDate" class="form-control form-control-sm"
												value="${search.startDate }">
											<%-- 시간까지 받는 input
									<input type="datetime-local" id="startDate" name="startDate" class="form-control form-control-sm" value="${partsDTO.startDate }"> --%>
											<span class="px-1">~</span> <input type="date" id="endDate" name="endDate" class="form-control form-control-sm" value="${search.endDate }">
										</div>
									</div>
									<!-- 마감 상태 -->
									<div class="col-auto">
										<div class="input-group input-group-sm">
											<span class="input-group-text">마감 상태</span> <select id="close_status" name="close_status" class="form-select form-select-sm">
												<option value="999">전체</option>
											</select>
										</div>
									</div>
									<!-- 담당자 -->
									<div class="col-auto">
										<div class="input-group input-group-sm">
											<span class="input-group-text">담당자</span><input type="text" name="emp_no_text" class="form-control"
												placeholder="담당자명" value="${search.emp_no_text }" style="width: 80px">
										</div>
									</div>
									<!-- 검색 버튼 -->
									<div class="col-auto">
										<button type="submit" class="btn btn-secondary btn-sm text-nowrap">
											<i class="bi bi-search"></i> 검색
										</button>
									</div>
								</div>
							</form>
							<!-- 검색 폼 마지막 -->

							<!-- List 테이블 시작 -->
							<div class="table-responsive">
								<table class="table table-bordered align-middle">
									<thead class="table-light">
										<tr>
											<th class="text-center" style="white-space: nowrap;">년월</th>
											<th class="text-center" style="white-space: nowrap;">시작일시</th>
											<th class="text-center" style="white-space: nowrap;">종료일시</th>
											<th class="text-center" style="white-space: nowrap;">마감 상태</th>
											<th class="text-center" style="white-space: nowrap;">담당자</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="inventoryClose" items="${inventoryCloseList}">
											<tr>
												<td class="text-center">${inventoryClose.yearmonth}</td>
												<td class="text-center">${inventoryClose.close_startdate}</td>
												<td class="text-center">${inventoryClose.close_enddate}</td>
												<td class="text-center"><span class="status-text status-text-close" data-status="${inventoryClose.close_status}"> <span
														class="dot"></span> <span class="text">${inventoryClose.close_status}</span>
												</span></td>
												<td class="text-center">${inventoryClose.emp_no_text}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<!-- List 테이블 마지막 -->
						</div>
						<div class="card-footer d-flex justify-content-center">
							<!-- 페이징에서 사용하는 경로 변수 -->
							<c:set var="pagingPath" value="${pageContext.request.contextPath}/inventory/close?" />

							<nav aria-label="Page navigation">
								<ul class="pagination justify-content-center mb-0">
									<li class="page-item ${paging.currentPage > 1 ? '' : 'disabled'}"><a class="page-link" href="${pagingPath}&currentPage=1"
										aria-label="First"><i class="bi bi-chevron-double-left"></i></a></li>
									<li class="page-item ${paging.currentPage > 1 ? '' : 'disabled'}"><a class="page-link"
										href="${pagingPath}&currentPage=${paging.currentPage - 1}" aria-label="Previous"><i class="bi bi-chevron-left"></i></a></li>
									<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="page">
										<li class="page-item ${paging.currentPage == page ? 'active' : ''}"><a class="page-link" href="${pagingPath}&currentPage=${page}">${page}</a></li>
									</c:forEach>
									<li class="page-item ${paging.currentPage < paging.totalPage ? '' : 'disabled'}"><a class="page-link"
										href="${pagingPath}&currentPage=${paging.currentPage + 1}" aria-label="Next"><i class="bi bi-chevron-right"></i></a></li>
									<li class="page-item ${paging.currentPage < paging.totalPage ? '' : 'disabled'}"><a class="page-link"
										href="${pagingPath}&currentPage=${paging.totalPage}" aria-label="Last"><i class="bi bi-chevron-double-right"></i></a></li>
								</ul>
							</nav>
						</div>
					</div>

				</div>
				<!-- 이곳에 자신의 코드를 작성하세요 -->

			</div>
			<jsp:include page="/foot.jsp" />
		</div>

		<!-- 모달창 -->
		<!-- 
		aria-hidden="true" : 페이지 로드시 해당 내용은 읽지 않도록 처리
		tabindex="-1" : tab키로 focus받지 않도록 설정 -->
		<div class="modal fade" id="modalMonthClose" tabindex="-1" aria-labelledby="modalMonthCloseTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modalMonthCloseTitle">월마감</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div id="modalMonthCloseText">월마감을 진행하시겠습니까?</div>
						<div id="currentTime"></div>
						<div id="spinner" class="d-flex justify-content-center d-none">
							<div class="spinner-border" role="status">
								<span class="visually-hidden">Loading...</span>
							</div>
						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-success" id="btnFakeMonthClose">가마감 진행</button>
						<button type="button" class="btn btn-success" id="btnMonthClose">월마감 진행</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
</body>
</html>