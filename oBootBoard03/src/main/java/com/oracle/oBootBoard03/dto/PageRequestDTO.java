package com.oracle.oBootBoard03.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

// 상속관계에서도 부모class 필드를 자식 Class Builder에서 설정 가능
// 부모/자식 둘다 @SuperBuilder 지정 
@Data
@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class PageRequestDTO {
	@Builder.Default
	private int page = 1;

	@Builder.Default
	private int size = 10;
	  
	private int start;
	private int end;

}
