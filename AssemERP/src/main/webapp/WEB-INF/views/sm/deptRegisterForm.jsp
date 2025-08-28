<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/common.jsp" />

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <meta charset="UTF-8">
    <title>AssemERP - 신규 부서 등록</title>

    <style>

        body{background:#f6f8fb;}
        .shadow-soft{box-shadow:0 10px 30px rgba(16,24,40,.06),0 2px 6px rgba(16,24,40,.06);}
        .card{border:0;border-radius:18px;overflow:hidden;}
        .card-header{
            background:linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);
            color:#fff;
        }
        .card-header .brand-chip{
            display:inline-flex;align-items:center;gap:.5rem;
            padding:.35rem .6rem;border-radius:999px;background:rgba(255,255,255,.16);
            backdrop-filter:saturate(180%) blur(6px);
        }
        .brand-chip .dots{display:grid;grid-template-columns:repeat(2,8px);grid-template-rows:repeat(2,8px);gap:3px}
        .brand-chip .dots span{width:8px;height:8px;background:#fff;border-radius:2px;display:block}
        .brand-chip .label{color:#fff;font-weight:800;letter-spacing:.4px;font-size:.8rem;line-height:1}

        .required-field::after{content:" *";color:#ff4d4f;font-weight:700}
        .section-title{font-weight:800;color:#1E2B4F;margin:18px 0 10px}
        .help-text{font-size:.9rem;color:#6b7280}

        .addr-row .input-group > .btn{min-width:120px}

        .card-footer{position:sticky;bottom:0;z-index:1;background:#fff}
        .card-footer .btn{height:44px}

        .modal-body .table-hover tbody tr:hover{cursor:pointer;background:#f3f6ff}
    </style>
</head>
<body>

<div id="layout">
    <div id="side"><jsp:include page="/side.jsp"/></div>

    <div id="main-area">
        <jsp:include page="/header.jsp"/>

        <div id="contents" class="container-fluid px-4 py-3">
            <div class="card shadow-soft">

                <div class="card-header py-3">
                    <div class="d-flex align-items-center gap-3">
                    	<a href="${pageContext.request.contextPath}/dept/deptListForm" class="btn btn-outline-light btn-sm">
                            <i class="bi bi-list-ul me-1"></i> 목록
                        </a>
                        <span class="brand-chip">
                          <span class="dots"><span></span><span></span><span></span><span></span></span>
                          <span class="label">ERP</span>
                        </span>
                        <div class="me-auto">
                            <h4 class="mb-0 fw-bold">신규 부서 등록</h4>
                            <small class="opacity-75">부서 기본정보와 위치를 입력하세요.</small>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">
                    <form id="deptForm" action="${pageContext.request.contextPath}/dept/deptSavePro" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <div class="row g-4">
                            <div class="col-12 col-lg-7">
                                <div class="section-title">기본 정보</div>

                                <div class="mb-3">
                                    <label for="deptName" class="form-label required-field">부서명</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-building"></i></span>
                                        <input type="text" class="form-control" id="deptName" name="deptName" required>
                                        <div class="invalid-feedback">부서명을 입력해주세요.</div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="deptCaptainName" class="form-label required-field">부서장</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="deptCaptainName" placeholder="오른쪽 검색 버튼을 클릭하세요" readonly>
                                        <input type="hidden" id="deptCaptain" name="deptCaptain">
                                        <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#empSearchModal">
                                            <i class="bi bi-search"></i> 검색
                                        </button>
                                    </div>
                                    <div class="invalid-feedback d-block" id="deptCaptainError" style="display:none;">부서장을 선택해주세요.</div>
                                    <div class="help-text mt-1">사원 검색 팝업에서 선택 시 자동으로 입력됩니다.</div>
                                </div>

                                <div class="mb-3">
                                    <label for="parentDeptName" class="form-label required-field">상위 부서</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="parentDeptName" placeholder="오른쪽 검색 버튼을 클릭하세요" readonly>
                                        <input type="hidden" id="parentDeptCode" name="parentDeptCode">
                                        <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#deptSearchModal">
                                            <i class="bi bi-search"></i> 검색
                                        </button>
                                    </div>
                                    <div class="invalid-feedback d-block" id="parentDeptError" style="display:none;">상위 부서를 선택해주세요.</div>
                                </div>

                                <input type="hidden" id="delStatus" name="delStatus" value="0" />
                            </div>
                            
							

                            <div class="col-12 col-lg-5">
                                <div class="section-title">위치 정보</div>

                                <div class="row g-2 align-items-center addr-row">
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-mailbox"></i></span>
                                            <input type="text" class="form-control" id="postcode" placeholder="우편번호" readonly disabled="disabled">
                                        </div>
                                    </div>
                                    <div class="col-sm-5 d-grid d-sm-block">
                                        <button class="btn btn-primary w-100" type="button" onclick="execDaumPostcode()">
                                            주소 검색
                                        </button>
                                    </div>
                                </div>

                                <div class="mt-2">
                                    <label for="deptLoc" class="form-label">주소</label>
                                    <input type="text" class="form-control" id="deptLoc" name="deptLoc" placeholder="주소" readonly>
                                </div>

                                <div class="mt-2">
                                    <label for="locDetail" class="form-label">상세주소</label>
                                    <input type="text" class="form-control" id="locDetail" name="locDetail" placeholder="상세주소 입력">
                                </div>

                                <div class="help-text mt-2">
                                    다음 우편번호 서비스를 사용해 주소를 검색한 뒤, 상세주소를 입력하세요.
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="card-footer py-3">
                    <div class="d-flex justify-content-end gap-2">
                        <button form="deptForm" type="reset" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-counterclockwise me-2"></i>초기화
                        </button>
                       <button form="deptForm" type="submit" class="btn btn-primary" id="submitBtn" disabled>
					      <i class="bi bi-check-lg me-2"></i>부서 등록
					   </button>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="/foot.jsp"/>
    </div>
</div>

<!-- ★★ 공통 CDN (부트스트랩 JS 등) -->
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
</script>

<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      let addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
      document.getElementById('postcode').value = data.zonecode;
      document.getElementById('deptLoc').value = addr;
      document.getElementById('locDetail').focus();
    }
  }).open();
}
</script>

<div class="modal fade" id="empSearchModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="bi bi-search me-2"></i>사원 검색</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-person"></i></span>
          <input type="text" id="empSearchInput" class="form-control" placeholder="사원명 입력">
          <button class="btn btn-outline-secondary" type="button" id="empSearchBtn">검색</button>
        </div>
        <div class="table-responsive">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
              <tr><th style="width:120px">사원번호</th><th>이름</th><th>부서</th><th>이메일</th></tr>
            </thead>
            <tbody id="empSearchTbody">
              <tr><td colspan="4" class="text-center text-muted py-4">검색어를 입력해 주세요.</td></tr>
            </tbody>
          </table>
        </div>
        <div class="small text-muted mt-2">행을 클릭하면 선택됩니다.</div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="deptSearchModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title"><i class="bi bi-search me-2"></i>상위 부서 검색</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="input-group mb-3">
          <span class="input-group-text"><i class="bi bi-building"></i></span>
          <input type="text" id="deptSearchInput" class="form-control" placeholder="부서명 입력">
          <button class="btn btn-outline-secondary" type="button" id="deptSearchBtn">검색</button>
        </div>
        <div class="table-responsive">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-light">
              <tr><th style="width:140px">부서코드</th><th>부서명</th><th>상위부서</th></tr>
            </thead>
            <tbody id="deptSearchTbody">
              <tr><td colspan="3" class="text-center text-muted py-4">검색어를 입력해 주세요.</td></tr>
            </tbody>
          </table>
        </div>
        <div class="small text-muted mt-2">행을 클릭하면 선택됩니다. 
      </div>
    </div>
  </div>
</div>

<script>
const ctx = '${pageContext.request.contextPath}';

async function loadEmployees(keyword='') {
  const url = ctx + '/api/search/searchEmpModal?keyword=' + encodeURIComponent(keyword||'');
  const tbody = document.getElementById('empSearchTbody');
  tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-4">조회 중…</td></tr>';
  try{
    const res = await fetch(url, {headers:{'Accept':'application/json'}});
    const list = await res.json();
    if(!list || list.length===0){
      tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-4">검색 결과가 없습니다.</td></tr>';
      return;
    }
    tbody.innerHTML = list.map(emp => `
      <tr data-id="\${emp.empNo}" data-name="\${emp.empName}">
        <td>\${emp.empNo}</td>
        <td>\${emp.empName}</td>
        <td>\${emp.deptName ?? ''}</td>
        <td>\${emp.email ?? ''}</td>
      </tr>`).join('');
  }catch(e){
    tbody.innerHTML = '<tr><td colspan="4" class="text-center text-danger py-4">조회 중 오류가 발생했습니다.</td></tr>';
  }
}

async function loadDepartments(keyword='') {
  const url = ctx + '/api/search/searchParentDeptModal?deptName=' + encodeURIComponent(keyword||''); 
  const tbody = document.getElementById('deptSearchTbody');
  tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted py-4">조회 중…</td></tr>';
  try{
    const res = await fetch(url, {headers:{'Accept':'application/json'}});
    const list = await res.json();
    if(!list || list.length===0){
      tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted py-4">검색 결과가 없습니다.</td></tr>';
      return;
    }
    tbody.innerHTML = list.map(d => `
      <tr data-code="\${d.deptCode}" data-name="\${d.deptName}" data-parent="\${d.parentDeptName ?? ''}">
        <td>\${d.deptCode}</td>
        <td>\${d.deptName}</td>
        <td>\${d.parentDeptName ?? ''}</td>
      </tr>`).join('');
  }catch(e){
    tbody.innerHTML = '<tr><td colspan="3" class="text-center text-danger py-4">조회 중 오류가 발생했습니다.</td></tr>';
  }
}

document.getElementById('empSearchBtn').addEventListener('click',()=>loadEmployees(document.getElementById('empSearchInput').value));
document.getElementById('deptSearchBtn').addEventListener('click',()=>loadDepartments(document.getElementById('deptSearchInput').value));

['empSearchInput','deptSearchInput'].forEach(id=>{
  const el = document.getElementById(id);
  if(el) el.addEventListener('keydown',e=>{ if(e.key==='Enter'){ e.preventDefault(); el.id==='empSearchInput'?document.getElementById('empSearchBtn').click():document.getElementById('deptSearchBtn').click(); }});
});

</script>

<script>
function isFilled(v){ return v !== null && String(v).trim().length > 0; }

function updateSubmitState(){
  const deptName       = document.getElementById('deptName').value;
  const deptCaptainVal = document.getElementById('deptCaptain').value;
  const parentDeptVal  = document.getElementById('parentDeptCode').value;

  const deptCaptainName = document.getElementById('deptCaptainName');
  const parentDeptName  = document.getElementById('parentDeptName');

  const deptCaptainError = document.getElementById('deptCaptainError');
  const parentDeptError  = document.getElementById('parentDeptError');

  if(isFilled(deptCaptainVal)){
    deptCaptainName.classList.remove('is-invalid');
    deptCaptainError.style.display = 'none';
  }else{
    deptCaptainName.classList.add('is-invalid');
    deptCaptainError.style.display = 'block';
  }

  if(isFilled(parentDeptVal)){
    parentDeptName.classList.remove('is-invalid');
    parentDeptError.style.display = 'none';
  }else{
    parentDeptName.classList.add('is-invalid');
    parentDeptError.style.display = 'block';
  }

  const allOk = isFilled(deptName) && isFilled(deptCaptainVal) && isFilled(parentDeptVal);
  document.getElementById('submitBtn').disabled = !allOk;
}

document.getElementById('deptName').addEventListener('input', updateSubmitState);

document.addEventListener('DOMContentLoaded', updateSubmitState);

document.querySelector('button[type="reset"]').addEventListener('click', () => {
  setTimeout(updateSubmitState, 0); 
});

document.getElementById('empSearchTbody').addEventListener('click', e=>{
  const tr = e.target.closest('tr'); if(!tr || !tr.dataset.id) return;
  document.getElementById('deptCaptain').value = tr.dataset.id;
  document.getElementById('deptCaptainName').value = tr.dataset.name + ' ('+ tr.dataset.id +')';
  bootstrap.Modal.getInstance(document.getElementById('empSearchModal')).hide();
  updateSubmitState();
});

document.getElementById('deptSearchTbody').addEventListener('click', e=>{
  const tr = e.target.closest('tr'); if(!tr || !tr.dataset.code) return;
  document.getElementById('parentDeptCode').value = tr.dataset.code;
  document.getElementById('parentDeptName').value = tr.dataset.name + ' ('+ tr.dataset.code +')';
  bootstrap.Modal.getInstance(document.getElementById('deptSearchModal')).hide();
  updateSubmitState();
});
</script>


</body>
</html>
