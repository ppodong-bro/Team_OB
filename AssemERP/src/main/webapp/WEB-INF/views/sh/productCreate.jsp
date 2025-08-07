<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품 등록</title>
<jsp:include page="/common.jsp" />
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #0d6efd;
	color: white;
}

.required-field::after {
	content: " *";
	color: red;
}
</style>

<!-- 공통 CSS -->
</head>
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
								<div
									class="card-header d-flex justify-content-between align-items-center">
									<%------------------------------------------------------------------------------
                						1-1. 목록 버튼 스타일
                 					------------------------------------------------------------------------------%>
									<a href="/parts/partsList" class="btn btn-outline-light btn-sm">
										<i class="bi bi-list-ul me-1"></i> 목록
									</a>
									<%------------------------------------------------------------------------------
                						1-2. 타이틀 중앙 정렬 스타일
                 					------------------------------------------------------------------------------%>
									<h4 class="card-title mb-0">신규 제품 등록</h4>
									<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
									<div style="width: 90px;"></div>
								</div>
								<div class="card-body p-4">
									<form action="/product/productCreate" method="post"
										class="needs-validation" 
										enctype="multipart/form-data"
										novalidate>
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />

										<!-- 제품박스 -->
										<h5 class="mb-3">기본 정보</h5>
										<div class="row">

											<div class="col-md-6 mb-3">

												<!-- 제품명 -->

												<label for="productName" class="form-label">제품명</label>
												<div class="input-group">
													<span class="input-group-text"> <i class="bi bi-tag"></i>
													</span> <input type="text" class="form-control form-control-sm"
														id="productName" name="product_name" required>
													<div class="invalid-feedback">제품명을 입력해주세요.</div>
												</div>
											</div>

											<!-- 제품구분 -->
											<div class="col-md-6 mb-3">
												<label for="productStatus" class="form-label">구분</label>
												<div class="input-group">
													<span class="input-group-text"> <i
														class="bi bi-grid"></i></span> <select
														class="form-select form-select-sm w-auto"
														id="productStatus" name="product_status" required>
														<option value="">선택</option>
														<option value="0">데스크탑</option>
														<option value="1">노트북</option>
														<option value="2">워크스테이션</option>
													</select>
													<div class="invalid-feedback">제품종류를 선택해주세요.</div>
												</div>
											</div>
										</div>

										<!-- 등록자 -->
										<div class="row">
											<div class="col-md-6 mb-3">
												<label for="empNo" class="form-label">등록자</label>
												<div class="input-group">
													<span class="input-group-text"><i
														class="bi bi-person"></i></span> <select
														class="form-control form-control-sm" name="emp_no"
														id="empNo">
														<%-- <c:forEach var="emp">
											<option value="${emp.emp_no }">${emp.emp_name }</option>
										</c:forEach> --%>
													</select>

												</div>
											</div>
											<!-- 이미지 -->
											<div class="col-md-6 mb-3">
												<label for="productfile" class="form-label">제품이미지</label> <input
													type="file" class="form-control form-control-sm"
													id="productfile" name="file">
											</div>
										</div>

										<!-- 부품설명 -->
										<div class="col-md-6 mb-3">
											<label for="productContext" class="form-label">제품설명</label>
											<textarea class="form-control form-control-sm" rows="5"
												id="productContext" name="product_context"
												placeholder="설명란에 정보를 입력해주세요"></textarea>

										</div>

										


										<hr class="my-4">

										<!-- BOM 영역 -->
										<div class="container mt-4">
											<!-- 👇 제목과 버튼을 같은 줄, 양쪽 정렬 -->
											<div
												class="d-flex justify-content-between align-items-center mb-3">
												<h5 class="mb-0">제품 구성</h5>
												<button type="button" class="btn btn-primary" id="addRowBtn">+
													부품 추가</button>
											</div>

											<table class="table table-bordered" id="bomTable">
												<colgroup>
													<col style="width: 20%;">
													<col style="width: 5%%;">
													<col style="width: 15%;">
													<col style="width: 10%;">
												</colgroup>
												<thead>
													<tr style="text-align: center;">
														<th>부품구분</th>
														<th>부품명</th>
														<th>수량</th>
														<th>삭제</th>
													</tr>
												</thead>
												<tbody>
													<!-- JavaScript로 행이 추가됨 -->
												</tbody>
											</table>
										</div>

										<div class="row mt-4 g-2">
											<%------------------------------------------------------------------------------
					                     		4. Bootstrap 버튼 클릭
					                     			 - 초기화   : 화면 Clear
					                     			 - XX 등록 : 등록 이벤트
					                    	------------------------------------------------------------------------------%>
											<div class="col-6 d-grid">
												<button type="reset" class="btn btn-outline-secondary">
													<i class="bi bi-arrow-counterclockwise me-2"></i>초기화
												</button>
											</div>
											<div class="col-6 d-grid">
												<button type="submit" class="btn btn-primary">
													<i class="bi bi-check-lg me-2"></i>등록
												</button>
											</div>
										</div>
									</form>


								</div>
							</div>


						</div>
					</div>
				</div>
				<!-- 이곳에 자신의 코드를 작성하세요 -->
			</div>
			<jsp:include page="/foot.jsp" />
		</div>
	</div>


	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
	
<script>
    let rowIndex = 0;

    document.getElementById("addRowBtn").addEventListener("click", function () {
        const table = document.getElementById("bomTable").getElementsByTagName("tbody")[0];
        const newRow = table.insertRow();
		        
        const typeCell = newRow.insertCell(0);
        const partCell = newRow.insertCell(1);
        const cntCell = newRow.insertCell(2);
        const actionCell = newRow.insertCell(3);

        // 부품구분 select
        const typeSelect = document.createElement("select");
        typeSelect.className = "form-select";
        typeSelect.name = "productBOMList[" + rowIndex + "].parts_status";

        const defaultOption = new Option("선택", "");
        typeSelect.appendChild(defaultOption);

        // 부품 구분 목록 AJAX 호출
        fetch("/common/900")
            .then(res => res.json())
            .then(types => {
       		 	console.log("서버 응답:", types); // 👈 콘솔에서 구조 확인
                types.forEach(type => {
		            console.log("type:", type);
                    const option = new Option(type.context, type.middle_status);
                    typeSelect.appendChild(option);
                });
            })
            .catch(err => console.error('부품 구분 목록 로드 실패:', err));

        typeCell.appendChild(typeSelect);

        
        // 부품명 select
        const partSelect = document.createElement("select");
        partSelect.className = "form-select";
        partSelect.name = "productBOMList[" + rowIndex + "].parts_no";
        partCell.appendChild(partSelect);

        typeSelect.addEventListener("change", function () {
            const selectedValue = this.value;
            
            // 부품명 select 항상 초기화
            partSelect.innerHTML = "";
            partSelect.appendChild(new Option("선택", ""));

            // 선택된 값이 있고 유효한 숫자인 경우에만 API 호출
            if (selectedValue && !isNaN(parseInt(selectedValue, 10))) {
                const selectedType = parseInt(selectedValue, 10);
                console.log("API 호출:", selectedType);
                const url = "/product/getPartsByStatus/" + selectedType;
                console.log("API 호출 URL:", url); // URL 확인용

                fetch(url)
                    .then(res => {
                        if (!res.ok) {
                            throw new Error("서버 오류: ${res.status}");
                        }
                        return res.json();
                    })
                    .then(parts => {
                        if (Array.isArray(parts) && parts.length > 0) {
                            parts.forEach(part => {
                                const option = new Option(part.parts_name, part.parts_no);
                                partSelect.appendChild(option);
                            });
                        }
                    })
                    .catch(err => console.error('부품명 목록 로드 실패:', err));
            } else {
                console.log("유효하지 않은 값 선택됨:", selectedValue);
                // 유효하지 않은 값일 때는 API 호출하지 않고 select만 초기화
            }
        });
        // 수량 input
        const quantityInput = document.createElement("input");
        quantityInput.type = "number";
        quantityInput.className = "form-control";
        quantityInput.name = "productBOMList[" + rowIndex + "].cnt";
        quantityInput.min = "1";
        quantityInput.value = "1";
        cntCell.appendChild(quantityInput);

        // 삭제 버튼
        const deleteBtn = document.createElement("button");
        deleteBtn.type = "button";
        deleteBtn.className = "btn btn-danger";
        deleteBtn.innerText = "삭제";
        deleteBtn.onclick = () => newRow.remove();
        actionCell.appendChild(deleteBtn);

        rowIndex++;
    });
    
    document.querySelector("form").addEventListener("submit", function (e) {
        const rows = document.querySelectorAll("#bomTable tbody tr");

        const partsNoSet = new Set(); // 중복 체크용 Set

        let hasError = false;

        rows.forEach((row, idx) => {
            const type = row.querySelector('select[name^="productBOMList"][name$=".parts_status"]');
            const part = row.querySelector('select[name^="productBOMList"][name$=".parts_no"]');
            const cnt = row.querySelector('input[name^="productBOMList"][name$=".cnt"]');

            // 빈 값 체크
            if (!type.value || !part.value) {
                alert("모든 항목을 입력해주세요.");
                type.focus();
                e.preventDefault();
                hasError = true;
                return;
            }

            if (!cnt.value || parseInt(cnt.value) <= 0) {
                alert("수량을 입력해주세요.");
                cnt.focus();
                e.preventDefault();
                hasError = true;
                return;
            }

            // 중복 체크
            if (partsNoSet.has(part.value)) {
                alert("같은 부품을 두 번 추가할 수 없습니다.");
                part.focus();
                e.preventDefault();
                hasError = true;
                return;
            }

            partsNoSet.add(part.value);
        });

        if (hasError) return;
    });
</script> 
</body>
</html>