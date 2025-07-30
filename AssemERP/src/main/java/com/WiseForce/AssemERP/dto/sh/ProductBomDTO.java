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
	private int parts_no;
	private int cnt;
}
