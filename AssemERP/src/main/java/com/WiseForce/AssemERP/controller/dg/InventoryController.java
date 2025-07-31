package com.WiseForce.AssemERP.controller.dg;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.WiseForce.AssemERP.domain.dg.Month_Inventory;
import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.service.dg.InventoryService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InventoryController {

	private final InventoryService inventoryService;

	@GetMapping("/inventory")
	public String inventory(Real_InventoryDTO real_InventoryDTO, Model model) {
//		System.out.println(real_InventoryDTO);
		
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
		model.addAttribute("page", page);
		
		// 인벤토리 화면 이동
		return "dg/inventoryList";
	}
	
	@PutMapping("/inventory/monthClose")
	public String monthClose() {
		System.out.println("월마감 시작합니다.");
		// 월마감 실행
		boolean result = inventoryService.doMonthClose();

		return "";
	}

}
