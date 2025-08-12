package com.WiseForce.AssemERP.dto.km;



import com.WiseForce.AssemERP.dto.sh.PartsDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Purchase_ItemDto {
	private int 		purchase_No;
	private int			parts_no;
	private int 		purchase_Item_Cnt;
	private int 		purchase_Item_InCnt;
	private Long 		purchase_Item_Cost;
	private Long 		purchase_Item_TotCost;
	private Long 		purchase_Item_TotInCost;
	private PartsDTO 	partsDTO;

}
