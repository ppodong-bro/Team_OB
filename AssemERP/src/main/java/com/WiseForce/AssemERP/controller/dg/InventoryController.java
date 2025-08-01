package com.WiseForce.AssemERP.controller.dg;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.WiseForce.AssemERP.domain.dg.Month_Inventory;
import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;
import com.WiseForce.AssemERP.service.dg.InventoryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InventoryController {

	private final InventoryService inventoryService;

	@GetMapping("/inventory")
	public String inventory(Model model) { // 현재 재고 목록
		// 현재 재고 전체 조회
		List<Real_InventoryDTO> real_InventoryDTOs = inventoryService.getRealInventory();
		
//		System.out.println(real_InventoryDTOs);

		model.addAttribute("realInventoryList", real_InventoryDTOs);
		
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
