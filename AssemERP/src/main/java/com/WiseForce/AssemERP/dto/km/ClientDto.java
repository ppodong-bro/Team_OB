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
public class ClientDto {

	private int client_No;
	private String 			client_Name;
	private Integer			client_Gubun;
	private String  		client_Email;
	private String  		client_Man;
	private String  		client_Address;
	private int				del_Status;
	private LocalDateTime   modify_date;
	private LocalDateTime	in_date;
	private int				start;
	private int				end;
	private String			currentPage;
}