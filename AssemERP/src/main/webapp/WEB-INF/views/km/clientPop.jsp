<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>거래처 선택</title>
  <jsp:include page="/common.jsp"/>
<style>
body {
	padding: 12px
}

.table-sm td, .table-sm th {
	padding: .35rem .5rem;
}

/* 세로선만 표시 (Bootstrap 5 기준) */ .table.table-vert-only>:not(caption)>*>*
	{
	border-left: 1px solid var(--bs-table-border-color);
	border-right: 1px solid var(--bs-table-border-color);
	border-top: 0; /* 가로선 제거 */
	border-bottom: 0; /* 가로선 제거 */
}

.table thead th {
	border-bottom-width: 2px !important;
}
/* 바깥쪽 좌우 테두리(선택) */
.table.table-vert-only {
	border-left: 1px solid var(--bs-table-border-color);
	border-right: 1px solid var(--bs-table-border-color);
}
</style>
</head>
<body>
  <h6 class="mb-3">거래처 선택</h6>

  <!-- 검색 폼 (emp 팝업과 동일 UI) -->
  <form method="get" action="<c:url value='/client/popup'/>" class="mb-2">
  	 <input type="hidden" name="client_Gubun" value="${client_Gubun}"/>
    <div class="input-group input-group-sm">
      <input type="text" class="form-control" name="client_Name"
             value="${fn:escapeXml(param.client_Name)}"
             placeholder="거래처명 검색"/>
      <button class="btn btn-outline-secondary" type="submit">검색</button>
    </div>
  </form>

  	<table class="table table-sm table-hover align-middle table-bordered">
    <thead class="table-light">
      <tr>
        <th style="width: 12%;"class="text-center">거래처명</th>
        <th style="width: 35%;" class="text-center">주소</th>
        <th style="width: 20%;" class="text-center">이메일</th>
        <th style="width: 8%;"class="text-center">거래처 담당자</th>
        <th style="width: 10%;"class="text-center">전화</th>
        <th style="width: 10%;"class="text-center">담당사원(사번)</th>
        <th style="width: 5%;" class="text-center">선택</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="c" items="${clientList}">
        <tr>
          <td class="text-center">${fn:escapeXml(c.client_Name)}</td>
          <td class = "text-center">${fn:escapeXml(c.client_Address)}</td>
          <td class = "text-center">${fn:escapeXml(c.client_Email)}</td>
          <td class="text-center">${fn:escapeXml(c.client_Man)}</td>
          <td class="text-center">${fn:escapeXml(c.client_Tel)}</td>
          <td class="text-center">
            <c:choose>
              <c:when test="${not empty c.empDTO}">
                ${fn:escapeXml(c.empDTO.empName)} (${c.empDTO.empNo})
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </td>
          <td class="text-center">
            <button type="button" class="btn btn-primary btn-sm selectBtn"
              data-client-no="${c.client_No}"
              data-client-name="${fn:escapeXml(c.client_Name)}"
              data-client-address="${fn:escapeXml(c.client_Address)}"
              data-client-email="${fn:escapeXml(c.client_Email)}"
              data-client-tel="${fn:escapeXml(c.client_Tel)}"
              data-client-man="${fn:escapeXml(c.client_Man)}"
              data-emp-no="${not empty c.empDTO ? c.empDTO.empNo : ''}"
              data-emp-name="${not empty c.empDTO ? fn:escapeXml(c.empDTO.empName) : ''}">
              선택
            </button>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty clientList}">
        <tr><td colspan="7" class="text-center text-muted">결과가 없습니다.</td></tr>
      </c:if>
    </tbody>
  </table>

  <script>
    // emp 팝업과 동일한 방식: 선택 버튼 → 부모창 함수 호출
    document.addEventListener('click', function(e){
      const btn = e.target.closest('.selectBtn');
      if (!btn) return;

      const d = btn.dataset;
      if (window.opener && !window.opener.closed && typeof window.opener.setClientInfo === 'function') {
        window.opener.setClientInfo(
          d.clientNo,
          d.clientName,
          d.clientAddress,
          d.clientEmail,
          d.clientTel,
          d.clientMan,
          d.empNo || '',
          d.empName || ''
        );
      }
      window.close();
    });
  </script>
</body>
</html>