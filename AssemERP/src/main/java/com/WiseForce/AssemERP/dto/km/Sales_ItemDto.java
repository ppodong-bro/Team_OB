package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDateTime;

import com.WiseForce.AssemERP.dto.sh.ProductDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Sales_ItemDto {
	private int 			sales_No;
	private int 			product_No;
	private int				sales_Item_Cnt;
	private int	 			sales_Item_OutCnt;
	private int				sales_Item_WaitingCnt;
	private Long			sales_Item_Cost;
	private Long        	sales_Item_TotCost;
	private Long			sales_Item_TotOutCost;
	private ProductDTO 	productDto;
	
}
