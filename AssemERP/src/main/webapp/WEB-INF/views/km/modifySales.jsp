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

  <script>
    /* ===== 거래처 팝업 연동 ===== */
    function openClientPopup() {
      window.open(
        '${pageContext.request.contextPath}/client/popup',
        'clientPopup',
        'width=600,height=500,scrollbars=yes'
      );
    }
    function setClientInfo(client_No, client_Name, client_Address, client_Email, client_Tel, client_Man, empNo, empName) {
      document.getElementById('clientNoInput').value = client_No;
      document.getElementById('clientNameInput').value = client_Name;
      document.getElementById('clientAddressInput').value = client_Address;
      document.getElementById('clientEmailInput').value = client_Email;
      document.getElementById('clientTelInput').value = client_Tel;
      document.getElementById('clientManInput').value = client_Man;
      if (empNo)  document.getElementById('empNoInput').value = empNo;
      if (empName)document.getElementById('empNameInput').value = empName;
      window.close();
    }

    /* ===== 제품 팝업 연동 ===== */
    let targetProductInput = null;
    let targetProductNameInput = null;

    function openProductPopup(btn) {
      const tr = btn.closest('tr');
      targetProductInput     = tr.querySelector('.productNoInput');
      targetProductNameInput = tr.querySelector('.productNameInput');
      window.open(
        '${pageContext.request.contextPath}/sales/productPopup',
        'productPopup',
        'width=700,height=560,scrollbars=yes'
      );
    }
    function setProductInfo(product_no, product_name) {
      if (targetProductInput)     targetProductInput.value = product_no;
      if (targetProductNameInput) targetProductNameInput.value = product_name;
      window.close();
    }

    /* ===== 합계 자동 계산 ===== */
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

      document.getElementById('sum-req').innerText  = sumReq.toLocaleString();
      document.getElementById('sum-cost').innerText = sumCost.toLocaleString();
    }

    document.addEventListener('input', function(e) {
      if (e.target.classList.contains('qty-input') || e.target.classList.contains('cost-input')) {
        recalcTotal();
      }
    });

    /* ===== 동적 행 추가/삭제 ===== */
    document.addEventListener('DOMContentLoaded', function() {
      const addBtn = document.getElementById('add-item-btn');
      const tbody  = document.getElementById('items-tbody');

      addBtn.addEventListener('click', function() {
        const idx = tbody.querySelectorAll('tr').length;

        const tr = document.createElement('tr');
        tr.innerHTML =
          '<td>' +
            '<div class="input-group input-group-sm">' +
              '<input type="hidden" class="productNoInput" name="sales_Item['+idx+'].product_No" />' +
              '<input type="text" class="form-control form-control-sm productNameInput" readonly tabindex="-1" style="background:#f6f6f6;" />' +
              '<button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>' +
            '</div>' +
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
            '<button type="button" class="btn btn-sm btn-outline-danger remove-item-btn" title="행 삭제">&times;</button>' +
          '</td>';

        tbody.appendChild(tr);
        recalcTotal();
      });

      document.getElementById('items-table').addEventListener('click', function(e){
        if (e.target.classList.contains('remove-item-btn')) {
          e.target.closest('tr').remove();
          recalcTotal();
        }
      });

      // 초기 렌더 후 합계 계산
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
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="/sales/list" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0">
                <i class="bi bi-pencil-square me-2"></i>수주 수정
              </h4>
              <div style="width: 90px;"></div>
            </div>

            <div class="card-body p-4">
              <form action="${pageContext.request.contextPath}/sales/modify"
                    method="post">
                <!-- 키/상태 -->
                <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                <input type="hidden" name="out_Status" value="${sales_OrderDto.out_Status}" />

                <!-- 수주 / 거래처 입력 -->
                <section aria-labelledby="order-create-title" class="info-card" aria-label="수주 및 거래처 정보">
                  <div id="order-create-title" class="info-card-title">수주 / 거래처 정보</div>
                  <div class="row g-3">

                    <!-- 거래처 이름 (팝업 조회) -->
                    <div class="col-md-4">
                      <label class="form-label">거래처 이름 <span class="text-danger">*</span></label>
                      <div class="input-group input-group-sm">
                        <input type="hidden" id="clientNoInput" name="clientDto.client_No"
                               value="${sales_OrderDto.clientDto.client_No}" />
                        <input type="text" id="clientNameInput" class="form-control form-control-sm"
                               name="clientDto.client_Name"
                               value="${sales_OrderDto.clientDto.client_Name}"
                               readonly required placeholder="조회 버튼으로 선택" />
                        <button type="button" class="btn btn-outline-secondary" onclick="openClientPopup()">조회</button>
                      </div>
                    </div>

                    <!-- 주소 -->
                    <div class="col-md-4">
                      <label class="form-label">주소</label>
                      <input type="text" id="clientAddressInput" name="clientDto.client_Address"
                             class="form-control form-control-sm"
                             value="${sales_OrderDto.clientDto.client_Address}" />
                    </div>

                    <!-- 이메일 -->
                    <div class="col-md-4">
                      <label class="form-label">이메일</label>
                      <div class="input-group input-group-sm">
                        <span class="input-group-text">@</span>
                        <input type="email" id="clientEmailInput" name="clientDto.client_Email"
                               class="form-control"
                               value="${sales_OrderDto.clientDto.client_Email}" />
                      </div>
                    </div>

                    <!-- 전화 -->
                    <div class="col-md-4">
                      <label class="form-label">거래처 전화번호</label>
                      <input type="text" id="clientTelInput" name="clientDto.client_Tel"
                             class="form-control form-control-sm"
                             value="${sales_OrderDto.clientDto.client_Tel}" />
                    </div>

                    <!-- 거래처 담당자 -->
                    <div class="col-md-4">
                      <label class="form-label">거래처 담당자</label>
                      <input type="text" id="clientManInput" name="clientDto.client_Man"
                             class="form-control form-control-sm"
                             value="${sales_OrderDto.clientDto.client_Man}" />
                    </div>

                    <!-- 내부 담당자 -->
                    <div class="col-md-4">
                      <label class="form-label">담당자 이름</label>
                      <input type="hidden" id="empNoInput" name="empDTO.empNo"
                             value="${sales_OrderDto.empDTO.empNo}" />
                      <input type="text" id="empNameInput" name="empDTO.empName"
                             class="form-control form-control-sm"
                             value="${sales_OrderDto.empDTO.empName}" readonly />
                    </div>

                    <!-- 납기(수주) 일자 -->
                    <div class="col-md-4">
                      <label class="form-label">납기 완료일</label>
                      <input type="date" class="form-control form-control-sm" name="sales_Date"
                             value="${fn:substring(sales_OrderDto.sales_Date,0,10)}" />
                    </div>
                  </div>
                </section>

                <!-- 제품 목록 -->
                <section aria-labelledby="product-list-title" class="info-card mt-4" aria-label="제품 목록">
                  <div id="product-list-title" class="info-card-title d-flex justify-content-between align-items-center">
                    <span>제품 목록</span>
                    <button type="button" id="add-item-btn" class="btn btn-sm btn-outline-secondary">항목 추가</button>
                  </div>

                  <div class="table-responsive" style="max-height: 360px; overflow: auto;">
                    <table class="table table-sm table-bordered align-middle mb-0 product-table" id="items-table">
                      <caption class="visually-hidden">수정할 제품 목록</caption>
                      <thead class="table-light">
                        <tr>
                          <th scope="col">제품명</th>
                          <th scope="col" class="numeric">요청수량</th>
                          <th scope="col" class="numeric">제품 단가</th>
                          <th scope="col" class="numeric">요청 총액</th>
                          <th scope="col">삭제</th>
                        </tr>
                      </thead>
                      <tbody id="items-tbody">
                        <c:choose>
                          <c:when test="${not empty sales_OrderDto.sales_Item}">
                            <c:forEach var="item" items="${sales_OrderDto.sales_Item}" varStatus="st">
                              <tr>
                                <td>
                                  <div class="input-group input-group-sm">
                                    <input type="hidden" class="productNoInput"
                                           name="sales_Item[${st.index}].product_No"
                                           value="${item.product_No}" />
                                    <input type="text" class="form-control form-control-sm productNameInput"
                                           value="${item.productDto != null ? item.productDto.product_name : ''}"
                                           readonly tabindex="-1" style="background:#f6f6f6;" />
                                    <button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>
                                  </div>
                                </td>
                                <td class="numeric">
                                  <input type="number" min="0" name="sales_Item[${st.index}].sales_Item_Cnt"
                                         class="form-control form-control-sm qty-input"
                                         value="${item.sales_Item_Cnt}" required />
                                </td>
                                <td class="numeric">
                                  <input type="number" step="0.01" min="0" name="sales_Item[${st.index}].sales_Item_Cost"
                                         class="form-control form-control-sm cost-input"
                                         value="${item.sales_Item_Cost}" required />
                                </td>
                                <td class="numeric">
                                  <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost"
                                         value="<fmt:formatNumber value='${item.sales_Item_TotCost}' type='number' groupingUsed='true'/>"
                                         readonly />
                                </td>
                                <td class="text-center">
                                  <button type="button" class="btn btn-sm btn-outline-danger remove-item-btn" title="행 삭제">&times;</button>
                                </td>
                              </tr>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <!-- 기존 품목이 없으면 1행 생성 -->
                            <tr>
                              <td>
                                <div class="input-group input-group-sm">
                                  <input type="hidden" class="productNoInput" name="sales_Item[0].product_No" />
                                  <input type="text" class="form-control form-control-sm productNameInput"
                                         readonly tabindex="-1" style="background:#f6f6f6;" />
                                  <button type="button" class="btn btn-outline-secondary" onclick="openProductPopup(this)">조회</button>
                                </div>
                              </td>
                              <td class="numeric">
                                <input type="number" min="0" name="sales_Item[0].sales_Item_Cnt"
                                       class="form-control form-control-sm qty-input" required />
                              </td>
                              <td class="numeric">
                                <input type="number" step="0.01" min="0" name="sales_Item[0].sales_Item_Cost"
                                       class="form-control form-control-sm cost-input" required />
                              </td>
                              <td class="numeric">
                                <input type="text" class="form-control form-control-plaintext form-control-sm tot-cost" readonly />
                              </td>
                              <td class="text-center">
                                <button type="button" class="btn btn-sm btn-outline-danger remove-item-btn" title="행 삭제">&times;</button>
                              </td>
                            </tr>
                          </c:otherwise>
                        </c:choose>
                      </tbody>
                      <tfoot>
                        <tr class="total-row">
                          <td>합계</td>
                          <td class="numeric"><span id="sum-req"><fmt:formatNumber value="${sales_OrderDto.totCnt}" type="number" groupingUsed="true"/></span></td>
                          <td></td>
                          <td class="numeric"><span id="sum-cost"><fmt:formatNumber value="${sales_OrderDto.totCost}" type="number" groupingUsed="true"/></span></td>
                          <td></td>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                </section>

                <!-- 액션 버튼 -->
                <div class="text-end mt-4 d-flex justify-content-end gap-2">
                  <a href="${pageContext.request.contextPath}/sales/list" class="btn btn-outline-secondary btn-sm px-4">취소</a>
                  <button type="submit" class="btn btn-primary btn-sm px-4">저장</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>

      <!-- 부트스트랩 JS -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </div>
  </div>
</body>
</html>
