package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDateTime;
import java.util.List;

import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

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
	private EmpDTO				empDTO;
	private String				empName;
	private LocalDateTime 		sales_Date;
	private int 				out_Status;
	private int 				del_Status;
	private LocalDateTime 		in_Date;
	private List<Sales_ItemDto> sales_Item;
	private ClientDto			clientDto;
	
	private String				currentPage;
	private int					start;
	private int					end;
}
