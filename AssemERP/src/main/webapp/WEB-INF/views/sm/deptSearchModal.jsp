<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty deptModalList}">
    <tr>
        <td colspan="2" class="text-center text-muted py-3">검색 결과가 없습니다.</td>
    </tr>
</c:if>

<c:forEach var="deptModal" items="${deptModalList}">
    <tr style="cursor: pointer;" data-code="${deptModal.deptCode}" data-name="${deptModal.deptName}">
        <td>${deptModal.deptCode}</td>
        <td>${deptModal.deptName}</td>
    </tr>
</c:forEach>