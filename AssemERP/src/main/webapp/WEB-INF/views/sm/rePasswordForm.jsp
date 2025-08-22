<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AssemERP - 비밀번호 재설정</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        html, body { height: 100%; }
        body {
            background:
                radial-gradient(1200px 600px at 10% -10%, #e9f0ff 0%, transparent 60%),
                radial-gradient(1000px 400px at 100% 0%, #f2f6ff 0%, transparent 50%),
                linear-gradient(180deg, #ffffff 0%, #f6f7fb 100%);
        }
        .wrap {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
        }

        .reset-container {
            max-width: 980px;
        }

        .glass-card {
            backdrop-filter: blur(10px);
            background: rgba(255,255,255,0.88);
            border: 1px solid rgba(255,255,255,0.6);
            border-radius: 20px;
            box-shadow: 0 12px 40px rgba(78, 102, 197, 0.15);
        }

        .brand {
            display: flex; align-items: center; justify-content: center;
            gap: .6rem; font-weight: 800; color: #2b3a67; letter-spacing: .3px;
        }
        .brand .badge {
            background: linear-gradient(135deg, #406aff, #7a9cff);
            border: 0;
        }

        .form-floating>.form-control { border-radius: 12px; }
        .btn-primary { border-radius: 12px; font-weight: 700; }
        .btn-icon {
            position: absolute; right: 10px; top: 50%;
            transform: translateY(-50%);
            border: 0; background: transparent;
        }
        .alert { border-radius: 12px; }
        .muted-links a { color: #556; }
        .muted-links a:hover { color: #223; }
    </style>
</head>
<body>
<div class="wrap container">
    <div class="row justify-content-center reset-container w-100">
        <div class="col-12 col-md-10 col-lg-9 col-xl-8 col-xxl-7">
            <div class="card glass-card shadow-lg">
                <div class="card-body p-4 p-md-5">

                    <div class="text-center mb-4">
                        <div class="brand fs-4">
                            <span class="badge rounded-pill px-3 py-2">
                                <i class="bi bi-grid-fill me-1"></i>ERP
                            </span>
                            AssemERP
                        </div>
                        <h3 class="mt-3 mb-2 fw-bold">비밀번호 재설정</h3>
                        <p class="text-muted mb-0">아이디와 새 비밀번호를 입력하세요</p>
                    </div>

                    <form id="resetForm" action="${pageContext.request.contextPath}/account/rePasswordPro" method="post" class="needs-validation" novalidate>
                        <!-- 아이디 -->
                        <div class="form-floating mb-3">
                            <input type="text"
							       class="form-control"
							       id="userId"
							       name="userId"
							       value="${param.userId}"
							       placeholder="아이디"
							       readonly
							       style="background-color:#f3f4f6;"
							       required>
                            <label for="userId"><i class="bi bi-person-fill me-1"></i>아이디</label>
                            <div class="invalid-feedback">아이디를 입력해주세요.</div>
                        </div>

                        <div class="form-floating mb-3 position-relative">
                            <input type="password" class="form-control" id="password" name="password" placeholder="새 비밀번호" minlength="8" required>
                            <label for="password"><i class="bi bi-lock-fill me-1"></i>새 비밀번호 (8자 이상)</label>
                            <button type="button" class="btn btn-sm btn-icon" id="togglePw1" aria-label="비밀번호 보기/숨기기">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                            <div class="invalid-feedback">8자 이상의 새 비밀번호를 입력해주세요.</div>
                        </div>

                        <div class="form-floating mb-4 position-relative">
                            <input type="password" class="form-control" id="passwordCheck" placeholder="새 비밀번호 확인" required>
                            <label for="passwordCheck"><i class="bi bi-shield-lock-fill me-1"></i>새 비밀번호 확인</label>
                            <button type="button" class="btn btn-sm btn-icon" id="togglePw2" aria-label="비밀번호 보기/숨기기">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                            <div class="invalid-feedback" id="password-check-feedback">비밀번호가 일치하지 않습니다.</div>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                <span class="spinner-border spinner-border-sm me-2 d-none" id="submitSpinner" role="status" aria-hidden="true"></span>
                                비밀번호 변경
                            </button>
                        </div>

                        <div class="text-center mt-3 muted-links">
                            <a href="${pageContext.request.contextPath}/sm/profileForm" class="text-decoration-none">프로필 이동</a>&nbsp; / &nbsp; 
                            <a href="${pageContext.request.contextPath}/sm/loginForm" class="text-decoration-none">로그인 화면</a>
                        </div>
                    </form>

                </div>
            </div>

            <p class="text-center text-muted mt-3 mb-0" style="font-size: .9rem;">
                안전을 위해 강력한 비밀번호(문자·숫자·기호 조합)를 사용하세요.
            </p>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict';

    const form = document.getElementById('resetForm');
    const pw = document.getElementById('password');
    const pw2 = document.getElementById('passwordCheck');
    const spinner = document.getElementById('submitSpinner');
    const submitBtn = document.getElementById('submitBtn');

    function bindToggle(btnId, inputEl) {
        document.getElementById(btnId).addEventListener('click', function () {
            const icon = this.querySelector('i');
            const showing = inputEl.getAttribute('type') === 'text';
            inputEl.setAttribute('type', showing ? 'password' : 'text');
            icon.classList.toggle('bi-eye', !showing);
            icon.classList.toggle('bi-eye-slash', showing);
        });
    }
    bindToggle('togglePw1', pw);
    bindToggle('togglePw2', pw2);

    form.addEventListener('submit', (event) => {
        let valid = form.checkValidity();

        if (pw.value !== pw2.value) {
            pw2.classList.add('is-invalid');
            valid = false;
        } else {
            pw2.classList.remove('is-invalid');
        }

        if (!valid) {
            event.preventDefault();
            event.stopPropagation();
        } else {
            // 중복 제출 방지 & 로딩 표시
            submitBtn.setAttribute('disabled', 'disabled');
            spinner.classList.remove('d-none');
        }

        form.classList.add('was-validated');
    }, false);
})();
</script>
</body>
</html>
