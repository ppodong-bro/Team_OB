package com.WiseForce.AssemERP.domain.dg;

import java.time.LocalDateTime;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Month_Inventory {
	@EmbeddedId
	// 년월
	// 기초/기말 구분
	// 제품/부품 구분
	// 제품/부품번호
	Month_Inventory_ID month_Inventory_ID;

	int cnt;// 수량
	LocalDateTime in_date;// 등록일자
}
