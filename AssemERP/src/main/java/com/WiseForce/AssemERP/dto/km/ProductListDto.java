package com.WiseForce.AssemERP.dto.km;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductListDto {
	private int product_no;
	private String	product_name;
	private int	product_price;
}
