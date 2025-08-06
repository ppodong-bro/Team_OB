<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- 공통 CSS -->
<jsp:include page="/common.jsp" />
<link rel="stylesheet" href="<c:url value='/css/list.css'/>" />
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 거래처 팝업 연동 스크립트 -->
<script>
	function openClientPopup() {
		window.open(
			'${pageContext.request.contextPath}/client/popup',
			'clientPopup',
			'width=600,height=500,scrollbars=yes'
		);
	}

	function setClientInfo(client_No, client_Name, client_Address, client_Email, client_Man, empNo, empName) {
		  document.getElementById('clientNoInput').value = client_No;
		  document.getElementById('clientNameInput').value = client_Name;
		  document.getElementById('clientAddressInput').value = client_Address;
		  document.getElementById('clientEmailInput').value = client_Email;
		  document.getElementById('clientManInput').value = client_Man;
		  document.getElementById('empNoInput').value = empNo;
		  document.getElementById('empNameInput').value = empName;
		  // document.getElementById('clientDateInput').value = in_Date?.substring(0, 10); ← 일단 주석처리
		  window.close();
	}
	
	let targetProductInput = null; // 값을 넣을 타겟 input(한 줄만 기억)

	function openProductPopup(btn) {
	    // btn: 사용자가 클릭한 "조회" 버튼(this)
	    // 해당 버튼이 속한 tr에서 class가 'productNoInput'인 input을 찾음
	    targetProductInput = btn.closest('tr').querySelector('.productNoInput');
	  
	    targetProductNameInput = btn.closest('tr').querySelector('.productNameInput');

	    window.open(
	        '${pageContext.request.contextPath}/sales/productPopup',
	        'productPopup',
	        'width=600,height=500,scrollbars=yes'
	    );
	}
	
	// 팝업창에서 선택 버튼 클릭 시 실행되는 함수
	function setProductInfo(product_no, product_name) {
	    if (targetProductInput) {
	        targetProductInput.value = product_no;
	 	if (targetProductNameInput) 
	 		targetProductNameInput.value = product_name;
	    }
	    window.close();
	}
	
	
	document.addEventListener('DOMContentLoaded', function () {
		  const addItemBtn = document.getElementById('add-item-btn');
		  const itemsTbody = document.getElementById('items-tbody');

		  addItemBtn.addEventListener('click', function () {
			  const idx = itemsTbody.querySelectorAll('tr').length;

			  const newRow = document.createElement('tr');
			  newRow.className = 'item-row';
			  newRow.innerHTML =
				  '<td>' +
				    '<div class="input-group input-group-sm">' +
				      '<input type="hidden" class="productNoInput" ' +
				             'name="sales_Item[' + idx + '].product_No" />' +
				      '<input type="text" class="form-control form-control-sm productNameInput" ' +
				             'readonly tabindex="-1" style="background:#f6f6f6;" />' +
				      '<button type="button" class="btn btn-outline-secondary" ' +
				              'onclick="openProductPopup(this)">조회</button>' +
				    '</div>' +
				  '</td>' +

				  // ────────────────────────────────────────────────────────────────────────
				  // 두 번째 셀: 요청수량
				  '<td>' +
				    '<input type="number" min="0" ' +
				           'name="sales_Item[' + idx + '].sales_Item_Cnt" ' +
				           'class="form-control form-control-sm qty-input" required />' +
				  '</td>' +

				  // 세 번째 셀: 제품 단가
				  '<td>' +
				    '<input type="number" step="0.01" min="0" ' +
				           'name="sales_Item[' + idx + '].sales_Item_Cost" ' +
				           'class="form-control form-control-sm cost-input" required />' +
				  '</td>' +

				  // 네 번째 셀: 요청 총액 (readonly)
				  '<td>' +
				    '<input type="text" readonly ' +
				           'class="form-control form-control-plaintext form-control-sm tot-cost" />' +
				  '</td>' +

				  // 다섯 번째 셀: 삭제 버튼
				  '<td class="text-center">' +
				    '<button type="button" ' +
				            'class="btn btn-sm btn-outline-danger remove-item-btn" ' +
				            'onclick="this.closest(\'tr\').remove(); recalcTotal();">' +
				      '&times;' +
				    '</button>' +
				  '</td>';
			    // … 나머지 칸도 동일하게 문자열 연결로 name 속성에 idx 삽입
			  itemsTbody.appendChild(newRow);
			});
		});

	function recalcTotal() {
		  let sumReq = 0;
		  let sumCost = 0;

		  document.querySelectorAll('#items-tbody tr').forEach(function(row) {
		    // 요청수량
		    const qty = Number(row.querySelector('.qty-input')?.value) || 0;
		    // 단가
		    const cost = Number(row.querySelector('.cost-input')?.value) || 0;
		    // 요청 총액 계산
		    const totCost = qty * cost;

		    // 각 행의 요청 기준 총액 표시
		    const totCostInput = row.querySelector('.tot-cost');
		    if (totCostInput) totCostInput.value = totCost ? totCost.toLocaleString() : '';

		    sumReq += qty;
		    sumCost += totCost;
		  });

		  // 합계 영역 업데이트
		  document.getElementById('sum-req').innerText = sumReq.toLocaleString();
		  document.getElementById('sum-cost').innerText = sumCost.toLocaleString();
		}

		// 수량/단가 input 입력시마다 합계 다시 계산
		document.addEventListener('input', function(e) {
		  if (e.target.classList.contains('qty-input') || e.target.classList.contains('cost-input')) {
		    recalcTotal();
		  }
		});

		// 항목 추가/삭제 후에도 호출 필요
		document.addEventListener('DOMContentLoaded', function() {
		  recalcTotal();
		});
</script>
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
				<div class="container-fluid px-4">
					<form action="${pageContext.request.contextPath}/sales/create"
						method="post" class="needs-validation" novalidate>

						<!-- 수주 / 거래처 기본 정보 -->
						<section class="info-card mb-4">
							<div class="info-card-title mb-2">수주 / 거래처 정보</div>
							<div class="row g-3">
								<!-- 거래처 이름 (팝업 조회) -->
								<div class="col-md-4">
									<label class="form-label">거래처 이름<span
										class="text-danger">*</span></label>
									<div class="input-group input-group-sm">
										<input type="hidden" id="clientNoInput"
											name="sales_OrderDto.clientDto.client_No"
											value="${sales_OrderDto.clientDto.client_No}" /> <input
											type="text" id="clientNameInput"
											class="form-control form-control-sm"
											name="clientDto.client_Name"
											value="${sales_OrderDto.clientDto.client_Name}" readonly
											required placeholder="조회 버튼으로 선택" />
										<button type="button" class="btn btn-outline-secondary"
											onclick="openClientPopup()">조회</button>
									</div>
								</div>

								<!-- 거래처 주소 -->
								<div class="col-md-4">
									<label class="form-label">주소</label> <input type="text"
										class="form-control form-control-sm" id="clientAddressInput"
										name="clientDto.client_Address"
										value="${sales_OrderDto.clientDto.client_Address}" />
								</div>

								<!-- 이메일 -->
								<div class="col-md-4">
									<label class="form-label">이메일</label>
									<div class="input-group input-group-sm">
										<span class="input-group-text">@</span> <input type="email"
											class="form-control" id="clientEmailInput"
											name="clientDto.client_Email"
											value="${sales_OrderDto.clientDto.client_Email}" />
									</div>
								</div>

								<!-- 거래처 담당자 -->
								<div class="col-md-4">
									<label class="form-label">거래처 담당자</label> <input type="text"
										class="form-control form-control-sm" id="clientManInput"
										name="clientDto.client_Man"
										value="${sales_OrderDto.clientDto.client_Man}" />
								</div>

								<!-- 담당자 이름 -->
								<div class="col-md-4">
									<label class="form-label">담당자 이름</label> 
									<input type="hidden" name="empDTO.empNo" id="empNoInput" 
										   value="${sales_OrderDto.empDTO.empNo}" />
									<input type="text" readonly class="form-control form-control-sm"
										id="empNameInput" value="${sales_OrderDto.empDTO.empName}" />
								</div>

								<!-- 등록 일자 -->
								<div class="col-md-4">
									<label class="form-label">납기 완료일</label> <input type="date"
										class="form-control form-control-sm"
										name="sales_Date"
										value="$(sales_OrderDto.sales_Date}" />
								</div>
						</section>

						<!-- 제품 항목 추가 -->
						<section class="info-card mb-4">
							<div
								class="info-card-title mb-2 d-flex justify-content-between align-items-center">
								<div>제품 목록</div>
								<button type="button" id="add-item-btn"
									class="btn btn-sm btn-outline-secondary">항목 추가</button>
							</div>

							<div class="table-responsive"
								style="max-height: 360px; overflow: auto;">
								<table
									class="table table-sm table-bordered align-middle mb-0 product-table"
									id="items-table">
									<caption class="visually-hidden">등록할 제품 목록</caption>
									<thead class="table-light">
										<tr>
											<th scope="col">제품</th>
											<th scope="col" class="numeric">요청수량</th>
											<th scope="col" class="numeric">제품 단가</th>
											<th scope="col" class="numeric">요청 총액</th>
											<th scope="col">삭제</th>
										</tr>
									</thead>
									<tbody id="items-tbody">
										<!-- 초기에는 한 줄 비어있게 -->
										<tr class="item-row">
											<td><div class="input-group input-group-sm">
													<input type="hidden" class="productNoInput"
														name="sales_Item[0].product_No" /> <input
														type="text"
														class="form-control form-control-sm productNameInput"
														value="${sales_OrderDto.clientDto.client_Name}">
													<button type="button" class="btn btn-outline-secondary"
														onclick=openProductPopup(this)>조회</button>
												</div></td>
											<td><input type="number" min="0"
												name="sales_Item[0].sales_Item_Cnt"
												class="form-control form-control-sm qty-input" required /></td>
											<td><input type="number" step="0.01" min="0"
												name="sales_Item[0].sales_Item_Cost"
												class="form-control form-control-sm cost-input" required /></td>
											<td><input type="text" readonly
												class="form-control form-control-plaintext form-control-sm tot-cost" /></td>
											<td class="text-center">
												<button type="button"
													class="btn btn-sm btn-outline-danger remove-item-btn">&times;</button>
											</td>
										</tr>
									</tbody>
									<tfoot>
										<tr class="total-row">
											<td>합계</td>
											<td class="numeric"><span id="sum-req">0</span></td>
											<td></td>
											<td class="numeric"><span id="sum-cost">0</span></td>
											<td></td>
										</tr>
									</tfoot>
								</table>
							</div>
						</section>

						<!-- 액션 -->
						<div class="d-flex justify-content-end gap-2">
							<a href="${pageContext.request.contextPath}/sales/list"
								class="btn btn-outline-secondary btn-sm px-4">취소</a>
							<button type="submit" class="btn btn-primary btn-sm px-4">등록</button>
						</div>

					</form>
				</div>
			</div>
			<!-- 이곳에 자신의 코드를 작성하세요 -->

			<jsp:include page="/foot.jsp" />
		</div>
	</div>

	<!-- 부트스트랩 CDN -->
	<jsp:include page="/common_cdn.jsp" />
</body>
</html>