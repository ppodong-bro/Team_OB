<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <meta charset="UTF-8">
    <title>AssemERP - 신규 부서 등록</title>
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

				<!-- <div class="container px-4"> --><!-- 기존영역 주석처리 -->
				<div class="container-fluid px-4"><!-- container-fluid 추가 -->
				    <!-- <div class="row justify-content-center">
				        <div class="col-lg-8">--><!-- 기존영역 주석처리 -->
				            <div class="card shadow-sm">
				                <div class="card-header d-flex justify-content-between align-items-center">
				                    <a href="/dept/deptListForm" class="btn btn-outline-light btn-sm">
				                        <i class="bi bi-list-ul me-1"></i> 목록
				                    </a>
				                    <h4 class="card-title mb-0"><i class="bi bi-building-add me-2"></i>신규 부서 등록</h4>
				                    <div style="width: 90px;"></div>
				                </div>
				                <div class="card-body p-4">
				                    <form action="/dept/deptSavePro" method="post" class="needs-validation" novalidate>
				                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				                        
				                        <div class="mb-3">
				                            <label for="deptName" class="form-label required-field">부서명</label>
				                            <div class="input-group">
				                                <span class="input-group-text"><i class="bi bi-building"></i></span>
				                                <input type="text" class="form-control" id="deptName" name="deptName" required>
				                                <div class="invalid-feedback">부서명을 입력해주세요.</div>
				                            </div>
				                        </div>
				
				                        <div class="mb-3">
				                            <label for="deptCaptain" class="form-label">부서장 (사원번호)</label>
				                            <div class="input-group">
				                                <span class="input-group-text"><i class="bi bi-person-check"></i></span>
				                                <input type="number" class="form-control" id="deptCaptain" name="deptCaptain" placeholder="부서장 사원번호 입력">
				                            </div>
				                        </div>
				
				                        <div class="mb-3">
				                            <label for="parentDeptCode" class="form-label">상위 부서 코드</label>
				                            <div class="input-group">
				                                <span class="input-group-text"><i class="bi bi-diagram-3"></i></span>
				                                <input type="number" class="form-control" id="parentDeptCode" name="parentDeptCode" placeholder="상위 부서가 있을 경우 입력">
				                            </div>
				                        </div>
				
				                        <%-- 기존 '위치' 필드를 아래의 '우편번호', '주소', '상세주소' 필드로 교체 --%>
										<div class="row mb-4">
										    <label for="postcode" class="col-md-1 col-form-label">위치</label>
										    <div class="col-md-11">
										        <div class="row">
										            <div class="col-md-5 mb-2">
										                <div class="input-group">
										                    <input type="text" class="form-control" id="postcode" placeholder="우편번호" readonly disabled="disabled">
										                    <button class="btn btn-primary" type="button" onclick="execDaumPostcode()">주소 검색</button>
										                </div>
										            </div>
										        </div>
										        <div class="row">
										            <div class="col-md-8 mb-2 mb-md-0">
										                <input type="text" class="form-control" id="deptLoc" name="deptLoc" value="" placeholder="주소" readonly>
										            </div>
										            <div class="col-md-4">
										                <input type="text" class="form-control" id="locDetail" name="locDetail" value="" placeholder="상세주소 입력">
										            </div>
										        </div>
										    </div>
										</div>
										
										 <div class="mb-4">
				                            <label for="delStatus" class="form-label">삭제 구분</label>
				                            <div class="input-group">
				                                <span class="input-group-text"><i class="bi bi-toggles"></i></span>
				                                <select class="form-select" id="delStatus" name="delStatus" disabled="disabled">
				                                    <option value="0" ${dept.delStatus == 0 ? 'selected' : ''}>0 (활성)</option>
				                                    <%-- <option value="1" ${dept.delStatus == 1 ? 'selected' : ''}>1 (삭제)</option> --%>
				                                </select>
				                            </div>
				                        </div>
				                        
				                        <div class="row mt-4 g-2">
				                            <div class="col-6 d-grid">
				                                <button type="reset" class="btn btn-outline-secondary"><i class="bi bi-arrow-counterclockwise me-2"></i>초기화</button>
				                            </div>
				                            <div class="col-6 d-grid">
				                                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-2"></i>부서 등록</button>
				                            </div>
				                        </div>
				                    </form>
				                </div>
				            </div>
				        </div>
				   <!--  </div>
				</div> -->
				
				</div>
			<!-- 이곳에 자신의 코드를 작성하세요 -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>

	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />

<!--  부서관리 javaScript function 구현  -->	
<script>
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
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) 
            {
                let addr = ''; // 최종 주소 변수
                
                if (data.userSelectedType === 'R') { // 도로명 주소 선택
                    addr = data.roadAddress;
                } else { // 지번 주소 선택(J)
                    addr = data.jibunAddress;
                }

                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("deptLoc").value = addr;
                
                document.getElementById("locDetail").focus();
            }
        }).open();
    }
</script>
</body>
</html>