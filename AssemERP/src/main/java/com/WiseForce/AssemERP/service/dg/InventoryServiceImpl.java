package com.WiseForce.AssemERP.service.dg;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.dg.InventoryDao;
import com.WiseForce.AssemERP.domain.dg.Month_Inventory;
import com.WiseForce.AssemERP.domain.dg.Month_Inventory_ID;
import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.repository.dg.InventoryRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class InventoryServiceImpl implements InventoryService {
	private final InventoryRepository inventoryRepository;
	private final ModelMapper modelMapper;

	private final InventoryDao inventoryDao;

	// 전체 재고의 종류 수 조회
	@Override
	public int getTotalTypeCount(int item_type) {
		// 이번 월 기말재고의 종류 수 조회
		int totalTypeCount = inventoryRepository.getLastestMonthInventoryCnt(item_type);
		
		return totalTypeCount;
	}

	// 현재 재고 전체 조회
	@Override
	public List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO) {
		//조회시 페이지 고려
		
		// 현재 재고 전체 조회 함수 실행
//		List<Real_InventoryDTO> real_InventoryDTOs = inventoryDao.getRealInventory();
		List<Real_InventoryDTO> real_InventoryDTOs = inventoryDao.getRealInventory(real_InventoryDTO);

		return real_InventoryDTOs;
	}

	// 월마감 실행
	@Override
	public boolean doMonthClose() {
		// 오늘 YYMM, 실행 사원ID 필요
		LocalDate today = LocalDate.now();
		String yearMonth = today.format(DateTimeFormatter.ofPattern("yy-MM"));
		int empno = 1001;

		// 월마감 패키지 실행
//		inventoryDao.doMonthClose(yearMonth, empno);

		return true;
	}

}
