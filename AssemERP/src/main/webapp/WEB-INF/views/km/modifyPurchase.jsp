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
  <title>발주 수정</title>

  <style>
    body { background-color:#f8f9fa; }
    .card-header { background-color:#198754; color:white; } /* Green theme for editing */
    .required-field::after { content:" *"; color:red; }

    .parent-container { display:flex; flex-direction:column; gap:30px; }

    .numeric{ text-align:right; }

    /* 가로 스크롤(부트스트랩 역할 유지) */
    #items-wrap{ overflow-x:auto; }

    /* 기본은 세로 스크롤 숨김 */
    #items-scroll{
      position:relative; overflow-y:hidden;
      scrollbar-gutter:stable both-edges; overscroll-behavior:contain;
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

    /* ✅ 전역 스크롤바 테마가 thumb 길이를 고정해둔 경우 해제 */
    #items-scroll::-webkit-scrollbar{ width:10px; height:auto !important; }
    #items-scroll::-webkit-scrollbar-thumb{ min-height:0 !important; height:auto !important; }
    #items-scroll{ scrollbar-width:auto; } /* Firefox */
    #items-scroll::-webkit-scrollbar-track{ background:rgba(0,0,0,.06) !important; }
    #items-scroll::-webkit-scrollbar-thumb{ background:rgba(0,0,0,.35) !important; border-radius:6px; }

    /* 1) sticky 헤더 위쪽 보더 강제 */
    #items-scroll.table-scroll thead th{ border-top:1px solid var(--bs-table-border-color,#dee2e6) !important; }
    /* 2) 스크롤 컨테이너 최상단 라인 보정 */
    #items-scroll.table-scroll::before{
      content:""; position:sticky; top:0; display:block; height:1px;
      background:var(--bs-table-border-color,#dee2e6); z-index:3; pointer-events:none;
    }

    .table-warning{ animation:blink 1s ease-in-out 1; }
    @keyframes blink { 0%{background:#fff3cd;} 100%{background:transparent;} }
    
	/* ====================== 합계행(총계) & 헤더/바닥선 보정 ====================== */
	
	/* 헤더 하단 보더 두께를 2px로: 기준선 통일 */
	.product-table thead > tr > * {
	  border-bottom-width: 2px;
	}
	
	/* 합계 행 위쪽 보더를 헤더와 동일하게(2px) */
	.product-table tfoot .total-row > * {
	  border-top: 2px solid var(--bs-table-border-color, #dee2e6) !important;
	}
	
	/* 마지막 데이터 행 하단 보더 제거: 합계 위 보더와 이중선 방지 */
	.product-table tbody tr:last-child > * {
	  border-bottom: 0 !important;
	}
	
	/* 스크롤러 기준 sticky: 합계를 하단에 고정 + 얇은 상단 경계/그림자 */
	#items-scroll.table-scroll tfoot .total-row > * {
	  position: sticky;
	  bottom: 0;
	  z-index: 3; /* thead(2)보다 위 */
	  background: var(--bs-body-bg, #fff); /* sticky 겹침시 배경 비침 방지 */
	  box-shadow:
	    0 -1px 0 var(--bs-table-border-color, #dee2e6),   /* 위쪽 얇은 라인 */
	    0 -6px 12px rgba(0,0,0,.04);                      /* 은은한 음영 */
	}
	
	/* ====================== "텍스트만" 은은하게 강조(음영) ====================== */
	
	/* 합계 행 전체 텍스트에 미세 음영 + 약한 굵기 */
	.product-table tfoot .total-row > * {
	  font-weight: 600;
	  text-shadow: 0.5px 0.5px 0 rgba(0,0,0,.18); /* blur 0: 번짐 없이 또렷 */
	}
	
	/* 첫 칸 "합계" 라벨만 살짝 더 입체감(하이라이트+그림자) */
	.product-table tfoot .total-row td:first-child {
	  letter-spacing: .2px;
	  text-shadow:
	    0.7px 0.7px 0 rgba(0,0,0,.22),        /* 아래/오른쪽 얇은 그림자 */
	   -0.5px -0.5px 0 rgba(255,255,255,.35); /* 위/왼쪽 얇은 하이라이트 */
	}
	    
  </style>

  <!-- 오늘 날짜 문자열 (납기 min 값에서 사용) -->
  <jsp:useBean id="now" class="java.util.Date" />
  <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="todayStr" timeZone="Asia/Seoul" />

  <script>
    /* ====================== 거래처 팝업 연동 ====================== */
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
      window.close();
    }

    /* ====================== 부품 팝업 + 중복 방지 ====================== */
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

    // 팝업에서 호출되는 콜백
    function setPartsInfo(parts_no, parts_name) {
      const pno    = String(parts_no || '');
      const prevNo = targetPartsInput?.value ? String(targetPartsInput.value) : null;

      if (prevNo && prevNo === pno) { window.close(); return; }

      if (pno && selectedParts.has(pno)) {
        alert('이미 선택된 부품입니다.');
        const dup = document.querySelector('#items-tbody tr[data-parts-no="'+pno+'"]');
        if (dup) {
          dup.classList.add('table-warning');
          dup.scrollIntoView({ behavior:'smooth', block:'center' });
          setTimeout(()=>dup.classList.remove('table-warning'), 1200);
        }
        return;
      }

      if (prevNo) selectedParts.delete(prevNo);

      if (targetPartsInput)     targetPartsInput.value     = pno;
      if (targetPartsNameInput) targetPartsNameInput.value = parts_name || '';
      if (currentRow)           currentRow.dataset.partsNo = pno;

      if (pno) selectedParts.add(pno);

      if (typeof recalcTotal === 'function') recalcTotal();
      window.close();
    }

    /* ====================== 합계 자동 계산 ====================== */
    function recalcTotal() {
      let sumReq = 0, sumCost = 0;

      document.querySelectorAll('#items-tbody tr').forEach(function(row) {
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
    document.addEventListener('input', function(e) {
      if (e.target.classList.contains('qty-input') || e.target.classList.contains('cost-input')) recalcTotal();
    });

    /* ====================== 인덱스 재정렬(빈 인덱스 방지) ====================== */
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

    /* ====================== 동적 행 추가/삭제 ====================== */
    let updateScroll;
    document.addEventListener('DOMContentLoaded', function() {
      const addBtn = document.getElementById('add-item-btn');
      const tbody  = document.getElementById('items-tbody');
      const table  = document.getElementById('items-table');
      const form   = document.getElementById('purchaseForm');

      // 수정폼: 기존 선택값을 Set에 미리 반영
      document.querySelectorAll('#items-tbody .partsNoInput').forEach(inp => {
        if (inp.value) {
          const p = String(inp.value);
          selectedParts.add(p);
          const tr = inp.closest('tr');
          if (tr) tr.dataset.partsNo = p;
        }
      });

      // 항목 추가
      addBtn?.addEventListener('click', function() {
        const idx = tbody.querySelectorAll('tr').length;
        const tr  = document.createElement('tr');
        tr.innerHTML =
          '<td>' +
            '<div class="input-group input-group-sm">' +
              '<input type="hidden" class="partsNoInput" name="purchase_Item['+idx+'].partsDTO.parts_no" required />' +
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
        if (typeof updateScroll==='function') requestAnimationFrame(updateScroll);
      });

      // 삭제 위임: 선택세트 제거 + 재인덱싱 + 합계 + 스크롤
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

      // 제출 전 커스텀 검증 + 재인덱싱 + 빈 인덱스 차단
      form?.addEventListener('submit', function(e){
        // 거래처 선택
        const clientNoEl   = document.getElementById('clientNoInput');
        const clientNameEl = document.getElementById('clientNameInput');
        if (!clientNoEl.value.trim()) {
          clientNameEl.setCustomValidity('거래처를 선택하세요.');
          clientNameEl.reportValidity();
          e.preventDefault(); return;
        } else clientNameEl.setCustomValidity('');

        // 납기일 유효성
        const dateEl = document.getElementById('purchaseDate');
        const dateError = document.getElementById('dateError');
        if (!dateEl.value) {
          dateEl.setCustomValidity('납기 완료일을 선택하세요.');
          dateEl.reportValidity();
          e.preventDefault(); return;
        } else {
          const picked = new Date(dateEl.value);
          const today  = new Date('${todayStr}');
          if (picked < today) {
            dateEl.setCustomValidity('납기 완료일은 오늘 이후만 가능합니다.');
            dateEl.reportValidity();
            if (dateError) dateError.textContent = '오늘 이후 날짜로 선택해주세요.';
            e.preventDefault(); return;
          } else {
            dateEl.setCustomValidity('');
            if (dateError) dateError.textContent = '';
          }
        }

        const rows = document.querySelectorAll('#items-tbody tr');
        if (rows.length === 0) {
          alert('부품 항목을 최소 1개 이상 추가하세요.');
          e.preventDefault(); return;
        }

        // 재인덱싱
        reindexRows();

        // name에 빈 인덱스([]) 남아있으면 차단
        const bad = Array.from(form.querySelectorAll('[name^="purchase_Item["]')).filter(el => /\[\]/.test(el.name));
        if (bad.length) {
          console.warn('잘못된 name들:', bad.map(e => e.name));
          alert('일시적 오류가 발생했습니다. 다시 저장을 시도해주세요.');
          e.preventDefault(); return;
        }

        // 각 행 검증
        for (const row of rows) {
          const noEl   = row.querySelector('.partsNoInput');
          const nameEl = row.querySelector('.partsNameInput');
          const qtyEl  = row.querySelector('.qty-input');
          const costEl = row.querySelector('.cost-input');

          if (!noEl?.value) {
            if (nameEl) { nameEl.setCustomValidity('부품 선택이 필요합니다.'); nameEl.reportValidity(); }
            e.preventDefault(); return;
          } else if (nameEl) nameEl.setCustomValidity('');

          const qty  = Number(qtyEl?.value);
          const cost = Number(costEl?.value);
          if (!qty || qty <= 0) { qtyEl.setCustomValidity('요청 수량을 1 이상 입력하세요.'); qtyEl.reportValidity(); e.preventDefault(); return; }
          else qtyEl.setCustomValidity('');
          if (cost < 0) { costEl.setCustomValidity('단가는 0 이상이어야 합니다.'); costEl.reportValidity(); e.preventDefault(); return; }
          else costEl.setCustomValidity('');
        }
      });

      recalcTotal();
    });

    /* ====================== 반응형 테이블 (행 수 기준 스크롤 토글) ====================== */
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
      }

      const mo = new MutationObserver(updateScroll);
      mo.observe(tbody, { childList:true });

      window.addEventListener('resize', updateScroll);
      document.getElementById('add-item-btn')?.addEventListener('click', () => { requestAnimationFrame(updateScroll); });
      document.addEventListener('click', (e) => { if (e.target.closest('.remove-item-btn')) requestAnimationFrame(updateScroll); });

      updateScroll();
      window.addEventListener('load', updateScroll);
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
      <div id="contents">
        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="/purchase/list" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0"><i class="bi bi-pencil-square me-2"></i>발주 수정</h4>
              <div style="width:90px;"></div>
            </div>

            <div class="card-body p-4">
              <form id="purchaseForm" action="${pageContext.request.contextPath}/purchase/modify" method="post">
                <!-- 키/상태 -->
                <input type="hidden" name="purchase_No" value="${purchase_OrderDto.purchase_No}" />
                <input type="hidden" name="in_Status"    value="${purchase_OrderDto.in_Status}" />

                <!-- 발주 / 거래처 입력 -->
                <section aria-labelledby="order-create-title" class="info-card" aria-label="발주 및 거래처 정보">
                  <div id="order-create-title" class="info-card-title">발주 / 거래처 정보</div>
                  <div class="row g-3">
                    <!-- 발주 제목 -->
                    <div class="col-12">
                      <label class="form-label">발주 제목 <span class="text-danger">*</span></label>
                      <input type="text" id="purchaseTitleInput" name="purchase_Title"
                             value="${purchase_OrderDto.purchase_Title}"
                             class="form-control form-control-sm" required
                             placeholder="예: 2025-08 CPU 쿨러 발주 (요청서 #A-231)" />
                    </div>

                    <!-- 거래처 이름 (팝업 조회) -->
                    <div class="col-md-4">
                      <label class="form-label">거래처 이름 <span class="text-danger">*</span></label>
                      <div class="input-group input-group-sm">
                        <input type="hidden" id="clientNoInput"  name="clientDto.client_No"  value="${purchase_OrderDto.clientDto.client_No}" />
                        <input type="text"   id="clientNameInput" name="clientDto.client_Name"
                               class="form-control form-control-sm"
                               value="${purchase_OrderDto.clientDto.client_Name}" readonly required placeholder="조회 버튼으로 선택" />
                        <button type="button" class="btn btn-outline-secondary" onclick="openClientPopup()">조회</button>
                      </div>
                    </div>

                    <!-- 주소 -->
                    <div class="col-md-4">
                      <label class="form-label">주소</label>
                      <input type="text" id="clientAddressInput" name="clientDto.client_Address"
                             class="form-control form-control-sm"
                             value="${purchase_OrderDto.clientDto.client_Address}" readonly />
                    </div>

                    <!-- 이메일 -->
                    <div class="col-md-4">
                      <label class="form-label">이메일</label>
                      <div class="input-group input-group-sm">
                        <input type="email" id="clientEmailInput" name="clientDto.client_Email"
                               class="form-control" value="${purchase_OrderDto.clientDto.client_Email}" readonly />
                      </div>
                    </div>

                    <!-- 전화 -->
                    <div class="col-md-4">
                      <label class="form-label">거래처 전화번호</label>
                      <input type="text" id="clientTelInput" name="clientDto.client_Tel"
                             class="form-control form-control-sm" value="${purchase_OrderDto.clientDto.client_Tel}" readonly />
                    </div>

                    <!-- 거래처 담당자 -->
                    <div class="col-md-4">
                      <label class="form-label">거래처 담당자</label>
                      <input type="text" id="clientManInput" name="clientDto.client_Man"
                             class="form-control form-control-sm" value="${purchase_OrderDto.clientDto.client_Man}" readonly />
                    </div>

                    <!-- 내부 담당자 -->
                    <div class="col-md-4">
                      <label class="form-label">담당자 이름</label>
                      <input type="hidden" id="empNoInput" name="empDTO.empNo" value="${purchase_OrderDto.empDTO.empNo}" />
                      <input type="text"   id="empNameInput" name="empDTO.empName"
                             class="form-control form-control-sm" value="${purchase_OrderDto.empDTO.empName}" readonly />
                    </div>

                    <!-- 납기(발주) 일자 -->
                    <div class="col-md-4">
                      <label class="form-label">납기 완료일</label>
                      <input type="date" id="purchaseDate" class="form-control form-control-sm" name="purchase_Date"
                             value="${fn:substring(purchase_OrderDto.purchase_Date,0,10)}" min="${todayStr}" required />
                      <div id="dateError" class="form-text" style="color:#dc3545;"></div>
                    </div>
                  </div>
                </section>

                <!-- 부품 목록 -->
                <section aria-labelledby="product-list-title" class="info-card mt-4" aria-label="부품 목록">
                  <div id="product-list-title" class="info-card-title d-flex justify-content-between align-items-center">
                    <span>부품 목록</span>
                    <button type="button" class="btn btn-primary" id="add-item-btn">
                      <i class="bi bi-plus-lg"></i>부품 추가
                    </button>
                  </div>

                  <div class="table-responsive" id="items-wrap" data-scroll-rows="6">
                    <div id="items-scroll">
                      <table class="table table-sm table-bordered align-middle mb-0 product-table" id="items-table">
                        <caption class="visually-hidden">수정할 부품 목록</caption>
                        <thead class="table-light">
                          <tr>
                            <th style ="width: 45%;" class="text-center" scope="col">발주 부품명</th>
                            <th style ="width: 15%;" scope="col" class="numeric text-center">발주 요청수량</th>
                            <th style ="width: 15%;" scope="col" class="numeric text-center">발주 부품 단가</th>
                            <th style ="width: 15%;" scope="col" class="numeric text-center">발주 요청 총액</th>
                            <th style ="width: 10%;" class="text-center" style="width:7%;" scope="col">삭제</th>
                          </tr>
                        </thead>
                        <tbody id="items-tbody">
                          <c:choose>
                            <c:when test="${not empty purchase_OrderDto.purchase_Item}">
                              <c:forEach var="item" items="${purchase_OrderDto.purchase_Item}" varStatus="st">
                                <tr data-parts-no="${item.parts_no}">
                                  <td>
                                    <div class="input-group input-group-sm">
                                      <input type="hidden" class="partsNoInput"
                                             name="purchase_Item[${st.index}].partsDTO.parts_no"
                                             value="${item.parts_no}" />
                                      <input type="text" class="form-control form-control-sm partsNameInput"
                                             value="${item.partsDTO != null ? item.partsDTO.parts_name : ''}"
                                             readonly tabindex="-1" style="background:#f6f6f6;" />
                                      <button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>
                                    </div>
                                  </td>
                                  <td class="numeric">
                                    <input type="number" min="0" name="purchase_Item[${st.index}].purchase_Item_Cnt"
                                           class="form-control form-control-sm qty-input"
                                           value="${item.purchase_Item_Cnt}" required />
                                  </td>
                                  <td class="numeric">
                                    <input type="number" step="0.01" min="0" name="purchase_Item[${st.index}].purchase_Item_Cost"
                                           class="form-control form-control-sm cost-input"
                                           value="${item.purchase_Item_Cost}" required />
                                  </td>
                                  <td class="numeric">
                                    <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost"
                                           value="<fmt:formatNumber value='${item.purchase_Item_TotCost}' type='number' groupingUsed='true'/>" readonly />
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
                                  <div class="input-group input-group-sm">
                                    <input type="hidden" class="partsNoInput" name="purchase_Item[0].partsDTO.parts_no" required />
                                    <input type="text" class="form-control form-control-sm partsNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />
                                    <button type="button" class="btn btn-outline-secondary" onclick="openPartsPopup(this)">조회</button>
                                  </div>
                                </td>
                                <td class="numeric">
                                  <input type="number" min="0" name="purchase_Item[0].purchase_Item_Cnt"
                                         class="form-control form-control-sm qty-input" required />
                                </td>
                                <td class="numeric">
                                  <input type="number" step="0.01" min="0" name="purchase_Item[0].purchase_Item_Cost"
                                         class="form-control form-control-sm cost-input" required />
                                </td>
                                <td class="numeric">
                                  <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost" readonly />
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
                            <td class="numeric">
                              <span id="sum-req"><fmt:formatNumber value="${purchase_OrderDto.totCnt}" type="number" groupingUsed="true" /></span>
                            </td>
                            <td></td>
                            <td class="numeric">
                              <span id="sum-cost"><fmt:formatNumber value="${purchase_OrderDto.totCost}" type="number" groupingUsed="true" /></span>
                            </td>
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
                    <a href="<c:url value='/purchase/list'/>" class="btn btn-outline-secondary btn-sm px-4" role="button">
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

      <!-- 부트스트랩 JS 및 공통 푸터 -->
      <jsp:include page="/common_cdn.jsp" />
      <jsp:include page="/foot.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </div>
  </div>
</body>
</html>