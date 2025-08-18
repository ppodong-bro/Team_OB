package com.WiseForce.AssemERP.service.dg;

import java.io.Console;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.WiseForce.AssemERP.dao.dg.InventoryDao;
import com.WiseForce.AssemERP.domain.dg.Common;
import com.WiseForce.AssemERP.domain.dg.Common_ID;
import com.WiseForce.AssemERP.domain.dg.Files;
import com.WiseForce.AssemERP.domain.dg.Inventory;
import com.WiseForce.AssemERP.domain.dg.Inventory_Adjust;
import com.WiseForce.AssemERP.domain.dg.Inventory_Close;
import com.WiseForce.AssemERP.domain.sh.Parts;
import com.WiseForce.AssemERP.dto.dg.InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.InventoryInfoDTO;
import com.WiseForce.AssemERP.dto.dg.Inventory_AdjustDTO;
import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.repository.dg.CommonRepository;
import com.WiseForce.AssemERP.repository.dg.EmpRepository;
import com.WiseForce.AssemERP.repository.dg.FilesRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryAdjustRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryCloseRepository;
import com.WiseForce.AssemERP.repository.dg.InventoryRepository;
import com.WiseForce.AssemERP.repository.sh.PartsRepository;
import com.WiseForce.AssemERP.service.sh.ProductService;
import com.WiseForce.AssemERP.util.CustomFileUtil;

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
	private final PartsRepository partsRepository;

	// 재고
	private final InventoryDao inventoryDao;
	private final InventoryRepository inventoryRepository;
	private final InventoryAdjustRepository inventoryAdjustRepository; // 재고 조정
	private final InventoryCloseRepository inventoryCloseRepository; // 월마감
	
	// 첨부파일
	private final FilesRepository filesRepository;
	private final CustomFileUtil fileUtil;

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

		// 첨부파일 초기화
		String uuid = null;
		// 첨부파일 존재 확인
		if(!inventoryInfoDTO.getFiles().isEmpty()) {
			// UUID 생성
			uuid = UUID.randomUUID().toString();
			
			// 파일들 모두 복사
			for(MultipartFile file : inventoryInfoDTO.getFiles()) {
				// 첨부파일 복사
				String filePath = fileUtil.saveFile(file, "adjust", uuid);
				
				// 테스트용 파일
				Files files = Files.builder()
						.files_path(filePath)
						.files_folder("adjust")
						.filesNo(uuid)
						.files_name(file.getOriginalFilename())
						.build();

				// 첨부파일 DB저장
				filesRepository.save(files);
			}
		}
		
		// 재고 조정 Entity 생성
		Inventory_Adjust inventory_Adjust = Inventory_Adjust.builder()
				.adjust_status(6) // 조정 구분 : 조정
				.item_status(target_InventoryInfoDTO.getItem_type())
				.item_no(target_InventoryInfoDTO.getItem_no())
				.inout_status(currCnt < nextCnt ? 0/*IN*/ : 1/*OUT*/)
				.item_cnt(Math.abs(currCnt - nextCnt))
				.inout_date(LocalDateTime.now())
				.item_close_status(2/*완료*/)
				.files_no(uuid)
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

	// 재고현황 조회
	@Override
	public List<Map<String, Object>> getInventoryCurrent() {
		List<Map<String, Object>> inventoryCurrnetList = inventoryDao.getInventoryCurrent();
		
		return inventoryCurrnetList;
	}

	// 판매에 필요한 재고 확인
	@Override
	public Map<PartsDTO, Integer> getRequirementsForSales(List<Sales_ItemDto> sales_ItemDtos) {
//		Map<ProductDTO, Integer> returnProductMap = new HashMap<ProductDTO, Integer>(); // 리턴용 필요한 제품 맵
		Map<PartsDTO, Integer> returnPartsMap = new HashMap<PartsDTO, Integer>(); // 리턴용 필요한 부품 맵

		// 필요한 부품들 총합
		Map<Integer, Integer> requirementsPartsMergeMap = new HashMap<Integer, Integer>();
		// 필요한 부품을 계산한다.
		for(Sales_ItemDto sales_ItemDto : sales_ItemDtos) {
			// 제품 하나에 필요한 부품을 가져온다.
			Map<Integer, Integer> requirementsPartsMap = inventoryDao.getRequirementsForProduct(sales_ItemDto);
			
			// 필요한 부품이 이미 있는지 확인
			for(Integer key : requirementsPartsMap.keySet()) {
				// 이미 있다.
				if(requirementsPartsMergeMap.containsKey(key)) {
					// 이미 있는 필요한 부품 개수에 +
					Integer totalCnt = requirementsPartsMergeMap.get(key) + requirementsPartsMap.get(key);
					
					requirementsPartsMergeMap.put(key, totalCnt);
				}
				// 없다
				else {
					// 새로 필요한 부품으로 추가
					requirementsPartsMergeMap.put(key, requirementsPartsMap.get(key));
				}
			}
		}

		// 현재 재고를 가져온다.
		for(Integer key : requirementsPartsMergeMap.keySet()) {
			// 실재고 조회를 위한 DTO
			InventoryInfoDTO inventoryInfoDTO = InventoryInfoDTO.builder().item_type(0/*부품*/).item_no(key).build();
			// 필요한 부품의 실재고
			int realCnt = inventoryDao.getInventoryInfoById(inventoryInfoDTO).getCnt();
			
			// 실재고 - 필요한 개수
			int diffCnt = realCnt - requirementsPartsMergeMap.get(key);
			
			// 부족하다면
			if(diffCnt < 0) {
				Optional<Parts> parts = partsRepository.findById(key);
				if (parts.isPresent()) {
					PartsDTO partsDTO = PartsDTO.chagePartsDTO(parts.get());
					
					// 리턴용 필요한 부품 맵에 추가
					returnPartsMap.put(partsDTO, (Integer)Math.abs(diffCnt));
				}
			}
		}

		// 나중에 parts_no로 데이터를 가져와서 DTO로 변환한 후 리턴할 수 있다.
		System.out.println(returnPartsMap);
		
		return returnPartsMap;
	}

}
