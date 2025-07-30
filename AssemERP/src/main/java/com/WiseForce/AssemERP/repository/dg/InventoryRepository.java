package com.WiseForce.AssemERP.repository.dg;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.WiseForce.AssemERP.domain.dg.Month_Inventory;
import com.WiseForce.AssemERP.domain.dg.Month_Inventory_ID;

public interface InventoryRepository extends JpaRepository<Month_Inventory, Month_Inventory_ID> {
	// 이번 월 기초재고 조회 : 가장 최신 기초재고 조회
	// 도건 : yearmonth는 Month_Inventory_ID에 있는 데이터이기 떄문에 추가로 지정해주어야 한다.
	@Query("SELECT mi0 FROM Month_Inventory mi0 "
			+ "WHERE mi0.id.yearmonth = (SELECT MAX(mi1.id.yearmonth) FROM Month_Inventory mi1) "
			+ "AND mi0.id.startend_status = 0")
	List<Month_Inventory> getLastestMonthInventory();
}
