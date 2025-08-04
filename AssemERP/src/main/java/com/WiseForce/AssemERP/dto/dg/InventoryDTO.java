package com.WiseForce.AssemERP.dto.dg;

import java.time.LocalDateTime;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class InventoryDTO {
	private int inventory_his_no; // 재고변동이력번호
	private int item_status; // 제품/부품 구분
	private int item_no; // 제품/부품번호
	private int inout_status; // 입/출고 구분
	private LocalDateTime inout_date; // 입/출고일시
	private int item_cnt; // 수량
	private int item_quality; // 품질
}
