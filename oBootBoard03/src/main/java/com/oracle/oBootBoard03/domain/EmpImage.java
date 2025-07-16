package com.oracle.oBootBoard03.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

//독립적인 식별자(@Id)가 없음
//Emp 엔티티에 완전히 종속됨
//생명주기가 Emp 엔티티에 의존함
//@Embeddable 장점 
//간단한 구조: 복잡한 연관관계 없이 컬렉션 관리 가능
//자동 영속성 전이: Emp가 저장/삭제되면 EmpImage도 함께 저장/삭제됨

@Embeddable
@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class EmpImage {
	private int	   emp_no;
	private int    order_num;
	private String filename;
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	
}

