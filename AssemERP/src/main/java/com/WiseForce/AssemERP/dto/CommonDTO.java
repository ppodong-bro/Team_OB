package com.WiseForce.AssemERP.dto;

import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

import lombok.Data;

@Data
public class CommonDTO {
	private int big_status;// 대분류
	private int middle_status;// 중분류
	private String context;// 내용
	
	
}

