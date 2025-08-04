package com.WiseForce.AssemERP.service.dg;

import java.util.List;

import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;
import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

public interface InventoryService {
	// 전체 재고의 종류 수 조회
	int getTotalTypeCount(Real_InventoryDTO real_InventoryDTO);
	// 현재 재고 목록 조회
	List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO);

	// 월마감 이력 개수 조회
	int getInventoryCloseTotalCount(Inventory_CloseDTO inventory_CloseDTO);
	// 월마감 이력 목록 조회
	List<Inventory_CloseDTO> getInventoryCloseList(Inventory_CloseDTO inventory_CloseDTO);
	// 월마감 실행
	boolean doMonthClose(String yearMonth, int empno, int realStatus);

}
