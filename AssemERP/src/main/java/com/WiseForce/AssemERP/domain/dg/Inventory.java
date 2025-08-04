package com.WiseForce.AssemERP.domain.dg;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@SequenceGenerator(name = "INVENTORY_SEQ_GEN", sequenceName = "INVENTORY_SEQ", initialValue = 1, allocationSize = 1)
public class Inventory {
	@Id
	@GeneratedValue(generator = "INVENTORY_SEQ_GEN", strategy = GenerationType.SEQUENCE)
	private int inventory_his_no; // 재고변동이력번호
	private int order_status;//수주(0),발주(1) 구분
	private int order_no;//수주,발주 번호
	private int item_status; // 부품(0)/제품(1) 구분
	private int item_no; // 부품/제품번호
	private int inout_status; // 입/출고 구분
	private LocalDateTime inout_date; // 입/출고일시
	private int item_cnt; // 수량
	private int item_quality; // 품질

}
