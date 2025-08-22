<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 공통 CSS/JS -->
  <jsp:include page="/common.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <meta charset="UTF-8" />
  <title>AssemERP - 부서 상세 / 수정</title>

  <style
    body{background:#f6f8fb;}
    .shadow-soft{box-shadow:0 10px 30px rgba(16,24,40,.06),0 2px 6px rgba(16,24,40,.06);}
    .card{border:0;border-radius:18px;overflow:hidden;}
    .card-header{
      background:linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);
      color:#fff;
    }
    .brand-chip{
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

    .addr-row .btn{min-width:120px}

    .card-footer{position:sticky;bottom:0;z-index:1;background:#fff}
    .card-footer .btn{height:44px}

    /* 모달 테이블 UX */
    .modal-body .table-hover tbody tr:hover{cursor:pointer;background:#f3f6ff}
    
    /* 관리자 스타일 버튼 공통 */
	.btn-admin-primary {
	  background: linear-gradient(135deg, #5D7BFF 0%, #78A6FF 100%);
	  color: #fff;
	  border: none;
	  border-radius: 10px;
	  box-shadow: 0 4px 10px rgba(93, 123, 255, 0.3);
	  transition: all 0.2s ease-in-out;
	}
	.btn-admin-primary:hover {
	  background: linear-gradient(135deg, #4a6be0 0%, #6894f0 100%);
	  box-shadow: 0 6px 14px rgba(93, 123, 255, 0.45);
	}
	
	.btn-admin-danger {
	  background: linear-gradient(135deg, #FF5D5D 0%, #FF7B78 100%);
	  color: #fff;
	  border: none;
	  border-radius: 10px;
	  box-shadow: 0 4px 10px rgba(255, 93, 93, 0.3);
	}
	.btn-admin-danger:hover {
	  background: linear-gradient(135deg, #e84b4b 0%, #f76b68 100%);
	  box-shadow: 0 6px 14px rgba(255, 93, 93, 0.45);
	}
	
	.btn-admin-outline {
	  background: transparent;
	  color: #5D7BFF;
	  border: 2px solid #5D7BFF;
	  border-radius: 10px;
	  transition: all 0.2s ease-in-out;
	}
	.btn-admin-outline:hover {
	  background: #5D7BFF;
	  color: #fff;
	}
	
        .btn-admin { height: 44px; border-radius: 10px; border: none; transition: all .2s; }

        .btn-admin-primary {
          background: linear-gradient(135deg,#5D7BFF 0%,#78A6FF 100%);
          color:#fff; box-shadow:0 4px 10px rgba(93,123,255,.3);
        }
        .btn-admin-primary:hover{
          background: linear-gradient(135deg,#4a6be0 0%,#6894f0 100%);
          box-shadow:0 6px 14px rgba(93,123,255,.45);
        }

        .btn-admin-danger {
          background: linear-gradient(135deg,#FF5D5D 0%,#FF7B78 100%);
          color:#fff; box-shadow:0 4px 10px rgba(255,93,93,.3);
        }
        .btn-admin-danger:hover{
          background: linear-gradient(135deg,#e84b4b 0%,#f76b68 100%);
          box-shadow:0 6px 14px rgba(255,93,93,.45);
        }

        .btn-admin-outline {
          background: transparent; color:#5D7BFF; border:2px solid #5D7BFF; border-radius:10px;
        }
        .btn-admin-outline:hover { background:#5D7BFF; color:#fff; }

        .addr-row .btn { min-width:120px; }
        .card-footer .btn { height:44px; }
	    
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
          	<a href="/dept/deptListForm" class="btn btn-outline-light btn-sm">
              <i class="bi bi-list-ul me-1"></i> 목록
            </a>
            <span class="brand-chip">
              <span class="dots"><span></span><span></span><span></span><span></span></span>
              <span class="label">ERP</span>
            </span>
            <div class="me-auto">
              <h4 class="mb-0 fw-bold">부서 상세 / 수정</h4>
              <small class="opacity-75">부서 기본정보, 위치, 이력 정보를 확인/수정합니다.</small>
            </div>
          </div>
        </div>

        <div class="card-body p-4">
          <form id="updateForm" action="/dept/deptModifyPro" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="deptCode" value="${dept.deptCode}"/>

            <div class="row g-4">
              <div class="col-12 col-lg-7">
                <div class="section-title">기본 정보</div>

                <div class="mb-3">
                  <label for="deptName" class="form-label required-field">부서명</label>
                  <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-building"></i></span>
                    <input type="text" class="form-control" id="deptName" name="deptName" value="${dept.deptName}" required/>
                    <div class="invalid-feedback">부서명을 입력해주세요.</div>
                  </div>
                </div>

                <div class="mb-3">
                  <label class="form-label">부서장</label>
                  <div class="input-group">
                    <input type="text" class="form-control" id="deptCaptainName" placeholder="오른쪽 검색 버튼을 클릭하세요" readonly
                           value="<c:out value='${dept.deptCaptainName}'/> (<c:out value='${dept.deptCaptain}'/>)"/>
                    <input type="hidden" id="deptCaptain" name="deptCaptain" value="${dept.deptCaptain}"/>
                    <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#empSearchModal">
                      <i class="bi bi-search"></i> 검색
                    </button>
                  </div>
                  <div class="help-text mt-1">사원 검색 팝업에서 선택 시 자동 반영됩니다.</div>
                </div>

                <div class="mb-3">
                  <label class="form-label">상위 부서</label>
                  <div class="input-group">
                    <input type="text" class="form-control" id="parentDeptName" placeholder="오른쪽 검색 버튼을 클릭하세요" readonly
                           value="<c:out value='${dept.parentDeptName}'/> (<c:out value='${dept.parentDeptCode}'/>)"/>
                    <input type="hidden" id="parentDeptCode" name="parentDeptCode" value="${dept.parentDeptCode}"/>
                    <button class="btn btn-outline-secondary" type="button" data-bs-toggle="modal" data-bs-target="#deptSearchModal">
                      <i class="bi bi-search"></i> 검색
                    </button>
                  </div>
                </div>

                <div class="mb-3">
                  <label for="delStatus" class="form-label">삭제 구분</label>
                  <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-toggles"></i></span>
                    <select class="form-select" id="delStatus" name="delStatus" disabled="disabled">
                      <option value="0"
                        <c:if test="${dept.delStatus == 0}">selected="selected"</c:if>>0 (활성)</option>
                      <option value="1"
                        <c:if test="${dept.delStatus == 1}">selected="selected"</c:if>>1 (삭제)</option>
                    </select>
                  </div>
                </div>
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
                    <button class="btn btn-admin btn-admin-primary w-100" type="button" onclick="execDaumPostcode()">주소 검색</button>
                  </div>
                </div>

                <div class="mt-2">
                  <label for="deptLoc" class="form-label">주소</label>
                  <input type="text" class="form-control" id="deptLoc" name="deptLoc" placeholder="주소" readonly value="${dept.deptLoc}"/>
                </div>

                <div class="mt-2">
                  <label for="locDetail" class="form-label">상세주소</label>
                  <input type="text" class="form-control" id="locDetail" name="locDetail" placeholder="상세주소 입력" value="${dept.locDetail}"/>
                </div>

                <div class="help-text mt-2">우편번호 서비스로 주소 검색 후 상세주소를 입력하세요.</div>
              </div>
            </div>

            <div class="row mt-4">
              <div class="col-md-6 mb-3">
                <label class="form-label">최초 등록자</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="bi bi-person-up"></i></span>
                  <input type="text" class="form-control" id="registrarName"
                         value="<c:out value='${dept.registrarName}'/> (사번: <c:out value='${dept.registrar}'/>)" readonly disabled="disabled"/>
                </div>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">등록일</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="bi bi-calendar-check"></i></span>
                  <fmt:formatDate value="${dept.inDate}" pattern="yyyy-MM-dd" var="formattedDate"/>
                  <input type="text" class="form-control" id="inDate" value="${formattedDate}" readonly disabled="disabled"/>
                </div>
              </div>
            </div>
         </form>
       </div>
       
       <div class="card-footer py-3">
		  <div class="d-flex justify-content-end gap-2">
		    <button type="button" id="deleteBtn" class="btn btn-admin btn-admin-danger">
		      <i class="bi bi-trash me-2"></i> 삭제
		    </button>
		    <button type="submit" form="updateForm" class="btn btn-admin btn-admin-primary">
		      <i class="bi bi-check-lg me-2"></i> 정보 수정
		    </button>
		  </div>
		</div>
		
		<form id="deleteForm" action="/dept/deptDeletePro" method="post" class="d-none">
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		  <input type="hidden" name="deptCode" value="${dept.deptCode}"/>
		</form>

      </div>
    </div>

    <jsp:include page="/foot.jsp"/>
  </div>
</div>

<!-- 공통 CDN (부트스트랩 JS 등) -->
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
const deleteBtn = document.getElementById('deleteBtn');
if(deleteBtn){
  deleteBtn.addEventListener('click', function(){
    if(confirm('정말로 이 부서 정보를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')){
      document.getElementById('deleteForm').submit();
    }
  });
}
</script>

<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
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
        <div class="small text-muted mt-2">행을 클릭하면 선택됩니다.</div>
      </div>
    </div>
  </div>
</div>

<script>
async function loadEmployees(keyword){
  const q = (keyword || '').trim();
  const tbody = document.getElementById('empSearchTbody');

  tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-4">조회 중…</td></tr>';
  try{
    const res  = await fetch('/api/search/searchEmpModal?empName=' + encodeURIComponent(q),
                             { headers:{ 'Accept':'application/json' }});
    const list = await res.json();
    if(!list || list.length===0){
      tbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted py-4">검색 결과가 없습니다.</td></tr>';
      return;
    }
    tbody.innerHTML = list.map(function(emp){
    	  return '<tr data-id="' + emp.empNo + '" data-name="' + (emp.empName || '') + '">' +
    	         '<td>' + emp.empNo + '</td>' +
    	         '<td>' + (emp.empName || '') + '</td>' +
    	         '<td>' + (emp.deptName || '') + '</td>' +
    	         '<td>' + (emp.email || '') + '</td>' +
    	         '</tr>';
    	}).join('');
  }catch(e){
    tbody.innerHTML = '<tr><td colspan="4" class="text-center text-danger py-4">조회 중 오류가 발생했습니다.</td></tr>';
  }
}

async function loadDepartments(keyword){
  const q = (keyword || '').trim();
  const tbody = document.getElementById('deptSearchTbody');

  tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted py-4">조회 중…</td></tr>';
  try{
    const res  = await fetch('/api/search/searchParentDeptModal?deptName=' + encodeURIComponent(q),
                             { headers:{ 'Accept':'application/json' }});
    const list = await res.json();
    
    if(!list || list.length===0){
      tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted py-4">검색 결과가 없습니다.</td></tr>';
      return;
    }
    tbody.innerHTML = list.map(function(dept){
        var code   = (dept.deptCode == null ? '' : dept.deptCode);
        var name   = (dept.deptName || '');
        var parent = (dept.parentDeptName || ''); // 필요시 parentDeptCode 로 교체

        return '<tr data-code="' + code + '" data-name="' + name + '">'
             +   '<td>' + code   + '</td>'
             +   '<td>' + name   + '</td>'
             +   '<td>' + parent + '</td>'
             + '</tr>';
      }).join('');
    
  }catch(e){
    tbody.innerHTML = '<tr><td colspan="3" class="text-center text-danger py-4">조회 중 오류가 발생했습니다.</td></tr>';
  }
}

document.getElementById('empSearchBtn').addEventListener('click', function(){
  loadEmployees(document.getElementById('empSearchInput').value);
});
document.getElementById('deptSearchBtn').addEventListener('click', function(){
  loadDepartments(document.getElementById('deptSearchInput').value);
});

['empSearchInput','deptSearchInput'].forEach(function(id){
  var el = document.getElementById(id);
  if(el) el.addEventListener('keydown', function(e){
    if(e.key==='Enter'){
      e.preventDefault();
      (id==='empSearchInput' ? document.getElementById('empSearchBtn') : document.getElementById('deptSearchBtn')).click();
    }
  });
});

document.getElementById('empSearchTbody').addEventListener('click', function(e){
  var tr = e.target.closest('tr'); if(!tr || !tr.dataset.id) return;
  document.getElementById('deptCaptain').value     = tr.dataset.id;
  document.getElementById('deptCaptainName').value = tr.dataset.name + ' ('+ tr.dataset.id +')';
  bootstrap.Modal.getInstance(document.getElementById('empSearchModal')).hide();
});
document.getElementById('deptSearchTbody').addEventListener('click', function(e){
  var tr = e.target.closest('tr'); if(!tr || !tr.dataset.code) return;
  document.getElementById('parentDeptCode').value  = tr.dataset.code;
  document.getElementById('parentDeptName').value  = tr.dataset.name + ' ('+ tr.dataset.code +')';
  bootstrap.Modal.getInstance(document.getElementById('deptSearchModal')).hide();
});
</script>


</body>
</html>
