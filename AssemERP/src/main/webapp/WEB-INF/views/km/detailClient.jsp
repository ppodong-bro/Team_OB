<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 공통 CSS 및 헤더 포함 (공통 레이아웃/스타일) -->
  <jsp:include page="/common.jsp" />
  <link rel="stylesheet" href="<c:url value='/css/list.css' />" />
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>거래처 상세</title>
</head>
<body>
  <div id="layout">
    <!-- 사이드 내비게이션 -->
    <div id="side">
      <jsp:include page="/side.jsp" />
    </div>

    <div id="main-area">
      <!-- 상단 헤더 -->
      <jsp:include page="/header.jsp" />

      <!-- 컨텐츠 -->
      <div id="contents">
        <div class="container-fluid px-4">
          <div class="card shadow-sm">
            <!-- 카드 헤더: 좌측 검정 '목록' 버튼 + 중앙 타이틀 -->
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="<c:url value='/client/list'/>" class="btn btn-outline-dark btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0">
                <i class="bi bi-pencil-square me-2"></i>거래처 상세
              </h4>
              <div style="width: 90px;"></div>
            </div>

            <div class="card-body p-4">
              <!-- 거래처 정보 -->
              <section aria-labelledby="client-info-title" class="info-card" aria-label="거래처 정보">
                <div id="client-info-title" class="info-card-title">거래처 정보</div>

                <div class="info-grid">
                  <!-- 거래처 번호 -->
                  <div class="field">
                    <div class="field-label">거래처 번호</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.client_No}"/></span>
                    </div>
                  </div>

                  <!-- 담당자 이름(내부) -->
                  <div class="field">
                    <div class="field-label">담당자 이름</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.empDTO.empName}"/></span>
                    </div>
                  </div>

                  <!-- 거래처 유형 -->
                  <div class="field">
                    <div class="field-label">거래처 유형</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.context}"/></span>
                    </div>
                  </div>

                  <!-- 거래처명 -->
                  <div class="field">
                    <div class="field-label">거래처명</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.client_Name}"/></span>
                    </div>
                  </div>

                  <!-- 주소 -->
                  <div class="field">
                    <div class="field-label">주소</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.client_Address}"/></span>
                    </div>
                  </div>

                  <!-- 이메일 (수주 상세와 동일하게 @ 보조 표기) -->
                  <div class="field">
                    <div class="field-label">이메일</div>
                    <div class="field-box">
                      <span class="small-addon">@</span>
                      <span><c:out value="${clientDto.client_Email}"/></span>
                    </div>
                  </div>

                  <!-- 거래처 전화번호 -->
                  <div class="field">
                    <div class="field-label">거래처 전화번호</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.client_Tel}"/></span>
                    </div>
                  </div>

                  <!-- 거래처 담당자 -->
                  <div class="field">
                    <div class="field-label">거래처 담당자</div>
                    <div class="field-box">
                      <span><c:out value="${clientDto.client_Man}"/></span>
                    </div>
                  </div>

                  <!-- 최근 수정 일자 (있을 때만) -->
                  <c:if test="${not empty clientDto.modify_Date}">
                    <div class="field">
                      <div class="field-label">최근 수정 일자</div>
                      <div class="field-box">
                        <!-- LocalDateTime 문자열/타입 모두 대응: 문자열이면 substring, 타입이면 컨트롤러에서 String으로 넘겨주는 걸 권장 -->
                        <span>${fn:substring(clientDto.modify_Date, 0, 10)}</span>
                      </div>
                    </div>
                  </c:if>

                  <!-- 등록 일자 -->
                  <div class="field">
                    <div class="field-label">등록 일자</div>
                    <div class="field-box">
                      <span>${fn:substring(clientDto.in_Date, 0, 10)}</span>
                    </div>
                  </div>
                </div>
              </section>

              <!-- 하단 버튼 (목록/수정) -->
              <div class="text-end mt-4 d-flex justify-content-end gap-2">
                <a href="<c:url value='/client/list'/>" class="btn btn-outline-secondary btn-sm px-4">목록</a>
                <a href="<c:url value='/client/modifyStart?client_No=${clientDto.client_No}'/>"
                   class="btn btn-outline-primary btn-sm px-4">수정</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 푸터 -->
      <jsp:include page="/foot.jsp" />
      <!-- 부트스트랩 JS -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </div>
  </div>
</body>
</html>
