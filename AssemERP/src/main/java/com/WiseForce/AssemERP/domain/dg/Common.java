package com.WiseForce.AssemERP.domain.dg;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Common {
	@EmbeddedId
	// 대분류
	// 중분류
	Common_ID common_ID;
	
	private String context;// 내용
}
