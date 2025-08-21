<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <!-- 공통 CSS 및 헤더 포함 (공통 레이아웃/스타일) -->
  <jsp:include page="/common.jsp" />
  <link rel="stylesheet" href="<c:url value='/css/list.css' />" />
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>수주 등록</title>

  <style>
    body { background-color:#f8f9fa; }
    .card-header { background-color:#0d6efd; color:#fff; }
    .required-field::after { content:" *"; color:red; }

    /* 가로 스크롤(부트스트랩 역할 유지) */
    #items-wrap { overflow-x:auto; }
    /* 기본은 세로 스크롤 숨김 */
    #items-scroll { position:relative; overflow-y:hidden; scrollbar-gutter:stable both-edges; overscroll-behavior:contain; }
    /* 임계 행수 초과 시에만 세로 스크롤 */
    #items-scroll.table-scroll { overflow-y:auto; }
    /* sticky header/footer도 #items-scroll 기준으로 동작 */
    #items-scroll.table-scroll thead th { position:sticky; top:0; z-index:2; background:var(--bs-table-bg,#fff); }
    #items-scroll.table-scroll tfoot td { position:sticky; bottom:0; z-index:1; background:var(--bs-body-bg,#fff); box-shadow:0 -1px 0 var(--bs-table-border-color,#dee2e6); }
    #items-scroll .table, #items-scroll thead, #items-scroll tbody, #items-scroll tfoot { height:auto !important; }
    /* 스크롤바 */
    #items-scroll::-webkit-scrollbar{ width:10px; height:auto !important; }
    #items-scroll::-webkit-scrollbar-thumb{ min-height:0 !important; height:auto !important; background:rgba(0,0,0,.35) !important; border-radius:6px; }
    #items-scroll{ scrollbar-width:auto; }
    #items-scroll::-webkit-scrollbar-track{ background:rgba(0,0,0,.06) !important; }
    /* sticky 헤더 위쪽 보더 + 보정라인 */
    #items-scroll.table-scroll thead th{ border-top:1px solid var(--bs-table-border-color,#dee2e6) !important; }
    #items-scroll.table-scroll::before{ content:""; position:sticky; top:0; display:block; height:1px; background:var(--bs-table-border-color,#dee2e6); z-index:3; pointer-events:none; }
    
    /* ====================== 합계행(총계) & 헤더/바닥선 보정 ====================== */
    .product-table thead > tr > * { border-bottom-width: 2px; }
    .product-table tfoot .total-row > * {
      border-top: 2px solid var(--bs-table-border-color, #dee2e6) !important;
    }
    .product-table tbody tr:last-child > * { border-bottom: 0 !important; }
    #items-scroll.table-scroll tfoot .total-row > * {
      position: sticky;
      bottom: 0;
      z-index: 3;
      background: var(--bs-body-bg, #fff);
      box-shadow: 0 -1px 0 var(--bs-table-border-color, #dee2e6),
                  0 -6px 12px rgba(0,0,0,.04);
    }
    .product-table tfoot .total-row > * { font-weight: 600; text-shadow: 0.5px 0.5px 0 rgba(0,0,0,.18); }
    .product-table tfoot .total-row td:first-child {
      letter-spacing: .2px;
      text-shadow: 0.7px 0.7px 0 rgba(0,0,0,.22), -0.5px -0.5px 0 rgba(255,255,255,.35);
    }
  </style>

  <!-- 오늘 날짜 문자열 (납기 min 값에서 사용) -->
  <jsp:useBean id="now" class="java.util.Date" />
  <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" timeZone="Asia/Seoul" />

  <script>
    /* ====================== 에러 헬퍼 ====================== */
    function showError(el, msg) {
      if (!el) return;
      el.setCustomValidity(msg);
      el.classList.add('is-invalid');
      const fb = el.closest('.col-12, .col-md-4, td')?.querySelector('.invalid-feedback')
                || el.parentElement.querySelector('.invalid-feedback');
      if (fb) { fb.textContent = msg; fb.classList.add('d-block'); }
      el.scrollIntoView({ behavior: 'smooth', block: 'center' });
      el.focus();
      el.reportValidity?.();
    }
    function clearError(el) {
      if (!el) return;
      el.setCustomValidity('');
      el.classList.remove('is-invalid');
      const fb = el.closest('.col-12, .col-md-4, td')?.querySelector('.invalid-feedback')
                || el.parentElement.querySelector('.invalid-feedback');
      if (fb) { fb.textContent = ''; fb.classList.remove('d-block'); }
    }
    
    /* ====================== 전역 상태 ====================== */
    // 이미 선택된 제품번호 보관(제품 중복 방지 — 버전 무시)
    const selectedProducts = new Set();

    // 팝업에서 채울 대상 포인터
    let currentRow = null;
    let targetProductInput = null;
    let targetProductNameInput = null;
    let targetProductVersionInput = null;

    /* ====================== 거래처 팝업 연동 ====================== */
    function openClientPopup() {
      window.open(
        '${pageContext.request.contextPath}/client/popup?client_Gubun=${client_Gubun}&client_Name=',
        'clientPopup',
        'width=1800,height=500,scrollbars=yes'
      );
    }
    function setClientInfo(client_No, client_Name, client_Address, client_Email, client_Tel, client_Man, empNo, empName) {
      document.getElementById('clientNoInput').value      = client_No;
      document.getElementById('clientNameInput').value    = client_Name;
      document.getElementById('clientAddressInput').value = client_Address;
      document.getElementById('clientEmailInput').value   = client_Email;
      document.getElementById('clientTelInput').value     = client_Tel;
      document.getElementById('clientManInput').value     = client_Man;
      if (empNo)   document.getElementById('empNoInput').value   = empNo;
      if (empName) document.getElementById('empNameInput').value = empName;

      clearError(document.getElementById('clientNameInput')); // 선택 시 에러 해제
      window.close();
    }

    /* ====================== 제품 팝업 연동 ====================== */
    function openProductPopup(btn) {
      const tr = btn.closest('tr');
      currentRow = tr;
      targetProductInput        = tr.querySelector('.productNoInput');
      targetProductNameInput    = tr.querySelector('.productNameInput');
      targetProductVersionInput = tr.querySelector('.productVersionInput');

      window.open(
        '${pageContext.request.contextPath}/sales/productPopup?product_Name=',
        'productPopup',
        'width=1800,height=560,scrollbars=yes'
      );
    }

    // 팝업에서 호출됨 (product_version 포함)
    function setProductInfo(product_no, product_name, product_version) {
      const pno   = String(product_no);
      const prevNo = targetProductInput?.value ? String(targetProductInput.value) : null;

      if (prevNo && prevNo === pno) { window.close(); return; } // 같은 행에 동일 선택 → 무시

      if (selectedProducts.has(pno)) {
        alert('이미 선택된 제품입니다.');
        const dup = document.querySelector('#items-tbody tr[data-product-no="' + pno + '"]');
        if (dup) {
          dup.classList.add('table-warning');
          dup.scrollIntoView({ behavior:'smooth', block:'center' });
          setTimeout(() => dup.classList.remove('table-warning'), 1200);
        }
        return;
      }

      if (prevNo) selectedProducts.delete(prevNo);

      if (targetProductInput)         targetProductInput.value        = pno;
      if (targetProductNameInput)     { targetProductNameInput.value    = product_name; clearError(targetProductNameInput); }
      if (targetProductVersionInput)  targetProductVersionInput.value = product_version;
      if (currentRow)                 currentRow.dataset.productNo    = pno;

      selectedProducts.add(pno);
      if (typeof recalcTotal === 'function') recalcTotal();
      window.close();
    }

    /* ====================== 합계 자동 계산 ====================== */
    function recalcTotal() {
      let sumReq = 0, sumCost = 0;
      document.querySelectorAll('#items-tbody tr').forEach(function(row){
        const qty  = Number(row.querySelector('.qty-input')?.value)  || 0;
        const cost = Number(row.querySelector('.cost-input')?.value) || 0;
        const tot  = qty * cost;
        const totCell = row.querySelector('.tot-cost');
        if (totCell) totCell.value = tot ? tot.toLocaleString() : '';
        sumReq  += qty;
        sumCost += tot;
      });
      const sumReqEl  = document.getElementById('sum-req');
      const sumCostEl = document.getElementById('sum-cost');
      if (sumReqEl)  sumReqEl.innerText  = sumReq.toLocaleString();
      if (sumCostEl) sumCostEl.innerText = sumCost.toLocaleString();
    }
    document.addEventListener('input', function(e){
      if (e.target.classList.contains('qty-input') || e.target.classList.contains('cost-input')) recalcTotal();
    });

    /* ====================== 행 인덱스 재정렬 (빈 인덱스 포함) ====================== */
    function reindexRows() {
      const rows = document.querySelectorAll('#items-tbody tr');
      rows.forEach(function(tr, i){
        tr.querySelectorAll('input[name^="sales_Item["], select[name^="sales_Item["], textarea[name^="sales_Item["]').forEach(function(inp){
          // \d* 로 "[]" (빈 인덱스)와 숫자 인덱스 모두 교체
          inp.name = inp.name.replace(/sales_Item\[\d*\]\./, 'sales_Item[' + i + '].');
        });
      });
    }

    /* ====================== 반응형 테이블 스크롤 ====================== */
    let updateScroll; // 외부 참조
    document.addEventListener('DOMContentLoaded', function(){
      const wrap     = document.getElementById('items-wrap');
      const scroller = document.getElementById('items-scroll');
      const table    = document.getElementById('items-table');
      const tbody    = document.getElementById('items-tbody');
      if (!wrap || !scroller || !table || !tbody) return;

      const SCROLL_ROWS = parseInt(wrap.dataset.scrollRows || '6', 10);

      function heightForRows(n){
        const thead = table.tHead, tfoot = table.tFoot;
        const rows = Array.from(tbody.rows);
        const rowsH = rows.slice(0, n).reduce((sum, r) => sum + r.getBoundingClientRect().height, 0);
        const headH = thead ? thead.getBoundingClientRect().height : 0;
        const footH = tfoot ? tfoot.getBoundingClientRect().height : 0;
        return Math.ceil(headH + footH + rowsH + 2);
      }

      updateScroll = function(){
        const rowCount = tbody.rows.length;
        const on = rowCount > SCROLL_ROWS;
        scroller.classList.toggle('table-scroll', on);
        if (on) {
          const h = heightForRows(SCROLL_ROWS);
          scroller.style.height = '';
          scroller.style.maxHeight = h + 'px';
          if (scroller.scrollHeight <= scroller.clientHeight) scroller.style.maxHeight = (h - 1) + 'px';
        } else {
          scroller.style.height = '';
          scroller.style.maxHeight = '';
        }
      };

      const mo = new MutationObserver(updateScroll);
      mo.observe(tbody, { childList:true });

      window.addEventListener('resize', updateScroll);
      updateScroll();
      window.addEventListener('load', updateScroll);
    });

    /* ====================== 동적 행 추가/삭제 + 초기화 ====================== */
    document.addEventListener('DOMContentLoaded', function(){
      const addBtn = document.getElementById('add-item-btn');
      const tbody  = document.getElementById('items-tbody');
      const table  = document.getElementById('items-table');
      const form   = document.getElementById('salesForm');

      // 초기 행에서 선택된 제품 선반영(대개 없음)
      document.querySelectorAll('#items-tbody .productNoInput').forEach(function(inp){
        if (inp.value) {
          const p = String(inp.value);
          selectedProducts.add(p);
          const tr = inp.closest('tr');
          if (tr) tr.dataset.productNo = p;
        }
      });

      // 항목 추가
      addBtn?.addEventListener('click', function(){
        const idx = tbody.querySelectorAll('tr').length;
        const tr = document.createElement('tr');
        tr.innerHTML =
          '<td>' +
            '<div class="input-group input-group-sm">' +
              '<input type="hidden" class="productNoInput" name="sales_Item['+idx+'].product_No" required />' +
              '<input type="hidden" class="productVersionInput" name="sales_Item['+idx+'].product_Version" required />' +
              '<input type="text" class="form-control form-control-sm productNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
              '<button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>' +
            '</div>' +
            '<div class="invalid-feedback">제품(버전) 선택이 필요합니다.</div>' + // ★ 추가
          '</td>' +
          '<td class="numeric">' +
            '<input type="number" min="0" name="sales_Item['+idx+'].sales_Item_Cnt" class="form-control form-control-sm qty-input" required />' +
          '</td>' +
          '<td class="numeric">' +
            '<input type="number" step="0.01" min="0" name="sales_Item['+idx+'].sales_Item_Cost" class="form-control form-control-sm cost-input" required />' +
          '</td>' +
          '<td class="numeric">' +
            '<input type="text" class="form-control form-control-plaintext form-control-sm tot-cost" readonly />' +
          '</td>' +
          '<td class="text-center">' +
            '<button type="button" class="btn btn-sm btn-outline-danger remove-item-btn"><i class="bi bi-trash"></i> 삭제</button>' +
          '</td>';
        tbody.appendChild(tr);
        if (typeof updateScroll === 'function') requestAnimationFrame(updateScroll);
      });

      // 항목 삭제 (Set에서 제품번호도 제거) + 재인덱싱 + 합계
      table?.addEventListener('click', function(e){
        const btn = e.target.closest('.remove-item-btn');
        if (!btn) return;
        const tr = btn.closest('tr');
        const no = tr.querySelector('.productNoInput')?.value;
        if (no) selectedProducts.delete(String(no));
        tr.remove();
        reindexRows();
        recalcTotal();
        if (typeof updateScroll === 'function') requestAnimationFrame(updateScroll);
      });

      // 제출 전 검증 + 재인덱싱 + 누락 필드 보강
      form?.addEventListener('submit', function(e){
        // 1) 거래처 먼저 1회 검증
        const clientNoEl   = document.getElementById('clientNoInput');
        const clientNameEl = document.getElementById('clientNameInput');
        if (!clientNoEl.value.trim()) {
          e.preventDefault();
          showError(clientNameEl, '거래처를 선택하세요.');
          return;
        } else {
          clearError(clientNameEl);
        }

        // 2) 납기일 유효성
        const dateEl    = document.getElementById('salesDate');
        const dateError = document.getElementById('dateError');
        if (!dateEl.value) {
          e.preventDefault();
          showError(dateEl, '납기 완료일을 선택하세요.');
          if (dateError) dateError.textContent = '납기 완료일을 선택하세요.';
          return;
        } else {
          const picked = new Date(dateEl.value);
          const today  = new Date('${todayStr}');
          if (picked < today) {
            e.preventDefault();
            showError(dateEl, '납기 완료일은 오늘 이후만 가능합니다.');
            if (dateError) dateError.textContent = '오늘 이후 날짜로 선택해주세요.';
            return;
          } else {
            clearError(dateEl);
            if (dateError) dateError.textContent = '';
          }
        }

        // 3) 최소 1행
        const rows = document.querySelectorAll('#items-tbody tr');
        if (rows.length === 0) {
          e.preventDefault();
          alert('제품 항목을 최소 1개 이상 추가하세요.');
          return;
        }

        // 4) 재인덱싱 먼저
        reindexRows();

        // 5) name에 빈 인덱스([]) 남아있으면 막기
        const formElts = form.querySelectorAll('[name^="sales_Item["]');
        const bad = Array.from(formElts).filter(el => /\[\]/.test(el.name));
        if (bad.length) {
          e.preventDefault();
          console.warn('잘못된 name들:', bad.map(e => e.name));
          alert('일시적 오류가 발생했습니다. 다시 저장을 시도해주세요.');
          return;
        }

        // 6) 각 행 검증 + OUTCNT=0 주입 (for문으로 최초 에러에서 중단)
        for (let i = 0; i < rows.length; i++) {
          const row    = rows[i];
          const noEl   = row.querySelector('.productNoInput');
          const verEl  = row.querySelector('.productVersionInput');
          const nameEl = row.querySelector('.productNameInput'); // 보이는 필드
          const qtyEl  = row.querySelector('.qty-input');
          const costEl = row.querySelector('.cost-input');

          // 제품/버전
          if (!noEl?.value || !verEl?.value) {
            e.preventDefault();
            showError(nameEl, '제품(버전) 선택이 필요합니다.');
            return;
          } else {
            clearError(nameEl);
          }

          // 수량
          const qty = Number(qtyEl?.value);
          if (!Number.isFinite(qty) || qty <= 0) {
            e.preventDefault();
            showError(qtyEl, '요청 수량을 1 이상 입력하세요.');
            return;
          } else {
            clearError(qtyEl);
          }

          // 단가
          const cost = Number(costEl?.value);
          if (!Number.isFinite(cost) || cost < 0) {
            e.preventDefault();
            showError(costEl, '단가는 0 이상이어야 합니다.');
            return;
          } else {
            clearError(costEl);
          }

          // OUTCNT 기본값(0) 없으면 추가
          const sel = 'input[name="sales_Item['+i+'].sales_Item_OutCnt"]';
          if (!row.querySelector(sel)) {
            const hidden = document.createElement('input');
            hidden.type  = 'hidden';
            hidden.name  = 'sales_Item['+i+'].sales_Item_OutCnt';
            hidden.value = '0';
            row.appendChild(hidden);
          }
        }
        // 통과 시 submit 진행
      });

      // 초기 합계
      recalcTotal();
    });
  </script>
</head>
<body>
  <div id="layout">
    <!-- 사이드 내비게이션 포함 -->
    <div id="side"><jsp:include page="/side.jsp" /></div>

    <div id="main-area">
      <!-- 헤더 포함 (상단 공통 네비/로고 등) -->
      <jsp:include page="/header.jsp" />

      <!-- 컨텐츠 영역 시작 -->
      <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
      <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

      <div id="contents">
        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="/sales/list" class="btn btn-outline-light btn-sm"><i class="bi bi-list-ul me-1"></i> 목록</a>
              <h4 class="card-title mb-0"><i class="bi bi-pencil-square me-2"></i>수주 등록</h4>
              <div style="width:90px;"></div>
            </div>

            <div class="card-body p-4">
              <form id="salesForm" action="${pageContext.request.contextPath}/sales/create" method="post">
                <!-- 수주 / 거래처 입력 -->
                <section aria-labelledby="order-create-title" class="info-card" aria-label="수주 및 거래처 정보">
                  <div id="order-create-title" class="info-card-title">수주 / 거래처 정보</div>
                  <div class="row g-3">
                    <div class="col-12">
                      <label class="form-label">제목 <span class="text-danger">*</span></label>
                      <input type="text" id="salesTitleInput" name="sales_Title"
                             class="form-control form-control-sm" required
                             placeholder="예: 2025-08 CPU 쿨러 발주 (요청서 #A-231)" />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">거래처 이름 <span class="text-danger">*</span></label>
                      <div class="input-group input-group-sm">
                        <input type="hidden" id="clientNoInput" name="clientDto.client_No" required />
                        <input type="text" id="clientNameInput" class="form-control form-control-sm" readonly required placeholder="조회 버튼으로 선택" />
                        <button type="button" class="btn btn-outline-secondary" onclick="openClientPopup()">조회</button>
                      </div>
                      <div class="invalid-feedback" id="clientNameFeedback">거래처를 선택하세요.</div>
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">주소</label>
                      <input type="text" id="clientAddressInput" class="form-control form-control-sm" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">이메일</label>
                      <div class="input-group input-group-sm">
                        <input type="email" id="clientEmailInput" class="form-control" readonly />
                      </div>
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">거래처 전화번호</label>
                      <input type="text" id="clientTelInput" class="form-control form-control-sm" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">거래처 담당자</label>
                      <input type="text" id="clientManInput" class="form-control form-control-sm" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">담당자 이름</label>
                      <input type="hidden" id="empNoInput" name="empDTO.empNo" />
                      <input type="text" id="empNameInput" class="form-control form-control-sm" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">납기 완료일</label>
                      <input type="date" id="salesDate" class="form-control form-control-sm" name="sales_Date" min="${todayStr}" required />
                      <div id="dateError" class="form-text" style="color:#dc3545;"></div>
                    </div>
                  </div>
                </section>

                <!-- 제품 목록 -->
                <section aria-labelledby="product-list-title" class="info-card mt-4" aria-label="제품 목록">
                  <div id="product-list-title" class="info-card-title d-flex justify-content-between align-items-center">
                    <span>제품 목록</span>
                    <button type="button" class="btn btn-primary" id="add-item-btn">
                      <i class="bi bi-plus-lg"></i>제품 추가
                    </button>
                  </div>

                  <div class="table-responsive" id="items-wrap" data-scroll-rows="6">
                    <div id="items-scroll">
                      <table class="table table-sm table-bordered align-middle mb-0 product-table" id="items-table">
                        <caption class="visually-hidden">등록할 제품 목록</caption>
                        <thead class="table-light">
                          <tr>
                            <th style="width:45%;" class="text-center" scope="col">제품명</th>
                            <th style="width:15%;" scope="col" class="numeric text-center">요청수량</th>
                            <th style="width:15%;" scope="col" class="numeric text-center">제품 단가</th>
                            <th style="width:15%;" scope="col" class="numeric text-center">요청 총액</th>
                            <th style="width:10%;"  scope="col" class="text-center">삭제</th>
                          </tr>
                        </thead>
                        <tbody id="items-tbody">
                          <!-- 초기 1행 -->
                          <tr>
                            <td>
                              <div class="input-group input-group-sm">
                                <input type="hidden" class="productNoInput" name="sales_Item[0].product_No" required />
                                <input type="hidden" class="productVersionInput" name="sales_Item[0].product_Version" required />
                                <input type="text" class="form-control form-control-sm productNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />
                                <button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>
                              </div>
                              <div class="invalid-feedback">제품(버전) 선택이 필요합니다.</div>
                            </td>
                            <td class="numeric">
                              <input type="number" min="0" name="sales_Item[0].sales_Item_Cnt" class="form-control form-control-sm qty-input" required />
                            </td>
                            <td class="numeric">
                              <input type="number" step="0.01" min="0" name="sales_Item[0].sales_Item_Cost" class="form-control form-control-sm cost-input" required />
                            </td>
                            <td class="numeric">
                              <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost" readonly />
                            </td>
                            <td class="text-center">
                              <button type="button" class="btn btn-sm btn-outline-danger remove-item-btn"><i class="bi bi-trash"></i> 삭제</button>
                            </td>
                          </tr>
                        </tbody>
                        <tfoot>
                          <tr class="total-row table-light">
                            <td class="text-center">합계</td>
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

                <!-- 액션 버튼 -->
                <div class="row mt-4 g-2">
                  <div class="col-md-4 d-grid">
                    <a href="<c:url value='/sales/list'/>" class="btn btn-outline-secondary btn-sm px-4" role="button">
                      <i class="bi bi-x-circle me-2"></i>취소
                    </a>
                  </div>
                  <div class="col-md-8 d-grid">
                    <button type="submit" class="btn btn-primary btn-sm px-4">
                      <i class="bi bi-check-lg me-2"></i>등록
                    </button>
                  </div>
                </div>
              </form>
            </div>

          </div>
        </div>
      </div>

      <!-- 부트스트랩 JS -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      <!-- 공통 푸터 포함 -->
      <jsp:include page="/foot.jsp" />
    </div>
  </div>
</body>
</html>
  
