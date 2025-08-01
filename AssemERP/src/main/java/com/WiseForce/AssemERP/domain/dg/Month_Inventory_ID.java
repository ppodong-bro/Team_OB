package com.WiseForce.AssemERP.domain.dg;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class Month_Inventory_ID {
	private String yearmonth; // 년월
	private int startend_status; // 기초/기말 구분
	private int item_status; // 제품/부품 구분
	private int item_no; // 제품/부품번호
}
