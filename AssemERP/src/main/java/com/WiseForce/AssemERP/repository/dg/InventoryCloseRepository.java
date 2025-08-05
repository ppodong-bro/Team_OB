package com.WiseForce.AssemERP.repository.dg;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.WiseForce.AssemERP.domain.dg.Inventory_Close;
import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;

public interface InventoryCloseRepository {

	// 월마감 이력 개수 조회
	int totalCount(Inventory_CloseDTO inventory_CloseDTO);

	// 월마감 이력 목록 조회
	List<Inventory_Close> findAllBySearch(Inventory_CloseDTO inventory_CloseDTO);
	
	
}
