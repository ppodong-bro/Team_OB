package com.WiseForce.AssemERP.service.dg;

import java.util.List;

import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;

public interface InventoryService {

	List<Month_InventoryDTO> getList();

	// 이번 월 기초재고 조회 : 가장 최신 기초재고 조회
	List<Month_InventoryDTO> getCurrentList();

}
