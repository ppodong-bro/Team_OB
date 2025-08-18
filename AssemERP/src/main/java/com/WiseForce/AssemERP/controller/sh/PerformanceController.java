package com.WiseForce.AssemERP.controller.sh;

import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;
import com.WiseForce.AssemERP.service.sh.PartsService;
import com.WiseForce.AssemERP.service.sh.PerformanceService;
import com.WiseForce.AssemERP.service.sh.ProductService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("perform/")
public class PerformanceController {

	private final PerformanceService performanceService;
	private final ProductService productService;
	private final PartsService partsService;
	
	@GetMapping("yearsPerform")
	public String yearsPerform(){
		
		return "sh/yearsPerformDetail";
	}
	
	@GetMapping("/searchItem")
	@ResponseBody
	public List<Map<String, Object>> searchItem(@RequestParam(name = "keyword") String keyword) {
	    // DB 조회
	    List<ProductDTO> productitems = productService.searchByName(keyword);
	    List<PartsDTO> partsitems = partsService.searchByName(keyword);
	    // JSON 반환
	    List<Map<String, Object>> result = new ArrayList<>();
	    for(ProductDTO i : productitems){
	        Map<String, Object> map = new HashMap<>();
	        map.put("id", i.getProduct_no());
	        map.put("name", i.getProduct_name());
	        map.put("status", "[제품]");
	        result.add(map);
	    }
	    
	    for(PartsDTO i : partsitems) {
	    	Map<String, Object> map = new HashMap<>();
	        map.put("id", i.getParts_no());
	        map.put("name", i.getParts_name());
	        map.put("status", "[부품]");
	        result.add(map);
	    }
	    
	    return result;
	}
	
	@GetMapping("/getitemPerform")
	@ResponseBody
	public List<Map<String, Object>> getitemPerform(@RequestParam(name = "id") int id, @RequestParam(name = "type") String type) {
		System.out.println("id => "+id);
		System.out.println("status => "+type);
		
		
		List<Map<String, Object>> result = new ArrayList<>();
		
		if("[제품]".equals(type)) {
			List<YearsPerformDTO> productPerfrom = performanceService.searchProductById(id);
			for(YearsPerformDTO i : productPerfrom) {
				Map<String, Object> map = new HashMap<>();
				map.put("monthLabel", i.getEach_month());
				map.put("itemData", i.getItem_totalCost());
				map.put("borderColor", "rgba(255, 99, 132, 1)" );
				result.add(map);
			}
			return result;
		}
		
		
		
		else if("[부품]".equals(type)) {
			List<YearsPerformDTO> partsItem = performanceService.searchPartsById(id);
			for(YearsPerformDTO i : partsItem) {
				Map<String, Object> map = new HashMap<>();
				map.put("monthLabel", i.getEach_month());
				map.put("itemData", i.getItem_totalCost());
				map.put("borderColor", "rgba(75, 192, 192, 1)");
				result.add(map);
			}
			
			return result;
		}
		
		else {
			System.out.println("결과 없음");
		}
		return null;
	}
}
