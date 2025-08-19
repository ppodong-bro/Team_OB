<%-- <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>부족 부품 확인</title>
  <jsp:include page="/common.jsp"/>
  <style>
    .table-sm td,.table-sm th{padding:.4rem .6rem}
  </style>
</head>
<body>
<div id="layout">
  <div id="side"><jsp:include page="/side.jsp"/></div>
  <div id="main-area">
    <jsp:include page="/header.jsp"/>

    <div class="container-fluid px-4">
      <div class="card shadow-sm">
        <div class="card-header d-flex justify-content-between align-items-center">
          <a href="javascript:history.back()" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left"></i> 뒤로
          </a>
          <h4 class="card-title mb-0"><i class="bi bi-exclamation-triangle me-2"></i>부족 부품 확인</h4>
          <div style="width:90px"></div>
        </div>

        <div class="card-body">
          <c:choose>
            <c:when test="${empty shortages}">
              <div class="alert alert-success mb-0">부족한 부품이 없습니다.</div>
            </c:when>
            <c:otherwise>
              <p class="text-muted">부족 수량을 확인/수정한 뒤 “발주 화면으로 이동”을 누르세요.</p>

              <form method="post" action="${pageContext.request.contextPath}/sales/confirmToPurchase">
                <div class="table-responsive" style="max-height:420px;overflow:auto">
                  <table class="table table-sm table-bordered align-middle mb-3">
                    <thead class="table-light">
                      <tr>
                        <th style="width:120px">부품코드</th>
                        <th>부품명</th>
                        <th class="text-end" style="width:120px">필요수량</th>
                        <th class="text-end" style="width:120px">가용재고</th>
                        <th class="text-end" style="width:140px">부족수량(발주)</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="s" items="${shortages}" varStatus="st">
                        <tr>
                          <td class="text-monospace">${s.parts_no}
                            <input type="hidden" name="shortages[${st.index}].parts_no" value="${s.parts_no}">
                          </td>
                          <td>
                            ${fn:escapeXml(s.parts_name)}
                            <input type="hidden" name="shortages[${st.index}].parts_name"
                                   value="${fn:escapeXml(s.parts_name)}">
                          </td>
                          <td class="text-end">
                            ${s.required_cnt}
                            <input type="hidden" name="shortages[${st.index}].required_cnt" value="${s.required_cnt}">
                          </td>
                          <td class="text-end">
                            ${s.available_cnt}
                            <input type="hidden" name="shortages[${st.index}].available_cnt" value="${s.available_cnt}">
                          </td>
                          <td>
                            <input type="number" class="form-control form-control-sm text-end"
                                   name="shortages[${st.index}].shortage_cnt"
                                   min="0" value="${s.shortage_cnt}">
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>

                <div class="text-end d-flex justify-content-end gap-2">
                  <a href="javascript:history.back()" class="btn btn-outline-secondary btn-sm px-4">돌아가기</a>
                  <button type="submit" class="btn btn-primary btn-sm px-4">
                    발주 화면으로 이동
                  </button>
                </div>
              </form>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>

    <jsp:include page="/foot.jsp"/>
  </div>
</div>
</body>
</html>
 --%>
 
 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <jsp:include page="/common.jsp" />
  <meta charset="UTF-8">
  <title>부품 부족 안내</title>
</head>
<body>
<div class="container mt-4">
  <div class="card shadow-sm">
    <div class="card-header text-center fw-bold">부품 부족 안내</div>
    <div class="card-body">
      <p>아래 부품이 부족합니다. 발주 등록 화면으로 이동하시겠습니까?</p>

      <div class="table-responsive">
        <table class="table table-sm table-bordered align-middle" id="shortage-table">
          <thead class="table-light text-center">
          <tr>
            <th>부품번호</th>
            <th>부품명</th>
            <th>필요수량</th>
            <th>가용재고</th>
            <th>부족수량</th>
          </tr>
          </thead>
          <tbody class="text-center">
          <c:forEach var="row" items="${shortages}">
            <tr>
              <!-- data-*에 숫자값/문자값을 보관해 두면 JS에서 안전하게 읽어 JSON 생성 가능 -->
              <td data-parts-no="${row.parts_no}">${row.parts_no}</td>
              <td data-parts-name="${row.parts_name}">${row.parts_name}</td>
              <td data-required="${row.required_cnt}">${row.required_cnt}</td>
              <td data-available="${row.available_cnt}">${row.available_cnt}</td>
              <td data-shortage="${row.shortage_cnt}" class="text-danger fw-bold">${row.shortage_cnt}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>

      <form id="toPurchaseForm" method="post" action="${pageContext.request.contextPath}/sales/confirmToPurchase">
        <input type="hidden" name="shortagesJson" id="shortagesJson"/>
        <div class="d-flex gap-2 justify-content-end">
          <a href="${pageContext.request.contextPath}/sales/detail?sales_No=${pendingSalesOrder.sales_No}" class="btn btn-outline-secondary">취소</a>
          <button type="button" class="btn btn-primary" onclick="submitShortages()">발주로 이동</button>
        </div>
      </form>

    </div>
  </div>
</div>

<script>
function submitShortages(){
  const rows = document.querySelectorAll('#shortage-table tbody tr');
  const payload = [];
  rows.forEach(tr => {
    payload.push({
      parts_no:      Number(tr.querySelector('td[data-parts-no]')   ?.dataset.partsNo   || 0),
      parts_name:          tr.querySelector('td[data-parts-name]') ?.dataset.partsName || '',
      required_cnt:  Number(tr.querySelector('td[data-required]')  ?.dataset.required  || 0),
      available_cnt: Number(tr.querySelector('td[data-available]') ?.dataset.available || 0),
      shortage_cnt:  Number(tr.querySelector('td[data-shortage]')  ?.dataset.shortage  || 0)
    });
  });
  document.getElementById('shortagesJson').value = JSON.stringify(payload);
  document.getElementById('toPurchaseForm').submit();
}
</script>
</body>
</html>
 