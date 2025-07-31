package com.WiseForce.AssemERP.domain.dg;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class Common_ID {
	private int big_status;// 대분류
	private int middle_status;// 중분류
}
