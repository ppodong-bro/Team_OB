<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AssemERP - 로그인</title>

    <!-- ★★ Bootstrap + Icons ★★ -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        /* ★★ 배경 & 레이아웃 ★★ */
        html, body { height: 100%; }
        body {
            background:
                radial-gradient(1200px 600px at 10% -10%, #e9f0ff 0%, transparent 60%),
                radial-gradient(1000px 400px at 100% 0%, #f2f6ff 0%, transparent 50%),
                linear-gradient(180deg, #ffffff 0%, #f6f7fb 100%);
        }
        .login-wrap {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
        }

        /* ★★ 컨테이너 최대 너비 확대 (기존보다 넓게) ★★ */
        .login-container {
            max-width: 980px; /* 필요하면 1040px, 1140px로 더 키워도 OK */
        }

        /* ★★ 카드(글래스) ★★ */
        .glass-card {
            backdrop-filter: blur(10px);
            background: rgba(255,255,255,0.88);
            border: 1px solid rgba(255,255,255,0.6);
            border-radius: 20px;
            box-shadow: 0 12px 40px rgba(78, 102, 197, 0.15);
        }

        /* ★★ 브랜드/타이틀 ★★ */
        .brand {
            display: flex; align-items: center; justify-content: center;
            gap: .6rem; font-weight: 800; color: #2b3a67; letter-spacing: .3px;
        }
        .brand .badge {
            background: linear-gradient(135deg, #406aff, #7a9cff);
            border: 0;
        }

        /* ★★ 입력/버튼 ★★ */
        .form-floating>.form-control { border-radius: 12px; }
        .btn-primary { border-radius: 12px; font-weight: 700; }
        .btn-icon {
            position: absolute; right: 10px; top: 50%;
            transform: translateY(-50%);
            border: 0; background: transparent;
        }
        .muted-links a { color: #556; }
        .muted-links a:hover { color: #223; }
        .alert { border-radius: 12px; }
    </style>
</head>
<body>
<div class="login-wrap container">
    <div class="row justify-content-center login-container w-100">
        <div class="col-12 col-md-10 col-lg-9 col-xl-8 col-xxl-7">
            <div class="card glass-card shadow-lg">
                <div class="card-body p-4 p-md-5">

                    <div class="text-center mb-4" >
                        <div class="brand fs-4" >
                            <span class="badge rounded-pill px-3 py-2"><i class="bi bi-grid-fill me-1"></i>ERP</span>
                            AssemERP
                        </div>
                        <h2 class="mt-3 mb-2 fw-bold">로그인</h2>
                        <p class="text-muted mb-0">사내 계정으로 로그인하세요</p>
                    </div>
                    
					<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

					<c:choose>
					
					  <c:when test="${param.error == 'ACCOUNT_WITHDRAWN' or param.error == 'withdrawn'}">
					    <div class="alert alert-warning d-flex align-items-center" role="alert">
					      <i class="bi bi-shield-exclamation me-2"></i>
					      <div>계정 상태(퇴사/탈퇴)로 인해 로그인이 제한되었습니다. 관리자에게 문의하세요.</div>
					    </div>
					  </c:when>
					
					  <c:when test="${
					      param.error == 'APPROVAL_PENDING'   or param.error == 'approval'
					      or param.error == 'APPROVAL_REQUIRED' or param.error == 'required'
					      or param.error == 'PRE_REGISTERED'    or param.error == 'pre'
					    }">
					    <div class="alert alert-warning d-flex align-items-center" role="alert">
					      <i class="bi bi-hourglass-split me-2"></i>
					      <div>관리자 승인 후 로그인이 가능합니다. </div>
					    </div>
					  </c:when>
					
					  <c:when test="${param.error == 'APPROVAL_REJECTED' or param.error == 'rejected'}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-x-octagon me-2"></i>
					      <div>승인이 반려되었습니다. 관리자에게 문의해 주세요.</div>
					    </div>
					  </c:when>
					
					  <c:when test="${param.error == 'denied' or param.error == 'ACCESS_DENIED'}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-slash-circle me-2"></i>
					      <div>접근 권한이 없습니다. 필요한 권한 부여 후 다시 시도해 주세요.</div>
					    </div>
					  </c:when>
					
					  <c:when test="${param.error == 'locked' or param.error == 'LOCKED'}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-lock-fill me-2"></i>
					      <div>계정이 잠겨 있습니다. 관리자에게 문의해 주세요.</div>
					    </div>
					  </c:when>
					  <c:when test="${param.error == 'expired' or param.error == 'ACCOUNT_EXPIRED'}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-calendar-x me-2"></i>
					      <div>계정이 만료되었습니다. 관리자에게 문의해 주세요.</div>
					    </div>
					  </c:when>
					  <c:when test="${param.error == 'pwexpired' or param.error == 'CREDENTIALS_EXPIRED'}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-key-fill me-2"></i>
					      <div>비밀번호가 만료되었습니다. 비밀번호를 변경해 주세요.</div>
					    </div>
					  </c:when>
					
					  <c:when test="${param.error == 'bad' or param.error == 'BAD_CREDENTIALS' or param.error == 'USER_NOT_FOUND'}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-exclamation-triangle me-2"></i>
					      <div>아이디 또는 비밀번호가 올바르지 않습니다.</div>
					    </div>
					  </c:when>
					
					  <c:when test="${not empty param.error}">
					    <div class="alert alert-danger d-flex align-items-center" role="alert">
					      <i class="bi bi-info-circle me-2"></i>
					      <div>로그인에 실패했습니다. 잠시 후 다시 시도하거나 관리자에게 문의하세요. (<code>${param.error}</code>)</div>
					    </div>
					  </c:when>
					
					</c:choose>

                    <form id="loginForm" action="${pageContext.request.contextPath}/account/loginPro" method="post" novalidate>
                        <div class="form-floating mb-3 position-relative">
                            <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디" required>
                            <label for="userId"><i class="bi bi-person-fill me-1"></i>아이디</label>
                        </div>
                        
                        <div class="form-floating mb-2 position-relative">
                            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
                            <label for="password"><i class="bi bi-lock-fill me-1"></i>비밀번호</label>
                            <button type="button" class="btn btn-sm btn-icon" id="togglePw" aria-label="비밀번호 보기/숨기기">
                                <i class="bi bi-eye-slash"></i>
                            </button>
                        </div>

                        <div class="d-grid mt-4">
                            <button class="btn btn-primary btn-lg" type="submit" id="loginBtn">
                                <span class="spinner-border spinner-border-sm me-2 d-none" id="loginSpinner" role="status" aria-hidden="true"></span>
                                로그인
                            </button>
                        </div>

                        <div class="text-center mt-3 muted-links">
                            <a href="${pageContext.request.contextPath}/sm/accountRegisterForm" class="text-decoration-none">회원가입</a>
                        </div>
                    </form>

                </div>
            </div>

            <p class="text-center text-muted mt-3 mb-0" style="font-size: .9rem;">
                보안 강화를 위해 공용PC에서는 사용 후 반드시 로그아웃하세요.
            </p>
        </div>
    </div>
</div>

<!-- ★★ Bootstrap JS ★★ -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.getElementById('togglePw').addEventListener('click', function () {
    const pw = document.getElementById('password');
    const icon = this.querySelector('i');
    const showing = pw.getAttribute('type') === 'text';
    pw.setAttribute('type', showing ? 'password' : 'text');
    icon.classList.toggle('bi-eye', !showing);
    icon.classList.toggle('bi-eye-slash', showing);
});

document.getElementById('loginForm').addEventListener('submit', function () {
    const btn = document.getElementById('loginBtn');
    const spn = document.getElementById('loginSpinner');
    btn.setAttribute('disabled', 'disabled');
    spn.classList.remove('d-none');
});
</script>
</body>
</html>
