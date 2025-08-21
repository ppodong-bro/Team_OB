package com.WiseForce.AssemERP.repository.dg;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.WiseForce.AssemERP.dto.dg.InventoryDTO;

public interface InventoryRepository {

	// 입출고 이력의 총 수량 계산하는 프로시저 실행
	void execProcedureClacInventoryTot();

	// 입출고 이력 목록 조회
	int getInventoryHistoryCnt(InventoryDTO inventoryDTO);// 입출고 이력 목록 수 조회
	List<InventoryDTO> getInventoryHistory(InventoryDTO inventoryDTO);
}
