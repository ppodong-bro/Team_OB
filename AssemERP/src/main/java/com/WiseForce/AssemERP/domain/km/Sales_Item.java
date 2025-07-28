package com.WiseForce.AssemERP.domain.km;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "SALES_ITEM")
@Getter
@Setter
@NoArgsConstructor  // JPA용 기본 생성자
public class Sales_Item {
	   
	@EmbeddedId
	private Sales_Item_Id 	 sales_Item_Id;
	private int  			 sales_Item_Cnt;
	private int   			 sales_Item_Outcnt;
	private Long  			 sales_Item_Cost;
}
