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

	private int client_no;
	private String 			client_name;
	private int 			client_gubun;
	private String  		client_email;
	private String  		client_man;
	private String  		client_address;
	private int				del_statis;
	private LocalDateTime   modify_date;
	private LocalDateTime	in_date;
	private int				start;
	private int				end;
}