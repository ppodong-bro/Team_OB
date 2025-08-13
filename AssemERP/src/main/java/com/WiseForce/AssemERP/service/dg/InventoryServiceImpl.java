package com.WiseForce.AssemERP.service.dg;

import java.io.Console;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.dg.InventoryDao;
import com.WiseForce.AssemERP.domain.dg.Common;
import com.WiseForce.AssemERP.domain.dg.Common_ID;
import com.WiseForce.AssemERP.domain.dg.Inventory;
import com.WiseForce.AssemERP.domain.dg.Inventory_Adjust;
import com.WiseForce.AssemERP.domain.dg.Inventory_Close;
import com.WiseForce.AssemERP.dto.dg.InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.InventoryInfoDTO;
import com.WiseForce.AssemERP.dto.dg.Inventory_AdjustDTO;
import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.repository.dg.CommonRepository;
import com.WiseForce.AssemERP.repository.dg.EmpRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryAdjustRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryCloseRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class InventoryServiceImpl implements InventoryService {
	private final ModelMapper modelMapper;
	// 외부
	private final CommonRepository commonRepository;
	private final EmpRepository empRepository;

	// 재고
	private final InventoryDao inventoryDao;
	private final InventoryRepository inventoryRepository;
	private final InventoryAdjustRepository inventoryAdjustRepository; // 재고 조정
	private final InventoryCloseRepository inventoryCloseRepository; // 월마감

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

		return real_InventoryDTOs;
	}

	// 재고 상세 조회
	@Override
	public InventoryInfoDTO getRealInventoryById(InventoryInfoDTO inventoryInfoDTO) {
		// 상세 정보 가져오기
		InventoryInfoDTO target_InventoryInfoDTO = inventoryDao.getInventoryInfoById(inventoryInfoDTO);
		
		return target_InventoryInfoDTO;
	}
	
	// 재고 실 수량 조정
	@Override
	public boolean adjustRealInventoryById(InventoryInfoDTO inventoryInfoDTO) {
		int currCnt = inventoryInfoDTO.getCnt();
		int nextCnt = inventoryInfoDTO.getItem_adjustcnt();
		
		// 상세 정보 가져오기
		InventoryInfoDTO target_InventoryInfoDTO = inventoryDao.getInventoryInfoById(inventoryInfoDTO);
		
		System.out.println(inventoryInfoDTO);
		System.out.println(target_InventoryInfoDTO);
		System.out.println(currCnt < nextCnt ? 0/*IN*/ : 1/*OUT*/);
		System.out.println(Math.abs(currCnt - nextCnt));
		
		// 재고 조정 Entity 생성
		Inventory_Adjust inventory_Adjust = Inventory_Adjust.builder()
				.adjust_status(6) // 조정 구분 : 조정
				.item_status(target_InventoryInfoDTO.getItem_type())
				.item_no(target_InventoryInfoDTO.getItem_no())
				.inout_status(currCnt < nextCnt ? 0/*IN*/ : 1/*OUT*/)
				.item_cnt(Math.abs(currCnt - nextCnt))
				.inout_date(LocalDateTime.now())
				.item_close_status(2/*완료*/)
				.build();

		// 재고 조정 Entity 저장
		inventoryAdjustRepository.save(inventory_Adjust);
		
		return true;
	}

	// 재고 입출고 이력 목록 수 조회
	@Override
	public int getInventoryHistoryCnt(InventoryDTO inventoryDTO) {
		// 조회전 : 재고 입출고 이력의 총 수량 계산하는 프로시저 실행
		inventoryRepository.execProcedureClacInventoryTot();
		
		// 재고 입출고 이력 목록 수 조회
		int inventories = inventoryRepository.getInventoryHistoryCnt(inventoryDTO);
		
		return inventories;
	}
	// 재고 입출고 이력 목록 조회
	@Override
	public List<InventoryDTO> getInventoryHistory(InventoryDTO inventoryDTO) {
		// 재고 입출고 이력 목록 조회
		List<InventoryDTO> inventoryDTOs = inventoryRepository.getInventoryHistory(inventoryDTO);
		
		return inventoryDTOs;
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
					.emp_no_text(empRepository.getEmpNameFromEmpNo(entity.getEmp_no()))
					.build())
					.collect(Collectors.toList());
		
		return inventory_CloseDTOs;
	}

	// 월마감 실행
	@Override
	public boolean doMonthClose(String yearMonth, int empno, int realStatus) {
		// 월마감 패키지 실행
		return inventoryDao.doMonthClose(yearMonth, empno, realStatus);
	}

}
