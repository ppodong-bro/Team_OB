<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>거래처 선택</title>
  <style>
    body { padding: 1rem; font-family: sans-serif; }
    table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
    tr:hover { background: #f1f1f1; cursor: pointer; }
  </style>
  <script>
    // 부모창으로 값 전달
    function selectClient(client_No, client_Name, client_Address, client_Email, client_Man) {
      if (window.opener && !window.opener.closed) {
        window.opener.setClientInfo(
          client_No,
          client_Name,
          client_Address,
          client_Email,
          client_Man,
          
        );
      }
      window.close();
    }
  </script>
</head>
<body>
  <h4>거래처 선택</h4>
  <table>
    <thead>
      <tr>
        <th>거래처명</th>
        <th>주소</th>
        <th>이메일</th>
        <th>거래처 담당자</th>
        <th>담당자</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="client" items="${clientList}">
        <tr onclick="selectClient(
              '${client.client_No}',
              '${empty client.client_Name ? "" : fn:replace(client.client_Name, "'", "\\'")}',
              '${empty client.client_Address ? "" : fn:replace(client.client_Address, "'", "\\'")}',
              '${empty client.client_Email ? "" : fn:replace(client.client_Email, "'", "\\'")}',
              '${empty client.client_Man ? "" : fn:replace(client.client_Man, "'", "\\'")}',
              '${empty client.empDTO.empName ? "" : fn:replace(client.empDTO.empName, "'", "\\'")}'
          )">
          <td>${client.client_Name}</td>
          <td>${client.client_Address}</td>
          <td>${client.client_Email}</td>
          <td>${client.client_Man}</td>
          <td>${client.empDTO.empName}</td>

        </tr>
      </c:forEach>
    </tbody>
  </table>
</body>
</html>
