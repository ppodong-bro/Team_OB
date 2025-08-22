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

import com.WiseForce.AssemERP.domain.sh.Product;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;
import com.WiseForce.AssemERP.service.km.ClientService;
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
	private final ClientService clientService;
	
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
	
	@GetMapping("/getItemPerform")
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
	
	@GetMapping("clientPerform")
	public String clientPerform(){
		
		return "sh/clientChartDetail";
	}
	
	
	@GetMapping("/searchClient")
	@ResponseBody
	public List<Map<String, Object>> searchClient(@RequestParam(name = "keyword")String keyword){
		
		// DB조회
		List<Map<String, Object>> result = new ArrayList<>();
		
		// 판매회사 리스트
		List<ClientPerformanceDTO> salesClient = performanceService.getSalesClient(keyword);
		for(ClientPerformanceDTO i : salesClient) {
			Map<String, Object> map = new HashMap<>();
			map.put("id", i.getClient_no());
			map.put("name", i.getClient_name());
			map.put("status", "[판매처]");
			result.add(map);
		}
		
		// 구매회사 리스트
		List<ClientPerformanceDTO> purChaseClient = performanceService.getPurchaseClient(keyword);
		for(ClientPerformanceDTO i : purChaseClient) {
			Map<String, Object> map = new HashMap<>();
			map.put("id", i.getClient_no());
			map.put("name", i.getClient_name());
			map.put("status", "[구매처]");
			result.add(map);
		}
		return result;
	}
	

	@GetMapping("/getClientPerform")
	@ResponseBody
	public List<Map<String, Object>> getClientPerform(@RequestParam("id") int id, @RequestParam("type") String type){
		System.out.println("id => "+id);
		System.out.println("status => "+type);
		
		// 거래처번호롤 거래처 정보 가져오기
		ClientDto clientDto = new ClientDto();
		clientDto.setClient_No(id);
		clientDto = clientService.detailClient(clientDto);
		System.out.println("clientDto => "+clientDto);
		
		List<Map<String, Object>> result = new ArrayList<>();
		
		// 구매처 or 판매처 필터링
		if("[판매처]".equals(type)) {
			List<ClientPerformanceDTO> salesPerform = performanceService.getSalesClinetData(id);
			for(ClientPerformanceDTO i : salesPerform) {
				Map<String, Object> map = new HashMap<>();
				map.put("monthLabel", i.getEach_month());
				map.put("clientData" , i.getTotalcost());
				map.put("clientName", clientDto.getClient_Name());
				map.put("type", clientDto.getClient_Gubun());
				result.add(map);
			}
			return result;
		}
		
		if("[구매처]".equals(type)) {
			List<ClientPerformanceDTO> purchasePerform = performanceService.getPurchaseClinetData(id);
			for(ClientPerformanceDTO i : purchasePerform) {
				Map<String, Object> map = new HashMap<>();
				map.put("monthLabel", i.getEach_month());
				map.put("clientData" , i.getTotalcost());
				map.put("clientName", clientDto.getClient_Name());
				map.put("type", clientDto.getClient_Gubun());
				result.add(map);
			}
			return result;
		}
		else {
			System.out.println("결과 없음");
		}
		
		return null;
	}
	
	
	@GetMapping("/itemInitialData")
	@ResponseBody
	public List<Map<String, Object>> itemInitialData(){
		
		List<Map<String, Object>> result = new ArrayList<>();
		
		int product_no = performanceService.getMostProductOfYears();
		
		ProductDTO productDTO = productService.getfindById(product_no);
		
		List<YearsPerformDTO> productPerfrom = performanceService.getInitYearsperform(product_no);
		for(YearsPerformDTO i : productPerfrom) {
			Map<String, Object> map = new HashMap<>();
			map.put("monthLabel", i.getEach_month());
			map.put("itemData", i.getItem_totalCost());
			map.put("itemName", productDTO.getProduct_name());
			result.add(map);
		}
		
		
		System.out.println("result => "+result);
		
		return result;
	}
	
	
	@GetMapping("/clientInitialData")
	@ResponseBody
	public List<Map<String, Object>> clientInitialData(){
		
		List<Map<String, Object>> result = new ArrayList<>();
		
		int client_no = performanceService.getMostClientOfYears();
		
		// 거래처번호롤 거래처 정보 가져오기
		ClientDto clientDto = new ClientDto();
		clientDto.setClient_No(client_no);
		clientDto = clientService.detailClient(clientDto);
		System.out.println("clientDto => "+clientDto);
		
		
		List<ClientPerformanceDTO> salesPerform = performanceService.getSalesClinetData(client_no);
		for(ClientPerformanceDTO i : salesPerform) {
			Map<String, Object> map = new HashMap<>();
			map.put("monthLabel", i.getEach_month());
			map.put("clientData" , i.getTotalcost());
			map.put("clientName", clientDto.getClient_Name());
			map.put("type", clientDto.getClient_Gubun());
			result.add(map);
		
		}
		return result;
	}
}
