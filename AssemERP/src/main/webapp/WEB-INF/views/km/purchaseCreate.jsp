<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    body { background:#f8f9fa; }
    .card-header { background:#0d6efd; color:#fff; }
    .required-field::after { content:" *"; color:red; }
    .numeric { text-align:right; }

    .info-card { border:1px solid #eee; border-radius:10px; padding:16px; margin-bottom:16px; }
    .info-card-title { font-weight:600; margin-bottom:12px; }

    .table-warning { animation:blink 1s ease-in-out 1; }
    @keyframes blink {
      0% { background:#fff3cd; }
      100% { background:transparent; }
    }

    /* 가로 스크롤(부트스트랩 역할 유지) */
    #items-wrap { overflow-x:auto; }
    /* 기본은 세로 스크롤 숨김 */
    #items-scroll { position:relative; overflow-y:hidden; scrollbar-gutter:stable both-edges; overscroll-behavior:contain; padding-bottom: 1px; }
    /* 임계 행수 초과 시에만 세로 스크롤 */
    #items-scroll.table-scroll { overflow-y:auto; }
    /* sticky header/footer */
    #items-scroll.table-scroll thead th { position:sticky; top:0; z-index:2; background:var(--bs-table-bg,#fff); }
    #items-scroll.table-scroll tfoot td { position:sticky; bottom:0; z-index:1; background:var(--bs-body-bg,#fff); box-shadow:0 -1px 0 var(--bs-table-border-color,#dee2e6); }

    #items-scroll .table, #items-scroll thead, #items-scroll tbody, #items-scroll tfoot { height:auto !important; }
    /* 스크롤바 */
    #items-scroll::-webkit-scrollbar{ width:10px; height:auto !important; }
    #items-scroll::-webkit-scrollbar-thumb{ min-height:0 !important; height:auto !important; background:rgba(0,0,0,.35) !important; border-radius:6px; }
    #items-scroll{ scrollbar-width:auto; }
    #items-scroll::-webkit-scrollbar-track{ background:rgba(0,0,0,.06) !important; }
    /* 헤더 위쪽 보더 + 보정라인 */
    #items-scroll.table-scroll thead th{ border-top:1px solid var(--bs-table-border-color,#dee2e6) !important; }
    #items-scroll.table-scroll::before{ content:""; position:sticky; top:0; display:block; height:1px; background:var(--bs-table-border-color,#dee2e6); z-index:3; pointer-events:none; }

    /* ====================== 합계행(총계) & 헤더/바닥선 보정 ====================== */
    .product-table thead>tr>* { border-bottom-width:2px; }
    .product-table tfoot .total-row>* { border-top:2px solid var(--bs-table-border-color,#dee2e6) !important; }
    .product-table tbody tr:last-child>* { border-bottom:0 !important; }
    #items-scroll.table-scroll tfoot .total-row>* {
      position:sticky; bottom:0; z-index:3;
      background:var(--bs-body-bg,#fff);
      box-shadow:0 -1px 0 var(--bs-table-border-color,#dee2e6), 0 -6px 12px rgba(0,0,0,.04);
    }

    /* ====================== "텍스트만" 은은하게 강조(음영) ====================== */
    .product-table tfoot .total-row>* { font-weight:600; text-shadow:0.5px 0.5px 0 rgba(0,0,0,.18); }
    .product-table tfoot .total-row td:first-child {
      letter-spacing:.2px;
      text-shadow:0.7px 0.7px 0 rgba(0,0,0,.22), -0.5px -0.5px 0 rgba(255,255,255,.35);
    }
    
    input[type=number]::-webkit-outer-spin-button,
	input[type=number]::-webkit-inner-spin-button{ -webkit-appearance:none; margin:0; }
	input[type=number]{ -moz-appearance:textfield; appearance:textfield; }
  </style>

  <!-- 오늘 날짜 (납기 min) -->
  <jsp:useBean id="now" class="java.util.Date" />
  <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" timeZone="Asia/Seoul" />

  <!-- 서버에서 온 프리필 JSON(부족분) 안전 주입 -->
  <script id="prefillShortagesJson" type="application/json">
    <c:out value="${prefillShortagesJson}" escapeXml="false"/>
  </script>

  <script>
    /* ================= 공통 에러 헬퍼 ================= */
    function showError(el, msg) {
      if (!el) return;
      el.setCustomValidity?.(msg);
      el.classList.add('is-invalid');
      const fb = el.closest('.col-12, .col-md-4, td')?.querySelector('.invalid-feedback')
                || el.parentElement.querySelector('.invalid-feedback');
      if (fb) { fb.textContent = msg; fb.classList.add('d-block'); }
      el.scrollIntoView?.({ behavior:'smooth', block:'center' });
      el.focus?.();
      el.reportValidity?.();
    }
    function clearError(el) {
      if (!el) return;
      el.setCustomValidity?.('');
      el.classList.remove('is-invalid');
      const fb = el.closest('.col-12, .col-md-4, td')?.querySelector('.invalid-feedback')
                || el.parentElement.querySelector('.invalid-feedback');
      if (fb) { fb.textContent = ''; fb.classList.remove('d-block'); }
    }

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

      clearError(document.getElementById('clientNameInput')); // 선택 시 에러 해제
      window.close();
    }

    /* ================= 부품 팝업 + 중복방지 ================= */
    const selectedParts = new Set();
    let currentRow = null, targetPartsInput = null, targetPartsNameInput = null;

    function openPartsPopup(btn) {
      const tr = btn.closest('tr');
      currentRow           = tr;
      targetPartsInput     = tr.querySelector('.partsNoInput');
      targetPartsNameInput = tr.querySelector('.partsNameInput');

      window.open(
        '${pageContext.request.contextPath}/purchase/partsPopup?parts_Name=',
        'partsPopup',
        'width=1800,height=560,scrollbars=yes'
      );
    }

    function setPartsInfo(parts_no, parts_name) {
      const pno   = String(parts_no || '');
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

      if (targetPartsInput)     targetPartsInput.value     = pno;
      if (targetPartsNameInput) { targetPartsNameInput.value = parts_name || ''; clearError(targetPartsNameInput); }
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
 // 합계 갱신 + 커스텀 유효성 즉시 해제/설정
    document.addEventListener('input', function (e) {
      const t = e.target;

      if (t.classList.contains('qty-input')) {
        const v = Number(t.value);
        // 메시지는 세팅만, 보고 싶을 때(제출 등) 브라우저가 표시
        t.setCustomValidity(Number.isFinite(v) && v >= 1 ? '' : '요청 수량을 1 이상 입력하세요.');
        if (v >= 1) t.classList.remove('is-invalid'); // 이전 showError 흔적 제거
      }

      if (t.classList.contains('cost-input')) {
        const v = Number(t.value);
        t.setCustomValidity(Number.isFinite(v) && v >= 0 ? '' : '단가는 0 이상이어야 합니다.');
        if (v >= 0) t.classList.remove('is-invalid');
      }

      if (t.classList.contains('qty-input') || t.classList.contains('cost-input')) {
        recalcTotal();
      }
    });


    /* ================= 인덱스 재정렬(빈 인덱스 방지) ================= */
    function reindexRows() {
      const rows = document.querySelectorAll('#items-tbody tr');
      rows.forEach((tr, i) => {
        tr.querySelectorAll('input[name^="purchase_Item["],select[name^="purchase_Item["],textarea[name^="purchase_Item["]')
          .forEach(inp => {
            // \d* 로 "[]"와 숫자 모두 교체
            inp.name = inp.name.replace(/purchase_Item\[\d*\]\./, 'purchase_Item['+i+'].');
          });
      });
    }

    /* ================= 반응형 테이블 스크롤 ================= */
    let updateScroll;
    document.addEventListener('DOMContentLoaded', function(){
      const wrap     = document.getElementById('items-wrap');
      const scroller = document.getElementById('items-scroll');
      const table    = document.getElementById('items-table');
      const tbody    = document.getElementById('items-tbody');
      if (!wrap || !scroller || !table || !tbody) return;

      const SCROLL_ROWS = parseInt(wrap.dataset.scrollRows || '6', 10);

      function heightForRows(n){
        const thead = table.tHead, tfoot = table.tFoot;
        const rows  = Array.from(tbody.rows);
        const rowsH = rows.slice(0, n).reduce((s,r)=>s+r.getBoundingClientRect().height,0);
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

    /* ================= 행 추가/삭제 & 프리필 적용 ================= */
    document.addEventListener('DOMContentLoaded', function(){
      const addBtn = document.getElementById('add-item-btn');
      const tbody  = document.getElementById('items-tbody');
      const table  = document.getElementById('items-table');
      const form   = document.getElementById('purchaseForm');

      // 기존 선택값 세팅
      document.querySelectorAll('#items-tbody .partsNoInput').forEach(inp=>{
        if (inp.value) {
          const p = String(inp.value);
          selectedParts.add(p);
          const tr = inp.closest('tr');
          if (tr) tr.dataset.partsNo = p;
        }
      });

      // 추가
      addBtn?.addEventListener('click', function(){
        const idx = tbody.querySelectorAll('tr').length;
        const tr = document.createElement('tr');
        tr.innerHTML =
          '<td>' +
            '<div class="input-group input-group-sm">' +
              '<input type="hidden" class="partsNoInput" name="purchase_Item['+idx+'].partsDTO.parts_no" required />' +
              '<input type="text" class="form-control form-control-sm partsNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
              '<button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>' +
            '</div>' +
            '<div class="invalid-feedback">부품 선택이 필요합니다.</div>' + // ★ 추가
          '</td>' +
          '<td class="numeric">' +
            '<input type="number" min="0" name="purchase_Item['+idx+'].purchase_Item_Cnt" class="form-control form-control-sm qty-input text-end" required />' +
          '</td>' +
          '<td class="numeric">' +
            '<input type="number" min="0" name="purchase_Item['+idx+'].purchase_Item_Cost" class="form-control form-control-sm cost-input text-end" required />' +
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

      // 삭제(위임) + 재인덱싱 + 합계 + 스크롤
      table?.addEventListener('click', function(e){
        const btn = e.target.closest('.remove-item-btn');
        if (!btn) return;
        const tr = btn.closest('tr');
        const no = tr.querySelector('.partsNoInput')?.value;
        if (no) selectedParts.delete(String(no));
        tr.remove();
        reindexRows();
        recalcTotal();
        if (typeof updateScroll==='function') requestAnimationFrame(updateScroll);
      });

      // ★★★ 프리필(JSON) 적용
      let prefill = [];
      try {
        const raw = (document.getElementById('prefillShortagesJson')?.textContent || '[]').trim();
        prefill = JSON.parse(raw || '[]');
      } catch(e){ prefill = []; }

      if (Array.isArray(prefill) && prefill.length>0) {
        // 초기 1행이 완전 비어있으면 제거
        if (tbody.children.length === 1) {
          const first = tbody.firstElementChild;
          const no = first.querySelector('.partsNoInput')?.value;
          const nm = first.querySelector('.partsNameInput')?.value;
          const qty = first.querySelector('.qty-input')?.value;
          if (!no && !nm && !qty) first.remove();
        }

        prefill.forEach(obj=>{
          const idx = tbody.querySelectorAll('tr').length;
          const tr = document.createElement('tr');
          tr.innerHTML =
            '<td>' +
              '<div class="input-group input-group-sm">' +
                '<input type="hidden" class="partsNoInput" name="purchase_Item['+idx+'].partsDTO.parts_no" required />' +
                '<input type="text" class="form-control form-control-sm partsNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
                '<button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>' +
              '</div>' +
              '<div class="invalid-feedback">부품 선택이 필요합니다.</div>' + // ★ 추가
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
          const partsNo   = obj.partsNo   ?? obj.parts_no   ?? '';
          const partsName = obj.partsName ?? obj.parts_name ?? '';
          const qty       = obj.qty       ?? obj.shortage_cnt ?? 0;

          row.querySelector('.partsNoInput').value   = partsNo;
          row.querySelector('.partsNameInput').value = partsName;
          row.querySelector('.qty-input').value      = qty;

          if (partsNo) {
            selectedParts.add(String(partsNo));
            row.dataset.partsNo = String(partsNo);
            clearError(row.querySelector('.partsNameInput'));
          }
        });

        reindexRows();
        recalcTotal();
        if (typeof updateScroll==='function') requestAnimationFrame(updateScroll);
      }

      // 제출 전 유효성 검사 + 재인덱싱 + 빈 인덱스 차단
      form?.addEventListener('submit', function(e){
        // 1) 거래처 검증 (1회)
        const clientNoEl   = document.getElementById('clientNoInput');
        const clientNameEl = document.getElementById('clientNameInput');
        if (!clientNoEl.value.trim()) {
          e.preventDefault();
          showError(clientNameEl, '거래처를 선택하세요.');
          return;
        } else {
          clearError(clientNameEl);
        }

        // 2) 납기일 검증
        const dateEl = document.getElementById('purchaseDate');
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
          alert('부품 항목을 최소 1개 이상 추가하세요.');
          return;
        }

        // 4) 재인덱싱
        reindexRows();

        // 5) name에 빈 인덱스([]) 남아있으면 차단
        const bad = Array.from(form.querySelectorAll('[name^="purchase_Item["]')).filter(el => /\[\]/.test(el.name));
        if (bad.length) {
          e.preventDefault();
          console.warn('잘못된 name들:', bad.map(e => e.name));
          alert('일시적 오류가 발생했습니다. 다시 저장을 시도해주세요.');
          return;
        }

        // 6) 각 행 검증 (최초 에러에서 중단)
        for (const row of rows) {
          const noEl   = row.querySelector('.partsNoInput');
          const nameEl = row.querySelector('.partsNameInput');
          const qtyEl  = row.querySelector('.qty-input');
          const costEl = row.querySelector('.cost-input');

          // 부품 선택
          if (!noEl?.value) {
            e.preventDefault();
            showError(nameEl, '부품 선택이 필요합니다.');
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
        }
        // 통과 시 submit 진행
      });

      recalcTotal();
    });

    // (보조) 행 수 기준 스크롤 토글: 추가/삭제 직후 갱신
    document.addEventListener('DOMContentLoaded', function(){
      const wrap     = document.getElementById('items-wrap');
      const scroller = document.getElementById('items-scroll');
      const table    = document.getElementById('items-table');
      const tbody    = document.getElementById('items-tbody');
      if (!wrap || !scroller || !table || !tbody) return;

      const SCROLL_ROWS = parseInt(wrap.dataset.scrollRows || '6', 10);

      function heightForRows(n){
        const thead = table.tHead, tfoot = table.tFoot;
        const rows  = Array.from(tbody.rows);
        const rowsH = rows.slice(0, n).reduce((sum, r) => sum + r.getBoundingClientRect().height, 0);
        const headH = thead ? thead.getBoundingClientRect().height : 0;
        const footH = tfoot ? tfoot.getBoundingClientRect().height : 0;
        return Math.ceil(headH + footH + rowsH + 2);
      }

      function updateScroll2(){
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
      }

      const mo = new MutationObserver(updateScroll2);
      mo.observe(tbody, { childList:true });

      window.addEventListener('resize', updateScroll2);
      document.getElementById('add-item-btn')?.addEventListener('click', ()=>{ requestAnimationFrame(updateScroll2); });
      document.addEventListener('click', (e)=>{ if (e.target.closest('.remove-item-btn')) requestAnimationFrame(updateScroll2); });

      updateScroll2();
      window.addEventListener('load', updateScroll2);
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
    <div id="side"><jsp:include page="/side.jsp" /></div>
    <div id="main-area">
      <jsp:include page="/header.jsp" />

      <div id="contents">
        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="${pageContext.request.contextPath}/purchase/list" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0"><i class="bi bi-pencil-square me-2"></i>발주 등록</h4>
              <div style="width:90px;"></div>
            </div>

            <div class="card-body p-4">
              <form id="purchaseForm" action="${pageContext.request.contextPath}/purchase/create" method="post" style="display:inline;">
                <!-- 발주 / 거래처 -->
                <section class="info-card" aria-label="발주 및 거래처 정보">
                  <div class="info-card-title">발주 / 거래처 정보</div>
                  <div class="row g-3">
                    <div class="col-12">
                      <label class="form-label">제목 <span class="text-danger">*</span></label>
                      <input type="text" id="purchaseTitleInput" name="purchase_Title"
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
                      <!-- 거래처 미선택 메시지 -->
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
                      <input type="date" id="purchaseDate" class="form-control form-control-sm" name="purchase_Date" min="${todayStr}" required />
                      <div id="dateError" class="form-text" style="color:#dc3545;"></div>
                    </div>
                  </div>
                </section>

                <!-- 부품 목록 -->
                <section class="info-card mt-4" aria-label="부품 목록">
                  <div class="info-card-title d-flex justify-content-between align-items-center">
                    <span>부품 목록</span>
                    <button type="button" class="btn btn-primary" id="add-item-btn">
                      <i class="bi bi-plus-lg"></i>부품 추가
                    </button>
                  </div>

                  <div class="table-responsive" id="items-wrap" data-scroll-rows="6">
                    <div id="items-scroll">
                      <table class="table table-sm table-bordered align-middle mb-0 product-table" id="items-table">
                        <thead class="table-light">
                          <tr>
                            <th style="width:45%;" class="text-center">부품명</th>
                            <th style="width:15%;" class="numeric text-center">요청 수량</th>
                            <th style="width:15%;" class="numeric text-center">부품 단가</th>
                            <th style="width:15%;" class="numeric text-center">요청 총액</th>
                            <th style="width:10%;" class="text-center">삭제</th>
                          </tr>
                        </thead>
                        <tbody id="items-tbody">
                          <!-- 초기 1행 -->
                          <tr>
                            <td>
                              <div class="input-group input-group-sm">
                                <input type="hidden" class="partsNoInput" name="purchase_Item[0].partsDTO.parts_no" required />
                                <input type="text" class="form-control form-control-sm partsNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />
                                <button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>
                              </div>
                              <!-- 부품 미선택 메시지 -->
                              <div class="invalid-feedback">부품 선택이 필요합니다.</div>
                            </td>
                            <td class="numeric">
                              <input type="number" min="0" name="purchase_Item[0].purchase_Item_Cnt" class="form-control form-control-sm qty-input text-end" required />
                            </td>
                            <td class="numeric">
                              <input type="number" min="0" name="purchase_Item[0].purchase_Item_Cost" class="form-control form-control-sm cost-input text-end" required />
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

                <div class="row mt-4 g-2">
                  <div class="col-md-4 d-grid">
                    <a href="<c:url value='/purchase/list'/>" class="btn btn-outline-secondary btn-sm px-4" role="button">
                      <i class="bi bi-x-circle me-2"></i>취소
                    </a>
                  </div>
                  <div class="col-md-8 d-grid">
                    <button type="submit" id="modifyBtn" class="btn btn-primary btn-sm px-4">
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
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
