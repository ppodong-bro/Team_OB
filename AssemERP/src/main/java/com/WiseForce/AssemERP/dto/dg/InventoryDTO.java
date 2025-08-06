package com.WiseForce.AssemERP.dto.dg;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class InventoryDTO {
	private int inventory_his_no; // 재고변동이력번호
	private int order_status;//수주(0),발주(1) 구분
	private int order_no;//수주,발주 번호
	private int item_status; // 제품/부품 구분
	private int item_no; // 제품/부품번호
	private int inout_status; // 입/출고 구분
	private LocalDateTime inout_date; // 입/출고일시
	private int item_cnt; // 수량
	private int item_totalcnt; // 수량
	private int item_quality; // 품질
	
	// 출력
	private String inout_date_text;
	
	// 검색
	private int order_status_select = 999;
	private String order_no_text;
	private int item_status_select = 999;
	private String item_no_text;

	// 페이지
	private int start;// 재고 번호 시작
	private int end;// 재고 번호 끝
	private String currentPage;// 현제 페이지
	private String pageNum;// 전체 페이지 개수
}
