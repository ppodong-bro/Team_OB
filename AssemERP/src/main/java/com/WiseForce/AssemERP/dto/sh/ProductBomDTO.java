package com.WiseForce.AssemERP.dto.sh;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ProductBomDTO {

	private int product_no;
	private Integer parts_no;
	private Integer cnt;
	
	
	// 이름전환
	private String product_name;
	private String parts_name;
	
	// 파츠분류
	private int parts_status;
	private String parts_statusName;
}
