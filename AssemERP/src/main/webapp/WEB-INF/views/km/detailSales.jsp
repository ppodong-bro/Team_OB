<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <!-- 공통 CSS -->
  <jsp:include page="/common.jsp" />
  <meta charset="UTF-8">
  <title>거래처 상세</title>
</head>
<body>
  <div id="layout">
    <div id="side">
      <jsp:include page="/side.jsp" />
    </div>
    <div id="main-area">
      <jsp:include page="/header.jsp" />
		<!-- 이곳에 자신의 코드를 작성하세요 -->
      <div id="contents">
        <div class="container px-3 py-4">
          <div class="card shadow-sm border-1px bg-white col-md-8 mx-auto">
            <div class="card-header shadow-sm border-bottom bg-light">
              <h5 class="mb-0">거래처 상세</h5>
            </div>
            <div class="card-body px-4 py-3">
              <form>
                <!-- 수주 번호 -->
                <div class="mb-3">
                  <label for="salesNo" class="form-label">수주 번호</label>
                  <input id="salesNo" type="text" readonly class="form-control form-control-sm w-auto"
                         value="${sales_OrderDto.sales_No}" />
                </div>

                <!-- 거래처 이름 -->
                <div class="mb-3">
                  <label for="clientName" class="form-label">거래처 이름</label>
                  <input id="clientName" type="text" readonly class="form-control form-control-sm w-auto"
                         value="${sales_OrderDto.clientDto.client_Name}" />
                </div>

                <!-- 주소 -->
                <div class="mb-3">
                  <label for="clientAddress" class="form-label">주소</label>
                  <input id="clientAddress" type="text" readonly class="form-control form-control-sm"
                         value="${clientDto.client_Address}" />
                </div>

                <!-- 이메일 -->
                <div class="mb-3">
                  <label for="clientEmail" class="form-label">이메일</label>
                  <input id="clientEmail" type="email" readonly class="form-control form-control-sm"
                         value="${clientDto.client_Email}" />
                </div>

                <!-- 거래처 담당자 -->
                <div class="mb-3">
                  <label for="clientMan" class="form-label">거래처 담당자</label>
                  <input id="clientMan" type="text" readonly class="form-control form-control-sm"
                         value="${clientDto.client_Man}" />
                </div>

                <!-- 담당자 이름 -->
                <div class="mb-3">
                  <label for="empName" class="form-label">담당자 이름</label>
                  <input id="empName" type="text" readonly class="form-control form-control-sm w-auto"
                         value="${sales_OrderDto.empDTO.empName}" />
                </div>

                <!-- 수정 / 등록 일자 -->
                <c:if test="${not empty clientDto.modify_Date}">
                  <div class="mb-3">
                    <label class="form-label">수정 일자</label>
                    <input type="text" readonly class="form-control form-control-sm w-auto"
                           value="${clientDto.modify_Date}" />
                  </div>
                </c:if>
                <div class="mb-3">
                  <label class="form-label">등록 일자</label>
                  <input type="text" readonly class="form-control form-control-sm w-auto"
                         value="${clientDto.in_Date}" />
                </div>

                <!-- 제품 목록 -->
                <div class="mb-3">
                  <label class="form-label">제품 목록</label>
                  <div class="table-responsive">
                    <table class="table table-sm table-bordered align-middle mb-0">
                      <thead class="table-light">
                        <tr>
                          <th>제품명</th>
                          <th class="text-end">요청수량</th>
                          <th class="text-end">출고수량</th>
                          <th class="text-end">제품 단가</th>
                          <th class="text-end">요청 기준 총액</th>
                          <th class="text-end">출고 기준 총액</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:choose>
                          <c:when test="${not empty sales_OrderDto.salesItemList}">
                            <!-- 합계 변수 초기화 -->
                            <c:set var="totalReqQty" value="0" />
                            <c:set var="totalOutQty" value="0" />
                            <c:set var="totalReqAmount" value="0" />
                            <c:set var="totalOutAmount" value="0" />

                            <c:forEach var="item" items="${sales_OrderDto.salesItemList}">
                              <!-- 개별 계산 (null 방어) -->
                              <c:set var="reqCnt" value="${item.sales_Item_Cnt}" />
                              <c:set var="outCnt" value="${item.sales_Item_OutCnt}" />
                              <c:set var="unitCost" value="${item.sales_Item_Cost}" />

                              <c:set var="reqAmt" value="${reqCnt * (unitCost != null ? unitCost : 0)}" />
                              <c:set var="outAmt" value="${outCnt * (unitCost != null ? unitCost : 0)}" />

                              <!-- 누적 -->
                              <c:set var="totalReqQty" value="${totalReqQty + reqCnt}" />
                              <c:set var="totalOutQty" value="${totalOutQty + outCnt}" />
                              <c:set var="totalReqAmount" value="${totalReqAmount + reqAmt}" />
                              <c:set var="totalOutAmount" value="${totalOutAmount + outAmt}" />

                              <tr>
                                <td><c:out value="${item.productDTO.productName}" /></td>
                                <td class="text-end">${reqCnt}</td>
                                <td class="text-end">${outCnt}</td>
                                <td class="text-end">
                                  <fmt:formatNumber value="${unitCost}" type="number" groupingUsed="true" />
                                </td>
                                <td class="text-end">
                                  <fmt:formatNumber value="${reqAmt}" type="number" groupingUsed="true" />
                                </td>
                                <td class="text-end">
                                  <fmt:formatNumber value="${outAmt}" type="number" groupingUsed="true" />
                                </td>
                              </tr>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <tr>
                              <td colspan="6" class="text-center">상품이 없습니다.</td>
                            </tr>
                          </c:otherwise>
                        </c:choose>
                      </tbody>
                      <tfoot>
                        <tr class="fw-bold">
                          <td>합계</td>
                          <td class="text-end">${totalReqQty}</td>
                          <td class="text-end">${totalOutQty}</td>
                          <td></td>
                          <td class="text-end">
                            <fmt:formatNumber value="${totalReqAmount}" type="number" groupingUsed="true" />
                          </td>
                          <td class="text-end">
                            <fmt:formatNumber value="${totalOutAmount}" type="number" groupingUsed="true" />
                          </td>
                        </tr>
                      </tfoot>
                    </table>
                  </div>
                </div>

                <!-- 버튼 그룹: 목록, 수정 -->
                <div class="text-end mt-4 d-flex justify-content-end gap-2">
                  <a href="${pageContext.request.contextPath}/client/list"
                     class="btn btn-outline-secondary btn-sm px-4">목록</a>
                  <a href="${pageContext.request.contextPath}/client/modifyStart?client_No=${clientDto.client_No}"
                     class="btn btn-outline-primary btn-sm px-4">수정</a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>

      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      <jsp:include page="/foot.jsp" />
    </div>
  </div>
</body>
</html>
