<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 공통 CSS 및 헤더 포함 -->
  <jsp:include page="/common.jsp" />
  <link rel="stylesheet" href="<c:url value='/css/list.css' />" />
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>발주 상세</title>

  <style>
    body { background-color: #f8f9fa; }

    .card-header {
      background-color: #C0C0C0;
      color: white;
    }

    .required-field::after { content: " *"; color: red; }

    .image-box { width: auto; height: 300px; overflow: hidden; }
    .image-box img { width: 100%; height: 100%; display: block; }

    .parent-container { display: flex; flex-direction: column; gap: 15px; }

    /* 숫자 정렬용 공용 클래스 */
    .numeric { text-align: right; }

    /* 상세 테이블: 작은 화면 가로 스크롤 보장 + 헤더 sticky + 행수 기반 세로 스크롤 */
    .product-table { min-width: 720px; }
    @media (max-width: 768px) { .product-table { min-width: 640px; } }

    .product-table thead th {
      position: sticky; top: 0; z-index: 2;
      background: var(--bs-light, #f8f9fa);
    }

    /* 세로 스크롤은 JS가 상황에 따라 토글. 기본은 숨김 */
    .product-table-wrap { overflow-y: hidden; 
    }
    
	/* 헤더 하단 보더(기준) – 혹시 모를 테마 차이를 맞추기 위함 */
	.product-table thead > tr > * {
	  border-bottom-width: 2px;
	}
	
	/* 합계 행 위쪽 보더를 헤더 하단 보더와 동일하게 */
	.product-table tfoot .total-row > * {
	  border-top: 2px solid var(--bs-border-color, #dee2e6) !important;
	}
	
	/* (선택) 마지막 데이터 행의 하단 보더를 제거해 이중선 느낌 방지 */
	.product-table tbody tr:last-child > * {
	  border-bottom: 0 !important;
	}
	
	#productTableWrap { position: relative; }  /* sticky 기준이 되는 컨테이너 */
	.product-table tfoot .total-row > * {
	  position: sticky;
	  bottom: 0;
	  z-index: 3; /* thead와 겹치지 않게 */
	  /* 배경은 위에서 지정한 값 유지 */
	  box-shadow: 0 -1px 0 var(--bs-border-color, #dee2e6),
	              0 -6px 12px rgba(0,0,0,.04); /* 위쪽에 얇은 경계/그림자로 레이어감 */
	}
	
	
/* 합계 행의 모든 글자에 아주 살짝 드롭 섀도우 */
.product-table tfoot .total-row > * {
  font-weight: 600;                          /* 굵기는 미세 강조 */
  text-shadow: 0.5px 0.5px 0 rgba(0,0,0,.18); /* 번짐 없는 미세 음영 */
}

/* "합계" 라벨(첫 칸)만 살짝 더 입체감: 위쪽 하이라이트 + 아래쪽 음영 */
.product-table tfoot .total-row td:first-child {
  letter-spacing: .2px;
  text-shadow:
    0.7px 0.7px 0 rgba(0,0,0,.22),            /* 아래/오른쪽 얇은 그림자 */
   -0.5px -0.5px 0 rgba(255,255,255,.35);     /* 위/왼쪽 얇은 하이라이트 */
}
  </style>

  <script>
  /* ===== 6행 초과 시 세로 스크롤 + 헤더 고정 ===== */
  (function () {
    function apply7RowScroll() {
      const wrap  = document.getElementById('productTableWrap');
      if (!wrap) return;
      const table = wrap.querySelector('.product-table');
      if (!table) return;

      const thead = table.tHead;
      const tbody = table.tBodies[0];
      if (!tbody) return;

      const rows = Array.from(tbody.rows).filter(r => r.offsetParent !== null);

      // 기본: 스크롤 해제
      wrap.style.maxHeight = '';
      wrap.style.overflowY = 'hidden';

      if (rows.length <= 6) return; // 7행 이하면 스크롤 X

      const headH = thead ? thead.getBoundingClientRect().height : 0;
      let bodyH = 0;
      for (let i = 0; i < 6 && i < rows.length; i++) {
        bodyH += rows[i].getBoundingClientRect().height;
      }
      const buffer = 2; // 보더 여유
      wrap.style.maxHeight = Math.ceil(headH + bodyH + buffer) + 'px';
      wrap.style.overflowY = 'auto';
    }

    let raf = null;
    function onResize() {
      if (raf) cancelAnimationFrame(raf);
      raf = requestAnimationFrame(apply7RowScroll);
    }
    window.addEventListener('load', apply7RowScroll);
    window.addEventListener('resize', onResize);

    // 필요 시 동적으로 호출할 수 있게 공개
    window.refreshProductTableScroll = apply7RowScroll;
  })();
  </script>
</head>
<body>
  <div id="layout">
    <!-- 사이드 내비게이션 -->
    <div id="side"><jsp:include page="/side.jsp" /></div>

    <div id="main-area">
      <!-- 상단 헤더 -->
      <jsp:include page="/header.jsp" />

      <!-- 컨텐츠 -->
      <div id="contents">
        <c:if test="${not empty error}">
          <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
          <div class="alert alert-success">${success}</div>
        </c:if>

        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <!-- 카드 헤더 -->
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="<c:url value='/purchase/list'/>" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0">
                <i class="bi bi-pencil-square me-2"></i>발주 상세
              </h4>
              <!-- 중앙 정렬을 위한 공간 -->
              <div style="width:90px;"></div>
            </div>

            <div class="card-body p-4">
              <!-- 발주 / 거래처 정보 -->
              <section aria-labelledby="order-info-title" class="info-card" aria-label="발주 및 거래처 정보">
                <div id="order-info-title" class="info-card-title">발주 / 거래처 정보</div>
                <div class="info-grid">
                  <!-- 발주 제목(전폭) -->
                  <div class="field" style="grid-column:1 / -1;">
                    <div class="field-label">제목</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.purchase_Title}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">발주 번호</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.purchase_No}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">거래처명</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.clientDto.client_Name}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">주소</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.clientDto.client_Address}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">이메일</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.clientDto.client_Email}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">거래처 전화번호</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.clientDto.client_Tel}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">거래처 담당자</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.clientDto.client_Man}" default="-" />
                    </div>
                  </div>

                  <div class="field">
                    <div class="field-label">영업 담당자</div>
                    <div class="field-box">
                      <c:out value="${Purchase_OrderDto.empDTO.empName}" default="-" />
                    </div>
                  </div>
                  
                
                  <div class="field">
                    <div class="field-label">납기 완료일</div>
                     <div class="field-box">
                        <c:out value="${fn:substring(Purchase_OrderDto.purchase_Date,0,10)}" default="-" />
                     </div>
                  </div>

                  <!-- 완료일: 존재할 때만 -->
                  <c:if test="${not empty Purchase_OrderDto.complete_Date}">
                    <div class="field">
                      <div class="field-label">완료일</div>
                      <div class="field-box">
                        <c:out value="${fn:substring(Purchase_OrderDto.complete_Date,0,10)}" default="-" />
                      </div>
                    </div>
                  </c:if>

                  <!-- 최근 수정일: 존재할 때만 -->
                  <c:if test="${not empty Purchase_OrderDto.modify_Date}">
                    <div class="field">
                      <div class="field-label">최근 수정일</div>
                      <div class="field-box">
                        <c:out value="${fn:substring(Purchase_OrderDto.modify_Date,0,10)}" default="-" />
                      </div>
                    </div>
                  </c:if>

                  <div class="field">
                    <div class="field-label">등록일</div>
                    <div class="field-box">
                      <c:out value="${fn:substring(Purchase_OrderDto.in_Date,0,10)}" default="-" />
                    </div>
                  </div>
                </div>
              </section>

              <!-- 부품 목록 -->
              <section aria-labelledby="product-list-title" class="info-card mt-4" aria-label="부품 목록">
                <div id="product-list-title" class="info-card-title">부품 목록</div>

                <div id="productTableWrap" class="table-responsive product-table-wrap">
                  <table class="table table-sm table-bordered align-middle mb-0 product-table">
                    <caption class="visually-hidden">발주한 부품 목록과 입고/요청 기준 금액</caption>
                    <thead class="table-light">
                      <tr>
                        <th style ="width: 40%;" class="text-center" scope="col">부품명</th>
                        <th style ="width: 10%;" scope="col" class="numeric text-center">요청 수량</th>
                        <th style ="width: 10%;" scope="col" class="numeric text-center">입고 수량</th>
                        <th style ="width: 10%;" scope="col" class="numeric text-center">입고 대기</th>
                        <th style ="width: 10%;" scope="col" class="numeric text-center">부품 단가</th>
                        <th style ="width: 10%;" scope="col" class="numeric text-center">입고 기준 총액</th>
                        <th style ="width: 10%;" scope="col" class="numeric text-center">요청 기준 총액</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:choose>
                        <c:when test="${not empty Purchase_OrderDto.purchase_Item}">
                          <c:forEach var="item" items="${Purchase_OrderDto.purchase_Item}">
                            <tr>
                              <td class="name text-truncate"
                                  title="<c:out value='${item.partsDTO != null ? item.partsDTO.parts_name : "-"}'/>">
                                <c:out value="${item.partsDTO != null ? item.partsDTO.parts_name : '-'}" />
                              </td>
                              <td class="numeric">
                                <c:out value="${item.purchase_Item_Cnt}" default="0" />
                              </td>
                              <td class="numeric">
                                <c:out value="${item.purchase_Item_InCnt}" default="0" />
                              </td>
                              <td class="numeric">
                                <c:out value="${item.purchase_Item_WaitingCnt}" default="0" />
                              </td>
                              <td class="numeric">
                                <fmt:formatNumber value="${item.purchase_Item_Cost != null ? item.purchase_Item_Cost : 0}"
                                                  type="number" groupingUsed="true" />
                              </td>
                              <td class="numeric">
                                <fmt:formatNumber value="${item.purchase_Item_TotInCost != null ? item.purchase_Item_TotInCost : 0}"
                                                  type="number" groupingUsed="true" />
                              </td>
                              <td class="numeric">
                                <fmt:formatNumber value="${item.purchase_Item_TotCost != null ? item.purchase_Item_TotCost : 0}"
                                                  type="number" groupingUsed="true" />
                              </td>
                            </tr>
                          </c:forEach>
                        </c:when>
                        <c:otherwise>
                          <tr>
                            <td colspan="7" class="text-center">부품이 없습니다.</td>
                          </tr>
                        </c:otherwise>
                      </c:choose>
                    </tbody>
                    <tfoot>
                      <tr class="total-row table-light">
                        <td class="text-center">합계</td>
                        <td class="numeric"><c:out value="${Purchase_OrderDto.totCnt}" default="0" /></td>
                        <td class="numeric"><c:out value="${Purchase_OrderDto.totInCnt}" default="0" /></td>
                        <td class="numeric"><c:out value="${Purchase_OrderDto.totWaitingCnt}" default="0" /></td>
                        <td class="numeric"></td>
                        <td class="numeric"><fmt:formatNumber value="${Purchase_OrderDto.totInCost}" type="number" groupingUsed="true" /></td>
                        <td class="numeric"><fmt:formatNumber value="${Purchase_OrderDto.totCost}"   type="number" groupingUsed="true" /></td>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </section>

              <!-- 액션 버튼들 -->
              <div class="mt-4">
                <div class="row g-2">
                  <c:choose>
                    <%-- in_Status == 0 : 승인 / 수정 / 발주 취소 --%>
                    <c:when test="${Purchase_OrderDto.in_Status == 0}">
                      <div class="col-12 col-md-6 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/modifyStatus" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-primary btn-sm px-4 w-100"
                                  onclick="return confirm('발주를 승인 하시겠습니까?');">
                            <i class="bi bi-check2-circle me-1"></i>승인
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <a href="${pageContext.request.contextPath}/purchase/detailPageModifyStart?purchase_No=${Purchase_OrderDto.purchase_No}"
                           class="btn btn-outline-primary btn-sm px-4 w-100"
                           onclick="return confirm('발주를 수정 하시겠습니까?');">
                          <i class="bi bi-pencil-square me-1"></i>수정
                        </a>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/delete" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-danger btn-sm px-4 w-100"
                                  onclick="return confirm('발주를 취소 하시겠습니까?');">
                            <i class="bi bi-trash me-1"></i>발주 취소
                          </button>
                        </form>
                      </div>
                    </c:when>

                    <%-- in_Status == 1 : 완료 / 재발주 요청 / 승인 취소 / 발주 취소 --%>
                    <c:when test="${Purchase_OrderDto.in_Status == 1}">
                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/modifyStatus" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-primary btn-sm px-4 w-100"
                                  onclick="return confirm('발주를 완료 하시겠습니까?');">
                            <i class="bi bi-check-lg me-1"></i>완료
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/accessModify" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-outline-primary btn-sm px-4 w-100"
                                  onclick="return confirm('정말 재발주 요청하시겠습니까? 요청 상태로 변환 후 해당 발주 수정 페이지로 이동합니다.');">
                            <i class="bi bi-arrow-repeat me-1"></i>재발주 요청
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/returnStatus" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-secondary btn-sm px-4 w-100"
                                  onclick="return confirm('정말 승인 상태를 취소 하시겠습니까? 요청 상태로 변환 후 해당 발주 상세 페이지로 이동합니다.');">
                            <i class="bi bi-x-circle me-1"></i>승인 취소
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/delete" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-danger btn-sm px-4 w-100"
                                  onclick="return confirm('발주를 취소 하시겠습니까?');">
                            <i class="bi bi-trash me-1"></i>발주 취소
                          </button>
                        </form>
                      </div>
                    </c:when>

                    <%-- in_Status == 2 : 완료 취소(풀폭) --%>
                    <c:when test="${Purchase_OrderDto.in_Status == 2}">
                      <div class="col-12 d-grid">
                        <form action="${pageContext.request.contextPath}/purchase/returnStatus" method="post" class="m-0">
                          <input type="hidden" name="purchase_No" value="${Purchase_OrderDto.purchase_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-secondary btn-sm px-4 w-100"
                                  onclick="return confirm('정말 완료 상태를 취소 하시겠습니까? 승인 상태로 변환 후 해당 발주 상세 페이지로 이동합니다.');">
                            <i class="bi bi-arrow-counterclockwise me-1"></i>완료 취소
                          </button>
                        </form>
                      </div>
                    </c:when>
                  </c:choose>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>

      <!-- 부트스트랩 JS + 공통 푸터 -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      <jsp:include page="/foot.jsp" />
    </div>
  </div>
</body>
</html>
 