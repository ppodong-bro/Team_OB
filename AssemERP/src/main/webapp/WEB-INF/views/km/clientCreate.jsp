<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>거래처 등록</title>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css'/>" />

<meta name="viewport" content="width=device-width, initial-scale=1" />
<style>
  body { background-color:#f8f9fa; }
  .card-header { background-color:#0d6efd; color:#fff; }
  .required-field::after { content:" *"; color:red; }

  /* 카드 안 폼의 배치/간격은 유지하면서 2열 그리드만 적용 */
  .info-card { border:1px solid #eee; border-radius:10px; padding:16px; margin-bottom:16px; }
  .info-card-title { font-weight:600; margin-bottom:12px; }

  /* ✅ 기본 2칸(= 한 줄 2 입력창), 작은 화면 1칸 */
  .info-grid {
    display:grid;
    grid-template-columns:repeat(2, minmax(0,1fr));
    gap:12px;
  }
  @media (max-width: 576px){
    .info-grid { grid-template-columns:1fr; }
  }

  .field-label { font-weight:600; color:#6c757d; margin-bottom:4px; }

  /* 부트스트랩 invalid 피드백이 input-group 아래에서 보이도록 보조 */
  .invalid-feedback.d-block { display:block; }
</style>

<script>
  /* ===== 공통 에러 표시 헬퍼: 빨간 테두리 + 아래 메시지 ===== */
  function showError(el, msg) {
    if (!el) return;
    el.setCustomValidity(msg);
    el.classList.add('is-invalid');

    // 같은 칸(field) 아래의 invalid-feedback 찾아서 메시지 출력
    const fb = el.closest('.field')?.querySelector('.invalid-feedback')
            || el.parentElement.querySelector('.invalid-feedback');
    if (fb) { fb.textContent = msg; fb.classList.add('d-block'); }

    // 사용자 시선 유도
    el.scrollIntoView({behavior:'smooth', block:'center'});
    el.focus();
  }

  function clearError(el) {
    if (!el) return;
    el.setCustomValidity('');
    el.classList.remove('is-invalid');
    const fb = el.closest('.field')?.querySelector('.invalid-feedback')
            || el.parentElement.querySelector('.invalid-feedback');
    if (fb) { fb.textContent = ''; fb.classList.remove('d-block'); }
  }

  /* ===== 직원 선택 팝업 연동 ===== */
  function openEmpPopup() {
    window.open('<c:url value="/client/empPopup"/>?empName=', 'empPopup',
                'width=1800,height=600,scrollbars=yes');
  }

  // 팝업에서 opener.fillEmp(empNo, empName) 형태로 호출
  function fillEmp(empNo, empName) {
    document.getElementById('empNo').value = empNo || '';
    const empNameEl = document.getElementById('empName');
    empNameEl.value = empName || '';
    clearError(empNameEl); // 선택 시 에러 해제
  }
  window.fillEmp = fillEmp;

  /* ===== 제출 전 유효성 검사: 담당 직원 필수 ===== */
  document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('clientCreateForm');
    form.addEventListener('submit', function(e) {
      const empNoVal = (document.getElementById('empNo').value || '').trim();
      const empNameEl = document.getElementById('empName');

      if (!empNoVal) {
        e.preventDefault();
        showError(empNameEl, '담당 직원을 선택하세요.');
        return;
      }
      clearError(empNameEl);
      // 통과: 브라우저의 기본 required 체크(거래처명/유형)는 그대로 동작
    });
  });
</script>
</head>

<body>
  <div id="layout">
    <div id="side">
      <jsp:include page="/side.jsp" />
    </div>

    <div id="main-area">
      <jsp:include page="/header.jsp" />

      <div id="contents">
        <div class="container-fluid px-4"><!-- ✅ 카드 외부 컨테이너/여백: 원본과 동일 -->
          <div class="card shadow-sm"><!-- ✅ 카드 크기/그림자: 원본과 동일 -->
            <!-- 카드 헤더: 좌측 목록, 중앙 타이틀, 우측 빈공간 -->
            <div class="card-header d-flex justify-content-between align-items-center">
              <a href="<c:url value='/client/list'/>" class="btn btn-outline-light btn-sm">
                <i class="bi bi-list-ul me-1"></i> 목록
              </a>
              <h4 class="card-title mb-0">
                <i class="bi bi-pencil-square me-2"></i>거래처 등록
              </h4>
              <div style="width:90px;"></div>
            </div>

            <div class="card-body p-4"><!-- ✅ 내부 패딩: 원본과 동일 -->
              <form id="clientCreateForm" method="post" action="<c:url value='/client/create'/>">
                <!-- 기본 정보 -->
                <section aria-labelledby="client-create-title" class="info-card" aria-label="거래처 기본 정보">
                  <div id="client-create-title" class="info-card-title">기본 정보</div>

                  <div class="info-grid"><!-- ✅ 2열 그리드 유지 -->
                    <!-- 담당 직원 -->
                    <div class="field">
                      <div class="field-label">담당 직원 <span class="text-danger">*</span></div>
                      <div class="input-group input-group-sm">
                        <!-- 서버 제출용 -->
                        <input type="hidden" id="empNo" name="empDTO.empNo" required />
                        <!-- 표시용 (readonly여도 커스텀 에러 표시 가능) -->
                        <input type="text" id="empName" class="form-control form-control-sm" placeholder="직원 선택" readonly />
                        <button type="button" class="btn btn-outline-secondary" onclick="openEmpPopup()">조회</button>
                      </div>
                      <!-- ↳ 아래 메시지 표시 위치 -->
                      <div class="invalid-feedback">담당 직원을 선택하세요.</div>
                    </div>

                    <!-- 거래처명 -->
                    <div class="field">
                      <div class="field-label">거래처명 <span class="text-danger">*</span></div>
                      <input type="text" class="form-control form-control-sm" name="client_Name" required />
                    </div>

                    <!-- 거래처 유형 -->
                    <div class="field">
                      <div class="field-label">거래처 유형 <span class="text-danger">*</span></div>
                      <select class="form-select form-select-sm w-auto" name="client_Gubun" required>
                        <option value="">선택</option>
                        <option value="0">구매처</option>
                        <option value="1">판매처</option>
                      </select>
                    </div>

                    <!-- 주소 -->
                    <div class="field">
                      <div class="field-label">주소</div>
                      <input type="text" class="form-control form-control-sm" name="client_Address" />
                    </div>

                    <!-- 이메일 -->
                    <div class="field">
                      <div class="field-label">이메일</div>
                      <input type="email" class="form-control form-control-sm" name="client_Email" />
                    </div>

                    <!-- 거래처 전화번호 -->
                    <div class="field">
                      <div class="field-label">거래처 전화번호</div>
                      <input type="text" class="form-control form-control-sm" name="client_Tel" />
                    </div>

                    <!-- 거래처 담당자 -->
                    <div class="field">
                      <div class="field-label">거래처 담당자</div>
                      <input type="text" class="form-control form-control-sm" name="client_Man" />
                    </div>
                  </div>
                </section>

                <!-- 숨김 필드 -->
                <input type="hidden" name="del_Status" value="0" />

                <!-- 액션 버튼: 원본과 동일한 배치/크기 -->
                <div class="row mt-4 g-2">
                  <div class="col-md-4 d-grid">
                    <a href="<c:url value='/client/list'/>" class="btn btn-outline-secondary btn-sm px-4" role="button">
                      <i class="bi bi-x-circle me-2"></i>취소
                    </a>
                  </div>
                  <div class="col-md-8 d-grid">
                    <button type="submit" id="modifyBtn" class="btn btn-primary btn-sm px-4">
                      <i class="bi bi-check-lg me-2"></i>등록
                    </button>
                  </div>
                </div>
              </form>
            </div><!-- /.card-body -->
          </div><!-- /.card -->
        </div><!-- /.container-fluid -->
      </div><!-- /#contents -->

      <jsp:include page="/foot.jsp" />
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </div><!-- /#main-area -->
  </div><!-- /#layout -->
</body>
</html>