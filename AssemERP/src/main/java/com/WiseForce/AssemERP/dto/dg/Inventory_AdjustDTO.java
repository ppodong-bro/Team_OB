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
public class Inventory_AdjustDTO {
	private int inventory_adjust_no; // 재고조정번호
	private int adjust_status; // 조정 구분
	private int item_status; // 제품/부품 구분
	private int item_no; // 제품/부품번호
	private int inout_status; // 입/출고 구분
	private int item_cnt; // 변동 수량
	private LocalDateTime inout_date; // 입/출고일시
	private int item_close_status; // 마감 구분
}
