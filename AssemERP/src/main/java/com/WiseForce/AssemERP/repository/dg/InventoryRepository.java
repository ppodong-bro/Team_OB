package com.WiseForce.AssemERP.repository.dg;

import java.util.List;

import com.WiseForce.AssemERP.domain.dg.Inventory;
import com.WiseForce.AssemERP.dto.dg.InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

public interface InventoryRepository {

	// 재고 입출고 이력의 총 수량 계산하는 프로시저 실행
	void execProcedureClacInventoryTot();

	// 재고 입출고 이력 목록 조회
	int getInventoryHistoryCnt(InventoryDTO inventoryDTO);// 재고 입출고 이력 목록 수 조회
	List<InventoryDTO> getInventoryHistory(InventoryDTO inventoryDTO);
}
