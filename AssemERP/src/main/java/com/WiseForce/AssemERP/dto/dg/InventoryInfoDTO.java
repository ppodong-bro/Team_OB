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
public class InventoryInfoDTO {
	private int item_type; // 부품/제품 구분
	private int item_no; // 재고 번호
	private int item_status; // 재고 구분
	private String item_name; // 재고 명
	private int cnt; // 재고 수량 
	
	private int item_adjustcnt; // 조정 재고 수량
}
