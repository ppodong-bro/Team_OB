<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css' />" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>발주 등록</title>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #0d6efd;
	color: white;
}

.required-field::after {
	content: " *";
	color: red;
}
</style>

<!-- 오늘 날짜 (납기 min) -->
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr"
	timeZone="Asia/Seoul" />

<style>
.numeric {
	text-align: right;
}

.info-card {
	border: 1px solid #eee;
	border-radius: 10px;
	padding: 16px;
	margin-bottom: 16px;
}

.info-card-title {
	font-weight: 600;
	margin-bottom: 12px;
}

.table-warning {
	animation: blink 1s ease-in-out 1;
}

@
keyframes blink { 0%{
	background: #fff3cd;
}
100


%
{
background


:


transparent
;


}
}

/* 가로 스크롤(부트스트랩 역할 유지) */
#items-wrap {
	overflow-x: auto;
}

/* 기본은 세로 스크롤 숨김 */
#items-scroll {
	position: relative;
	overflow-y: hidden;
	scrollbar-gutter: stable both-edges; /* 스크롤 영역 흔들림 방지(선택) */
	overscroll-behavior: contain; /* 바깥 스크롤 전파 방지(선택) */
}

/* 임계 행수 초과 시에만 세로 스크롤 */
#items-scroll.table-scroll {
	overflow-y: auto;
}

/* sticky header/footer도 #items-scroll 기준으로 동작 */
#items-scroll.table-scroll thead th {
	position: sticky;
	top: 0;
	z-index: 2;
	background: var(--bs-table-bg, #fff);
}

#items-scroll.table-scroll tfoot td {
	position: sticky;
	bottom: 0;
	z-index: 1;
	background: var(--bs-body-bg, #fff);
	box-shadow: 0 -1px 0 var(--bs-table-border-color, #dee2e6);
}

/* 전역 height:100%류 무력화 (#items-scroll 제외) */
#items-scroll .table, #items-scroll thead, #items-scroll tbody,
	#items-scroll tfoot {
	height: auto !important;
}

/* ✅ 전역 스크롤바 테마가 thumb 길이를 고정해둔 경우 해제 */
#items-scroll::-webkit-scrollbar {
	width: 10px;
	height: auto !important;
}

#items-scroll::-webkit-scrollbar-thumb {
	min-height: 0 !important;
	height: auto !important;
}

#items-scroll {
	scrollbar-width: auto;
} /* Firefox: thin/auto 중 취향 */
#items-scroll::-webkit-scrollbar-track {
	background: rgba(0, 0, 0, .06) !important;
}

#items-scroll::-webkit-scrollbar-thumb {
	background: rgba(0, 0, 0, .35) !important;
	border-radius: 6px;
}
/* 1) sticky 헤더 위쪽 보더 강제 */
#items-scroll.table-scroll thead th {
	border-top: 1px solid var(--bs-table-border-color, #dee2e6) !important;
}

/* 2) 스크롤 컨테이너 최상단에 1px 라인(헤더 위쪽 라인 보정) */
#items-scroll.table-scroll::before {
	content: "";
	position: sticky;
	top: 0;
	display: block;
	height: 1px;
	background: var(--bs-table-border-color, #dee2e6);
	z-index: 3; /* th(z-index:2)보다 위 */
	pointer-events: none;
}
</style>

<!-- 서버에서 온 프리필 JSON(부족분) 안전 주입 -->
<script id="prefillShortagesJson" type="application/json">
  <c:out value="${prefillShortagesJson}" escapeXml="false"/>
</script>

<script>
    /* ================= 거래처 팝업 ================= */
    function openClientPopup() {
      window.open(
        '${pageContext.request.contextPath}/client/popup?client_Gubun=${client_Gubun}&client_Name=',
        'clientPopup',
        'width=1800,height=560,scrollbars=yes'
      );
    }
    function setClientInfo(client_No, client_Name, client_Address, client_Email, client_Tel, client_Man, empNo, empName) {
      document.getElementById('clientNoInput').value      = client_No || '';
      document.getElementById('clientNameInput').value    = client_Name || '';
      document.getElementById('clientAddressInput').value = client_Address || '';
      document.getElementById('clientEmailInput').value   = client_Email || '';
      document.getElementById('clientTelInput').value     = client_Tel || '';
      document.getElementById('clientManInput').value     = client_Man || '';
      if (empNo)   document.getElementById('empNoInput').value   = empNo;
      if (empName) document.getElementById('empNameInput').value = empName;
      window.close();
    }

    /* ================= 부품 팝업 + 중복방지 ================= */
    const selectedParts = new Set();
    let currentRow = null;
    let targetPartsInput = null;
    let targetPartsNameInput = null;

    function openPartsPopup(btn) {
      const tr = btn.closest('tr');
      currentRow = tr;
      targetPartsInput     = tr.querySelector('.partsNoInput');
      targetPartsNameInput = tr.querySelector('.partsNameInput');

      window.open(
        '${pageContext.request.contextPath}/purchase/partsPopup?parts_Name=',
        'partsPopup',
        'width=1800,height=560,scrollbars=yes'
      );
    }

    // 팝업 콜백
    function setPartsInfo(parts_no, parts_name) {
      const pno = String(parts_no || '');
      const prevNo = targetPartsInput?.value ? String(targetPartsInput.value) : null;

      if (prevNo && prevNo === pno) { window.close(); return; }
      if (selectedParts.has(pno)) {
        alert('이미 선택된 부품입니다.');
        const dup = document.querySelector('#items-tbody tr[data-parts-no="'+pno+'"]');
        if (dup) {
          dup.classList.add('table-warning');
          dup.scrollIntoView({behavior:'smooth', block:'center'});
          setTimeout(()=>dup.classList.remove('table-warning'), 1000);
        }
        return;
      }

      if (prevNo) selectedParts.delete(prevNo);

      if (targetPartsInput)     targetPartsInput.value = pno;
      if (targetPartsNameInput) targetPartsNameInput.value = parts_name || '';
      if (currentRow)           currentRow.dataset.partsNo = pno;

      selectedParts.add(pno);

      if (typeof recalcTotal === 'function') recalcTotal();
      window.close();
    }

    /* ================= 합계 ================= */
    function recalcTotal() {
      let sumReq = 0, sumCost = 0;
      document.querySelectorAll('#items-tbody tr').forEach(row => {
        const qty  = Number(row.querySelector('.qty-input')?.value)  || 0;
        const cost = Number(row.querySelector('.cost-input')?.value) || 0;
        const tot  = qty * cost;
        const totCell = row.querySelector('.tot-cost');
        if (totCell) totCell.value = tot ? tot.toLocaleString() : '';
        sumReq  += qty;
        sumCost += tot;
      });
      document.getElementById('sum-req').innerText  = sumReq.toLocaleString();
      document.getElementById('sum-cost').innerText = sumCost.toLocaleString();
    }

    document.addEventListener('input', function(e){
      if (e.target.classList.contains('qty-input') || e.target.classList.contains('cost-input')) {
        recalcTotal();
      }
    });

    /* ================= 행 추가/삭제 & 프리필 적용 ================= */
    document.addEventListener('DOMContentLoaded', function(){
      const addBtn = document.getElementById('add-item-btn');
      const tbody  = document.getElementById('items-tbody');

      // 기존 선택값 세팅(수정폼 재사용 대비)
      document.querySelectorAll('#items-tbody .partsNoInput').forEach(inp => {
        if (inp.value) {
          const p = String(inp.value);
          selectedParts.add(p);
          const tr = inp.closest('tr');
          if (tr) tr.dataset.partsNo = p;
        }
      });

      if (addBtn) {
        addBtn.addEventListener('click', function(){
          const idx = tbody.querySelectorAll('tr').length;
          const tr = document.createElement('tr');
          tr.innerHTML =
            '<td>' +
              '<div class="input-group input-group-sm">' +
                '<input type="hidden" class="partsNoInput" name="purchase_Item['+idx+'].partsDTO.parts_no" />' +
                '<input type="text" class="form-control form-control-sm partsNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
                '<button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>' +
              '</div>' +
            '</td>' +
            '<td class="numeric">' +
              '<input type="number" min="0" name="purchase_Item['+idx+'].purchase_Item_Cnt" class="form-control form-control-sm qty-input" required />' +
            '</td>' +
            '<td class="numeric">' +
              '<input type="number" step="0.01" min="0" name="purchase_Item['+idx+'].purchase_Item_Cost" class="form-control form-control-sm cost-input" required />' +
            '</td>' +
            '<td class="numeric">' +
              '<input type="text" class="form-control form-control-plaintext form-control-sm tot-cost" readonly />' +
            '</td>' +
            '<td class="text-center">' +
              '<button type="button" class="btn btn-sm btn-outline-danger remove-item-btn"><i class="bi bi-trash"></i> 삭제</button>' +
            '</td>';
          tbody.appendChild(tr);
        });
      }

      // 삭제 위임
      const table = document.getElementById('items-table');
      if (table) {
        table.addEventListener('click', function(e){
          const btn = e.target.closest('.remove-item-btn');
          if (!btn) return;
          const tr = btn.closest('tr');
          const no = tr.querySelector('.partsNoInput')?.value;
          if (no) selectedParts.delete(String(no));
          tr.remove();
          recalcTotal();
        });
      }

      // ★★★ 프리필(JSON) 적용: shortageConfirm → 구매작성
      let prefill = [];
      try {
        const raw = (document.getElementById('prefillShortagesJson')?.textContent || '[]').trim();
        prefill = JSON.parse(raw || '[]');
      } catch(e) { prefill = []; }

      if (Array.isArray(prefill) && prefill.length > 0) {
        // 초기 1행이 완전 비어있으면 제거
        if (tbody.children.length === 1) {
          const first = tbody.firstElementChild;
          const no = first.querySelector('.partsNoInput')?.value;
          const nm = first.querySelector('.partsNameInput')?.value;
          if (!no && !nm) first.remove();
        }

        prefill.forEach(obj => {
          const idx = tbody.querySelectorAll('tr').length;
          const tr = document.createElement('tr');
          tr.innerHTML =
            '<td>' +
              '<div class="input-group input-group-sm">' +
                '<input type="hidden" class="partsNoInput" name="purchase_Item['+idx+'].partsDTO.parts_no" />' +
                '<input type="text" class="form-control form-control-sm partsNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
                '<button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>' +
              '</div>' +
            '</td>' +
            '<td class="numeric">' +
              '<input type="number" min="0" name="purchase_Item['+idx+'].purchase_Item_Cnt" class="form-control form-control-sm qty-input" required />' +
            '</td>' +
            '<td class="numeric">' +
              '<input type="number" step="0.01" min="0" name="purchase_Item['+idx+'].purchase_Item_Cost" class="form-control form-control-sm cost-input" required />' +
            '</td>' +
            '<td class="numeric">' +
              '<input type="text" class="form-control form-control-plaintext form-control-sm tot-cost" readonly />' +
            '</td>' +
            '<td class="text-center">' +
              '<button type="button" class="btn btn-sm btn-outline-danger remove-item-btn"><i class="bi bi-trash"></i> 삭제</button>' +
            '</td>';
          tbody.appendChild(tr);

          const row = tbody.lastElementChild;
          const partsNo   = obj.partsNo   ?? obj.parts_no ?? '';
          const partsName = obj.partsName ?? obj.parts_name ?? '';
          const qty       = obj.qty ?? obj.shortage_cnt ?? 0;

          row.querySelector('.partsNoInput').value   = partsNo;
          row.querySelector('.partsNameInput').value = partsName;
          row.querySelector('.qty-input').value      = qty;

          if (partsNo) {
            selectedParts.add(String(partsNo));
            row.dataset.partsNo = String(partsNo);
          }
        });

        if (typeof recalcTotal === 'function') recalcTotal();
      }

      recalcTotal();
    });
    
    // 반응형 테이블 (행 수 기준으로 스크롤 토글)
    document.addEventListener('DOMContentLoaded', function(){
      const wrap     = document.getElementById('items-wrap');   // 가로 스크롤용
      const scroller = document.getElementById('items-scroll'); // 세로 스크롤 전용
      const table    = document.getElementById('items-table');
      const tbody    = document.getElementById('items-tbody');
      if (!wrap || !scroller || !table || !tbody) return;

      const SCROLL_ROWS = parseInt(wrap.dataset.scrollRows || '6', 10);

      function heightForRows(n){
        const thead = table.tHead;
        const tfoot = table.tFoot;

        // 앞 n개 행의 실제 높이 합산 (정확)
        const rows = Array.from(tbody.rows);
        const rowsH = rows.slice(0, n).reduce((sum, r) => sum + r.getBoundingClientRect().height, 0);

        const headH = thead ? thead.getBoundingClientRect().height : 0;
        const footH = tfoot ? tfoot.getBoundingClientRect().height : 0;

        return Math.ceil(headH + footH + rowsH + 2);
      }

      function updateScroll(){
        const rowCount = tbody.rows.length;
        const on = rowCount > SCROLL_ROWS;

        scroller.classList.toggle('table-scroll', on);

        if (on) {
          const h = heightForRows(SCROLL_ROWS);
          scroller.style.height = '';           // 고정 height 제거
          scroller.style.maxHeight = h + 'px';  // 정확한 viewport 높이

          // 혹시 전역 충돌로 오버플로우가 안 생기면 1px 보정
          if (scroller.scrollHeight <= scroller.clientHeight) {
            scroller.style.maxHeight = (h - 1) + 'px';
          }
        } else {
          scroller.style.height = '';
          scroller.style.maxHeight = '';
        }
      }

      // 행 추가/삭제/창 리사이즈에 반응
      const mo = new MutationObserver(updateScroll);
      mo.observe(tbody, { childList: true });

      window.addEventListener('resize', updateScroll);
      document.getElementById('add-item-btn')?.addEventListener('click', () => {
        requestAnimationFrame(updateScroll);
      });
      document.addEventListener('click', (e) => {
        if (e.target.closest('.remove-item-btn')) requestAnimationFrame(updateScroll);
      });

      updateScroll();
      window.addEventListener('load', updateScroll);
    });
  </script>
</head>
<body>
	<div id="layout">
		<div id="side"><jsp:include page="/side.jsp" /></div>
		<div id="main-area">
			<jsp:include page="/header.jsp" />

			<div id="contents">
				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<a href="${pageContext.request.contextPath}/purchase/list"
								class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>발주 등록
							</h4>
							<div style="width: 90px;"></div>
						</div>

						<div class="card-body p-4">
							<form id="purchaseForm"
								action="${pageContext.request.contextPath}/purchase/create"
								method="post" style="display: inline;">
								<!-- (필요 시 CSRF 토큰)
              <c:if test="${not empty _csrf}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
              </c:if>
              -->

								<!-- 발주 / 거래처 -->
								<section class="info-card" aria-label="발주 및 거래처 정보">
									<div class="info-card-title">발주 / 거래처 정보</div>
									<div class="row g-3">
										<!-- 발주 제목: 한 줄 전체 사용 -->
										<div class="col-12">
											<label class="form-label">발주 제목 <span
												class="text-danger">*</span></label> <input type="text"
												id="purchaseTitleInput" name="purchase_Title"
												class="form-control form-control-sm" required
												placeholder="예: 2025-08 CPU 쿨러 발주 (요청서 #A-231)" />
										</div>
										<div class="col-md-4">
											<label class="form-label">거래처 이름 <span
												class="text-danger">*</span></label>
											<div class="input-group input-group-sm">
												<input type="hidden" id="clientNoInput"
													name="clientDto.client_No" /> <input type="text"
													id="clientNameInput" class="form-control form-control-sm"
													readonly required placeholder="조회 버튼으로 선택" />
												<button type="button" class="btn btn-outline-secondary"
													onclick="openClientPopup()">조회</button>
											</div>
										</div>
										<div class="col-md-4">
											<label class="form-label">주소</label> <input type="text"
												id="clientAddressInput" class="form-control form-control-sm"
												readonly />
										</div>
										<div class="col-md-4">
											<label class="form-label">이메일</label>
											<div class="input-group input-group-sm">
												<input type="email" id="clientEmailInput"
													class="form-control" readonly />
											</div>
										</div>
										<div class="col-md-4">
											<label class="form-label">거래처 전화번호</label> <input type="text"
												id="clientTelInput" class="form-control form-control-sm"
												readonly />
										</div>
										<div class="col-md-4">
											<label class="form-label">거래처 담당자</label> <input type="text"
												id="clientManInput" class="form-control form-control-sm"
												readonly />
										</div>
										<div class="col-md-4">
											<label class="form-label">담당자 이름</label> <input type="hidden"
												id="empNoInput" name="empDTO.empNo" /> <input type="text"
												id="empNameInput" class="form-control form-control-sm"
												readonly />
										</div>
										<div class="col-md-4">
											<label class="form-label">납기 완료일</label> <input type="date"
												id="purchaseDate" class="form-control form-control-sm"
												name="purchase_Date" min="${todayStr}" required />
											<div id="dateError" class="form-text" style="color: #dc3545;"></div>
										</div>
									</div>
								</section>

								<!-- 부품 목록 -->
								<section class="info-card mt-4" aria-label="부품 목록">
									<div
										class="info-card-title d-flex justify-content-between align-items-center">
										<span>부품 목록</span>
										<button type="button" class="btn btn-primary"
											id="add-item-btn">
											<i class="bi bi-plus-lg"></i>부품 추가
										</button>
									</div>

									<div class="table-responsive" id="items-wrap"
										data-scroll-rows="6">
										<div id="items-scroll">
											<table
												class="table table-sm table-bordered align-middle mb-0 product-table"
												id="items-table">
											<thead class="table-light">
												<tr>
													<th>부품명</th>
													<th class="numeric">요청수량</th>
													<th class="numeric">부품 단가</th>
													<th class="numeric">요청 총액</th>
													<th style="width: 7%;" class="text-center">삭제</th>
												</tr>
											</thead>
											<tbody id="items-tbody">
												<!-- 초기 1행 -->
												<tr>
													<td>
														<div class="input-group input-group-sm">
															<input type="hidden" class="partsNoInput"
																name="purchase_Item[0].partsDTO.parts_no" /> <input
																type="text"
																class="form-control form-control-sm partsNameInput"
																readonly tabindex="-1" style="background: #f6f6f6;" />
															<button type="button" class="btn btn-outline-secondary"
																onclick="openPartsPopup(this)">조회</button>
														</div>
													</td>
													<td class="numeric"><input type="number" min="0"
														name="purchase_Item[0].purchase_Item_Cnt"
														class="form-control form-control-sm qty-input" required />
													</td>
													<td class="numeric"><input type="number" step="0.01"
														min="0" name="purchase_Item[0].purchase_Item_Cost"
														class="form-control form-control-sm cost-input" required />
													</td>
													<td class="numeric"><input type="text"
														class="form-control form-control-plaintext form-control-sm tot-cost"
														readonly /></td>
													<td class="text-center">
														<button type="button"
															class="btn btn-sm btn-outline-danger remove-item-btn">
															<i class="bi bi-trash"></i> 삭제
														</button>
													</td>
												</tr>
											</tbody>
											<tfoot>
												<tr class="total-row">
													<td>합계</td>
													<td class="numeric"><span id="sum-req">0</span></td>
													<td></td>
													<td class="numeric"><span id="sum-cost">0</span></td>
													<td></td>
												</tr>
											</tfoot>
										</table>
									</div>
									</div>
								</section>

								<%--  <div class="text-end mt-4 d-flex justify-content-end gap-2">
                <a href="${pageContext.request.contextPath}/purchase/list" class="btn btn-outline-secondary btn-sm px-4">취소</a>
                <button type="submit" class="btn btn-primary btn-sm px-4">등록</button>
              </div> --%>
								<div class="row mt-4 g-2">
									<!-- 취소: 링크 -->
									<div class="col-md-4 d-grid">
										<a href="<c:url value='/purchase/list'/>"
											class="btn btn-outline-secondary btn-sm px-4" role="button">
											<i class="bi bi-x-circle me-2"></i>취소
										</a>
									</div>

									<!-- 수정: 폼 제출 -->
									<div class="col-md-8 d-grid">
										<button type="submit" id="modifyBtn"
											class="btn btn-primary btn-sm px-4">
											<i class="bi bi-check-lg me-2"></i>등록
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<jsp:include page="/foot.jsp" />
		</div>
	</div>

	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

