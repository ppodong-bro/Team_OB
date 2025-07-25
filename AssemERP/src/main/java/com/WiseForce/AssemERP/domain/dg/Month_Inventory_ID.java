package com.WiseForce.AssemERP.domain.dg;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class Month_Inventory_ID {
	private String YEARMONTH; // 년월
	private int STARTEND_STATUS; // 기초/기말 구분
	private int ITEM_STATUS; // 제품/부품 구분
	private int ITEM_NO; // 제품/부품번호
}
