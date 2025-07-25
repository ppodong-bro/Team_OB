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
@SequenceGenerator(
		name = "PRODUCT_COSTHIS_SEQ_GEN",
		sequenceName = "PRODUCT_COSTHIS_SEQ",
		initialValue = 1,
		allocationSize = 1
		)
public class Product_Costhis {
	@Id
	@GeneratedValue(
			generator = "PRODUCT_COSTHIS_SEQ_GEN",
			strategy = GenerationType.SEQUENCE
			)
	private int product_costhis_no;// 제품가격변동이력
	private int product_no;// 제품번호
	private LocalDateTime start_date;// 시작일자
	private LocalDateTime end_date;// 종료일자
	private long price;// 가격
}
