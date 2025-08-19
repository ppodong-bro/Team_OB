package com.WiseForce.AssemERP.controller.dg;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.WiseForce.AssemERP.dto.dg.InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.InventoryInfoDTO;
import com.WiseForce.AssemERP.dto.dg.Inventory_CloseDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.service.dg.InventoryService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InventoryController {

	private final InventoryService inventoryService;

	@GetMapping("/inventory")
	public String inventory(Real_InventoryDTO real_InventoryDTO, Model model) {
		// 현재 재고의 종류 수 조회
		int totalTypeCount = inventoryService.getTotalTypeCount(real_InventoryDTO);
		
		// 전체 개수와 요청한 현재 페이지를 토대로 start와 end를 설정한다.
		Paging page = new Paging(totalTypeCount, real_InventoryDTO.getCurrentPage());
		real_InventoryDTO.setStart(page.getStart());
		real_InventoryDTO.setEnd(page.getEnd());

		// 설정한 start, end로 현재 재고 전체 조회
		List<Real_InventoryDTO> real_InventoryDTOs = inventoryService.getRealInventory(real_InventoryDTO);

		model.addAttribute("search", real_InventoryDTO);
		model.addAttribute("realInventoryList", real_InventoryDTOs);
		model.addAttribute("paging", page);

		// 재고 관리 화면 이동
		return "dg/inventoryList";
	}
	
	@GetMapping("/inventory/adjust")
	public String inventoryAdjust_Get(InventoryInfoDTO inventoryInfoDTO, Model model) {
		// 재고 정보 조회하기(item_type, item_no만 사용)
		InventoryInfoDTO target_InventoryInfoDTO = inventoryService.getRealInventoryById(inventoryInfoDTO);
		
		model.addAttribute("inventory", target_InventoryInfoDTO);
		
		// 재고 조정 화면 이동
		return "dg/inventoryAdjust";
	}

	@PostMapping("/inventory/adjust")
	public String inventoryAdjust_Post(@ModelAttribute/*MultipartFile를 포함한 DTO에 넣기 위한 @*/ InventoryInfoDTO inventoryInfoDTO, Model model) {
		// 재고 실 수량 조정
		boolean result = inventoryService.adjustRealInventoryById(inventoryInfoDTO);
		
		// PostMapping은 redirect로 재고 조정 화면 이동
		return "redirect:/inventory";
	}
	
	@GetMapping("/inventory/history")
	public String inventoryHistory(InventoryDTO inventoryDTO, Model model) {
		// 검색을 위한 기본 설정을 정해준다.
		// 입출고일시
		LocalDate localDate_start = inventoryDTO.getStartDate() != null ? inventoryDTO.getStartDate() : LocalDate.now().minusMonths(1).withDayOfMonth(1);//이전달 1일
		inventoryDTO.setStartDate(localDate_start);
		LocalDate localDate_end = inventoryDTO.getEndDate() != null ? inventoryDTO.getEndDate() : LocalDate.now();
		inventoryDTO.setEndDate(localDate_end);
				
		// 재고 입출고 이력의 수 조회
		int totalCount = inventoryService.getInventoryHistoryCnt(inventoryDTO);

		// 전체 개수와 요청한 현재 페이지를 토대로 start와 end를 설정한다.
		Paging page = new Paging(totalCount, inventoryDTO.getCurrentPage());
		inventoryDTO.setStart(page.getStart());
		inventoryDTO.setEnd(page.getEnd());

		// 설정한 start, end로 현재 재고 전체 조회
		List<InventoryDTO> inventoryDTOs = inventoryService.getInventoryHistory(inventoryDTO);

		model.addAttribute("search", inventoryDTO);
		model.addAttribute("InventoryHistoryList", inventoryDTOs);
		model.addAttribute("paging", page);
		
		// 재고 관리 화면 이동
		return "dg/inventoryHistoryList";
	}
	
	@GetMapping("/inventory/close")
	public String inventoryClose(Inventory_CloseDTO inventory_CloseDTO, Model model) {
		// 검색을 위한 기본 설정을 정해준다.
		// 기본 날짜
		String default_yearmonth_start = LocalDate.now().minusMonths(1).format(DateTimeFormatter.ofPattern("yyMM"));//이전달
		String default_yearmonth_end = LocalDate.now().plusMonths(1).format(DateTimeFormatter.ofPattern("yyMM"));//다음달
		// 년월 예시
		inventory_CloseDTO.setSample_yearmonth_start_text(default_yearmonth_start);
		inventory_CloseDTO.setSample_yearmonth_end_text(default_yearmonth_end);
		// 년월
		String yearmonth_start = (inventory_CloseDTO.getYearmonth_start_text() != null && inventory_CloseDTO.getYearmonth_start_text() != "") ? inventory_CloseDTO.getYearmonth_start_text() : default_yearmonth_start;
		inventory_CloseDTO.setYearmonth_start_text(yearmonth_start);
		String yearmonth_end = (inventory_CloseDTO.getYearmonth_end_text() != null && inventory_CloseDTO.getYearmonth_end_text() != "") ? inventory_CloseDTO.getYearmonth_end_text() : default_yearmonth_end;
		inventory_CloseDTO.setYearmonth_end_text(yearmonth_end);
		// 마감일
		LocalDate localDate_start = inventory_CloseDTO.getStartDate() != null ? inventory_CloseDTO.getStartDate() : LocalDate.now().minusMonths(1).withDayOfMonth(1);//이전달 1일
		inventory_CloseDTO.setStartDate(localDate_start);
		LocalDate localDate_end = inventory_CloseDTO.getEndDate() != null ? inventory_CloseDTO.getEndDate() : LocalDate.now();
		inventory_CloseDTO.setEndDate(localDate_end);
		
		// 월마감 이력 개수 조회
		int totalCount = inventoryService.getInventoryCloseTotalCount(inventory_CloseDTO);

		// 전체 개수와 요청한 현재 페이지를 토대로 start와 end를 설정한다.
		Paging page = new Paging(totalCount, inventory_CloseDTO.getCurrentPage());
		inventory_CloseDTO.setStart(page.getStart());
		inventory_CloseDTO.setEnd(page.getEnd());

		// 설정한 start, end로 월마감 이력 조회
		List<Inventory_CloseDTO> inventory_CloseDTOs = inventoryService.getInventoryCloseList(inventory_CloseDTO);

		model.addAttribute("search", inventory_CloseDTO);
		model.addAttribute("inventoryCloseList", inventory_CloseDTOs);
		model.addAttribute("paging", page);

		// 월마감 이력 화면 이동
		return "dg/inventoryCloseList";
	}

	@PutMapping("/inventory/monthClose/{real_status}")
	@ResponseBody
	public Map<String, Object> monthClose(@RequestBody Inventory_CloseDTO inventory_CloseDTO, @PathVariable("real_status") int realStatus) {
		System.out.println(inventory_CloseDTO.getEmp_password());
		
		// 월마감 실행
		boolean result = inventoryService.doMonthClose(inventory_CloseDTO.getYearmonth(), inventory_CloseDTO.getEmp_no(), realStatus);
		
		Map<String, Object> response = new HashMap<>();
	    response.put("result", String.valueOf(result));
	    
	    System.out.println(response);
		
		return response;
	}

	@DeleteMapping("/inventory/monthClose")
	@ResponseBody
	public Map<String, Object> monthCloseCancel(@RequestBody Inventory_CloseDTO inventory_CloseDTO) {
		System.out.println(inventory_CloseDTO.getEmp_password());
		
		// 월마감 취소 진행
//		boolean result = inventoryService.doMonthCloseCancel(inventory_CloseDTO.getYearmonth());
		
		Map<String, Object> response = new HashMap<>();
	    response.put("result", String.valueOf(false));
	    
	    System.out.println(response);
		
		return response;
	}

	@GetMapping("/inventory/excel")
	@ResponseBody
	public Object inventoryExcelDownload(Real_InventoryDTO real_InventoryDTO) {
		// 현재 재고의 종류 수 조회
		int totalTypeCount = inventoryService.getTotalTypeCount(real_InventoryDTO);

		// 전체 개수와 요청한 현재 페이지를 토대로 start와 end를 설정한다.
		Paging page = new Paging(totalTypeCount, real_InventoryDTO.getCurrentPage());
		real_InventoryDTO.setStart(1);
		real_InventoryDTO.setEnd(totalTypeCount);

		// 설정한 start, end로 현재 재고 전체 조회
		List<Real_InventoryDTO> real_InventoryDTOs = inventoryService.getRealInventory(real_InventoryDTO);

	    List<Map<String, Object>> excelData = real_InventoryDTOs.stream()
	        .map(datas -> {
	            Map<String, Object> row = new LinkedHashMap<>(); // 순서 유지를 위해 LinkedHashMap 사용
	            row.put("재고번호", datas.getItem_no());
	            row.put("재고구분", datas.getItem_status());
	            row.put("재고명", datas.getItem_name());
	            row.put("수량", datas.getCnt());
	            // 필요한 다른 필드들도 여기에 추가
	            return row;
	        })
	        .collect(Collectors.toList());
		
		return excelData;
	}
}
