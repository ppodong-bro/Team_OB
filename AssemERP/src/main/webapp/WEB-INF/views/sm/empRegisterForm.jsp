<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<meta charset="UTF-8">
<title>AssemERP - 신규 사원 등록</title>
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
<style>
    body { background-color: #f8f9fa; }
    .card-header { background-color: #0d6efd; color: white; }
    .required-field::after { content: " *"; color: red; }
</style>
</head>
<body>
<!-- <body class="py-5"> -->

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
								    <h4 class="card-title mb-0"><i class="bi bi-person-plus-fill me-2"></i>신규 사원 등록</h4>
								    <%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
								    <div style="width: 90px;"></div>
								</div>
				                <div class="card-body p-4">
				                    <%------------------------------------------------------------------------------
				                     	2. Bootstrap 유효성 검사 적용 
				                    ------------------------------------------------------------------------------%>
				                    <form action="/emp/empSavePro" method="post" class="needs-validation" novalidate>
				                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				                        
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
				                                    <input type="text" class="form-control" id="empName" name="empName" required>
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
				                                        <option value="" selected disabled>부서를 선택하세요</option>
				                                        <option value="1000">인사팀</option>
				                                        <option value="2000">개발팀</option>
				                                        <option value="3000">영업팀</option>
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
				                                    <input type="tel" class="form-control" id="empTel" name="empTel" placeholder="010-1234-5678">
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
				                                    <input type="email" class="form-control" id="email" name="email" placeholder="abc@k.com" required>
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
				                                <input type="number" class="form-control" id="sal" name="sal" placeholder="숫자만 입력">
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
				                                    <input type="text" class="form-control" id="username" name="username" required>
				                                    <div class="invalid-feedback">사원 아이디를 입력해주세요.</div>
				                                </div>
				                            </div>
				                            <div class="col-md-6 mb-3">
				                            	<%------------------------------------------------------------------------------
						                     		3-2. Bootstrap 라벨 명칭 및 Input Tag 적용 
						                     			 - 필수입력 사항 : 붉은색 * 표시 (class="form-label required-field") 
						                     		     - 미입력시 : 입력값 체크 (class="invalid-feedback")
						                     		     - 타입 : password (입력값 비공개)
						                    	------------------------------------------------------------------------------%>
				                                <label for="password" class="form-label required-field">비밀번호</label>
				                                <div class="input-group">
				                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
				                                    <input type="password" class="form-control" id="password" name="password" required>
				                                    <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
				                                </div>
				                            </div>
				                        </div>
				
				                        <div class="mb-4">
				                        <%------------------------------------------------------------------------------
				                     		3-3. Bootstrap 라벨 명칭 및 Select Tag 적용 
				                     			 - 필수입력 사항 : 기본 선택 (selected) 
				                     			 - 미입력시 : 입력값 체크 (class="invalid-feedback") 오류 예방차원
				                    	------------------------------------------------------------------------------%>
									    <label for="rolesStatus" class="form-label required-field">권한</label>
									    <div class="input-group">
									        <span class="input-group-text"><i class="bi bi-shield-check"></i></span>
									        <select class="form-select" id="rolesStatus" name="rolesStatus" required>
									            <option value="ROLE_USER" selected>USER (일반 사용자)</option>
									            <option value="ROLE_MANAGER">MANAGER (중간 관리자)</option>
									            <option value="ROLE_ADMIN">ADMIN (최고 관리자)</option>
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
										    <div class="col-6 d-grid">
										        <button type="reset" class="btn btn-outline-secondary"><i class="bi bi-arrow-counterclockwise me-2"></i>초기화</button>
										    </div>
										    <div class="col-6 d-grid">
										        <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-2"></i>사원 등록</button>
										    </div>
										</div>
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
    })()
</script>
</body>
</html>