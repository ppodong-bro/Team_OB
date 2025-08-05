package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

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
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate   sales_Date_Start;
	 
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate	sales_Date_End;
	
	private int				start;
	private int				end;
	private String 			currentPage;
}
