<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<script>
  /* ====================== 거래처 팝업 연동 ====================== */
  function openClientPopup() {
    window.open(
      '${pageContext.request.contextPath}/client/popup?client_Gubun=${client_Gubun}',
      'clientPopup',
      'width=600,height=500,scrollbars=yes'
    );
  }
  function setClientInfo(client_No, client_Name, client_Address, client_Email, client_Tel, client_Man, empNo, empName) {
    document.getElementById('clientNoInput').value     = client_No;
    document.getElementById('clientNameInput').value   = client_Name;
    document.getElementById('clientAddressInput').value= client_Address;
    document.getElementById('clientEmailInput').value  = client_Email;
    document.getElementById('clientTelInput').value    = client_Tel;
    document.getElementById('clientManInput').value    = client_Man;
    if (empNo)   document.getElementById('empNoInput').value   = empNo;
    if (empName) document.getElementById('empNameInput').value = empName;
    window.close();
  }

  /* ====================== 제품 팝업 연동 + 중복 방지 ====================== */
  // 이미 선택된 제품번호 보관
  const selectedParts = new Set();
  // 팝업에서 선택 결과를 넣을 대상 행 및 입력 요소 참조
  let currentRow = null;
  let targetPartsInput = null;
  let targetPartsNameInput = null;

  function openPartsPopup(btn) {
    const tr = btn.closest('tr');
    currentRow = tr;
    targetPartsInput     = tr.querySelector('.partsNoInput');
    targetPartsNameInput = tr.querySelector('.partsNameInput');

    window.open(
      '${pageContext.request.contextPath}/purchase/partsPopup',
      'partsPopup',
      'width=700,height=560,scrollbars=yes'
    );
  }

  // 팝업에서 호출되는 콜백
  function setPartsInfo(parts_no, parts_name) {
    const pno = String(parts_no);

    // 현재 행의 이전 제품번호
    const prevNo = targetPartsInput?.value ? String(targetPartsInput.value) : null;

    // 동일 제품을 같은 행에 다시 고른 경우: 그냥 닫기
    if (prevNo && prevNo === pno) {
      window.close();
      return;
    }

    // 다른 행에서 이미 선택된 제품이면 막기
    if (selectedParts.has(pno)) {
      alert('이미 선택된 제품입니다.');
      const dup = document.querySelector(`#items-tbody tr[data-parts-no="${pno}"]`);
      if (dup) {
        dup.classList.add('table-warning');
        dup.scrollIntoView({ behavior: 'smooth', block: 'center' });
        setTimeout(() => dup.classList.remove('table-warning'), 1200);
      }
      return;
    }

    // 이전 선택 제거
    if (prevNo) selectedParts.delete(prevNo);

    // 현재 행에 값 반영
    if (targetPartsInput)     targetPartsInput.value = pno;
    if (targetPartsNameInput) targetPartsNameInput.value = parts_name;
    if (currentRow)             currentRow.dataset.partsNo = pno;

    // 선택 목록 갱신
    selectedParts.add(pno);

    // 합계 재계산 필요 시
    if (typeof recalcTotal === 'function') recalcTotal();

    window.close();
  }

  /* ====================== 합계 자동 계산 ====================== */
  function recalcTotal() {
    let sumReq = 0;
    let sumCost = 0;

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

  // 수량/단가 변경 시 합계 갱신
  document.addEventListener('input', function(e) {
    if (e.target.classList.contains('qty-input') || e.target.classList.contains('cost-input')) {
      recalcTotal();
    }
  });

  /* ====================== 동적 행 추가/삭제 ====================== */
  document.addEventListener('DOMContentLoaded', function() {
    const addBtn = document.getElementById('add-item-btn');
    const tbody  = document.getElementById('items-tbody');

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
    if (addBtn) {
      addBtn.addEventListener('click', function() {
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
            '<button type="button" class="btn btn-sm btn-outline-danger remove-item-btn" title="행 삭제">&times;</button>' +
          '</td>';

        tbody.appendChild(tr);
      });
    }

    // 항목 삭제 (Set에서 제품번호도 제거)
    const table = document.getElementById('items-table');
    if (table) {
      table.addEventListener('click', function(e){
        if (e.target.classList.contains('remove-item-btn')) {
          const tr = e.target.closest('tr');
          const no = tr.querySelector('.partsNoInput')?.value;
          if (no) selectedParts.delete(String(no));
          tr.remove();
          recalcTotal();
        }
      });
    }

    recalcTotal();
  });
</script>

</head>
<body>
	<div id="layout">
		<!-- 사이드 내비게이션 포함 -->
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>

		<div id="main-area">
			<!-- 헤더 포함 (상단 공통 네비/로고 등) -->
			<jsp:include page="/header.jsp" />

			<!-- 컨텐츠 영역 시작 -->
			<div id="contents">
				<div class="container-fluid px-4">
					<div class="card shadow-sm">
						<!-- 카드 헤더 (상세 페이지 톤과 동일) -->
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<a href="/purchase/list" class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<h4 class="card-title mb-0">
								<i class="bi bi-pencil-square me-2"></i>발주 등록
							</h4>
							<div style="width: 90px;"></div>
						</div>

						<div class="card-body p-4">
							<form action="${pageContext.request.contextPath}/purchase/create"
								method="post" style="display: inline;">
								<!-- 수주 / 거래처 입력 -->
								<section aria-labelledby="order-create-title" class="info-card"
									aria-label="발주 및 거래처 정보">
									<div id="order-create-title" class="info-card-title">발주 /
										거래처 정보</div>
									<div class="row g-3">
										<!-- 거래처 이름 (팝업 조회) -->
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

										<!-- 주소 -->
										<div class="col-md-4">
											<label class="form-label">주소</label> <input type="text"
												id="clientAddressInput" class="form-control form-control-sm" />
										</div>

										<!-- 이메일 -->
										<div class="col-md-4">
											<label class="form-label">이메일</label>
											<div class="input-group input-group-sm">
												<span class="input-group-text">@</span> <input type="email"
													id="clientEmailInput" class="form-control" />
											</div>
										</div>

										<!-- 전화 -->
										<div class="col-md-4">
											<label class="form-label">거래처 전화번호</label> <input type="text"
												id="clientTelInput" class="form-control form-control-sm" />
										</div>

										<!-- 거래처 담당자 -->
										<div class="col-md-4">
											<label class="form-label">거래처 담당자</label> <input type="text"
												id="clientManInput" class="form-control form-control-sm" />
										</div>

										<!-- 내부 담당자 -->
										<div class="col-md-4">
											<label class="form-label">담당자 이름</label> <input type="hidden"
												id="empNoInput" name="empDTO.empNo" /> <input type="text"
												id="empNameInput" class="form-control form-control-sm"
												readonly />
										</div>

										<!-- 납기(수주) 일자 -->
										<div class="col-md-4">
											<label class="form-label">납기 완료일</label> <input type="date"
												class="form-control form-control-sm" name="purchase_Date" required/>
										</div>
									</div>
								</section>

								<!-- 제품 목록 -->
								<section aria-labelledby="product-list-title"
									class="info-card mt-4" aria-label="부품 목록">
									<div id="product-list-title"
										class="info-card-title d-flex justify-content-between align-items-center">
										<span>부품 목록</span>
										<button type="button" id="add-item-btn"
											class="btn btn-sm btn-outline-secondary">항목 추가</button>
									</div>

									<div class="table-responsive"
										style="max-height: 360px; overflow: auto;">
										<table
											class="table table-sm table-bordered align-middle mb-0 product-table"
											id="items-table">
											<caption class="visually-hidden">등록할 부품 목록</caption>
											<thead class="table-light">
												<tr>
													<th scope="col">부품명</th>
													<th scope="col" class="numeric">요청수량</th>
													<th scope="col" class="numeric">부품 단가</th>
													<th scope="col" class="numeric">요청 총액</th>
													<th scope="col">삭제</th>
												</tr>
											</thead>
											<tbody id="items-tbody">
												<!-- 초기 1행 -->
												<tr>
													<td>
														<div class="input-group input-group-sm">
															<input type="hidden" class="partsNoInput"
																name="purchase_Item[0].partsDTO.parts_no" /> <input type="text"
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
															class="btn btn-sm btn-outline-danger remove-item-btn"
															title="행 삭제">&times;</button>
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
								</section>

								<!-- 액션 버튼 -->
								<div class="text-end mt-4 d-flex justify-content-end gap-2">
									<a href="${pageContext.request.contextPath}/purchase/list"
										class="btn btn-outline-secondary btn-sm px-4">취소</a>
									<button type="submit" class="btn btn-primary btn-sm px-4">등록</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<!-- 부트스트랩 JS -->
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

			<!-- 공통 푸터 포함 -->
			<jsp:include page="/foot.jsp" />
		</div>
	</div>
</body>
</html>
