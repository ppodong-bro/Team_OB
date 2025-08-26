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

import com.WiseForce.AssemERP.dto.sm.BoardDTO;
import com.WiseForce.AssemERP.service.dg.InventoryService;
import com.WiseForce.AssemERP.service.km.ClientService;
import com.WiseForce.AssemERP.service.sh.PartsService;
import com.WiseForce.AssemERP.service.sh.PerformanceService;
import com.WiseForce.AssemERP.service.sh.ProductService;
import com.WiseForce.AssemERP.service.sm.BoardService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	
	private final PerformanceService performanceService;
	private final InventoryService inventoryService;
	private final BoardService boardService;
	
	@GetMapping("/")
	public String mainPage(Model model) throws JsonProcessingException {
		ObjectMapper mapper = new ObjectMapper();
		System.out.println("mainPage Strart...");
		
		// 연간실적 그래프
		List<BigDecimal> yearsperformPurchasedata = performanceService.getPurchaseData();
		List<BigDecimal> yearsperformSaledata = performanceService.getSaleData();
		List<String> yearsperformlabels =  IntStream.rangeClosed(1, 12)
										             .mapToObj(i -> String.format("%d월", i))
										             .collect(Collectors.toList());
		
		model.addAttribute("yearsperformPurchasedata", mapper.writeValueAsString(yearsperformPurchasedata));
		model.addAttribute("yearsperformSaledata", mapper.writeValueAsString(yearsperformSaledata));
		model.addAttribute("yearsperformlabels", mapper.writeValueAsString(yearsperformlabels));
		
		
		
		// 거래처 실적 그래프
		
		List<Integer> bardata = performanceService.getClientTotalCost();
		List<String> barlabels = performanceService.getClientName();
		
		System.out.println("bardata => "+bardata );
		System.out.println("barlabels => "+barlabels );
		
		
		model.addAttribute("bardata", mapper.writeValueAsString(bardata));
		model.addAttribute("barlabels", mapper.writeValueAsString(barlabels));

		// 재고현황 그래프
		List<Map<String, Object>> inventoryCurrent = inventoryService.getInventoryCurrent();
//		System.out.println(inventoryCurrent);
        model.addAttribute("inventoryCurrent", mapper.writeValueAsString(inventoryCurrent)); // 자바 객체를 JSON 문자열로 변환

        // 공지사항
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setStart(1); // 가장 최신
		boardDTO.setEnd(5); // 5개
		// emp 정보 가져오기
		List<BoardDTO> boardDTOs = boardService.getBoardList(boardDTO);

        model.addAttribute("boardList", boardDTOs);
        
		return "main"; // src/main/webapp/WEB-INF/views/main.jsp
	}

	
	
}
