package com.WiseForce.AssemERP.controller;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
	@GetMapping("/")
	public String mainPage(Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("mainPage Strart...");
		
		// 연간실적 그래프
		List<BigDecimal> yearsperformPurchasedata = performenceService.getPurchaseData();
		List<Integer> yearsperformSaledata = Arrays.asList(380, 200, 450, 250, 300, 500);
		List<String> yearsperformlabels =  IntStream.rangeClosed(1, 12)
										             .mapToObj(i -> String.format("%d월", i))
										             .collect(Collectors.toList());
		
		model.addAttribute("yearsperformPurchasedata", mapper.writeValueAsString(yearsperformPurchasedata));
		model.addAttribute("yearsperformSaledata", mapper.writeValueAsString(yearsperformSaledata));
		model.addAttribute("yearsperformlabels", mapper.writeValueAsString(yearsperformlabels));
		
		
		// 거래처 실적 그래프
		List<Integer> bardata = Arrays.asList(16, 20, 25, 6, 3);
		List<String> barlabels = Arrays.asList("A사", "B사", "C사", "D사", "E사");
		
		
		
		model.addAttribute("bardata", mapper.writeValueAsString(bardata));
		model.addAttribute("barlabels", mapper.writeValueAsString(barlabels));

		
		// 재고현황 그래프
		List<Integer> inventoryData = Arrays.asList(80, 20);
		List<String> inventoryLabels = Arrays.asList("보유", " ");

		model.addAttribute("inventoryLabels", mapper.writeValueAsString(inventoryLabels));
		model.addAttribute("inventoryData", mapper.writeValueAsString(inventoryData));



		return "main"; // src/main/webapp/WEB-INF/views/main.jsp
	}

	
}
