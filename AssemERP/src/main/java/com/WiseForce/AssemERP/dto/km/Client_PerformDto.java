package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Client_PerformDto {
	private String 			yearMonth;
	private LocalDateTime 	dYearMonth;
	private int				client_No;
	private Long		    cnt;
	private Long			total_Amt;
}
