<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>제품 수정</title>
<jsp:include page="/common.jsp" />
<%------------------------------------------------------------------------------
	- Style body 적용
------------------------------------------------------------------------------%>
<style>
body {
	background-color: #f8f9fa;
}

.card-header {
	background-color: #198754;
	color: white;
}

.required-field::after {
	content: " *";
	color: red;
}
.image-box {
	width: 40px; /* 원하는 가로 크기 */
	height: 40px; /* 원하는 세로 크기 */
	overflow: hidden;
}

.image-box img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 비율 유지 + 잘라서 꽉 채움 */
	display: block; /* 여백 제거 */
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
				<div class="container-fluid px-4 py-4">
					<div class="card shadow-sm">
						<%------------------------------------------------------------------------------
                					1. Card Header 정중앙
                				 ------------------------------------------------------------------------------%>
						<div
							class="card-header d-flex justify-content-between align-items-center">
							<%------------------------------------------------------------------------------
                						1-1. 목록 버튼 스타일
                 					------------------------------------------------------------------------------%>
							<a href="/product/productList"
								class="btn btn-outline-light btn-sm"> <i
								class="bi bi-list-ul me-1"></i> 목록
							</a>
							<%------------------------------------------------------------------------------
                						1-2. 타이틀 중앙 정렬 스타일
                 					------------------------------------------------------------------------------%>
							<h4 class="card-title mb-0">제품 수정</h4>
							<%-- 타이틀의 정확한 중앙 정렬을 위한 빈 공간 --%>
							<div style="width: 90px;"></div>
						</div>
						<div class="card-body p-4">
							<form action="/product/productUpdate" method="post"
								class="needs-validation" enctype="multipart/form-data"
								novalidate>
								<input type="hidden" name="product_no"
									value="${productDTO.product_no }">

								<!-- 제품박스 -->
								<h5 class="mb-3">기본 정보</h5>
								<div class="row">

									<div class="col-md-6 mb-3">

										<!-- 제품명 -->

										<label for="productName" class="form-label">제품명</label>
										<div class="input-group">
											<span class="input-group-text"> <i class="bi bi-tag"></i></span>
											<input type="text" class="form-control form-control-sm"
												id="productName" name="product_name"
												value="${productDTO.product_name }" required>
											<div class="invalid-feedback">제품명을 입력해주세요.</div>
										</div>
									</div>

									<!-- 제품구분 -->
									<div class="col-md-6 mb-3">
										<label for="productStatus" class="form-label">구분</label>
										<div class="input-group">
											<span class="input-group-text"><i class="bi bi-grid"></i></span>
											<select class="form-select form-select-sm w-auto"
												id="productStatus" name="product_status" required>
												<option value=""
													${productDTO.product_status == null ? 'selected' : ''}>선택</option>
												<option value="0"
													${productDTO.product_status == 0 ? 'selected' : ''}>데스크탑</option>
												<option value="1"
													${productDTO.product_status == 1 ? 'selected' : ''}>노트북</option>
												<option value="2"
													${productDTO.product_status == 2 ? 'selected' : ''}>워크스테이션</option>
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
											<span class="input-group-text"><i class="bi bi-person"></i></span>
											<select class="form-control form-control-sm" name="emp_no"
												id="empNo">
												<c:forEach var="emp" items="${EmpList}">
													<option value="${emp.empNo }"
														${emp.empNo == productDTO.emp_no ? 'selected' : ''}>${emp.empName }</option>
												</c:forEach>
											</select>

										</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="productIndate" class="form-label">등록일</label>
										<div class="input-group">
											<input type="date" class="form-control form-control-sm"
												id="productIndate" name="in_date" readonly="readonly"
												value="${productDTO.in_date }">
										</div>
									</div>
								</div>


								<!-- 부품설명 -->
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="productContext" class="form-label">제품설명</label>
										<textarea class="form-control form-control-sm" rows="5"
											id="productContext" name="product_context"
											placeholder="설명란에 정보를 입력해주세요">${productDTO.product_context }</textarea>

									</div>


									<!-- 이미지 -->
									<div class="col-md-6 mb-3">
										<label for="partsfile" class="form-label">제품이미지</label>
										<div class="input-group">
											<div
												style="position: relative; display: inline-flex; margin-right: 15px;">
												<div class="image-box">
												<c:choose>
													<c:when test="${empty productDTO.filename}">
														<img
															src="${pageContext.request.contextPath}/upload/default.jpg"
															alt="기본이미지">
													</c:when>
													<c:otherwise>
														<img
															src="${pageContext.request.contextPath}/upload/s_${productDTO.filename}"
															alt="부품이미지">
													</c:otherwise>
												</c:choose>
												<!-- X 삭제 버튼 -->
												<c:if test="${!empty productDTO.filename}">
													<i class="bi bi-x"
														onclick="deleteFile(${productDTO.product_no})"
														style="position: absolute; background-color: red; top: -10px; right: -10px; font-size: 15px; border: solid; border-width: 1px; width: 20px; height: 20px; display: flex; align-items: center; justify-content: center;"></i>
												</c:if>
												</div>
											</div>
											<input type="file" class="form-control form-control-sm"
												id="productfile" name="file">
										</div>
									</div>
								</div>


								<hr class="my-4">

								<!-- BOM 영역 -->
								<div class="container-fluid px-4 py-4">
									<!-- 👇 제목과 버튼을 같은 줄, 양쪽 정렬 -->
									<div
										class="d-flex justify-content-between align-items-center mb-3">
										<h5 class="mb-0">제품 구성</h5>
										<button type="button" class="btn btn-primary" id="addRowBtn">
											<i class="bi bi-plus-lg"></i>부품 추가
										</button>
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
										<tbody id="bomTableBody">
											<c:forEach var="bom" items="${productBomDTOs}"
												varStatus="status">
												<tr>
													<!-- 부품구분 -->
													<td><select class="form-select" required>
															<option value="">선택</option>
															<option value="0"
																${bom.parts_status == 0 ? 'selected' : ''}>메인보드</option>
															<option value="1"
																${bom.parts_status == 1 ? 'selected' : ''}>CPU</option>
															<option value="2"
																${bom.parts_status == 2 ? 'selected' : ''}>GPU</option>
															<option value="3"
																${bom.parts_status == 3 ? 'selected' : ''}>메모리</option>
															<option value="4"
																${bom.parts_status == 4 ? 'selected' : ''}>POWER</option>
															<option value="5"
																${bom.parts_status == 5 ? 'selected' : ''}>HDD</option>
															<option value="6"
																${bom.parts_status == 6 ? 'selected' : ''}>SDD</option>
															<option value="7"
																${bom.parts_status == 7 ? 'selected' : ''}>CASE</option>
															<option value="8"
																${bom.parts_status == 8 ? 'selected' : ''}>COOLER</option>
													</select></td>

													<!-- 부품명 -->
													<td><select class="form-select" required>
															<option value="${bom.parts_no}">${bom.parts_name}</option>
															<c:forEach var="partsDTO" items="${partsDTOs}">
																<option value="${partsDTO.parts_no}"
																	${partsDTO.parts_no == bom.parts_no ? 'selected' : ''}>
																	${partsDTO.parts_name}</option>
															</c:forEach>
													</select></td>

													<!-- 수량 -->
													<td><input type="number" class="form-control"
														value="${bom.cnt}" min="1" required /></td>

													<!-- 삭제 버튼 -->
													<td>
														<button type="button" class="btn btn-danger"
															onclick="handleRowDelete(this)">삭제</button>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<div class="row mt-4 g-2">
										<%------------------------------------------------------------------------------
					                     		4. Bootstrap 버튼 클릭
					                     			 - 삭제	: 삭제 이벤트
					                     			 - 수정	: 수정 이벤트
					                    	------------------------------------------------------------------------------%>
										<div class="col-md-4 d-grid">
											<button type="button" id="deleteBtn" class="btn btn-danger">
												<i class="bi bi-trash me-2"></i>삭제
											</button>
										</div>
										<div class="col-md-8 d-grid">
											<button type="submit" class="btn btn-success">
												<i class="bi bi-check-lg me-2"></i>정보 수정
											</button>
										</div>
									</div>
								</div>
							</form>
							<%------------------------------------------------------------------------------
				                   		5. 삭제 처리를 위한 별도 form
				                  	------------------------------------------------------------------------------%>
							<form id="deleteForm" action="/product/productDeletePro"
								method="post" class="d-none">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="hidden"
									name="product_no" value="${productDTO.product_no}">
							</form>
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
let rowIndex = document.querySelectorAll("#bomTableBody tr").length;

document.addEventListener("DOMContentLoaded", function () {
    reindexBOMRows(); // 기존 행들도 name 설정
});

// 행 삭제
function handleRowDelete(button) {
    const row = button.closest("tr");
    row.remove();
    reindexBOMRows();
}

// 행 추가
document.getElementById("addRowBtn").addEventListener("click", function () {
    const tableBody = document.getElementById("bomTableBody");
    const newRow = document.createElement("tr");
	
    // 부품구분
    const typeCell = document.createElement("td");
    const typeSelect = document.createElement("select");
    typeSelect.className = "form-select";
    typeSelect.required = true;
    typeSelect.appendChild(new Option("선택", ""));
    typeCell.appendChild(typeSelect);

    fetch("/common/900")
        .then(res => res.json())
        .then(types => {
            types.forEach(type => {
                const option = new Option(type.context, type.middle_status);
                typeSelect.appendChild(option);
            });
        })
        .catch(err => console.error("부품 구분 로드 실패:", err));

    // 부품명
    const partCell = document.createElement("td");
    const partSelect = document.createElement("select");
    partSelect.className = "form-select";
    partSelect.required = true;
    partSelect.appendChild(new Option("선택", ""));
    partCell.appendChild(partSelect);

    typeSelect.addEventListener("change", function () {
        const selectedValue = this.value;
        partSelect.innerHTML = "";
        partSelect.appendChild(new Option("선택", ""));
        if (selectedValue && !isNaN(parseInt(selectedValue, 10))) {
            fetch("/product/getPartsByStatus/" + selectedValue)
                .then(res => res.json())
                .then(parts => {
                    parts.forEach(part => {
                        partSelect.appendChild(new Option(part.parts_name, part.parts_no));
                    });
                })
                .catch(err => console.error("부품명 로드 실패:", err));
        }
    });

    // 수량
    const cntCell = document.createElement("td");
    const cntInput = document.createElement("input");
    cntInput.type = "number";
    cntInput.className = "form-control";
    cntInput.min = "1";
    cntInput.value = "1";
    cntInput.required = true;
    cntCell.appendChild(cntInput);

    // 삭제 버튼
    const delCell = document.createElement("td");
    const delBtn = document.createElement("button");
    delBtn.type = "button";
    delBtn.className = "btn btn-danger";
    delBtn.innerText = "삭제";
    delBtn.onclick = () => handleRowDelete(delBtn);
    delCell.appendChild(delBtn);

    // 행에 각 셀 append
    newRow.appendChild(typeCell);
    newRow.appendChild(partCell);
    newRow.appendChild(cntCell);
    newRow.appendChild(delCell);

    tableBody.appendChild(newRow);
    reindexBOMRows();
});
// name 인덱스 재정렬
function reindexBOMRows() {
    const rows = document.querySelectorAll("#bomTableBody tr");
	console.log("rows length:", rows.length);
	
	rows.forEach((row, idx) => {
	    const selects = row.querySelectorAll("select");
	    const input = row.querySelector("input");

	    const type = selects[0];
	    const part = selects[1];
	    const cnt = input;

	    if (!type || !part || !cnt) {
	        console.warn(`⚠️ Row ${idx} is missing elements`);
	        return;
	    }

	    type.name = 'productBOMList['+idx+'].parts_status';
	    part.name = 'productBOMList['+idx+'].parts_no';
	    cnt.name = 'productBOMList['+idx+'].cnt';

	    console.log(`✅ Row ${idx} - type.name: ${type.name}, part.name: ${part.name}, cnt.name: ${cnt.name}`);
	});
}

// 유효성 검사
document.querySelector("form").addEventListener("submit", function (e) {
    const rows = document.querySelectorAll("#bomTableBody tr");
    const partsNoSet = new Set();

 	// 제품구성이 비었을 경우 확인창띄우기
    if (rows.length === 0) {
        const confirmResult = confirm("제품 구성이 설정되지 않았습니다. 이대로 등록하시겠습니까?");
        if (!confirmResult) {
            e.preventDefault();
            return;
        }
    }
    
    let hasError = false;
    let errorMessage = "";
    let firstError = null;

    rows.forEach(row => {
        const type = row.cells[0].querySelector("select");
        const part = row.cells[1].querySelector("select");
        const cnt = row.cells[2].querySelector("input");

        if (!type.value || !part.value) {
            errorMessage = "모든 항목을 입력해주세요.";
            firstError = type;
            hasError = true;
            return;
        }

        if (!cnt.value || parseInt(cnt.value) <= 0) {
            errorMessage = "수량을 입력해주세요.";
            firstError = cnt;
            hasError = true;
            return;
        }

        if (partsNoSet.has(part.value)) {
            errorMessage = "같은 부품을 중복으로 추가할 수 없습니다.";
            firstError = part;
            hasError = true;
            return;
        }

        partsNoSet.add(part.value);
    });

    if (hasError) {
        alert(errorMessage);
        firstError?.focus();
        e.preventDefault();
    }
});
	// 파일삭제 버튼
    function deleteFile(prdouctNo) {
        if (confirm('파일을 삭제하시겠습니까?')) {
            fetch('${pageContext.request.contextPath}/product/deleteFile/' + prdouctNo, {
                method: 'DELETE'
            }).then(response => {
                if (response.ok) {
                    alert('파일이 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('파일 삭제에 실패했습니다.');
                }
            }).catch(e => alert('오류가 발생했습니다.'));
        }
    }
	
	// DB 삭제버튼
    const deleteBtn = document.getElementById('deleteBtn');
    if (deleteBtn) {
        deleteBtn.addEventListener('click', function () {
            if (confirm('정말로 삭제하시겠습니까?')) {
                document.getElementById('deleteForm').submit();
            }
        });
    }
    
    
</script>
</body>
</html>