package com.WiseForce.AssemERP.service.dg;

import java.util.List;

import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

public interface InventoryService {
	// 전체 재고의 종류 수 조회
	int getTotalTypeCount(int item_type);
	// 현재 재고 전체 조회
	List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO);

	// 월마감 실행
	boolean doMonthClose();

}
