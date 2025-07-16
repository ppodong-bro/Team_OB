package com.oracle.oBootBoard03.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Emp_picDto {
	private int emp_no;
	private int order_num;
	private String filename;
	
}
