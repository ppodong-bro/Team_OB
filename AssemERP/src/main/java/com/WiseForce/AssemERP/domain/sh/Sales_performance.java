package com.WiseForce.AssemERP.domain.sh;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Sales_performance {
	@Id
	private String yearmonth;
	private int cnt;
	private int total;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "poduct_no")
	private Product product;
	
	
}