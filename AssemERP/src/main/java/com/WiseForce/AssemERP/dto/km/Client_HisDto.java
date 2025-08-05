package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDateTime;

import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Client_HisDto {
	private int    client_No;
	private String start_Date;
	private String end_Date;
	private int    emp_No;
	private String client_Name;
	private int	   client_Gubun;
	private String client_Man;
	private String client_Email;
	private String client_Tel;
	private String client_Address;
	
}
