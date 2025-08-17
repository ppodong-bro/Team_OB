<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>제품 선택</title>
  <jsp:include page="/common.jsp"/>
  <style>
    body{padding:12px}
    .table-sm td, .table-sm th{padding:.35rem .5rem;}
  </style>
</head>
<body>
  <h6 class="mb-3">제품 선택</h6>

  <!-- 검색 폼 (거래처 팝업과 동일 UI) -->
  <form method="get" action="<c:url value='/sales/productPopup'/>" class="mb-2">
    <div class="input-group input-group-sm">
      <input type="text" class="form-control" name="product_Name"
             value="${fn:escapeXml(param.product_Name)}"
             placeholder="제품명 검색"/>
      <button class="btn btn-outline-secondary" type="submit">검색</button>
    </div>
  </form>

  <table class="table table-sm table-hover align-middle">
    <thead class="table-light">
      <tr>
        <th style="width:110px">제품코드</th>
        <th>제품명</th>
        <th style="width:110px">버전</th>
        <th style="width:90px" class="text-center">선택</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="p" items="${productList}">
        <!-- 제품 버전은 BOM 리스트가 있으면 첫 항목, 아니면 개별 필드 사용 -->
        <c:set var="ver"
               value="${not empty p.productBOMList ? p.productBOMList[0].product_version
                       : (not empty p.product_version ? p.product_version : '')}" />

        <tr>
          <td>${p.product_no}</td>
          <td>${fn:escapeXml(p.product_name)}</td>
          <td>${fn:escapeXml(ver)}</td>
          <td class="text-center">
            <button type="button" class="btn btn-primary btn-sm selectBtn"
              data-product-no="${p.product_no}"
              data-product-name="${fn:escapeXml(p.product_name)}"
              data-product-version="${fn:escapeXml(ver)}">
              선택
            </button>
          </td>
        </tr>
      </c:forEach>

      <c:if test="${empty productList}">
        <tr><td colspan="4" class="text-center text-muted">결과가 없습니다.</td></tr>
      </c:if>
    </tbody>
  </table>

  <script>
    // 부모창에 setProductInfo(no, name, version) 함수가 있어야 합니다.
    document.addEventListener('click', function(e){
      const btn = e.target.closest('.selectBtn');
      if (!btn) return;

      const d = btn.dataset;
      if (window.opener && !window.opener.closed && typeof window.opener.setProductInfo === 'function') {
        window.opener.setProductInfo(d.productNo, d.productName, d.productVersion);
      }
      window.close();
    });
  </script>
</body>
</html>