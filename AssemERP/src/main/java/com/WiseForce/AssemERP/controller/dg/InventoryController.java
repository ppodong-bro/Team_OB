package com.WiseForce.AssemERP.controller.dg;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.WiseForce.AssemERP.domain.dg.Month_Inventory;
import com.WiseForce.AssemERP.dto.dg.Month_InventoryDTO;
import com.WiseForce.AssemERP.service.dg.InventoryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InventoryController {
	private final InventoryService inventoryService;

	@GetMapping("/inventory")
	public String inventory(Model model) {
		// 현재 재고 목록 조회
		List<Month_InventoryDTO> month_Inventories = inventoryService.getCurrentList();

		model.addAttribute("month_Inventories", month_Inventories);

		// 인벤토리 화면 이동
		return "dg/inventoryList";
	}

	@PutMapping("/inventory/monthClose")
	public String monthClose() {
		System.out.println("월마감 시작합니다.");
		
		return "";
	}

}
