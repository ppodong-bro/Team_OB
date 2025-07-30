package com.WiseForce.AssemERP.dto.dg;

import lombok.Data;

@Data
public class Real_InventoryDTO {
	private int item_no;// 재고 번호
	private String item_status;// 재고 분류
	private String item_name;// 재고 명
	private int cnt;// 수량
	private int proper_cnt;// 적정 수량
	private int diff_cnt;// 편차 수량
}
