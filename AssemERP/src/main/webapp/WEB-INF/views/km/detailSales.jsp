<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <title>수주 상세</title>

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
  (function () {
    function applyRowScroll() {
      const wrap  = document.getElementById('productTableWrap');
      if (!wrap) return;

      // 임계 행수: data-scroll-rows 에서 읽고, 없으면 6을 기본값으로 사용
      const limit = parseInt(wrap.dataset.scrollRows || '6', 10);

      const table = wrap.querySelector('.product-table');
      if (!table) return;

      const thead = table.tHead;
      const tbody = table.tBodies[0];
      if (!tbody) return;

      const rows = Array.from(tbody.rows).filter(r => r.offsetParent !== null);

      // 초기화(세로 스크롤 해제)
      wrap.style.maxHeight = '';
      wrap.style.overflowY = 'hidden';

      // limit 행 이하라면 스크롤 없음
      if (rows.length <= limit) return;

      // 헤더 높이 + 앞 limit개 행 높이 합으로 뷰포트 높이 계산
      const headH = thead ? thead.getBoundingClientRect().height : 0;
      let bodyH = 0;
      for (let i = 0; i < Math.min(limit, rows.length); i++) {
        bodyH += rows[i].getBoundingClientRect().height;
      }

      // 2px 보더 여유
      wrap.style.maxHeight = Math.ceil(headH + bodyH + 2) + 'px';
      wrap.style.overflowY = 'auto';
    }

    // 최초/리사이즈 시 반영
    let raf = null;
    function onResize() {
      if (raf) cancelAnimationFrame(raf);
      raf = requestAnimationFrame(applyRowScroll);
    }
    window.addEventListener('load', applyRowScroll);
    window.addEventListener('resize', onResize);

    // 동적으로 행이 변하는 경우 호출할 수 있게 공개
    window.refreshProductTableScroll = applyRowScroll;
  })();
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
      <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
      </c:if>
      <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
      </c:if>
      <c:if test="${not empty fail}">
        <div class="alert alert-danger">${fail}</div>
      </c:if>

      <div id="contents">
        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="/sales/list" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0">
                <i class="bi bi-pencil-square me-2"></i>수주 상세
              </h4>
              <div style="width: 90px;"></div>
            </div>

            <div class="card-body p-4">
              <!-- 수주 / 거래처 정보 (읽기 전용 상세) -->
              <section aria-labelledby="order-info-title" class="info-card" aria-label="수주 및 거래처 정보">
                <div id="order-info-title" class="info-card-title">수주 / 거래처 정보</div>
                <div class="info-grid">
                  <!-- 수주 제목 -->
                  <div class="field" style="grid-column: 1/-1;">
                    <div class="field-label">수주 제목</div>
                    <div class="field-box">
                      <span>${empty sales_OrderDto.sales_Title ? '-' : sales_OrderDto.sales_Title}</span>
                    </div>
                  </div>

                  <!-- 수주 번호 -->
                  <div class="field">
                    <div class="field-label">수주 번호</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.sales_No}</span>
                    </div>
                  </div>

                  <!-- 거래처 이름 -->
                  <div class="field">
                    <div class="field-label">거래처 이름</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.clientDto.client_Name}</span>
                    </div>
                  </div>

                  <!-- 주소 -->
                  <div class="field">
                    <div class="field-label">주소</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.clientDto.client_Address}</span>
                    </div>
                  </div>

                  <!-- 이메일 -->
                  <div class="field">
                    <div class="field-label">이메일</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.clientDto.client_Email}</span>
                    </div>
                  </div>

                  <!-- 거래처 전화번호 -->
                  <div class="field">
                    <div class="field-label">거래처 전화번호</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.clientDto.client_Tel}</span>
                    </div>
                  </div>

                  <!-- 거래처 담당자 -->
                  <div class="field">
                    <div class="field-label">거래처 담당자</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.clientDto.client_Man}</span>
                    </div>
                  </div>

                  <!-- 내부 담당자 이름 -->
                  <div class="field">
                    <div class="field-label">담당자 이름</div>
                    <div class="field-box">
                      <span>${sales_OrderDto.empDTO.empName}</span>
                    </div>
                  </div>

                  <!-- 완료 일자 -->
                  <c:if test="${not empty sales_OrderDto.complete_Date}">
                    <div class="field">
                      <div class="field-label">완료 일자</div>
                      <div class="field-box">
                        <span>${fn:substring(sales_OrderDto.complete_Date, 0, 10)}</span>
                      </div>
                    </div>
                  </c:if>

                  <!-- 최근 수정 일자 -->
                  <c:if test="${not empty sales_OrderDto.modify_Date}">
                    <div class="field">
                      <div class="field-label">최근 수정 일자</div>
                      <div class="field-box">
                        <span>${fn:substring(sales_OrderDto.modify_Date, 0, 10)}</span>
                      </div>
                    </div>
                  </c:if>

                  <!-- 등록 일자 -->
                  <div class="field">
                    <div class="field-label">등록 일자</div>
                    <div class="field-box">
                      <span>${fn:substring(sales_OrderDto.in_Date, 0, 10)}</span>
                    </div>
                  </div>
                </div>
              </section>

              <!-- 제품 목록 -->
              <section aria-labelledby="product-list-title" class="info-card mt-4" aria-label="제품 목록">
                <div id="product-list-title" class="info-card-title">제품 목록</div>

                <!-- ★ 여기서부터: 6행 이상일 때만 세로 스크롤 -->
                <div id="productTableWrap"
                     class="table-responsive product-table-wrap"
                     data-scroll-rows="6">
                  <table class="table table-sm table-bordered align-middle mb-0 product-table">
                    <caption class="visually-hidden">수주한 제품 목록과 출고/요청 기준 금액</caption>
                    <thead class="table-light">
                      <tr>
                        <th class="text-center" scope="col">제품명</th>
                        <th scope="col" class="numeric text-center">요청수량</th>
                        <th scope="col" class="numeric text-center">출고수량</th>
                        <th scope="col" class="numeric text-center">출고대기</th>
                        <th scope="col" class="numeric text-center">제품 단가</th>
                        <th scope="col" class="numeric text-center">출고 기준 총액</th>
                        <th scope="col" class="numeric text-center">요청 기준 총액</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:choose>
                        <c:when test="${not empty sales_OrderDto.sales_Item}">
                          <c:forEach var="item" items="${sales_OrderDto.sales_Item}">
                            <tr>
                              <td class="name text-truncate"
                                  title="<c:out value='${item.productDto != null ? item.productDto.product_name : "-"}'/>">
                                <c:out value="${item.productDto != null ? item.productDto.product_name : '-'}" />
                              </td>
                              <td class="numeric">
                                <c:out value="${item.sales_Item_Cnt != null ? item.sales_Item_Cnt : 0}" />
                              </td>
                              <td class="numeric">
                                <c:out value="${item.sales_Item_OutCnt != null ? item.sales_Item_OutCnt : 0}" />
                              </td>
                              <td class="numeric">
                                <c:out value="${item.sales_Item_WaitingCnt != null ? item.sales_Item_WaitingCnt : 0}" />
                              </td>
                              <td class="numeric">
                                <fmt:formatNumber value="${item.sales_Item_Cost != null ? item.sales_Item_Cost : 0}"
                                                  type="number" groupingUsed="true" />
                              </td>
                              <td class="numeric">
                                <fmt:formatNumber value="${item.sales_Item_TotOutCost != null ? item.sales_Item_TotOutCost : 0}"
                                                  type="number" groupingUsed="true" />
                              </td>
                              <td class="numeric">
                                <fmt:formatNumber value="${item.sales_Item_TotCost != null ? item.sales_Item_TotCost : 0}"
                                                  type="number" groupingUsed="true" />
                              </td>
                            </tr>
                          </c:forEach>
                        </c:when>
                        <c:otherwise>
                          <tr>
                            <td colspan="7" class="text-center">상품이 없습니다.</td>
                          </tr>
                        </c:otherwise>
                      </c:choose>
                    </tbody>
                    <tfoot>
                      <tr class="total-row">
                        <td class="text-center">합계</td>
                        <td class="numeric">${sales_OrderDto.totCnt}</td>
                        <td class="numeric">${sales_OrderDto.totOutCnt}</td>
                        <td class="numeric">${sales_OrderDto.totWaitingCnt}</td>
                        <td class="numeric"></td>
                        <td class="numeric">
                          <fmt:formatNumber value="${sales_OrderDto.totOutCost}" type="number" groupingUsed="true" />
                        </td>
                        <td class="numeric">
                          <fmt:formatNumber value="${sales_OrderDto.totCost}" type="number" groupingUsed="true" />
                        </td>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </section>

              <!-- 액션 바 -->
              <div class="mt-4">
                <div class="row g-2">
                  <c:choose>
                  
                    <c:when test="${sales_OrderDto.out_Status == 0}">
                      <div class="col-12 col-md-6 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/modifyStatus" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-primary btn-sm px-4 w-100"
                                  onclick="return confirm('수주를 승인 하시겠습니까?');">
                            <i class="bi bi-check2-circle me-1"></i>승인
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <a href="${pageContext.request.contextPath}/sales/detailPageModifyStart?sales_No=${sales_OrderDto.sales_No}"
                           class="btn btn-outline-primary btn-sm px-4 w-100"
                           onclick="return confirm('수주를 수정 하시겠습니까?');">
                          <i class="bi bi-pencil-square me-1"></i>수정
                        </a>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/delete" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-danger btn-sm px-4 w-100"
                                  onclick="return confirm('수주를 취소 하시겠습니까?');">
                            <i class="bi bi-trash me-1"></i>수주 취소
                          </button>
                        </form>
                      </div>
                    </c:when>

                   
                    <c:when test="${sales_OrderDto.out_Status == 1}">
                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/modifyStatus" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-primary btn-sm px-4 w-100"
                                  onclick="return confirm('수주를 완료 하시겠습니까?');">
                            <i class="bi bi-check-lg me-1"></i>완료
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/accessModify" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <input type="hidden" name="out_Status" value="${sales_OrderDto.out_Status}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-outline-primary btn-sm px-4 w-100"
                                  onclick="return confirm('정말 재수주 요청하시겠습니까? 요청 상태로 변경 후 해당 수주 수정 페이지로 이동합니다.');">
                            <i class="bi bi-arrow-repeat me-1"></i>재수주 요청
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/returnStatus" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-secondary btn-sm px-4 w-100"
                                  onclick="return confirm('정말 승인 상태를 취소 하시겠습니까? 요청 상태로 변환 후 해당 수주 상세 페이지로 이동합니다.');">
                            <i class="bi bi-x-circle me-1"></i>승인 취소
                          </button>
                        </form>
                      </div>

                      <div class="col-12 col-md-3 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/delete" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-danger btn-sm px-4 w-100"
                                  onclick="return confirm('수주를 취소 하시겠습니까?');">
                            <i class="bi bi-trash me-1"></i>수주 취소
                          </button>
                        </form>
                      </div>
                    </c:when>

                   
                    <c:when test="${sales_OrderDto.out_Status == 2}">
                      <div class="col-12 d-grid">
                        <form action="${pageContext.request.contextPath}/sales/returnStatus" method="post" class="m-0">
                          <input type="hidden" name="sales_No" value="${sales_OrderDto.sales_No}" />
                          <c:if test="${not empty _csrf}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                          </c:if>
                          <button type="submit" class="btn btn-secondary btn-sm px-4 w-100"
                                  onclick="return confirm('정말 완료 상태를 취소 하시겠습니까? 승인 상태로 변환 후 해당 수주 상세 페이지로 이동합니다.');">
                            <i class="bi bi-arrow-counterclockwise me-1"></i>완료 취소
                          </button>
                        </form>
                      </div>
                    </c:when>
                  </c:choose>
                </div>
              </div>

            </div> <!-- /.card-body -->
          </div>   <!-- /.card -->
        </div>     <!-- /.container-fluid -->
      </div>       <!-- /#contents -->

      <!-- 부트스트랩 JS -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
      <!-- 공통 푸터 포함 -->
      <jsp:include page="/foot.jsp" />
    </div> <!-- /#main-area -->
  </div>   <!-- /#layout -->
</body>
</html>
 