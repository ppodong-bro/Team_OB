	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:setTimeZone value="Asia/Seoul" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="regDate"/>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	  <jsp:include page="/common.jsp" />
	  <meta charset="UTF-8">
	  <title>AssemERP - 사원등록 및 계정관리</title>
	
	  <style>
	    body{background:#f6f8fb;}
	    .shadow-soft{box-shadow:0 10px 30px rgba(16,24,40,.06),0 2px 6px rgba(16,24,40,.06);}
	    .card{border:0;border-radius:18px;overflow:hidden;}
	    .card-header{background:linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);color:#fff;}
	    .card-footer{position:sticky;bottom:0;z-index:1;background:#fff}
	    .card-footer .btn{height:44px}
	    .section-title{font-weight:800;color:#1E2B4F;margin:18px 0 10px}
	    .required-field::after{content:" *";color:#ff4d4f;font-weight:700}
	    .help-text{font-size:.9rem;color:#6b7280}
	
	    .brand-chip{display:inline-flex;align-items:center;gap:.5rem;padding:.35rem .6rem;border-radius:999px;background:rgba(255,255,255,.16);backdrop-filter:saturate(180%) blur(6px);}
	    .brand-chip .dots{display:grid;grid-template-columns:repeat(2,8px);grid-template-rows:repeat(2,8px);gap:3px}
	    .brand-chip .dots span{width:8px;height:8px;background:#fff;border-radius:2px;display:block}
	    .brand-chip .label{color:#fff;font-weight:800;letter-spacing:.4px;font-size:.8rem;line-height:1}
	
	    .avatar-wrap{position:relative;display:inline-block}
	    .avatar{width:160px;height:160px;border-radius:100%;object-fit:cover;border:6px solid #fff;box-shadow:0 6px 22px rgba(0,0,0,.08)}
	    .avatar-edit{position:absolute;right:-6px;bottom:-6px;border:0;border-radius:999px;width:44px;height:44px;display:flex;align-items:center;justify-content:center;background:#0d6efd;color:#fff;box-shadow:0 6px 16px rgba(13,110,253,.35)}
	
	    .table-hover tbody tr{cursor:pointer}
	
	    /* Admin 버튼 스킨 */
	    .btn-admin{height:44px;border-radius:10px;border:none;transition:all .2s;}
	    .btn-admin-primary{
	      background:linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);
	      color:#fff; box-shadow:0 4px 10px rgba(93,123,255,.3);
	    }
	    .btn-admin-primary:hover{
	      background:linear-gradient(135deg,#4a6be0 0%,#6894f0 100%);
	      box-shadow:0 6px 14px rgba(93,123,255,.45);
	    }
	    .btn-admin-outline{
	      background:transparent;color:#5D7BFF;border:2px solid #5D7BFF;border-radius:10px;
	    }
	    .btn-admin-outline:hover{background:#5D7BFF;color:#fff;}
	    
		.micro-head{
		  font-size: .95rem;         
		  font-weight: 600 !important;
		  color: #1f2937;             
		  margin-bottom: .5rem;
		  line-height: 1.25;
		}
	  </style>
	</head>
	<body>
	
	<div id="layout">
	  <div id="side"><jsp:include page="/side.jsp"/></div>
	
	  <div id="main-area">
	    <jsp:include page="/header.jsp"/>
	
	    <div id="contents" class="container-fluid px-4 py-3">
	      <div class="card shadow-soft">
	        <!-- 헤더 -->
	        <div class="card-header py-3">
	          <div class="d-flex align-items-center gap-3">
	            <a href="${pageContext.request.contextPath}/emp/empListForm" class="btn btn-outline-light btn-sm">
	              <i class="bi bi-list-ul me-1"></i> 목록
	            </a>
	            <span class="brand-chip">
	              <span class="dots"><span></span><span></span><span></span><span></span></span>
	              <span class="label">ERP</span>
	            </span>
	            <div class="me-auto">
	              <h4 class="mb-0 fw-bold">사원등록 및 계정관리</h4>
	              <small class="opacity-75">사원 기본정보, 급여 프리셋, 계정 권한을 한 번에 등록합니다.</small>
	            </div>
	          </div>
	        </div>
	
	        <div class="card-body p-4">
	          <form id="empForm" action="${pageContext.request.contextPath}/empAcc/empAccountSavePro"
	                method="post" class="needs-validation" novalidate enctype="multipart/form-data">
	            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
	            <div class="row g-4">
	              <div class="col-12">
	                <div class="section-title">사원 기본 정보</div>
	              </div>
	
	              <div class="col-12 col-lg-4">
	                <div class="text-center">
	                  <div class="avatar-wrap mb-3">
	                  
	                    <c:choose>
						  <c:when test="${not empty emp.empFilename}">
						    <img id="avatarPreview"
						         class="avatar"
						         src="${pageContext.request.contextPath}/profile-images/${emp.empFilename}"
						         alt="프로필 이미지">
						  </c:when>
						  <c:otherwise>
						    <img id="avatarPreview"
						         class="avatar"
						         src="https://placehold.co/160x160/EFEFEF/AAAAAA?text=No+Image"
						         alt="프로필 이미지">
						  </c:otherwise>
						</c:choose>
						
	                    <label class="avatar-edit" for="profileImageFile" title="사진 변경">
	                      <i class="bi bi-camera"></i>
	                    </label>
	                  </div>
	                  <div class="small text-muted">JPG/PNG 5MB 이하 권장</div>
	                  <input class="d-none" type="file" id="profileImageFile" name="profileImageFile" accept="image/*">
	                </div>
	              </div>
	
	              <div class="col-12 col-lg-8">
	                <div class="row g-3">
	                  <div class="col-md-6">
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
	                      <button class="btn btn-admin btn-admin-outline" type="button" data-bs-toggle="modal" data-bs-target="#deptSearchModal" id="openDeptModalBtn">
	                        <i class="bi bi-search"></i> 검색
	                      </button>
	                      <div class="invalid-feedback">부서를 선택해주세요.</div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-6">
	                    <label for="empTel" class="form-label">전화번호</label>
	                    <div class="input-group">
	                      <span class="input-group-text"><i class="bi bi-telephone"></i></span>
	                     <%--  <input type="tel" class="form-control" id="empTel" name="empTel" 
	                      placeholder="010-1234-5678" value="${emp.empTel}" maxlength="13" pattern="[0-9]*" inputmode="numeric"> --%>
	                      <input type="tel" class="form-control" id="empTel" name="empTel" 
						       placeholder="010-1234-5678" value="${emp.empTel}"
						       maxlength="13"
						       pattern="^(\d{10,11}|\d{2,3}-\d{3,4}-\d{4})$"
						       inputmode="numeric"
						       title="숫자 10~11자리 또는 000-0000-0000 형식으로 입력하세요.">
	                    </div>
	                  </div>
	
	                  <div class="col-md-6">
	                    <label for="email" class="form-label required-field">이메일</label>
	                    <div class="input-group">
	                      <span class="input-group-text"><i class="bi bi-envelope"></i></span>
	                      <input type="email" class="form-control" id="email" name="email" placeholder="abc@k.com" value="${emp.email}" required>
	                      <div class="invalid-feedback">올바른 이메일 주소를 입력해주세요.</div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-4">
	                    <!-- <label for="hireDate" class="form-label required-field">입사일</label> -->
	                    <!-- <label for="hireDate" class="form-label">입사일</label> -->
	                    <label for="hireDate" class="form-label required-field" id="hireDateLabel">입사일</label>
	                    <div class="input-group">
	                      <span class="input-group-text"><i class="bi bi-calendar-event"></i></span>
	                      <input type="date" class="form-control" id="hireDate" name="hireDate"
						       value="<fmt:formatDate value='${emp.hireDate}' pattern='yyyy-MM-dd'/>" required>
	                      <div class="invalid-feedback">입사일을 선택해주세요.</div>
	                    </div>
	                  </div>
	
	                  <div class="col-md-4">
	                    <label for="gradeCode" class="form-label required-field">직급</label>
	                    <div class="input-group">
	                      <span class="input-group-text"><i class="bi bi-award"></i></span>
	                      	<select class="form-select" id="gradeCode" name="gradeCode" required>
							    <option value="" disabled
							        <c:if test="${empty gradeCode}">selected="selected"</c:if>
							    >직급 선택</option>
							
								<%-- '사원'은 emp.gradeCode가 1일 때만 선택되도록 수정 --%>
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
						       value="<fmt:formatNumber value='${sal}' pattern='#,###'/>"
						       placeholder="숫자만 입력" readonly="readonly">
	                    </div>
	                    <div id="salChange" class="form-text mt-1" style="min-height:1.5rem;" maxlength="12" style="text-align: right;"></div>
	                  </div>
	                </div>
	              </div>
	
	              <div class="col-12"><hr class="my-2"></div>
	              <div class="col-12">
	                <div class="section-title">계정 / 권한 정보</div>
	              </div>
	
	              <div class="col-12 col-lg-6">
	                <label for="userId" class="form-label">사원 아이디</label>
	                <div class="input-group">
	                  <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
	                  <input type="text" class="form-control" id="userId" name="userId" value="${account.userId}" 
	                  style="background-color:#EAEAEA" readonly placeholder="저장 시 자동 생성됩니다">
	                  <div class="invalid-feedback">사원 아이디를 입력해주세요.</div>
	                </div>
	              </div>
	
	              <div class="col-12 col-lg-6">
	                <label for="password" class="form-label required-field">비밀번호</label>
	                <div class="input-group">
	                  <span class="input-group-text"><i class="bi bi-lock"></i></span>
	                  <input type="password" class="form-control" id="password" name="password" required>
	                  <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
	                </div>
	              </div>
	              
					<div class="row g-3 align-items-start mt-1">
					  <div class="col-12 col-lg-6">
					    <h1 class="h5 fw-bold mb-2 micro-head">계정유형</h1>
					    <div class="input-group">
					      <span class="input-group-text"><i class="bi bi-people"></i></span>
					      <select class="form-select" id="empType" name="empType"
					              required>
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
					        <option value="9" <c:if test="${account.approvalStatus == 9}">selected</c:if>>승인불필요(내근)</option>
					      </select>
					    </div>
					    <div class="help-text mt-1">EXTERNAL일 때만 사용합니다. INTERNAL이면 자동으로 미적용(NULL).</div>
					  </div>
					</div>
					 <input type="hidden" id="approvalStatus" name="approvalStatus" value="9">
					
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
							          <!-- 표시는 '코드 - 코드명' -->
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
					      <input type="text" class="form-control" id="regDate"
					             value="<c:out value='${regDate}'/>" disabled>
					    </div>
					    <div class="help-text mt-1">※ 저장 시 DB DEFAULT(SYSDATE)로 기록됩니다.</div>
					  </div>
					</div>
	            </div> <!-- /row -->
	          </form>
	        </div>

	        <div class="card-footer py-3">
	          <div class="d-flex justify-content-end gap-2">
	            <button form="empForm" type="reset" class="btn btn-admin btn-admin-outline">
	              <i class="bi bi-arrow-counterclockwise me-2"></i> 초기화
	            </button>
	            <button type="button" id="saveButton" form="empForm" class="btn btn-admin btn-admin-primary" disabled>
	              <i class="bi bi-check-lg me-2"></i> 정보 저장
	            </button>
	          </div>
	        </div>
	
	      </div>
	    </div>
	
	    <jsp:include page="/foot.jsp"/>
	  </div>
	</div>
	
	<jsp:include page="/common_cdn.jsp" />
	
	<!-- 부트스트랩 유효성 검사 -->
	<script>
	(function(){
	  'use strict';
	  var forms = document.querySelectorAll('.needs-validation');
	  Array.prototype.forEach.call(forms, function(form){
	    form.addEventListener('submit', function(e){
	      if(!form.checkValidity()){ e.preventDefault(); e.stopPropagation(); }
	      form.classList.add('was-validated');
	    }, false);
	  });
	})();
	</script>
	
	<script>
	(function(){
		  const fileInput = document.getElementById('profileImageFile');
		  const previewImg = document.getElementById('avatarPreview');
		  const PLACEHOLDER_URL = 'https://placehold.co/160x160/EFEFEF/AAAAAA?text=No+Image';
	
		  if (fileInput && previewImg) {
		    fileInput.addEventListener('change', function (e) {
		      const file = e.target.files && e.target.files[0];
		      if (file) {
		        previewImg.src = URL.createObjectURL(file);
		      } else {
		        // 파일 선택을 취소한 경우, 기본 이미지로 복원
		        previewImg.src = PLACEHOLDER_URL;
		      }
		    });
		  }
		})();
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
	  /* salInput.value = formatHash3(value); */
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
	  
	  return data; // number
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
		lockSalary(${sal != null ? sal : 0}); 	// 기본 잠금
	  }
	});
	</script>
	
	<script>
	(function(){
	  const hireInput = document.getElementById('hireDate');
	  if (!hireInput) return;
	  hireInput.addEventListener('change', function(){
	    // 예: 다른 hidden 필드에 yyyyMMdd로 넣고 싶다면
	    // const yyyymmdd = this.value.replaceAll('-', '');
	    // document.getElementById('hireDateHidden')?.value = yyyymmdd;
	  });
	})();
	</script>
	
	<!-- 부서 검색 모달 -->
	<!-- <div class="col-md-6">
	    <label for="deptName" class="form-label required-field">부서</label>
	    <div class="input-group">
	        <span class="input-group-text"><i class="bi bi-building"></i></span>
	        
	        <input type="text" class="form-control" id="deptName" placeholder="오른쪽 검색 버튼으로 선택" readonly required>
	        
	        <input type="hidden" id="deptCode" name="deptCode">
	        
	        <button class="btn btn-admin btn-admin-outline" type="button" data-bs-toggle="modal" data-bs-target="#deptSearchModal">
	            <i class="bi bi-search"></i> 검색
	        </button>
	        <div class="invalid-feedback">부서를 선택해주세요.</div>
	    </div>
	</div> -->
	
	
	<!-- 부서 검색 모달 -->
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
document.addEventListener('DOMContentLoaded', function() {

    const form = document.getElementById('empForm');
    const saveButton = document.getElementById('saveButton');
    
    const telInput = document.getElementById('empTel');
    const salInput = document.getElementById('sal');
    const empTypeSelect = document.getElementById('empType');
    const approvalViewSelect = document.getElementById('approvalStatusView');
    const approvalHiddenInput = document.getElementById('approvalStatus');
    const roleSelect = document.getElementById('rolesStatus');
    const gradeSelect = document.getElementById('gradeCode');
    const hireDateInput = document.getElementById('hireDate');
    const hireDateLabel = document.getElementById('hireDateLabel');
    const userIdInput = document.getElementById('userId');
    const deptNameInput = document.getElementById('deptName');
    const deptCodeInput = document.getElementById('deptCode');

    const salPresetSelect = document.getElementById('salPreset');

    const fileInput = document.getElementById('profileImageFile');
    const previewImg = document.getElementById('avatarPreview');
    const PLACEHOLDER_URL = 'https://placehold.co/160x160/EFEFEF/AAAAAA?text=No+Image';

    const deptModalEl = document.getElementById('deptSearchModal');
    const deptKeywordInput = document.getElementById('deptKeyword');
    const deptSearchBtn = document.getElementById('deptSearchBtn');
    const deptResultBody = document.getElementById('deptResultBody');
    let elementThatOpenedModal; 

    const contextPath = "${pageContext.request.contextPath}";
    const regDateStr = '<c:out value="${regDate}"/>'; 

    if (!form || !saveButton) {
        console.error('필수 폼(empForm) 또는 저장 버튼(saveButton) 요소를 찾을 수 없습니다.');
        return;
    }

    function formatWithComma(n) {
        if (n === null || n === undefined || n === '') return '';
        return String(n).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }
    function unformatComma(s) {
        return (s || '').replace(/,/g, '');
    }
    function lockSalary(value) {
        if (!salInput) return;
        salInput.value = formatWithComma(value);
        salInput.readOnly = true;
        salInput.classList.add('bg-light');
        salInput.dispatchEvent(new Event('input', { bubbles: true }));
    }
    function unlockSalary() {
        if (!salInput) return;
        salInput.readOnly = false;
        salInput.classList.remove('bg-light');
        salInput.placeholder = '숫자만 입력';
        salInput.dispatchEvent(new Event('input', { bubbles: true }));
    }
    
    function onEmpTypeChange(val) {
        const selectedType = String(val).toUpperCase();

        if (gradeSelect) {
            for (const option of gradeSelect.options) {
                if (selectedType === 'INTERNAL') { option.style.display = (option.value === '888') ? 'none' : ''; } 
                else if (selectedType === 'EXTERNAL') { option.style.display = (option.value === '888') ? '' : 'none'; }
            }
        }
        if (approvalViewSelect) {
            for (const option of approvalViewSelect.options) {
                if (selectedType === 'INTERNAL') { option.style.display = (option.value === '9') ? '' : 'none'; } 
                else if (selectedType === 'EXTERNAL') { option.style.display = (option.value === '8') ? '' : 'none'; }
            }
        }
        
        if (selectedType === 'INTERNAL') {
            if (hireDateLabel) hireDateLabel.textContent = '입사일';
            if (userIdInput) {
            	userIdInput.readOnly = true;
                userIdInput.required = false;
                userIdInput.value     = '';                     
                userIdInput.placeholder = '저장 시 자동 생성됩니다';
                userIdInput.classList.add('bg-light');
            }
            if (approvalViewSelect) approvalViewSelect.value = '9';
            if (gradeSelect && gradeSelect.value === '888') {
                gradeSelect.value = '';
            }
            
            applySalary();            
        } else if (selectedType === 'EXTERNAL') {
            if (hireDateLabel) hireDateLabel.textContent = '가입일';
            if (userIdInput) {
               userIdInput.readOnly = true;
               userIdInput.required = false;
               userIdInput.value     = '';                     
               userIdInput.placeholder = '저장 시 자동 생성됩니다';
               userIdInput.classList.add('bg-light');
            }
            if (approvalViewSelect) approvalViewSelect.value = '8';
            if (roleSelect && roleSelect.value !== '10') {
                roleSelect.value = '10';
                onRoleChange('10');
            }
            if (gradeSelect && gradeSelect.value !== '888') {
                gradeSelect.value = '888';
            }
            lockSalary(0);		
        }
        
        if (approvalHiddenInput && approvalViewSelect) approvalHiddenInput.value = approvalViewSelect.value;
        approvalViewSelect?.dispatchEvent(new Event('input', { bubbles: true }));
        gradeSelect?.dispatchEvent(new Event('input', { bubbles: true }));
        userIdInput?.dispatchEvent(new Event('input', { bubbles: true }));
    }

    function onRoleChange(val) {
        if (!hireDateInput) return;
        if (String(val) === '10') {
            hireDateInput.value = regDateStr;
            hireDateInput.readOnly = true;
            hireDateInput.classList.add('bg-light');
        } else {
            hireDateInput.readOnly = false;
            hireDateInput.classList.remove('bg-light');
        }
        roleSelect?.dispatchEvent(new Event('input', { bubbles: true }));
        hireDateInput.dispatchEvent(new Event('input', { bubbles: true }));
    }
    
    if (telInput) {
        telInput.addEventListener('input', (e) => {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 11) value = value.slice(0, 11);
            e.target.value = value;
        });
        telInput.addEventListener('focus', (e) => { e.target.value = e.target.value.replace(/-/g, ''); });
        telInput.addEventListener('blur', (e) => {
            if (e.target.value) { e.target.value = e.target.value.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3"); }
        });
    }
    if (fileInput && previewImg) {
        fileInput.addEventListener('change', function (e) {
            const file = e.target.files && e.target.files[0];
            previewImg.src = file ? URL.createObjectURL(file) : PLACEHOLDER_URL;
        });
    }
    async function applySalary() {
        const salaryCode = salPresetSelect ? salPresetSelect.value : '';
        const gradeCode = gradeSelect ? gradeSelect.value : '';
        if (salaryCode === 'CUSTOM') { unlockSalary(); return; }
        if (!gradeCode && !salaryCode) { lockSalary(''); return; }
        try {
            const url = contextPath + '/emp/empSalaryByGradePreset?gradeCode=' + encodeURIComponent(gradeCode) + '&salaryCode=' + encodeURIComponent(salaryCode);
            const res = await fetch(url, { headers: { 'Accept': 'application/json' } });
            if (!res.ok) throw new Error('Salary fetch failed');
            const sal = await res.json();
            lockSalary(sal);
        } catch (e) { console.error(e); lockSalary(''); }
    }
    
    salPresetSelect?.addEventListener('change', applySalary);
    gradeSelect?.addEventListener('change', applySalary);
    
    if (salInput) {
        salInput.addEventListener('input', function() {
            if (salInput.readOnly) return;
            salInput.value = formatWithComma(unformatComma(salInput.value));
        });
    }
    async function searchAndFillDept() {
        const deptName = deptKeywordInput.value;
        const url = contextPath + '/api/search/searchEmpAccountModal?deptName=' + encodeURIComponent(deptName);
        try {
            const response = await fetch(url);
            if (!response.ok) throw new Error('Dept search failed');
            deptResultBody.innerHTML = await response.text();
        } catch (error) { deptResultBody.innerHTML = `<tr><td colspan="2" class="text-center text-danger">조회 중 오류 발생</td></tr>`; }
    }
    if(deptModalEl) {
        deptModalEl.addEventListener('show.bs.modal', function (event) {
            elementThatOpenedModal = event.relatedTarget || document.activeElement;
        });
        deptModalEl.addEventListener('hidden.bs.modal', function () {
            if (elementThatOpenedModal) { elementThatOpenedModal.focus(); }
        });
        deptSearchBtn?.addEventListener('click', searchAndFillDept);
        deptKeywordInput?.addEventListener('keydown', e => { if (e.key === 'Enter') { e.preventDefault(); searchAndFillDept(); } });
        deptModalEl.addEventListener('show.bs.modal', () => {
            deptKeywordInput.value = '';
            deptResultBody.innerHTML = `<tr><td colspan="2" class="text-center text-muted py-3">검색어를 입력하세요.</td></tr>`;
        });
        deptResultBody.addEventListener('click', e => {
            const row = e.target.closest('tr');
            if (!row || !row.dataset.code) return;
            deptCodeInput.value = row.dataset.code;
            deptNameInput.value = row.dataset.name;
            deptNameInput.dispatchEvent(new Event('input', { bubbles: true }));
            
            const active = document.activeElement;
            if (active && deptModalEl.contains(active)) active.blur();

            bootstrap.Modal.getInstance(deptModalEl).hide();
        });
    }
    empTypeSelect?.addEventListener('change', (e) => onEmpTypeChange(e.target.value));
    roleSelect?.addEventListener('change', (e) => onRoleChange(e.target.value));
    approvalViewSelect?.addEventListener('change', function(){ if(approvalHiddenInput) approvalHiddenInput.value = this.value; });
    
    function isFilled(el) {
      return !!(el && el.value != null && String(el.value).trim() !== '');
    }
    
    function checkFormValidity() 
    {
   	  const ok =
   	    isFilled(document.getElementById('empName'))   &&  // 사원명
   	    isFilled(document.getElementById('deptName'))   &&  // 부서명
   	    (document.getElementById('email')?.checkValidity() ?? false) && // 이메일 형식 포함
   	    isFilled(document.getElementById('hireDate'))   &&  // 입사일
   	    isFilled(document.getElementById('gradeCode'))  &&  // 직급
   	    isFilled(document.getElementById('delStatus'))  &&  // 재직유무
   	    isFilled(document.getElementById('password'))   &&  // 비밀번호
   	    isFilled(document.getElementById('empType'))    &&  // 계정유형
   	    isFilled(document.getElementById('rolesStatus'));   // 권한구분

   	  saveButton.disabled = !ok;
    }

    ['empName','deptName','email','hireDate','gradeCode','delStatus','password','empType','rolesStatus']
      .forEach(id => document.getElementById(id)?.addEventListener('input', checkFormValidity));

    ['gradeCode','delStatus','empType','rolesStatus']
      .forEach(id => document.getElementById(id)?.addEventListener('change', checkFormValidity));

    checkFormValidity();
    
    saveButton.addEventListener('click', function() {
    	if (!form.checkValidity() || saveButton.disabled) {
    	    form.classList.add('was-validated');
    	    form.querySelector(':invalid')?.focus();
    	    return;
    	}
    	if (salInput) { salInput.value = unformatComma(salInput.value); }
    	form.submit();
    });

    if (empTypeSelect) onEmpTypeChange(empTypeSelect.value);
    if (roleSelect) onRoleChange(roleSelect.value);
    if (salInput && salInput.value !== '0') { applySalary(); } 
    else if (empTypeSelect?.value !== 'EXTERNAL') { lockSalary(''); }
    checkFormValidity();
    
    form.addEventListener('submit', event => {
      if (!form.checkValidity()) { event.preventDefault(); event.stopPropagation(); }
      form.classList.add('was-validated');
    }, false);
});
</script>
	
</body>
</html>
