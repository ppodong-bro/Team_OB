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
		name = "INVENTORY_SEQ_GEN",
		sequenceName = "INVENTORY_SEQ",
		initialValue = 1,
		allocationSize = 1
		)
public class Inventory {
	@Id
	@GeneratedValue(
			generator = "INVENTORY_SEQ_GEN",
			strategy = GenerationType.SEQUENCE
			)
	private int inventory_his_no;
	private int item_status;
	private int item_no;
	private int inout_status;
	private LocalDateTime inout_date;
	private int item_cnt;
	private int item_quality;
}
