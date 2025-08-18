<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 선택</title>
<style>
body {
	padding: 1rem;
	font-family: sans-serif;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 1rem;
}

th, td {
	border: 1px solid #ccc;
	padding: 8px;
	text-align: center;
}

tr:hover {
	background: #f1f1f1;
	cursor: pointer;
}
</style>
<script>
	// 부모창으로 값 전달
	function selectParts(parts_no, parts_name) {
		if (window.opener && !window.opener.closed) {
			window.opener.setPartsInfo(parts_no, parts_name // 제품 정보 전달
			);
		}
		window.close();
	}
</script>
</head>
<body>
	<h4>부품 선택</h4>
	<table>
		<thead>
			<tr>
				<th>부품코드</th>
				<th>부품명</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="parts" items="${listParts}">
				<tr
					onclick="selectParts(
         '${parts.parts_no}',
         '${fn:escapeXml(parts.parts_name)}'
 					)">
					<td><c:out value="${parts.parts_no}" /></td>
					<td><c:out value="${parts.parts_name}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
 --%>
 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>부품 선택</title>
  <!-- 공통 CSS/JS (부트스트랩 포함) -->
  <jsp:include page="/common.jsp"/>
  <style>
    body{padding:12px}
    .table-sm td, .table-sm th{padding:.35rem .5rem;}
  </style>
</head>
<body>
  <h6 class="mb-3">부품 선택</h6>

  <!-- 검색 폼 (제품 팝업과 동일 UI) -->
  <!-- 컨트롤러 매핑에 맞게 action을 조정하세요: /purchase/partsPopup (예시) -->
  <form method="get" action="<c:url value='/purchase/partsPopup'/>" class="mb-2">
    <div class="input-group input-group-sm">
      <input type="text" class="form-control" name="parts_Name"
             value="${fn:escapeXml(param.parts_Name)}"
             placeholder="부품명 검색"/>
      <button class="btn btn-outline-secondary" type="submit">검색</button>
    </div>
  </form>

  <table class="table table-sm table-hover align-middle">
    <thead class="table-light">
      <tr>
        <th style="width:110px">부품코드</th>
        <th>부품명</th>
        <th style="width:90px" class="text-center">선택</th>
      </tr>
    </thead>
    <tbody>
      <!-- 모델 속성명은 컨트롤러에서 넣어준 리스트명에 맞추세요 (예: partsList). 기존에 listParts라면 items를 바꾸면 됩니다. -->
      <c:forEach var="p" items="${listParts}">
        <tr>
          <td>${p.parts_no}</td>
          <td>${fn:escapeXml(p.parts_name)}</td>
          <td class="text-center">
            <button type="button" class="btn btn-primary btn-sm selectBtn"
                    data-parts-no="${p.parts_no}"
                    data-parts-name="${fn:escapeXml(p.parts_name)}">선택</button>
          </td>
        </tr>
      </c:forEach>

      <c:if test="${empty listParts}">
        <tr><td colspan="3" class="text-center text-muted">결과가 없습니다.</td></tr>
      </c:if>
    </tbody>
  </table>

  <script>
    // 부모창에 setPartsInfo(no, name) 함수가 있어야 합니다.
    document.addEventListener('click', function(e){
      const btn = e.target.closest('.selectBtn');
      if (!btn) return;

      const d = btn.dataset;
      if (window.opener && !window.opener.closed && typeof window.opener.setPartsInfo === 'function') {
        window.opener.setPartsInfo(d.partsNo, d.partsName);
      }
      window.close();
    });
  </script>
</body>
</html>
 