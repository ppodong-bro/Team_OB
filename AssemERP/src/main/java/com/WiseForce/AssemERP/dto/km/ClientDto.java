package com.WiseForce.AssemERP.dto.km;

import java.time.LocalDateTime;
import java.util.List;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ClientDto {

	private int 			client_No;
	private EmpDTO			empDTO;
	private String 			client_Name;
	private Integer			client_Gubun;
	private String  		client_Email;
	private String  		client_Man;
	private String  		client_Address;
	private String			client_Tel;
	private int				del_Status;
	private LocalDateTime   modify_Date;
	private LocalDateTime	in_Date;
	private int				start;
	private int				end;
	private String			currentPage;
	private String			context;
	
}