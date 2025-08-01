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
public class Sales_OrderSearchDto {
	private String 		client_Name;
	private String 		empName;
	private Integer	   	out_Status;
	
	private int				start;
	private int				end;
	private String 			currentPage;
}
