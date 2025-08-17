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
    body{padding:12px}
    .table-sm td, .table-sm th{padding:.35rem .5rem;}
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

  <table class="table table-sm table-hover align-middle">
    <thead class="table-light">
      <tr>
        <th>거래처명</th>
        <th>주소</th>
        <th>이메일</th>
        <th>거래처 담당자</th>
        <th>전화</th>
        <th>담당사원(사번)</th>
        <th style="width:90px" class="text-center">선택</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="c" items="${clientList}">
        <tr>
          <td>${fn:escapeXml(c.client_Name)}</td>
          <td>${fn:escapeXml(c.client_Address)}</td>
          <td>${fn:escapeXml(c.client_Email)}</td>
          <td>${fn:escapeXml(c.client_Man)}</td>
          <td>${fn:escapeXml(c.client_Tel)}</td>
          <td>
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