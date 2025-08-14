package com.WiseForce.AssemERP.controller;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.WiseForce.AssemERP.service.dg.InventoryService;
import com.WiseForce.AssemERP.service.km.ClientService;
import com.WiseForce.AssemERP.service.sh.PartsService;
import com.WiseForce.AssemERP.service.sh.PerformenceService;
import com.WiseForce.AssemERP.service.sh.ProductService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final PerformenceService performenceService;
	private final InventoryService inventoryService;
	
	@GetMapping("/")
	public String mainPage(Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("mainPage Strart...");
		
		// 연간실적 그래프
		List<BigDecimal> yearsperformPurchasedata = performenceService.getPurchaseData();
		List<BigDecimal> yearsperformSaledata = performenceService.getSaleData();
		List<String> yearsperformlabels =  IntStream.rangeClosed(1, 12)
										             .mapToObj(i -> String.format("%d월", i))
										             .collect(Collectors.toList());
		
		model.addAttribute("yearsperformPurchasedata", mapper.writeValueAsString(yearsperformPurchasedata));
		model.addAttribute("yearsperformSaledata", mapper.writeValueAsString(yearsperformSaledata));
		model.addAttribute("yearsperformlabels", mapper.writeValueAsString(yearsperformlabels));
		
		
		
		// 거래처 실적 그래프
		
		List<Integer> bardata = performenceService.getClientTotalCost();
		List<String> barlabels = performenceService.getClientName();
		
		
		
		model.addAttribute("bardata", mapper.writeValueAsString(bardata));
		model.addAttribute("barlabels", mapper.writeValueAsString(barlabels));

		// 재고현황 그래프
		List<Map<String, Object>> inventoryCurrent = inventoryService.getInventoryCurrent();
//		System.out.println(inventoryCurrent);
        model.addAttribute("inventoryCurrent", mapper.writeValueAsString(inventoryCurrent)); // 자바 객체를 JSON 문자열로 변환

		return "main"; // src/main/webapp/WEB-INF/views/main.jsp
	}

	
}
