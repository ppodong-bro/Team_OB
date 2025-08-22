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
  <title>수주 수정</title>

  <style>
    body { background-color:#f8f9fa; }
    .card-header { background-color:#198754; color:#fff; }
    .required-field::after { content:" *"; color:red; }
    .numeric{ text-align:right; }

    /* 가로 스크롤(부트스트랩 역할 유지) */
    #items-wrap{ overflow-x:auto; }

    /* 기본은 세로 스크롤 숨김 */
    #items-scroll{
      position:relative; overflow-y:hidden;
      scrollbar-gutter:stable both-edges; overscroll-behavior:contain; padding-bottom:1px;
    }

    /* 임계 행수 초과 시에만 세로 스크롤 */
    #items-scroll.table-scroll{ overflow-y:auto; }

    /* sticky header/footer도 #items-scroll 기준으로 동작 */
    #items-scroll.table-scroll thead th{
      position:sticky; top:0; z-index:2; background:var(--bs-table-bg,#fff);
    }
    #items-scroll.table-scroll tfoot td{
      position:sticky; bottom:0; z-index:1; background:var(--bs-body-bg,#fff);
      box-shadow:0 -1px 0 var(--bs-table-border-color,#dee2e6);
    }

    /* 전역 height:100%류 무력화 (#items-scroll 제외) */
    #items-scroll .table, #items-scroll thead, #items-scroll tbody, #items-scroll tfoot { height:auto !important; }

    /* 스크롤바 테마 */
    #items-scroll::-webkit-scrollbar{ width:10px; height:auto !important; }
    #items-scroll::-webkit-scrollbar-thumb{ min-height:0 !important; height:auto !important; background:rgba(0,0,0,.35) !important; border-radius:6px; }
    #items-scroll{ scrollbar-width:auto; }
    #items-scroll::-webkit-scrollbar-track{ background:rgba(0,0,0,.06) !important; }

    /* sticky 헤더 위쪽 보더 + 최상단 라인 보정 */
    #items-scroll.table-scroll thead th{ border-top:1px solid var(--bs-table-border-color,#dee2e6) !important; }
    #items-scroll.table-scroll::before{
      content:""; position:sticky; top:0; display:block; height:1px;
      background:var(--bs-table-border-color,#dee2e6); z-index:3; pointer-events:none;
    }

    .table-warning{ animation:blink 1s ease-in-out 1; }
    @keyframes blink { 0%{background:#fff3cd;} 100%{background:transparent;} }

    /* ====================== 합계행(총계) & 헤더/바닥선 보정 ====================== */
    .product-table thead > tr > * { border-bottom-width: 2px; }
    .product-table tfoot .total-row > * { border-top: 2px solid var(--bs-table-border-color,#dee2e6) !important; }
    .product-table tbody tr:last-child > * { border-bottom: 0 !important; }

    #items-scroll.table-scroll tfoot .total-row > *{
      position:sticky; bottom:0; z-index:3; background:var(--bs-body-bg,#fff);
      box-shadow:0 -1px 0 var(--bs-table-border-color,#dee2e6), 0 -6px 12px rgba(0,0,0,.04);
    }

    .product-table tfoot .total-row > *{ font-weight:600; text-shadow:.5px .5px 0 rgba(0,0,0,.18); }
    .product-table tfoot .total-row td:first-child{
      letter-spacing:.2px;
      text-shadow:.7px .7px 0 rgba(0,0,0,.22), -0.5px -0.5px 0 rgba(255,255,255,.35);
    }
    
    input[type=number]::-webkit-outer-spin-button,
	input[type=number]::-webkit-inner-spin-button{ -webkit-appearance:none; margin:0; }
	input[type=number]{ -moz-appearance:textfield; appearance:textfield; }
  </style>

  <!-- 오늘 날짜 (납기 min 값에서 사용) -->
  <jsp:useBean id="now" class="java.util.Date" />
  <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" timeZone="Asia/Seoul" />

  <script>
    /* ====================== 에러 표시 헬퍼 ====================== */
    function showError(el, msg){
      if(!el) return;
      el.setCustomValidity(msg);
      el.classList.add('is-invalid');
      const fb = el.closest('.input-group, td, .col-md-4, .col-12')?.querySelector('.invalid-feedback');
      if (fb){ fb.textContent = msg; fb.classList.add('d-block'); }
      el.reportValidity?.();
    }
    function clearError(el){
      if(!el) return;
      el.setCustomValidity('');
      el.classList.remove('is-invalid');
      const fb = el.closest('.input-group, td, .col-md-4, .col-12')?.querySelector('.invalid-feedback');
      if (fb){ fb.textContent = ''; fb.classList.remove('d-block'); }
    }

    /* ====================== 전역 상태 ====================== */
    const selectedProducts = new Set(); // 제품 중복 방지(제품번호 기준)

    let currentRow = null;
    let targetProductInput = null;
    let targetProductNameInput = null;
    let targetProductVersionInput = null;

    /* ====================== 거래처 팝업 ====================== */
    function openClientPopup() {
      window.open(
        '${pageContext.request.contextPath}/client/popup?client_Gubun=${client_Gubun}&client_Name=',
        'clientPopup',
        'width=1800,height=500,scrollbars=yes'
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
      clearError(document.getElementById('clientNameInput'));
      window.close();
    }

    /* ====================== 제품 팝업 ====================== */
    function openProductPopup(btn){
      const tr = btn.closest('tr');
      currentRow                 = tr;
      targetProductInput         = tr.querySelector('.productNoInput');
      targetProductNameInput     = tr.querySelector('.productNameInput');
      targetProductVersionInput  = tr.querySelector('.productVersionInput');

      window.open(
        '${pageContext.request.contextPath}/sales/productPopup?product_Name=',
        'productPopup',
        'width=1800,height=560,scrollbars=yes'
      );
    }

    function setProductInfo(product_no, product_name, product_version){
      const pno    = String(product_no || '');
      const prevNo = targetProductInput?.value ? String(targetProductInput.value) : null;

      if (prevNo && prevNo === pno) { window.close(); return; }

      if (pno && selectedProducts.has(pno)) {
        alert('이미 선택된 제품입니다.');
        const dup = document.querySelector('#items-tbody tr[data-product-no="'+pno+'"]');
        if (dup) {
          dup.classList.add('table-warning');
          dup.scrollIntoView({ behavior:'smooth', block:'center' });
          setTimeout(()=>dup.classList.remove('table-warning'), 1200);
        }
        return;
      }

      if (prevNo) selectedProducts.delete(prevNo);

      if (targetProductInput)         targetProductInput.value        = pno;
      if (targetProductNameInput)    {targetProductNameInput.value    = product_name || ''; clearError(targetProductNameInput);}
      if (targetProductVersionInput)  targetProductVersionInput.value = product_version || '';
      if (currentRow)                 currentRow.dataset.productNo    = pno;

      if (pno) selectedProducts.add(pno);

      if (typeof recalcTotal==='function') recalcTotal();
      window.close();
    }

    /* ====================== 합계 계산 ====================== */
    function recalcTotal(){
      let sumReq = 0, sumCost = 0;

      document.querySelectorAll('#items-tbody tr').forEach((row)=>{
        const qty  = Number(row.querySelector('.qty-input')?.value)  || 0;
        const cost = Number(row.querySelector('.cost-input')?.value) || 0;
        const tot  = qty * cost;

        const totCell = row.querySelector('.tot-cost');
        if (totCell) totCell.value = (tot || tot===0) ? tot.toLocaleString() : '';

        sumReq  += qty;
        sumCost += tot;
      });

      const sumReqEl  = document.getElementById('sum-req');
      const sumCostEl = document.getElementById('sum-cost');
      if (sumReqEl)  sumReqEl.innerText  = sumReq.toLocaleString();
      if (sumCostEl) sumCostEl.innerText = sumCost.toLocaleString();
    }

    document.addEventListener('input', function(e){
      const t = e.target;

      if (t.classList.contains('qty-input')){
        const v = Number(t.value);
        t.setCustomValidity(Number.isFinite(v) && v >= 1 ? '' : '요청 수량을 1 이상 입력하세요.');
        if (t.checkValidity()) t.classList.remove('is-invalid');
      }

      if (t.classList.contains('cost-input')){
        const raw = t.value.trim();
        const v = raw==='' ? NaN : Number(raw);
        t.setCustomValidity(Number.isFinite(v) && v >= 0 ? '' : '단가는 0 이상이어야 합니다.');
        if (t.checkValidity()) t.classList.remove('is-invalid');
      }

      if (t.classList.contains('qty-input') || t.classList.contains('cost-input')) recalcTotal();
    });

    /* ====================== 인덱스 재정렬 ====================== */
    function reindexRows(){
      const rows = document.querySelectorAll('#items-tbody tr');
      rows.forEach((tr, i)=>{
        tr.querySelectorAll('input[name^="sales_Item["],select[name^="sales_Item["],textarea[name^="sales_Item["]')
          .forEach(inp=>{
            // ^ 앵커로 안전하게 치환 (빈 인덱스 "[]" 포함)
            inp.name = inp.name.replace(/^sales_Item\[\d*\]\./, 'sales_Item['+i+'].');
          });
      });
    }

    /* ====================== 반응형 테이블(행 수 기준 스크롤) ====================== */
    let updateScroll;
    document.addEventListener('DOMContentLoaded', function(){
      const wrap     = document.getElementById('items-wrap');
      const scroller = document.getElementById('items-scroll');
      const table    = document.getElementById('items-table');
      const tbody    = document.getElementById('items-tbody');
      if (!wrap || !scroller || !table || !tbody) return;

      const SCROLL_ROWS = parseInt(wrap.dataset.scrollRows || '6', 10);

      function heightForRows(n){
        const thead = table.tHead;
        const tfoot = table.tFoot;
        const rows  = Array.from(tbody.rows);
        const rowsH = rows.slice(0, n).reduce((sum, r)=> sum + r.getBoundingClientRect().height, 0);
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
      document.getElementById('add-item-btn')?.addEventListener('click', ()=> requestAnimationFrame(updateScroll));
      document.addEventListener('click', (e)=>{ if (e.target.closest('.remove-item-btn')) requestAnimationFrame(updateScroll); });

      updateScroll();
      window.addEventListener('load', updateScroll);
    });

    /* ====================== 동적 행 추가/삭제 + 초기화 ====================== */
    document.addEventListener('DOMContentLoaded', function(){
      const addBtn = document.getElementById('add-item-btn');
      const tbody  = document.getElementById('items-tbody');
      const table  = document.getElementById('items-table');
      const form   = document.getElementById('salesForm');

      // 수정폼: 기존 선택값을 Set에 미리 반영
      document.querySelectorAll('#items-tbody .productNoInput').forEach(inp=>{
        if (inp.value){
          const p = String(inp.value);
          selectedProducts.add(p);
          const tr = inp.closest('tr');
          if (tr) tr.dataset.productNo = p;
        }
      });

      // 항목 추가
      addBtn?.addEventListener('click', function(){
        const idx = tbody.querySelectorAll('tr').length;
        const tr  = document.createElement('tr');
        tr.innerHTML =
          '<td>' +
            '<div class="input-group input-group-sm has-validation">' +
              '<input type="hidden" class="productNoInput" name="sales_Item['+idx+'].product_No" />' +
              '<input type="hidden" class="productVersionInput" name="sales_Item['+idx+'].product_Version" />' +
              '<input type="text" class="form-control form-control-sm productNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
              '<button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>' +
              '<div class="invalid-feedback">제품(버전) 선택이 필요합니다.</div>' +
            '</div>' +
          '</td>' +
          '<td class="numeric">' +
            '<input type="number" min="1" step="1" name="sales_Item['+idx+'].sales_Item_Cnt" class="form-control form-control-sm qty-input text-end" required />' +
          '</td>' +
          '<td class="numeric">' +
            '<input type="number" min="0" name="sales_Item['+idx+'].sales_Item_Cost" class="form-control form-control-sm cost-input text-end" required />' +
          '</td>' +
          '<td class="numeric">' +
            '<input type="text" class="form-control form-control-plaintext form-control-sm tot-cost text-end" readonly />' +
          '</td>' +
          '<td class="text-center">' +
            '<button type="button" class="btn btn-sm btn-outline-danger remove-item-btn"><i class="bi bi-trash"></i> 삭제</button>' +
          '</td>';
        tbody.appendChild(tr);
        if (typeof updateScroll==='function') requestAnimationFrame(updateScroll);
      });

      // 항목 삭제
      table?.addEventListener('click', function(e){
        const btn = e.target.closest('.remove-item-btn');
        if (!btn) return;
        const tr = btn.closest('tr');
        const no = tr.querySelector('.productNoInput')?.value;
        if (no) selectedProducts.delete(String(no));
        tr.remove();
        reindexRows();
        recalcTotal();
        if (typeof updateScroll==='function') requestAnimationFrame(updateScroll);
      });

      // 제출 전 검증
      form?.addEventListener('submit', function(e){
        // 거래처
        const clientNoEl   = document.getElementById('clientNoInput');
        const clientNameEl = document.getElementById('clientNameInput');
        if (!clientNoEl.value.trim()){
          showError(clientNameEl, '거래처를 선택하세요.');
          e.preventDefault(); return;
        } else {
          clearError(clientNameEl);
        }

        // 납기일
        const dateEl = document.getElementById('salesDate');
        const dateError = document.getElementById('dateError');
        if (!dateEl.value){
          showError(dateEl, '납기 완료일을 선택하세요.');
          if (dateError) dateError.textContent = '납기 완료일을 선택하세요.';
          e.preventDefault(); return;
        } else {
          const picked = new Date(dateEl.value);
          const today  = new Date('${todayStr}');
          if (picked < today){
            showError(dateEl, '납기 완료일은 오늘 이후만 가능합니다.');
            if (dateError) dateError.textContent = '오늘 이후 날짜로 선택해주세요.';
            e.preventDefault(); return;
          } else {
            clearError(dateEl);
            if (dateError) dateError.textContent = '';
          }
        }

        // 최소 1행
        const rows = document.querySelectorAll('#items-tbody tr');
        if (rows.length===0){
          alert('제품 항목을 최소 1개 이상 추가하세요.');
          e.preventDefault(); return;
        }

        // 재인덱싱
        reindexRows();

        // 빈 인덱스([]) 사전 차단
        const bad = Array.from(form.querySelectorAll('[name^="sales_Item["]')).filter(el=> /\[\]/.test(el.name));
        if (bad.length){
          console.warn('잘못된 name들:', bad.map(e=>e.name));
          alert('일시적 오류가 발생했습니다. 다시 저장을 시도해주세요.');
          e.preventDefault(); return;
        }

        // 각 행 검증 + 누락 필드 보강
        for (let i=0; i<rows.length; i++){
          const row   = rows[i];
          const noEl  = row.querySelector('.productNoInput');
          const verEl = row.querySelector('.productVersionInput');
          const nameEl= row.querySelector('.productNameInput');
          const qtyEl = row.querySelector('.qty-input');
          const costEl= row.querySelector('.cost-input');

          if (!noEl?.value || !verEl?.value){
            showError(nameEl, '제품(버전) 선택이 필요합니다.');
            nameEl.scrollIntoView({ behavior:'smooth', block:'center' });
            nameEl.focus();
            e.preventDefault(); return;
          } else {
            clearError(nameEl);
          }

          const qty  = Number(qtyEl?.value);
          const cost = Number(costEl?.value);

          if (!Number.isFinite(qty) || qty < 1){
            showError(qtyEl, '요청 수량을 1 이상 입력하세요.');
            e.preventDefault(); return;
          } else clearError(qtyEl);

          if (!Number.isFinite(cost) || cost < 0){
            showError(costEl, '단가는 0 이상이어야 합니다.');
            e.preventDefault(); return;
          } else clearError(costEl);

          // SALES_ITEM_OUTCNT 기본값(0) 보강
          const sel = 'input[name="sales_Item['+i+'].sales_Item_OutCnt"]';
          if (!row.querySelector(sel)){
            const hidden = document.createElement('input');
            hidden.type  = 'hidden';
            hidden.name  = 'sales_Item['+i+'].sales_Item_OutCnt';
            hidden.value = '0';
            row.appendChild(hidden);
          }
        }
      });

      recalcTotal();
    });
    
    // ↑/↓ 키로 100단위 증감 (min/max 존중, 빈 값이면 0에서 시작)
    document.addEventListener('keydown', function (e) {
      const t = e.target;
      if (!t.classList.contains('cost-input')) return;

      if (e.key === 'ArrowUp' || e.key === 'ArrowDown') {
        e.preventDefault();

        const step = 100; // 바꾸고 싶으면 여기만 수정
        const delta = (e.key === 'ArrowUp') ? step : -step;

        const minAttr = t.getAttribute('min');
        const maxAttr = t.getAttribute('max');
        const min = Number.isFinite(parseFloat(minAttr)) ? parseFloat(minAttr) : -Infinity;
        const max = Number.isFinite(parseFloat(maxAttr)) ? parseFloat(maxAttr) :  Infinity;

        let v = parseFloat(t.value);
        if (!Number.isFinite(v)) v = 0;

        v = Math.min(max, Math.max(min, v + delta));
        t.value = (t.classList.contains('cost-input')) ? v : Math.round(v);

        // 합계 갱신 및 커스텀 유효성 로직 재사용
        t.dispatchEvent(new Event('input', { bubbles: true }));
      }
    });
    
  </script>
</head>
<body>
  <div id="layout">
    <!-- 사이드 내비게이션 -->
    <div id="side"><jsp:include page="/side.jsp" /></div>

    <div id="main-area">
      <!-- 헤더 -->
      <jsp:include page="/header.jsp" />

      <!-- 컨텐츠 -->
      <div id="contents">
        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="/sales/list" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0"><i class="bi bi-pencil-square me-2"></i>수주 수정</h4>
              <div style="width:90px;"></div>
            </div>

            <div class="card-body p-4">
              <form id="salesForm" action="${pageContext.request.contextPath}/sales/modify" method="post">
                <!-- 키/상태 -->
                <input type="hidden" name="sales_No"    value="${sales_OrderDto.sales_No}" />
                <input type="hidden" name="out_Status"  value="${sales_OrderDto.out_Status}" />

                <!-- 수주 / 거래처 입력 -->
                <section aria-labelledby="order-create-title" class="info-card" aria-label="수주 및 거래처 정보">
                  <div id="order-create-title" class="info-card-title">수주 / 거래처 정보</div>
                  <div class="row g-3">
                    <div class="col-12">
                      <label class="form-label">제목 <span class="text-danger">*</span></label>
                      <input type="text" id="salesTitleInput" name="sales_Title"
                             value="${sales_OrderDto.sales_Title}"
                             class="form-control form-control-sm" required
                             placeholder="예: 2025-08 CPU 쿨러 수주 (견적 #Q-231)" />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">거래처명<span class="text-danger">*</span></label>
                      <div class="input-group input-group-sm has-validation">
                        <input type="hidden" id="clientNoInput"  name="clientDto.client_No"  value="${sales_OrderDto.clientDto.client_No}" />
                        <input type="text"   id="clientNameInput" name="clientDto.client_Name"
                               class="form-control form-control-sm"
                               value="${sales_OrderDto.clientDto.client_Name}" readonly required placeholder="조회 버튼으로 선택" />
                        <button type="button" class="btn btn-outline-secondary" onclick="openClientPopup()">조회</button>
                        <div class="invalid-feedback">거래처를 선택하세요.</div>
                      </div>
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">주소</label>
                      <input type="text" id="clientAddressInput" name="clientDto.client_Address"
                             class="form-control form-control-sm"
                             value="${sales_OrderDto.clientDto.client_Address}" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">이메일</label>
                      <div class="input-group input-group-sm">
                        <input type="email" id="clientEmailInput" name="clientDto.client_Email"
                               class="form-control" value="${sales_OrderDto.clientDto.client_Email}" readonly />
                      </div>
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">거래처 전화번호</label>
                      <input type="text" id="clientTelInput" name="clientDto.client_Tel"
                             class="form-control form-control-sm" value="${sales_OrderDto.clientDto.client_Tel}" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">거래처 담당자</label>
                      <input type="text" id="clientManInput" name="clientDto.client_Man"
                             class="form-control form-control-sm" value="${sales_OrderDto.clientDto.client_Man}" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">영업 담당자</label>
                      <input type="hidden" id="empNoInput" name="empDTO.empNo" value="${sales_OrderDto.empDTO.empNo}" />
                      <input type="text"   id="empNameInput" name="empDTO.empName"
                             class="form-control form-control-sm" value="${sales_OrderDto.empDTO.empName}" readonly />
                    </div>

                    <div class="col-md-4">
                      <label class="form-label">납기 완료일</label>
                      <input type="date" id="salesDate" class="form-control form-control-sm"
                             name="sales_Date" value="${fn:substring(sales_OrderDto.sales_Date,0,10)}"
                             min="${todayStr}" required />
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
                        <caption class="visually-hidden">수정할 제품 목록</caption>
                        <thead class="table-light">
                          <tr>
                            <th style="width:45%" class="text-center" scope="col">제품명</th>
                            <th style="width:15%" class="numeric text-center" scope="col">요청 수량</th>
                            <th style="width:15%" class="numeric text-center" scope="col">제품 단가</th>
                            <th style="width:15%" class="numeric text-center" scope="col">요청 총액</th>
                            <th style="width:10%" class="text-center" scope="col">삭제</th>
                          </tr>
                        </thead>
                        <tbody id="items-tbody">
                          <c:choose>
                            <c:when test="${not empty sales_OrderDto.sales_Item}">
                              <c:forEach var="item" items="${sales_OrderDto.sales_Item}" varStatus="st">
                                <tr data-product-no="${item.product_No}">
                                  <td>
                                    <div class="input-group input-group-sm has-validation">
                                      <input type="hidden" class="productNoInput"
                                             name="sales_Item[${st.index}].product_No"
                                             value="${item.product_No}" />
                                      <input type="hidden" class="productVersionInput"
                                             name="sales_Item[${st.index}].product_Version"
                                             value="${item.product_Version}" />
                                      <input type="text" class="form-control form-control-sm productNameInput"
                                             value="${item.productDto != null ? item.productDto.product_name : ''}"
                                             readonly tabindex="-1" style="background:#f6f6f6;" />
                                      <button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>
                                      <div class="invalid-feedback">제품(버전) 선택이 필요합니다.</div>
                                    </div>
                                  </td>
                                  <td class="numeric">
                                    <input type="number" min="1" step="1"
                                           name="sales_Item[${st.index}].sales_Item_Cnt"
                                           class="form-control form-control-sm qty-input text-end"
                                           value="${item.sales_Item_Cnt}" required />
                                  </td>
                                  <td class="numeric">
                                    <input type="number" min="0"
                                           name="sales_Item[${st.index}].sales_Item_Cost"
                                           class="form-control form-control-sm cost-input text-end"
                                           value="${item.sales_Item_Cost}" required />
                                  </td>
                                  <td class="numeric">
                                    <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost text-end"
                                           value="<fmt:formatNumber value='${item.sales_Item_TotCost}' type='number' groupingUsed='true'/>"
                                           readonly />
                                  </td>
                                  <td class="text-center">
                                    <button type="button" class="btn btn-sm btn-outline-danger remove-item-btn">
                                      <i class="bi bi-trash"></i> 삭제
                                    </button>
                                  </td>
                                </tr>
                              </c:forEach>
                            </c:when>
                            <c:otherwise>
                              <!-- 기존 품목이 없으면 1행 생성 -->
                              <tr>
                                <td>
                                  <div class="input-group input-group-sm has-validation">
                                    <input type="hidden" class="productNoInput" name="sales_Item[0].product_No" />
                                    <input type="hidden" class="productVersionInput" name="sales_Item[0].product_Version" />
                                    <input type="text" class="form-control form-control-sm productNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />
                                    <button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>
                                    <div class="invalid-feedback">제품(버전) 선택이 필요합니다.</div>
                                  </div>
                                </td>
                                <td class="numeric">
                                  <input type="number" min="1" step="1" name="sales_Item[0].sales_Item_Cnt"
                                         class="form-control form-control-sm qty-input text-end" required />
                                </td>
                                <td class="numeric">
                                  <input type="number" min="0" name="sales_Item[0].sales_Item_Cost"
                                         class="form-control form-control-sm cost-input text-end" required />
                                </td>
                                <td class="numeric">
                                  <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost text-end" readonly />
                                </td>
                                <td class="text-center">
                                  <button type="button" class="btn btn-sm btn-outline-danger remove-item-btn">
                                    <i class="bi bi-trash"></i> 삭제
                                  </button>
                                </td>
                              </tr>
                            </c:otherwise>
                          </c:choose>
                        </tbody>
                        <tfoot>
                          <tr class="total-row table-light">
                            <td class="text-center">합계</td>
                            <td class="numeric"><span id="sum-req"><fmt:formatNumber value="${sales_OrderDto.totCnt}" type="number" groupingUsed="true" /></span></td>
                            <td></td>
                            <td class="numeric"><span id="sum-cost"><fmt:formatNumber value="${sales_OrderDto.totCost}" type="number" groupingUsed="true" /></span></td>
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
                    <button type="submit" id="modifyBtn" class="btn btn-primary btn-sm px-4">
                      <i class="bi bi-check-lg me-2"></i>수정
                    </button>
                  </div>
                </div>

              </form>
            </div>
          </div>
        </div>
      </div>

      <!-- 부트스트랩 및 공통 푸터 -->
      <jsp:include page="/common_cdn.jsp" />
      <jsp:include page="/foot.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </div>
  </div>
</body>
</html>
