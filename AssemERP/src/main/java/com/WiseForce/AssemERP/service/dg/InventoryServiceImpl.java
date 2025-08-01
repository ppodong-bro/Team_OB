package com.WiseForce.AssemERP.service.dg;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.dg.InventoryDao;
import com.WiseForce.AssemERP.domain.dg.Common;
import com.WiseForce.AssemERP.domain.dg.Common_ID;
import com.WiseForce.AssemERP.domain.dg.Inventory_Close;
import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.repository.dg.CommonRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryCloseRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class InventoryServiceImpl implements InventoryService {
	private final ModelMapper modelMapper;
	// 공통
	private final CommonRepository commonRepository;

	// 재고
	private final InventoryRepository inventoryRepository;
	private final InventoryDao inventoryDao;

	// 월마감
	private final InventoryCloseRepository inventoryCloseRepository;

	// 전체 재고의 종류 수 조회
	@Override
	public int getTotalTypeCount(Real_InventoryDTO real_InventoryDTO) {
		// 이번 월 기말재고의 종류 수 조회
		int totalTypeCount = inventoryDao.getLastestMonthInventoryCnt(real_InventoryDTO);

		return totalTypeCount;
	}

	// 현재 재고 전체 조회
	@Override
	public List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO) {
		// 현재 재고 전체 조회 함수 실행
		List<Real_InventoryDTO> real_InventoryDTOs = inventoryDao.getRealInventory(real_InventoryDTO);

		System.out.println(real_InventoryDTOs);

		return real_InventoryDTOs;
	}

	// 월마감 이력 개수 조회
	@Override
	public int getInventoryCloseTotalCount(Inventory_CloseDTO inventory_CloseDTO) {
		int totalCount = inventoryCloseRepository.totalCount(inventory_CloseDTO);

		return totalCount;
	}

	// 월마감 이력 목록 조회
	@Override
	public List<Inventory_CloseDTO> getInventoryCloseList(Inventory_CloseDTO inventory_CloseDTO) {
		// 월마감 이력 목록 조회
		List<Inventory_Close> inventory_Closes = inventoryCloseRepository.findAllBySearch(inventory_CloseDTO);

		// Entity -> DTO
		List<Inventory_CloseDTO> inventory_CloseDTOs = inventory_Closes.stream()
				.map(entity -> Inventory_CloseDTO.builder()
					.yearmonth(entity.getYearmonth())
					.close_status(entity.getClose_status())
					// LocalDateTime -> String
					.close_startdate(entity.getClose_startdate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
					.close_enddate(entity.getClose_enddate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
					.emp_no(entity.getEmp_no())
					.build())
					.collect(Collectors.toList());
		
		return inventory_CloseDTOs;
	}

	// 월마감 실행
	@Override
	public boolean doMonthClose(String yearMonth, int empno) {
		// 월마감 패키지 실행
		return inventoryDao.doMonthClose(yearMonth, empno);
	}

}
