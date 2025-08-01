<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>AssemERP - 사원 정보 수정</title>
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
<style>
    body { background-color: #f8f9fa; }
    .card-header { background-color: #198754; color: white; } /* Green theme for editing */
    .required-field::after { content: " *"; color: red; }
</style>
</head>
<!-- <body class="py-5"> -->
<body>

	<!-- 전체 레이아웃 -->
	<div id="layout">
		<div id="side">
			<jsp:include page="/side.jsp" />
		</div>
		<div id="main-area">
			<jsp:include page="/header.jsp" />

			<!-- 이곳에 자신의 코드를 작성하세요 -->
			<div id="contents">

				<div class="container">
				    <div class="row justify-content-center">
				        <div class="col-lg-8">
				            <div class="card shadow-sm">
				            	 <%------------------------------------------------------------------------------
				                		1. Card Header 정중앙
				                 ------------------------------------------------------------------------------%>
				                <div class="card-header d-flex justify-content-between align-items-center">
				                	<%------------------------------------------------------------------------------
				                		1-1. 목록 버튼 스타일
				                 	------------------------------------------------------------------------------%>
				                    <a href="/emp/empListForm" class="btn btn-outline-light btn-sm">
				                        <i class="bi bi-list-ul me-1"></i> 목록
				                    </a>
				                    <%------------------------------------------------------------------------------
				                		1-2. 타이틀 중앙 정렬 스타일
				                 	------------------------------------------------------------------------------%>
				                    <h4 class="card-title mb-0"><i class="bi bi-pencil-square me-2"></i>사원 정보 수정</h4>
				                    <div style="width: 90px;"></div>
				                </div>
				                <div class="card-body p-4">
				                	 <%------------------------------------------------------------------------------
				                     	2. Bootstrap 유효성 검사 적용 
				                    ------------------------------------------------------------------------------%>
				                    <form id="updateForm" action="/emp/empModifyPro" method="post" class="needs-validation" novalidate>
				                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				                        <%-- emp_no를 hidden으로 전달 --%>
				                        <input type="hidden" id="empNo" name="empNo" value="${emp.empNo}">
				
										<%------------------------------------------------------------------------------
				                     		2-1. Bootstrap 티이틀 적용 
				                    	------------------------------------------------------------------------------%>
				                        <h5 class="mb-3">기본 정보</h5>
				                        <div class="row">
				                            <div class="col-md-6 mb-3">
				                            	<%------------------------------------------------------------------------------
						                     		2-2. Bootstrap 라벨 명칭 및 Input Tag 적용 
						                     		     - 필수입력 사항 : 붉은색 * 표시 (class="form-label required-field") 
						                     		     - 미입력시 : 입력값 체크 (class="invalid-feedback")
						                    	------------------------------------------------------------------------------%>
				                                <label for="empName" class="form-label required-field">사원명</label>
				                                <div class="input-group">
				                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
				                                    <input type="text" class="form-control" id="empName" name="empName" value="${emp.empName}" required>
				                                    <div class="invalid-feedback">사원명을 입력해주세요.</div>
				                                </div>
				                            </div>
				                            <div class="col-md-6 mb-3">
				                            	<%------------------------------------------------------------------------------
						                     		2-2. Bootstrap 라벨 명칭 및 select Tag 적용 
						                     		     - 필수입력 사항 : 붉은색 * 표시 (class="form-label required-field") 
						                     		     - 미입력시 : 입력값 체크 (class="invalid-feedback")
						                    	------------------------------------------------------------------------------%>
				                                <label for="deptCode" class="form-label required-field">부서</label>
				                                <div class="input-group">
				                                     <span class="input-group-text"><i class="bi bi-building"></i></span>
				                                     <select class="form-select" id="deptCode" name="deptCode" required><!-- DB연동 대상(업무별 변경) -->
				                                        <option value="" disabled>부서를 선택하세요</option>
				                                        <option value="1000" ${emp.deptCode == 1000 ? 'selected' : ''}>인사팀</option>
				                                        <option value="2000" ${emp.deptCode == 2000 ? 'selected' : ''}>개발팀</option>
				                                        <option value="3000" ${emp.deptCode == 3000 ? 'selected' : ''}>영업팀</option>
				                                     </select>
				                                     <div class="invalid-feedback">부서를 선택해주세요.</div>
				                                </div>
				                            </div>
				                        </div>
				
				                        <div class="row">
				                             <div class="col-md-6 mb-3">
				                             	<%------------------------------------------------------------------------------
						                     		2-3. Bootstrap 라벨 명칭 및 Input Tag 적용 
						                     		     - Default 입력 형식 : 010-1234-5678 표시 (placeholder="010-1234-5678") 
						                    	------------------------------------------------------------------------------%>
				                                <label for="empTel" class="form-label">전화번호</label>
				                                <div class="input-group">
				                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
				                                    <input type="tel" class="form-control" id="empTel" name="empTel" value="${emp.empTel}" placeholder="010-1234-5678">
				                                </div>
				                            </div>
				                            <div class="col-md-6 mb-3">
				                            	<%------------------------------------------------------------------------------
						                     		2-3. Bootstrap 라벨 명칭 및 Input Tag 적용 
						                     			 - 필수입력 사항 : 붉은색 * 표시 (class="form-label required-field") 
						                     		     - 미입력시 : 입력값 체크 (class="invalid-feedback")
						                     		     - Default 입력 형식 : abc@k.com 표시 (placeholder="abc@k.com") 
						                    	------------------------------------------------------------------------------%>
				                                <label for="email" class="form-label required-field">이메일</label>
				                                <div class="input-group">
				                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
				                                    <input type="email" class="form-control" id="email" name="email" value="${emp.email}" required>
				                                    <div class="invalid-feedback">올바른 이메일 주소를 입력해주세요.</div>
				                                </div>
				                            </div>
				                        </div>
				                        
				                        <div class="mb-3">
				                        	<%------------------------------------------------------------------------------
					                     		2-4. Bootstrap 라벨 명칭 및 Input Tag 적용 
					                     		     - 타입 : number
					                     		     - 입력 조건 : 숫자만 입력 표시 (placeholder="숫자만 입력") 
					                    	------------------------------------------------------------------------------%>
				                            <label for="sal" class="form-label">급여</label>
				                            <div class="input-group">
				                                <span class="input-group-text"><i class="bi bi-cash-coin"></i></span>
				                                <input type="number" class="form-control" id="sal" name="sal" value="${emp.sal}" placeholder="숫자만 입력">
				                            </div>
				                        </div>
				                        
				                        <hr class="my-4">
				                        
				                         <%------------------------------------------------------------------------------
					                		3. 타이틀 중앙 정렬 스타일
					                 	------------------------------------------------------------------------------%>
				                        <h5 class="mb-3">계정 정보</h5>
				                        <div class="row">
				                             <div class="col-md-6 mb-3">
				                             	<%------------------------------------------------------------------------------
						                     		3-1. Bootstrap 라벨 명칭 및 Input Tag 적용 
						                     			 - 필수입력 사항 : 붉은색 * 표시 (class="form-label required-field") 
						                     		     - 미입력시 : 입력값 체크 (class="invalid-feedback")
						                    	------------------------------------------------------------------------------%>
				                                <label for="username" class="form-label required-field">사원 아이디</label>
				                                <div class="input-group">
				                                    <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
				                                    <input type="text" class="form-control" id="username" name="username" value="${emp.username}" readonly>
				                                </div>
				                                <small class="form-text text-muted">아이디는 변경할 수 없습니다.</small>
				                            </div>
				                            <div class="col-md-6 mb-3">
				                            	<%------------------------------------------------------------------------------
						                     		3-2. Bootstrap 라벨 명칭 및 Input Tag 적용 
						                     			 - 필수입력 사항 : 붉은색 * 표시 (class="form-label required-field") 
						                     		     - 변경값 체크 : 변경시 신규 입력 (class="form-text text-muted")
						                     		     - 타입 : password (입력값 비공개)
						                    	------------------------------------------------------------------------------%>
				                                <label for="password" class="form-label">비밀번호</label>
				                                <div class="input-group">
				                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
				                                    <input type="password" class="form-control" id="password" name="password">
				                                </div>
				                                <small class="form-text text-muted">변경할 경우에만 새 비밀번호를 입력하세요.</small>
				                            </div>
				                        </div>
				
				                        <div class="mb-4">
				                        	<%------------------------------------------------------------------------------
				                     		3-3. Bootstrap 라벨 명칭 및 Select Tag 적용 
				                     			 - 필수입력 사항 : DB 상태 정보로 선택 (selected) 
				                     			 - 미입력시 : 입력값 체크 (class="invalid-feedback") 오류 예방차원
				                    	------------------------------------------------------------------------------%>
				                            <label for="rolesStatus" class="form-label required-field">권한</label>
				                            <div class="input-group">
				                                <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
				                                <select class="form-select" id="rolesStatus" name="rolesStatus" required>
				                                    <option value="ROLE_USER" ${emp.rolesStatus == 'ROLE_USER' ? 'selected' : ''}>USER (일반 사용자)</option>
				                                    <option value="ROLE_MANAGER" ${emp.rolesStatus == 'ROLE_MANAGER' ? 'selected' : ''}>MANAGER (중간 관리자)</option>
				                                    <option value="ROLE_ADMIN" ${emp.rolesStatus == 'ROLE_ADMIN' ? 'selected' : ''}>ADMIN (최고 관리자)</option>
				                                </select>
				                                <div class="invalid-feedback">권한을 선택해주세요.</div>
				                            </div>
				                        </div>
				                        
				                        <div class="row mt-4 g-2">
				                        	<%------------------------------------------------------------------------------
					                     		4. Bootstrap 버튼 클릭
					                     			 - 초기화   : 화면 Clear
					                     			 - XX 등록 : 등록 이벤트
					                    	------------------------------------------------------------------------------%>
				                             <div class="col-md-4 d-grid">
				                                <button type="button" id="deleteBtn" class="btn btn-danger"><i class="bi bi-trash me-2"></i>삭제</button>
				                            </div>
				                            <div class="col-md-8 d-grid">
				                                <button type="submit" class="btn btn-success"><i class="bi bi-check-lg me-2"></i>정보 수정</button>
				                            </div>
				                        </div>
				                    </form>
				                    <%------------------------------------------------------------------------------
				                   		5. 삭제 처리를 위한 별도 form
				                  	------------------------------------------------------------------------------%>
				                    <form id="deleteForm" action="/emp/empDeletePro" method="post" class="d-none">
				                         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				                         <input type="hidden" name="empNo" value="${emp.empNo}">
				                    </form>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
				
			</div>
			<!-- 이곳에 자신의 코드를 작성하세요 -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>
				
	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
	
<%------------------------------------------------------------------------------
	 Bootstrap JS 및 유효성 검사 스크립트 
--------------------------------------------------------------------------------%>
<script>
    // Bootstrap 유효성 검사 스크립트
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })();

    // 삭제 버튼 확인 스크립트
    const deleteBtn = document.getElementById('deleteBtn');
    if(deleteBtn) {
        deleteBtn.addEventListener('click', function() {
            if(confirm('정말로 이 사원 정보를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                document.getElementById('deleteForm').submit();
            }
        });
    }
</script>
</body>
</html>