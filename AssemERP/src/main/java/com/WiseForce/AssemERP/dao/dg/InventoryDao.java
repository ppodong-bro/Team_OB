package com.WiseForce.AssemERP.dao.dg;

import java.util.List;

import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

public interface InventoryDao {
	// 이번 월 기말재고의 종류 수 조회
	int getLastestMonthInventoryCnt(Real_InventoryDTO real_InventoryDTO);
	
	// 현재 재고 전체 조회 함수 실행
	List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO);

	// 월마감 패키지 실행
	void doMonthClose(String yearMonth, int empno);


}
