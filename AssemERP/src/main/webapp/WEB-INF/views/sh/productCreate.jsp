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
							<!-- 제품박스 -->
							<form action="/product/productCreate" method="post"
								class="needs-validation" enctype="multipart/form-data"
								novalidate>
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />

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
											<span class="input-group-text"> <i class="bi bi-grid"></i></span>
											<select class="form-select form-select-sm w-auto"
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

								<div class="row">
									<!-- 등록자 -->
									<div class="col-md-6 mb-3">
										<label for="empNo" class="form-label">등록자</label>
										<div class="input-group">
											<span class="input-group-text"> <i
												class="bi bi-person"></i></span> <select
												class="form-control form-control-sm" name="emp_no"
												id="empNo">
												<c:forEach var="emp" items="${EmpList}">
													<option value="${emp.empNo }">${emp.empName }</option>
												</c:forEach>
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
								<div class="col-md-12 mb-6">
									<label for="productContext" class="form-label">제품설명</label>
									<textarea class="form-control form-control-sm" rows="5"
										id="productContext" name="product_context"
										placeholder="설명란에 정보를 입력해주세요"></textarea>
								</div>
								<!-- 제품 기본정보 종료 -->

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
										<!-- 테이블 헤더 비율 설정 -->
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
				<!-- 이곳에 자신의 코드를 작성하세요 -->
			</div>
			<jsp:include page="/foot.jsp" />
		</div>
	</div>


	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />

	<script>
let rowIndex = document.querySelectorAll("#bomTableBody tr").length;

// 페이지초기 select name값 설정
document.addEventListener("DOMContentLoaded", function () {
    reindexBOMRows(); // 기존 행들도 name 설정
});

// 행 삭제버튼 동작시 로우 인덱스 최신화
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

    // MainController API로 분류값 받아오기
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
	
    // 부품구분 변경시 변경값에 맞는 부품리스트 받아오기
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
   	const icon = document.createElement("i")
   	
   	icon.className = "bi bi-trash"; 
   	
    delBtn.type = "button";
    delBtn.className = "btn btn-sm btn-outline-danger remove-item-btn";
    delBtn.onclick = () => handleRowDelete(delBtn);
    
    delBtn.appendChild(icon);
    delBtn.append(" 삭제"); // 아이콘 뒤에 텍스트
    
    delCell.style.textAlign = "center"; // 셀 안에서 버튼을 중앙 정렬
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

</script>
</body>
</html>