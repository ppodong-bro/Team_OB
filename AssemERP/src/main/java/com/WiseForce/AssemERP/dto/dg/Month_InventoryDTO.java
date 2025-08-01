package com.WiseForce.AssemERP.dto.dg;

import java.time.LocalDateTime;

import com.WiseForce.AssemERP.domain.dg.Month_Inventory_ID;

import lombok.Data;
import lombok.ToString;

@Data
public class Month_InventoryDTO {
	Month_Inventory_ID month_Inventory_ID;

	int cnt;// 수량
	LocalDateTime in_date;// 등록일자
}
