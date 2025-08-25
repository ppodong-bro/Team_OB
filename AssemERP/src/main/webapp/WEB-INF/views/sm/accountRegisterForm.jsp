<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AssemERP - 회원가입</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons (옵션) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* ■■■ 배경 그라디언트 & 패턴 ■■■ */
        body {
            min-height: 100vh;
            background: radial-gradient(1200px 600px at -10% -10%, #e8f1ff, transparent 60%),
                        radial-gradient(1200px 600px at 110% 110%, #ffe9f0, transparent 60%),
                        linear-gradient(120deg, #f6f9ff 0%, #fff 100%);
        }
        /* ■■■ 글래스 카드 ■■■ */
        .glass-card {
            background: rgba(255,255,255,0.72);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.55);
            box-shadow:
                0 10px 30px rgba(28, 51, 140, 0.08),
                0 4px 16px rgba(0,0,0,0.04);
            border-radius: 18px;
        }
        /* ■■■ 로고 타이틀 ■■■ */
        .brand { display:flex; align-items:center; justify-content:center; gap:.6rem; font-weight:800; color:#2b3a67; letter-spacing:.3px; }
        .brand .badge { background: linear-gradient(135deg,#406aff,#7a9cff); border:0; }
        /* ■■■ 폼 요소 ■■■ */
        .form-floating>.form-control:focus ~ label,
        .form-floating>.form-control:not(:placeholder-shown) ~ label { color:#5a6bdb; }
        .form-control:focus { border-color:#6b82ff; box-shadow:0 0 0 .2rem rgba(41,82,227,.1); }
        .divider { height:1px; background:linear-gradient(90deg,transparent,#e9ecff,transparent); margin:1.25rem 0; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row min-vh-100 justify-content-center align-items-center py-5">
        <div class="col-xxl-4 col-xl-5 col-lg-6 col-md-8 col-sm-10">
            <div class="glass-card p-4 p-md-5">

                <div class="d-flex align-items-center justify-content-between mb-4">
                    <div class="d-flex align-items-center gap-2">
                        <div class="brand fs-4">
                            <span class="badge rounded-pill px-3 py-2"><i class="bi bi-grid-fill me-1"></i>ERP</span>
                            AssemERP
                        </div>
                    </div>
                    <span class="text-secondary small fw-semibold"></span>
                </div>

                <h2 class="h4 fw-bold mb-1" align="center">PARTNER 회원가입</h2>
                <p class="text-secondary mb-4" align="center">거래처 사용자 계정을 생성합니다. (관리자 승인 후 활성화)</p>

                <div class="divider"></div>
                
				<div class="mb-3">
				  <label class="form-label fw-semibold">계정 유형</label>
				
				  <div class="p-3 rounded-3 d-flex align-items-center gap-2
				              bg-primary-subtle border border-primary-subtle">
				    <i class="bi bi-people-fill fs-5"></i>
				    <span class="fw-bold text-primary-emphasis">거래처 사원</span>
				    <span class="badge bg-primary text-white ms-2">관리자 승인 필요</span>
				  </div>
				  <div class="form-text">
				    가입 후 관리자의 승인이 필요합니다.
				  </div>
				
				  <!-- <input type="hidden" name="empType" value="PARTNER"/>
				  <input type="hidden" name="partnerApproval" value="0"/> -->
				</div>

                <form action="${pageContext.request.contextPath}/account/accountRegisterPro" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <input type="hidden" name="empType" value="PARTNER"/>
                    <input type="hidden" name="partnerApproval" value="0"/>

					<div class="mb-3">
					  <label class="form-label fw-semibold">파트너번호</label>
					  <div class="input-group">
					    <span class="input-group-text"><i class="bi bi-hash"></i></span>
					    <input type="text"
					           class="form-control"
					           id="empNo"
					           name="empNo"
					           placeholder="숫자만 입력"
					           required
					           inputmode="numeric"
					           pattern="[0-9]+">
					    <button type="button" class="btn btn-primary" id="verifyBtn">
					      <i class="bi bi-patch-check"></i> 인증
					    </button>
					  </div>
					  <div class="invalid-feedback">파트너번호를 입력해주세요. (숫자만)</div>
					  <!-- 인증 결과 메시지 표시 -->
					  <div id="verifyFeedback" class="d-none mt-2"></div>
					</div>
					
					<div class="form-floating mb-3">
					  <input type="text" class="form-control" id="userId" placeholder="아이디" disabled>
					  <label for="userId"><i class="bi bi-person-badge me-1"></i>아이디</label>
					  <div class="form-text">인증 시 자동 생성됩니다.</div>
					</div>
					
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required minlength="8">
                        <label for="password"><i class="bi bi-shield-lock me-1"></i>비밀번호</label>
                        <div class="invalid-feedback">8자 이상의 비밀번호를 입력해주세요.</div>
                        <div class="form-text">관리자 승인시 사용할 비밀번호를 입력하세요.</div>
                    </div>
                    
					<div id="joinFeedback" class="d-none mb-3"></div>

                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-primary btn-lg" id="joinBtn">
						  <i class="bi bi-person-check me-1"></i>가입하기
						</button>

                        <a href="${pageContext.request.contextPath}/sm/loginForm" class="btn btn-outline-secondary">
                            <i class="bi bi-box-arrow-in-right me-1"></i>로그인으로 이동
                        </a>
                    </div>
                </form>
                
				<form id="verifyForm" class="d-none" method="get" action="${pageContext.request.contextPath}/account/verifyPartnerPro">
				  <input type="hidden" name="empNo"  id="vfEmpNo">
				  <input type="hidden" name="userId" id="vfUserId">
				</form>

                <div class="mt-4 small text-secondary">
                    계정 생성 관련 문의: <a class="text-decoration-none" href="mailto:help@assemblerp.local">help@assemblerp.local</a>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
(function(){
  'use strict';

  const ctx          = '${pageContext.request.contextPath}';
  const form         = document.querySelector('form.needs-validation');
  const empNo        = document.getElementById('empNo');
  const userId       = document.getElementById('userId');          // 표시용(또는 userIdView 사용 시 교체)
  const hiddenUserId = document.getElementById('hiddenUserId');    // 서버 전송용 hidden
  const password     = document.getElementById('password');
  const joinBtn      = document.getElementById('joinBtn');
  const verifyBtn    = document.getElementById('verifyBtn');
  const verifyForm   = document.getElementById('verifyForm');
  const vfEmpNo      = document.getElementById('vfEmpNo');

  const verifyMsg    = document.getElementById('verifyFeedback');  // 인증 결과
  const joinMsg      = document.getElementById('joinFeedback');    // 가입 결과

  const urlParams      = new URLSearchParams(window.location.search);
  const verifiedParam  = urlParams.get('verified');                // "true"/"false"
  const joinedParam    = urlParams.get('joined');                  // "true"/"false"
  const msgParam       = urlParams.get('msg');                     // 공통 메시지
  const empNoParam     = urlParams.get('empNo');
  const userIdParam    = urlParams.get('userId');                  // 서버에서 내려준 값만 사용

  function onlyDigits(v) { return (v || '').replace(/\D/g, ''); }

  function show(el, message, ok) {
    if (!el) return;
    el.textContent = message || '';
    el.classList.remove('d-none', 'alert-success', 'alert-danger');
    el.classList.add('alert', ok ? 'alert-success' : 'alert-danger', 'py-2', 'mb-0');
  }

  function updateJoinButtonState(){
    const verifiedOk = (verifiedParam === 'true');  // 인증 성공이어야 가입 가능
    const pwOk = password && password.value && password.value.length >= 8;
    if (joinBtn) joinBtn.disabled = !(verifiedOk && pwOk);
  }

  if (empNoParam)   empNo.value  = onlyDigits(empNoParam);
  if (userIdParam) {
    if (userId)       userId.value = userIdParam;        // 표시용
    if (hiddenUserId) hiddenUserId.value = userIdParam;  // 서버 전송용
  }

  if (verifiedParam === 'true')  show(verifyMsg, msgParam || '인증이 완료되었습니다.', true);
  if (verifiedParam === 'false') show(verifyMsg, msgParam || '인증에 실패했습니다.', false);
  if (verifiedParam === 'true') { empNo.readOnly = true; }

  if (joinedParam === 'true')  show(joinMsg, msgParam || '가입이 완료되었습니다.', true);
  if (joinedParam === 'false') show(joinMsg, msgParam || '가입에 실패했습니다.', false);

  empNo.addEventListener('input', () => {
    empNo.value = onlyDigits(empNo.value);
  });

  verifyBtn.addEventListener('click', () => {
    const digits = onlyDigits(empNo.value);
    if(!digits){ show(verifyMsg, '파트너번호를 입력하세요.', false); return; }
    vfEmpNo.value = digits;
    verifyForm.submit();
  });

  password?.addEventListener('input', updateJoinButtonState);
  updateJoinButtonState();

  joinBtn.addEventListener('click', () => {
    if(form.checkValidity()){
      form.submit();
    } else {
      form.classList.add('was-validated');
    }
  });

})();
</script>

</body>
</html>
