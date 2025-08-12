package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Purchase_OrderSearchDto {
	private String 		client_Name;
	private String 		empName;
	private Integer	   	in_Status;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate   purchase_Date_Start;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate	purchase_Date_End;
	
	private int				start;
	private int				end;
	private String 			currentPage;
}
