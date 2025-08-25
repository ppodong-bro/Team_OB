<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<sec:authentication property="principal.account.empName"/>
<sec:authentication property="principal.account.empFilename"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AssemERP - 프로필</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background: radial-gradient(1200px 600px at 10% -10%, #eef4ff 0%, transparent 60%),
                        radial-gradient(1000px 400px at 100% 0%, #f6f9ff 0%, transparent 50%),
                        linear-gradient(180deg, #ffffff 0%, #f6f7fb 100%);
        }
        .page-wrap {
            padding: 40px 0 60px;
        }
        .profile-card {
            border: 0;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(24, 56, 116, 0.08);
            overflow: hidden;
        }
        .profile-card .card-header {
            background: linear-gradient(135deg, #406aff, #7a9cff);
            color: #fff;
            padding: 24px 28px;
        }
        .profile-card .card-header h4 {
            margin: 0;
            font-weight: 700;
            letter-spacing: .3px;
        }

        .left-pane {
            border-right: 1px dashed #e8ecf5;
            background: linear-gradient(180deg, rgba(255,255,255,0.6), rgba(255,255,255,0.9));
        }
        .avatar-wrap {
            display: grid;
            place-items: center;
            padding: 32px 20px 20px;
        }
        .avatar {
            width: 180px;
            height: 180px;
            object-fit: cover;
            border-radius: 50%;
            border: 6px solid #fff;
            box-shadow: 0 6px 24px rgba(64,106,255,0.25);
            background: #fff;
        }
        .upload-row {
            padding: 0 24px 32px;
        }

        .form-pane {
            padding: 28px;
        }
        .form-section-title {
            font-size: 1rem;
            font-weight: 700;
            color: #233252;
            margin-bottom: 14px;
        }
        .form-control, .form-select {
            border-radius: 12px;
        }
        .btn-xl {
            padding: 0.9rem 1.4rem;
            border-radius: 12px;
            font-weight: 700;
        }
        .btn-outline-secondary {
            border-width: 2px;
        }

        .alert-area { margin-bottom: 16px; }

        @media (max-width: 991.98px) {
            .left-pane { border-right: 0; border-bottom: 1px dashed #e8ecf5; }
        }
    </style>
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="page-wrap container">
    <div class="card profile-card">
        <div class="card-header">
            <h4>프로필 정보</h4>
        </div>

        <div class="alert-area px-4 pt-3">
            <c:if test="${param.updateSuccess == 'true'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    프로필이 성공적으로 수정되었습니다.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <c:if test="${param.updateError == 'true'}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    프로필 수정 중 오류가 발생했습니다.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
        </div>

        <form action="${pageContext.request.contextPath}/account/profilePro" method="post" enctype="multipart/form-data">
            <input type="hidden" name="empNo" value="${account.empNo}"/>

            <div class="row g-0">
                <div class="col-lg-4 left-pane">
                    <div class="avatar-wrap">
                        <img id="profile-preview"
                             class="avatar"
                             src="${pageContext.request.contextPath}/profile-images/${account.empFilename}"
                             onerror="this.onerror=null;this.src='https://placehold.co/300x300/EFEFEF/AAAAAA?text=No+Image';"
                             alt="프로필 사진"/>
                    </div>

                    <div class="upload-row">
                        <label for="profileImageFile" class="form-label fw-bold">프로필 사진 변경</label>
                        <input class="form-control" type="file" id="profileImageFile" name="profileImageFile" accept="image/*">
                        <small id="fileNameHint" class="text-muted d-block mt-2">이미지 파일을 선택하세요 (최대 5MB)</small>
                    </div>
                </div>

                <div class="col-lg-8 form-pane">
                    <div class="form-section-title">기본 정보</div>
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label">사원번호</label>
                            <input type="text" class="form-control" value="${account.empNo}" readonly disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">사원명</label>
                            <input type="text" class="form-control" value="${account.empName}" readonly disabled>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">아이디</label>
                            <input type="text" class="form-control" value="${account.userId}" readonly disabled>
                        </div>
                    </div>

                    <div class="form-section-title mt-4">연락처</div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="email" name="email" value="${account.email}">
                        </div>
                        <div class="col-md-6">
                            <label for="empTel" class="form-label">연락처</label>
                            <input type="text" class="form-control" id="empTel" name="empTel" value="${account.empTel}">
                        </div>
                    </div>

                    <div class="d-flex gap-2 justify-content-end mt-4 pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-xl">메인으로</a>
                        <a href="${pageContext.request.contextPath}/sm/rePasswordForm?userId=${account.userId}"
   class="btn btn-outline-success btn-xl">비밀번호 재설정</a>
                        <button type="submit" class="btn btn-primary btn-xl">프로필 수정</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
     const fileInput    = document.getElementById('profileImageFile');
    const previewImg   = document.getElementById('profile-preview');
    const fileNameHint = document.getElementById('fileNameHint');

    fileInput?.addEventListener('change', (e) => {
        const [file] = e.target.files || [];
        if (!file) return;
        fileNameHint.textContent = file.name;
        previewImg.src = URL.createObjectURL(file);
    });
</script>
</body>
</html>
