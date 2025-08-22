<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:setTimeZone value="Asia/Seoul" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowText"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 공통 CSS -->
  <jsp:include page="/common.jsp" />
  <meta charset="UTF-8">
  <title>AssemERP - 사원 / 계정 정보 수정</title>

  <style>
    body{background:#f6f8fb;}
    .shadow-soft{box-shadow:0 10px 30px rgba(16,24,40,.06),0 2px 6px rgba(16,24,40,.06);}
    .card{border:0;border-radius:18px;overflow:hidden;}
    .card-header{
      background:linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);
      color:#fff;
    }
    .brand-chip{display:inline-flex;align-items:center;gap:.5rem;padding:.35rem .6rem;border-radius:999px;background:rgba(255,255,255,.16);backdrop-filter:saturate(180%) blur(6px);}
    .brand-chip .dots{display:grid;grid-template-columns:repeat(2,8px);grid-template-rows:repeat(2,8px);gap:3px}
    .brand-chip .dots span{width:8px;height:8px;background:#fff;border-radius:2px;display:block}
    .brand-chip .label{color:#fff;font-weight:800;letter-spacing:.4px;font-size:.8rem;line-height:1}

    .required-field::after{content:" *";color:#ff4d4f;font-weight:700}
    .section-title{font-weight:800;color:#1E2B4F;margin:18px 0 10px}
    .help-text{font-size:.9rem;color:#6b7280}

    .btn-admin{height:44px;border-radius:10px;border:none;transition:all .2s;}
    .btn-admin-primary{background:linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);color:#fff;box-shadow:0 4px 10px rgba(93,123,255,.3);}
    .btn-admin-primary:hover{background:linear-gradient(135deg,#4a6be0 0%,#6894f0 100%);box-shadow:0 6px 14px rgba(93,123,255,.45);}
    .btn-admin-danger{background:linear-gradient(135deg,#FF5D5D 0%,#FF7B78 100%);color:#fff;box-shadow:0 4px 10px rgba(255,93,93,.3);}
    .btn-admin-danger:hover{background:linear-gradient(135deg,#e84b4b 0%,#f76b68 100%);box-shadow:0 6px 14px rgba(255,93,93,.45);}

    .card-footer{position:sticky;bottom:0;z-index:1;background:#fff}
    .card-footer .btn{height:44px}

    /* 프로필 패널은 유지 */
	.profile-panel{background:#fff;border:1px solid #e5e7eb;border-radius:16px;padding:18px;}
	
	/* === 160×160 Ringed Avatar 규격 === */
	.avatar-wrap{position:relative;display:inline-block;}
	.avatar-160{width:160px;height:160px;}
	.avatar{
	  border-radius:50%;
	  object-fit:cover;
	  background:#EFEFEF;              /* placeholder 배경 */
	  border:6px solid #FFF;           /* 흰색 링 6px */
	  box-shadow:0 6px 22px rgba(0,0,0,.08); /* 소프트 섀도 */
	}
	
	.avatar-placeholder{
	  display:flex;align-items:center;justify-content:center;
	  color:#9ca3af;font-size:.9rem;
	}
	
	.avatar-edit{
	  position:absolute;right:-6px;bottom:-6px;
	  width:44px;height:44px;border:0;border-radius:50%;
	  display:flex;align-items:center;justify-content:center;
	  background:#0d6efd;color:#fff;
	  box-shadow:0 6px 16px rgba(13,110,253,.35);
	  cursor:pointer;
	}
	
	.btn-admin-outline{
      background:transparent;color:#5D7BFF;border:2px solid #5D7BFF;border-radius:10px;
    }
    .btn-admin-outline:hover{background:#5D7BFF;color:#fff;}
    
	.micro-head{
	  font-size: .95rem;          /* 더 작게 */
	  font-weight: 600 !important;/* fw-bold(700) 대신 약간만 강조 */
	  color: #1f2937;             /* 차분한 딥그레이 */
	  margin-bottom: .5rem;
	  line-height: 1.25;
	}

  </style>
</head>
<body>

<div id="layout">
  <div id="side"><jsp:include page="/side.jsp" /></div>

  <div id="main-area">
    <jsp:include page="/header.jsp" />

    <div id="contents" class="container-fluid px-4 py-3">
      <div class="card shadow-soft">
        <!-- 헤더 -->
        <div class="card-header py-3">
          <div class="d-flex align-items-center gap-3">
             <a href="/emp/empListForm" class="btn btn-outline-light btn-sm">
              <i class="bi bi-list-ul me-1"></i> 목록
            </a>
            <span class="brand-chip">
              <span class="dots"><span></span><span></span><span></span><span></span></span>
              <span class="label">ERP</span>
            </span>
            <div class="me-auto">
              <h4 class="mb-0 fw-bold"><i class="bi bi-pencil-square me-2"></i>사원 / 계정 정보 수정</h4>
              <small class="opacity-75">사원 기본정보와 계정 정보를 확인/수정합니다.</small>
            </div>
          </div>
        </div>

        <div class="card-body p-4">
          <form id="updateForm" action="${pageContext.request.contextPath}/empAcc/empAccountModifyPro" method="post" class="needs-validation" novalidate enctype="multipart/form-data">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <%-- <input type="hidden" id="empNo" name="empNo" value="${emp.empNo}"/> --%>

            <div class="row g-4">
				<div class="col-lg-4">
				  <!-- <div class="profile-panel"> -->
				    <div class="section-title" >사원 기본 정보</div>
				
				    <div class="text-center mb-3">
				      <div class="avatar-wrap">
				        <c:choose>
				          <c:when test="${not empty empAccount.empFilename}">

				            <img id="profilePreview"
				                 class="avatar avatar-160"
				                 src="${pageContext.request.contextPath}/profile-images/${empAccount.empFilename}"
				                 alt="프로필 이미지"
				                 onerror="this.onerror=null;this.src='https://placehold.co/160x160/EFEFEF/AAAAAA?text=No+Image';">
				          </c:when>

				          	<c:otherwise>
						  	<img id="profilePreview"
						       class="avatar avatar-160"
						       src="https://placehold.co/160x160/EFEFEF/AAAAAA?text=No+Image"
						       alt="프로필 이미지">
							</c:otherwise>
				        </c:choose>
				
				        <label class="avatar-edit" for="profileImageFile" title="사진 변경" aria-label="사진 변경">
				          <i class="bi bi-camera"></i>
				        </label>
				      </div>
				      
				      	<div class="small text-muted mt-2 text-center">JPG/PNG 5MB 이하 권장</div>
				    	<!-- 숨김 파일 입력 -->
				    	<input class="d-none" type="file" id="profileImageFile" name="profileImageFile" accept="image/*">
				    </div>
					
				    <div class="p-4">

						  <div class="d-flex justify-content-center align-items-center gap-3 flex-wrap">
						
						    <div class="form-check mb-0">
						      <input class="form-check-input me-2" type="checkbox" id="removeImage" name="removeImage" value="true"
								  <c:if test="${empty empAccount.empFilename}">disabled</c:if>>
							  <label class="form-check-label" for="removeImage">기존 이미지 삭제</label>
						    </div>

							<div class="w-100"></div>
							 
						    <label for="empNo" class="col-form-label required-field mb-0">사원번호</label>
						
						    <div class="input-group" style="width:auto; max-width:140px;">
						      <span class="input-group-text"><i class="bi bi-hash"></i></span>
						      <input type="text"
						             class="form-control flex-grow-0 flex-shrink-0 text-center"
						             id="empNo"
						             name="empNo"
						             value="${emp.empNo}"
						             inputmode="numeric"
						             pattern="\\d+"
						             placeholder="숫자만 입력"
						             style="width:90px; background-color:#EAEAEA"
						             required readonly="readonly">
						    </div>
						
						  </div>
						
						  <div class="invalid-feedback text-center mt-1">
						    사원번호를 입력해주세요. 숫자만 가능합니다.
						  </div>
						</div>
				</div>

              <div class="col-lg-8">
                <div class="section-title">기본 정보</div>
                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="empName" class="form-label required-field">사원명</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-person"></i></span>
                      <input type="text" class="form-control" id="empName" name="empName" value="${emp.empName}" required>
                      <div class="invalid-feedback">사원명을 입력해주세요.</div>
                    </div>
                  </div>
                  
                  <div class="col-md-6">
                    <label for="deptName" class="form-label required-field">부서</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-building"></i></span>
                      <input type="text" class="form-control" id="deptName" placeholder="오른쪽 검색 버튼으로 선택" value="${emp.deptName}" readonly required>
                      <input type="hidden" id="deptCode" name="deptCode" value="${emp.deptCode}">
                      <!-- <button class="btn btn-admin btn-admin-outline" type="button" data-bs-toggle="modal" data-bs-target="#deptSearchModal"> -->
                      <button class="btn btn-admin btn-admin-outline" type="button" data-bs-toggle="modal" data-bs-target="#deptSearchModal">
                        <i class="bi bi-search"></i> 검색
                      </button>
                      <div class="invalid-feedback">부서를 선택해주세요.</div>
                    </div>
                  </div>
                  
                </div><%-- End row --%>

                <div class="row">
                  <div class="col-md-6 mb-3">
                    <label for="empTel" class="form-label">전화번호</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                      <input type="tel" class="form-control" id="empTel" name="empTel" value="${emp.empTel}" 
                      placeholder="010-1234-5678"  maxlength="13" pattern="[0-9]*" inputmode="numeric">
                    </div>
                  </div>
                  <div class="col-md-6 mb-3">
                    <label for="email" class="form-label required-field">이메일</label>
                    <div class="input-group">
                      <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                      <input type="email" class="form-control" id="email" name="email" value="${emp.email}" required>
                      <div class="invalid-feedback">올바른 이메일 주소를 입력해주세요.</div>
                    </div>
                  </div>
                </div>
				<div class="row g-3">
				
				  <div class="col-md-4">
				    <!-- <label for="hireDate" class="form-label required-field">입사일</label> -->
				    <!-- <label for="hireDate" class="form-label">입사일</label> -->
				    <label for="hireDate" class="form-label" id="hireDateLabel">입사일</label>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-calendar-event"></i></span>
				      <input type="date" class="form-control" id="hireDate" name="hireDate"
				             value="${emp.hireDate}" required>
				      <div class="invalid-feedback">입사일을 선택해주세요.</div>
				    </div>
				  </div>

				  <div class="col-md-4">
				    <label for="gradeCode" class="form-label required-field">직급</label>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-award"></i></span>
				      <select class="form-select" id="gradeCode" name="gradeCode" onchange="initGradeChangeEvent()" required>
				        <option value="" disabled <c:if test="${empty gradeCode}">selected="selected"</c:if>>직급 선택</option>
				        <option value="10" <c:if test="${gradeCode == 10}">selected</c:if>>사원</option>
					    <option value="20"  <c:if test="${gradeCode == 20}">selected="selected"</c:if>>대리</option>
					    <option value="30"  <c:if test="${gradeCode == 30}">selected="selected"</c:if>>과장</option>
					    <option value="40"  <c:if test="${gradeCode == 40}">selected="selected"</c:if>>차장</option>
					    <option value="50"  <c:if test="${gradeCode == 50}">selected="selected"</c:if>>부장</option>
					    <option value="60"  <c:if test="${gradeCode == 60}">selected="selected"</c:if>>이사</option>
					    <option value="70"  <c:if test="${gradeCode == 70}">selected="selected"</c:if>>상무</option>
					    <option value="80"  <c:if test="${gradeCode == 80}">selected="selected"</c:if>>전무</option>
					    <option value="90"  <c:if test="${gradeCode == 90}">selected="selected"</c:if>>부사장</option>
					    <option value="100" <c:if test="${gradeCode == 100}">selected="selected"</c:if>>사장</option>
					    <option value="888" <c:if test="${gradeCode == 888}">selected="selected"</c:if>>파트너</option>
				      </select>
				      <div class="invalid-feedback">직급을 선택해주세요.</div>
				    </div>
				  </div>
				
				  <div class="col-md-4">
				    <label for="delStatus" class="form-label required-field">재직유무</label>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-person-check"></i></span>
				      <select class="form-select" id="delStatus" name="delStatus" required>
				        <option value="0" <c:if test="${emp.delStatus==0}">selected="selected"</c:if>>0 : 재직(사내) / 활성(파트너)</option>
				        <option value="1" <c:if test="${emp.delStatus==1}">selected="selected"</c:if>>1 : 퇴사(사내) / 정지(파트너)</option>
				      </select>
				      <div class="invalid-feedback">재직/퇴사를 선택해주세요.</div>
				    </div>
				  </div>
				
				  <div class="col-md-6">
				    <label for="salPreset" class="form-label">급여 프리셋</label>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-cash-stack"></i></span>
				      <select class="form-select" id="salPreset">
				        <option value="">프리셋 선택 (권장)</option>
				        <c:forEach var="p" items="${salPresets}">
				          <option value="${p.presetId}"
				            <c:if test="${p.presetId == presetId}">selected="selected"</c:if>>
				            <c:out value="${p.presetName}"/>
				          </option>
				        </c:forEach>
				        <option value="CUSTOM">직접 입력</option>
				      </select>
				    </div>
				    <div class="help-text mt-1">※ 직급과 프리셋은 선택시 급여 자동셋팅됩니다.</div>
				  </div>

				  <div class="col-md-6">
				    <label for="sal" class="form-label">급여 (직접 입력)</label>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-123"></i></span>
				      <input type="text" class="form-control" id="sal" name="sal"
				             value="<fmt:formatNumber value='${emp.sal}' pattern='#,###'/>"
				             placeholder="숫자만 입력" maxlength="12" readonly="readonly">
				    </div>
				    <div id="salChange" class="form-text mt-1" style="min-height:1.5rem;"></div>
				  </div>
				</div>
              </div>
              
				<div class="col-12"><hr class="my-2"></div>
					
				<div class="col-12">
				  <div class="section-title">계정 / 권한 정보</div>
				</div>
				
				<div class="col-12 col-lg-6">
				  <label for="userId" class="form-label required-field">사원 아이디</label>
				  <div class="input-group">
				    <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
				    <!-- 아이디는 변경 불가: readonly 유지 / name="userId" 유지 -->
				    <input type="text" class="form-control" id="userId" name="userId" style="background-color:#EAEAEA"
				           value="${account.userId}" readonly>
				    <div class="invalid-feedback">사원 아이디를 입력해주세요.</div>
				  </div>
				  <small class="form-text text-muted">아이디는 변경할 수 없습니다.</small>
				</div>
				
				<div class="col-12 col-lg-6">
				  <label for="password" class="form-label">비밀번호</label>
				  <div class="input-group">
				    <span class="input-group-text"><i class="bi bi-lock"></i></span>
				    <input type="password" class="form-control" id="password" name="password">
				  </div>
				  <small class="form-text text-muted">변경할 경우에만 새 비밀번호를 입력하세요.</small>
				</div>

				<div class="row g-3 align-items-start mt-1">

				  <div class="col-12 col-lg-6">
				    <h1 class="h5 fw-bold mb-2 micro-head">계정유형</h1>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-people"></i></span>
				      <select class="form-select" id="empType" name="empTypeView" required>
				        <option value="INTERNAL"
				          <c:if test="${account.empType == 'INTERNAL' || empty account.empType}">selected</c:if>>
				          INTERNAL
				        </option>
				        <option value="EXTERNAL"
				          <c:if test="${account.empType == 'EXTERNAL'}">selected</c:if>>
				          EXTERNAL
				        </option>
				      </select>
				      <div class="invalid-feedback">계정유형을 선택해주세요.</div>
				    </div>
				    <div class="help-text mt-1">INTERNAL=사내, EXTERNAL=외부/파트너</div>
				  </div>
				  <input type="hidden" id="empTypeHidden" name="empType"
				       value="<c:out value='${account.empType}'/>">

				  <div class="col-12 col-lg-6">
				    <h1 class="h5 fw-bold mb-2 micro-head">승인구분</h1>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-clipboard-check"></i></span>
				      <select class="form-select" id="approvalStatusView" name="approvalStatusView">
				        <option value="">선택</option>
				        <option value="1" <c:if test="${account.approvalStatus == 1}">selected</c:if>>대기</option>
				        <option value="2" <c:if test="${account.approvalStatus == 2}">selected</c:if>>승인</option>
				        <option value="3" <c:if test="${account.approvalStatus == 3}">selected</c:if>>반려</option>
				        <option value="8" <c:if test="${account.approvalStatus == 8}">selected</c:if>>선등록</option>
				        <option value="9" <c:if test="${account.approvalStatus == 9}">selected</c:if>>승인불필요(내부)</option>
				      </select>
				    </div>
				    <div class="help-text mt-1">EXTERNAL일 때만 사용합니다. INTERNAL이면 자동으로 미적용(NULL).</div>
				  </div>
				</div>
				<input type="hidden" id="approvalStatus" name="approvalStatus"
				       value="<c:out value='${account.approvalStatus}'/>">

				<div class="row g-3 align-items-start mt-1">

				  <div class="col-12 col-lg-6">
				    <h1 class="h5 fw-bold mb-2 micro-head">권한구분</h1>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
				      <select class="form-select" id="rolesStatus" name="rolesStatus" required>
				        <c:choose>
				          <c:when test="${not empty roleCodes}">
				            <c:forEach var="r" items="${roleCodes}">
				              <c:set var="code" value="${r.middle_status}"/>
				              <option value="${code}"
				                <c:if test="${account.rolesStatus == code || account.authRoleName == r.context}">selected</c:if>>
				                <fmt:formatNumber value="${code}" pattern="00"/> - <c:out value="${r.context}"/>
				              </option>
				            </c:forEach>
				          </c:when>
				          <c:otherwise>
				            <option value="">권한코드가 없습니다</option>
				          </c:otherwise>
				        </c:choose>
				      </select>
				      <div class="invalid-feedback">권한을 선택해주세요.</div>
				    </div>
				    <div class="help-text mt-1">※ Security 권한을 선택해 주세요.</div>
				  </div>
				
				  <div class="col-12 col-lg-6">
				    <h1 class="h5 fw-bold mb-2 micro-head">가입일자</h1>
				    <div class="input-group">
				      <span class="input-group-text"><i class="bi bi-calendar-check"></i></span>
				      <input type="text" class="form-control" id="regDate" value="<c:out value='${account.regDate}'/>" readonly="readonly">
				    </div>
				    <div class="help-text mt-1">※ 저장 시 DB DEFAULT(SYSDATE)로 기록됩니다.</div>
				  </div>
				</div>
            </div>
          </form>

          <form id="deleteForm" action="${pageContext.request.contextPath}/empAcc/empAccountDeletePro" method="post" class="d-none">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="empNo" value="${emp.empNo}">
            <input type="hidden" name="userId" value="${account.userId}">
          </form>
        </div>

        <div class="card-footer py-3">
          <div class="d-flex justify-content-end gap-2">
            <button type="button" id="deleteBtn" class="btn btn-admin btn-admin-danger">
              <i class="bi bi-trash me-2"></i> 삭제
            </button>
            <button type="button" form="updateForm" id="saveButton" class="btn btn-admin btn-admin-primary" disabled>
              <i class="bi bi-check-lg me-2"></i> 정보 수정
            </button>
          </div>
        </div>

      </div>
    </div>

    <jsp:include page="/foot.jsp" />
  </div>
</div>

<!-- 부트스트랩 CDN -->
<jsp:include page="/common_cdn.jsp" />

<script>
  (() => {
    'use strict';
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', e => {
        if (!form.checkValidity()) { e.preventDefault(); e.stopPropagation(); }
        form.classList.add('was-validated');
      }, false);
    });
  })();

  const deleteBtn = document.getElementById('deleteBtn');
  if(deleteBtn){
    deleteBtn.addEventListener('click', function(){
      if(confirm('정말로 이 사원 정보를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')){
        document.getElementById('deleteForm').submit();
      }
    });
  }

  	const fileInput  = document.getElementById('profileImageFile');
	const previewImg = document.getElementById('profilePreview');
	const removeChk  = document.getElementById('removeImage');
	
	const PLACEHOLDER_URL = 'https://placehold.co/160x160/EFEFEF/AAAAAA?text=No+Image';

	if (fileInput && previewImg) {
	  fileInput.addEventListener('change', function(e){
	    const f = e.target.files && e.target.files[0];
	    if (!f) return;
	    previewImg.src = URL.createObjectURL(f);
	    if (removeChk) {
	      removeChk.checked = false;
	      removeChk.disabled = false; // ★★★ 이 줄 추가: 새 파일 첨부 시 체크박스 활성화 ★★★
	    }
	    checkForChanges(); 
	  });
	}
	
	if (removeChk && previewImg && fileInput) {
	  removeChk.addEventListener('change', function(){
	    if (this.checked) {
	      fileInput.value = '';
	      previewImg.src = PLACEHOLDER_URL;
	    }
	    checkForChanges(); // ★★★ 변경감지 ★★★
	  });
	}

</script>

<script>
var salPreset = document.getElementById('salPreset');
var gradeSel  = document.getElementById('gradeCode');
var salInput  = document.getElementById('sal');

function formatHash3(n){
  if (n===null || n===undefined || n==='') return '';
  var s = String(n).replace(/[^\d-]/g,'');
  if (s==='' || s==='-') return '';
  var neg = s[0]==='-';
  var d = neg ? s.slice(1) : s;
  var c = d.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  return neg?('-'+c):c;
}
function unformat(s){ return (s||'').replace(/,/g,''); }

function lockSalary(value){
  salInput.value = (value==null?'':String(value)).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
  salInput.readOnly = true;                
  salInput.classList.add('bg-light');      
  salInput.setAttribute('inputmode','numeric'); 
  salInput.dispatchEvent(new Event('input', { bubbles: true })); 
}
function unlockSalary(){
  salInput.readOnly = false;               
  salInput.classList.remove('bg-light');
  salInput.placeholder = '숫자만 입력';
  salInput.dispatchEvent(new Event('input', { bubbles: true })); 

}

async function fetchSalaryByGradePreset(gradeCode, salaryCode){
  var url = '${pageContext.request.contextPath}/emp/empSalaryByGradePreset'
          + '?gradeCode=' + encodeURIComponent(gradeCode)
          + '&salaryCode=' + encodeURIComponent(salaryCode||'');
  
  const res = await fetch(url, { headers:{'Accept':'application/json'} });
  
  if(!res.ok) throw new Error('조회 실패: ' + res.status);
  
  const data = await res.json();
  
  return data;
}

async function applySalary(){
  
  var salaryCode = salPreset ? salPreset.value : '';
  var gradeCode  = gradeSel  ? gradeSel.value  : '';
  
  if (!salaryCode) {      		
    lockSalary(${sal != null ? sal : 0});	
    showSalaryChange('', '');
    return;
  }
  if (salaryCode === 'CUSTOM'){ 
	unlockSalary();			
	showSalaryChange('', '');	
    return;
  }

  try{
	  	var beforeVal = unformat(salInput.value);
    	const sal = await fetchSalaryByGradePreset(gradeCode, salaryCode);
	  	
    	lockSalary(sal);
    	showSalaryChange(beforeVal, sal);
    	prevSalaryValue = String(sal||'');
  }catch(e){
	  	console.error(e);
	    lockSalary('');
	    showSalaryChange('', '');
  }
}

salInput.addEventListener('input', function(){
  if (salInput.readOnly) return;
  var raw = unformat(salInput.value);
  salInput.value = formatHash3(raw);
});

if (salInput.form){
  salInput.form.addEventListener('submit', function(){
    salInput.value = unformat(salInput.value);
  });
}

if (salPreset) salPreset.addEventListener('change', applySalary);
if (gradeSel)  gradeSel.addEventListener('change', function(){
  if (salPreset.value && salPreset.value !== 'CUSTOM') applySalary();
});

document.addEventListener('DOMContentLoaded', function(){
  if (salPreset && salPreset.value){
    if (salPreset.value === 'CUSTOM') {
      unlockSalary();
    } else {
      applySalary(); 
    }
  } else {
	lockSalary(${sal != null ? sal : 0}); 	
  }
});
</script>

<div class="modal fade" id="deptSearchModal" tabindex="-1" aria-labelledby="deptSearchModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deptSearchModalLabel"><i class="bi bi-search me-2"></i>부서 검색</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-funnel"></i></span>
          <input type="text" id="deptKeyword" class="form-control" placeholder="부서명 입력 후 엔터 또는 검색 버튼 클릭">
          <button class="btn btn-admin btn-admin-primary" type="button" id="deptSearchBtn">검색</button>
        </div>
        
        <div class="table-responsive border rounded">
          <table class="table table-hover mb-0">
            <thead class="table-light">
              <tr>
                <th style="width:140px">부서코드</th>
                <th>부서명</th>
              </tr>
            </thead>
            <tbody id="deptResultBody">
              <tr><td colspan="2" class="text-center text-muted py-3">검색어를 입력하세요.</td></tr>
            </tbody>
          </table>
        </div>
        <div class="small text-muted mt-2">원하는 부서의 행을 클릭하면 자동으로 입력됩니다.</div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-admin btn-admin-outline" type="button" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {

    const deptModalEl 		= document.getElementById('deptSearchModal');
    const deptKeywordInput 	= document.getElementById('deptKeyword');
    const deptSearchBtn 	= document.getElementById('deptSearchBtn');
    const deptResultBody 	= document.getElementById('deptResultBody');
    const deptNameInput 	= document.getElementById('deptName');
    const deptCodeInput 	= document.getElementById('deptCode');
    
    const contextPath = "${pageContext.request.contextPath}";

    async function searchAndFillDept() {
        const deptName = document.getElementById('deptKeyword').value;
        
        const url = contextPath + "/api/search/searchEmpAccountModal?deptName=" + encodeURIComponent(deptName);

        try {
            const response = await fetch(url);
            if (!response.ok) {
                throw new Error('데이터 조회 실패');
            }
            const htmlResult = await response.text(); 

            document.getElementById('deptResultBody').innerHTML = htmlResult;

        } catch (error) {
            console.error('부서 검색 중 오류 발생:', error);
            document.getElementById('deptResultBody').innerHTML =
                '<tr><td colspan="2" class="text-center text-danger">조회 중 오류가 발생했습니다.</td></tr>';
        }
    }

    deptSearchBtn.addEventListener('click', searchAndFillDept);

    deptKeywordInput.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            searchAndFillDept();
        }
    });

    deptModalEl.addEventListener('show.bs.modal', function () {
        deptKeywordInput.value = '';
        deptResultBody.innerHTML = '<tr><td colspan="2" class="text-center text-muted py-3">검색어를 입력하세요.</td></tr>';
    });

    deptResultBody.addEventListener('click', function(e) {
        const selectedRow = e.target.closest('tr');
        if (!selectedRow || !selectedRow.dataset.code) return;

        deptCodeInput.value = selectedRow.dataset.code;
        deptNameInput.value = selectedRow.dataset.name;
        
        deptNameInput.dispatchEvent(new Event('input', { bubbles: true }));	
        bootstrap.Modal.getInstance(deptModalEl).hide();
    });

});
</script>

<script>
function initGradeChangeEvent() {
	
	const gradeSelect  = document.getElementById('gradeCode').value;	
	const salarySelect  = document.getElementById('salPreset').value;	

    if (!gradeSelect && !salarySelect) return;

     let url = '${pageContext.request.contextPath}/emp/empSalaryByGradePreset'
               + '?gradeCode=' + gradeSelect
               + '&salaryCode=' + salarySelect;

     fetch(url)
         .then(res => res.json())  
         .then(data => {
             console.log("급여:", data);
             document.getElementById('sal').value = data;
         })
         .catch(err => console.error("에러:", err));
}
</script>

<script>
(function(){
  const empTypeSel   = document.getElementById('empType');
  const appViewSel   = document.getElementById('approvalStatusView');
  const appHiddenInp = document.getElementById('approvalStatus');
  const empNoInput   = document.getElementById('empNo');

  const empTypeHidden = document.getElementById('empTypeHidden');
  const hireDateLabel = document.getElementById('hireDateLabel'); 

  function syncAllStates() {
    const empNoStr = (empNoInput && empNoInput.value) ? empNoInput.value : '';
    
    if (empNoStr.startsWith('1')) {
        empTypeSel.value = 'INTERNAL';
        empTypeSel.disabled = true;
    } else if (empNoStr.startsWith('9')) {
        empTypeSel.value = 'EXTERNAL';
        empTypeSel.disabled = true;
    } else {
        empTypeSel.disabled = false;
    }

    if (empTypeHidden) {
        empTypeHidden.value = empTypeSel.value;
    }

    const t = (empTypeSel.value || '').toUpperCase();
    
    if (hireDateLabel) {
        if (t === 'INTERNAL') {
            hireDateLabel.textContent = '입사일';
        } else if (t === 'EXTERNAL') {
            hireDateLabel.textContent = '가입일';
        }
    }
    
    for (const option of appViewSel.options) {
        if (t === 'EXTERNAL' && option.value === '9') {
            option.style.display = 'none';
        } else {
            option.style.display = '';
        }
    }

    if (t === 'INTERNAL') {
      appViewSel.value = '9';
      appViewSel.disabled = true;
      appHiddenInp.value = '9';
    } else if (t === 'EXTERNAL') {
      appViewSel.disabled = false;
      if (appViewSel.value === '9') {
          appViewSel.value = '1'; 
      }
      appHiddenInp.value = appViewSel.value || ''; 
    } else {
      appViewSel.disabled = true;
      appViewSel.value = '';
      appHiddenInp.value = '';
    }
  }

  function onApprovalViewChange(){
    if (!appViewSel.disabled) {
      appHiddenInp.value = appViewSel.value || '';
    }
  }

  document.addEventListener('DOMContentLoaded', function(){
    syncAllStates();
  });

  empTypeSel.addEventListener('change', syncAllStates);
  appViewSel.addEventListener('change', onApprovalViewChange);

})();
</script>

<script>
const empTelInput = document.getElementById('empTel');

const onInputHandler = (e) => {
  let value = e.target.value.replace(/\D/g, '');
  if (value.length > 11) {
    value = value.slice(0, 11);
  }
  e.target.value = value;
};

const onFocusHandler = (e) => {
  e.target.value = e.target.value.replace(/-/g, '');
};

const onBlurHandler = (e) => {
  let value = e.target.value;
  if (value) {
    const formatted = value.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
    e.target.value = formatted;
  }
};

if(empTelInput) {
    empTelInput.addEventListener('input', onInputHandler);
    empTelInput.addEventListener('focus', onFocusHandler);
    empTelInput.addEventListener('blur', onBlurHandler);
}

document.addEventListener('DOMContentLoaded', () => {
    if(empTelInput && empTelInput.value) {
        onBlurHandler({ target: empTelInput });
    }
});

</script>

<script>
const saveButtonForClick = document.getElementById('saveButton');
const formForClick = document.getElementById('updateForm');

if (saveButtonForClick && formForClick) {
    saveButtonForClick.addEventListener('click', function() {

        const salInput = document.getElementById('sal');
        if (salInput) {
            salInput.value = salInput.value.replace(/,/g, '');
        }

        formForClick.submit();
    });
}
</script>

<script>
document.addEventListener('DOMContentLoaded', function() {

    const form = document.getElementById('updateForm');
    const saveButton = document.getElementById('saveButton');
    if (!form || !saveButton) return;

    const fieldsToWatch = form.querySelectorAll('input:not([readonly]), select, textarea');

    const initialFormState = {};

    fieldsToWatch.forEach(field => {
        const key = field.name || field.id;
        if (field.type === 'checkbox') {
            initialFormState[key] = field.checked;
        } else if (field.type === 'file') {
            initialFormState[key] = ''; 
        } else {
            let initialValue = field.value;
            if (field.id === 'empTel') {
                initialValue = initialValue.replace(/-/g, '');
            } else if (field.id === 'sal') {
                initialValue = initialValue.replace(/,/g, '');
            }
            initialFormState[key] = initialValue;
        }
    });

    window.checkForChanges = function() {
        let hasChanged = false;

        for (const field of fieldsToWatch) {
            const key = field.name || field.id;
            let currentValue;

            if (field.type === 'checkbox') {
                currentValue = field.checked;
            } else if (field.type === 'file') {
                if (field.files.length > 0) {
                    hasChanged = true;
                    break; 
                }
                currentValue = '';
            } else {
                currentValue = field.value;
                if (field.id === 'empTel') {
                    currentValue = currentValue.replace(/-/g, '');
                } else if (field.id === 'sal') {
                    currentValue = currentValue.replace(/,/g, '');
                }
            }

            if (initialFormState[key] !== currentValue) {
                hasChanged = true;
                break; 
            }
        }

        saveButton.disabled = !hasChanged;
    };

    form.addEventListener('input', checkForChanges);

});
</script>

</body>
</html>
