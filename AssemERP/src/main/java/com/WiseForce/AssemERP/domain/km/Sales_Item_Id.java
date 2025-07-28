package com.WiseForce.AssemERP.domain.km;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@Embeddable
public class Sales_Item_Id {
	private int sales_No;
	private int product_No;
}
