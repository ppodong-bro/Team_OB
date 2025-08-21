package com.WiseForce.AssemERP.domain.dg;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
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
@SequenceGenerator(name = "INVENTORY_ADJUST_SEQ_GEN", sequenceName = "INVENTORY_ADJUST_SEQ", initialValue = 1, allocationSize = 1)
public class Inventory_Adjust {
	@Id
	@GeneratedValue(generator = "INVENTORY_ADJUST_SEQ_GEN", strategy = GenerationType.SEQUENCE)
	private int inventory_adjust_no; // 재고조정번호
	private int adjust_status; // 조정 구분
	private int item_status; // 제품/부품 구분
	private int item_no; // 제품/부품번호
	private int inout_status; // 입/출고 구분
	private int item_cnt; // 변동 수량
	@Column(nullable = true)
	private String filesNo;
	private LocalDateTime inout_date; // 입/출고일시
	private int item_close_status; // 마감 구분
}
