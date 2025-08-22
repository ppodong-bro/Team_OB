package com.WiseForce.AssemERP.dto.sh;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ClientPerformanceDTO {

	private int client_no;
	private String client_name;
	private Integer totalcost;
	private String each_month;
}
