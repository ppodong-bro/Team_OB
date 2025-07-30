package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Sales_OrderDto {
	private int 				sales_No;
	private int 				client_No;
	private int 				emp_No;
	private LocalDateTime 		sales_Date;
	private int 				out_Status;
	private int 				del_Status;
	private LocalDateTime 		in_Date;
	private List<Sales_ItemDto> sales_Item;
	private ClientDto 			clientDto;
}
