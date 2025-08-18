package com.WiseForce.AssemERP.controller.km;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WiseForce.AssemERP.dto.dg.InventoryInfoDTO;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.PartsShortageDto;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.dg.InventoryService;
import com.WiseForce.AssemERP.service.km.ClientService;
import com.WiseForce.AssemERP.service.km.Sales_OrderService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("/sales")
@RequiredArgsConstructor
@Controller
public class Sales_OrderController {
	private final Sales_OrderService sales_OrderService;
	private final ClientService clientService;
	private final InventoryService inventoryService;

	@GetMapping("/list")
	public String listSales(Sales_OrderSearchDto sales_OrderSearchDto, Model model) {
		System.out.println("Sales_OrderController salesSearchList Start...");
		int totCnt = sales_OrderService.totSales(sales_OrderSearchDto);
		Paging page = new Paging(totCnt, sales_OrderSearchDto.getCurrentPage());
		sales_OrderSearchDto.setStart(page.getStart());
		sales_OrderSearchDto.setEnd(page.getEnd());
		List<Sales_OrderDto> searchList = sales_OrderService.listSales(sales_OrderSearchDto);
		model.addAttribute("listSales", searchList);
		model.addAttribute("paging", page);
		model.addAttribute("Sales_OrderSearchDto", sales_OrderSearchDto);

		return "km/sales_OrderList";
	}

	@GetMapping("/detail")
	public String detailSales(Sales_OrderDto sales_OrderDto1, Model model) {

		Sales_OrderDto sales_OrderDto = sales_OrderService.detailSales(sales_OrderDto1);
		model.addAttribute("sales_OrderDto", sales_OrderDto);
		
		return "km/detailSales";
	}

	@GetMapping("/createStart")
	public String createStartSales(Model model, RedirectAttributes ra) {
		try {
			sales_OrderService.closeCheck();
			model.addAttribute("client_Gubun", 1);
			return "km/salesCreate";
		} catch (IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/sales/list";
		}
	}

	@PostMapping("/create")
	public String createSales(Sales_OrderDto sales_OrderDto, RedirectAttributes ra) {
		
		System.out.println("createSales sales_OrderDto--->" + sales_OrderDto);
		
		// View용 부족한 부품의 DTO
		List<PartsShortageDto> shortages = new ArrayList<>();
		
		// 부족한 부품 정보 및 수량
		Map<PartsDTO, Integer> requirementsForSalesMap = inventoryService.getRequirementsForSales(sales_OrderDto.getSales_Item());

		for(PartsDTO key : requirementsForSalesMap.keySet()) {
			// 실재고 조회를 위한 DTO
			InventoryInfoDTO inventoryInfoDTO = InventoryInfoDTO.builder().item_type(0/*부품*/).item_no(key.getParts_no()).build();
			// 필요한 부품의 실재고
			int realCnt = inventoryService.getRealInventoryById(inventoryInfoDTO).getCnt();

			PartsShortageDto partsShortageDto = PartsShortageDto.builder()
					.parts_no(key.getParts_no()) // 부품번호
					.parts_name(key.getParts_name()) // 부품명
					.required_cnt(realCnt + requirementsForSalesMap.get(key)) // 필요 부품 수량
					.available_cnt(realCnt) // 보유 부품 수량
					.shortage_cnt(requirementsForSalesMap.get(key)) // 부족 부품 수량
					.build();

			// View용 부족한 부품 리스트에 추가
			shortages.add(partsShortageDto);
		}
		
	    if (!shortages.isEmpty()) {
	        ra.addFlashAttribute("shortages", shortages);
	        ra.addFlashAttribute("pendingSalesOrder", sales_OrderDto);
	        return "redirect:/sales/shortageConfirm";
	    }
	    
	    int result = sales_OrderService.createSales(sales_OrderDto);
	    
	    if(result == 1) {
	    	String message = "수주 요청 완료";
	    	ra.addFlashAttribute("createSuccess", message);
	    } else if (result == 0) {
	    	String message = "수주 요청 실패";
	    	ra.addFlashAttribute("createFail", message);
	    }

		return "redirect:/sales/list";
	}
	
	@GetMapping("/shortageConfirm")
	public String shortageConfirm() {
	    return "km/shortageConfirm";
	}
	

//	@PostMapping("/confirmToPurchase")
//	public String confirmToPurchase(
//	        @RequestParam(value = "shortagesJson", required = false) String shortagesJson,
//	        RedirectAttributes ra
//	) {
//	    if (shortagesJson == null || shortagesJson.isBlank()) {
//	        shortagesJson = "[]";
//	    }
//	    ra.addFlashAttribute("prefillShortagesJson", shortagesJson);
//	    return "redirect:/purchase/createStart";
//	}
	
	@PostMapping("/confirmToPurchase")
	public String confirmToPurchase(@RequestParam("shortagesJson") String shortagesJson,
	                                RedirectAttributes ra) {
	    ra.addFlashAttribute("prefillShortagesJson", shortagesJson);
	    return "redirect:/purchase/createStart";
	}

	@GetMapping("/modifyStart")
	public String modifyStart(Sales_OrderDto sales_OrderDto, Model model, RedirectAttributes ra) {
		try {
			sales_OrderService.closeCheck();
			Sales_OrderDto sales_OrderDto1 = sales_OrderService.detailSales(sales_OrderDto);
			model.addAttribute("client_Gubun", 1);
			model.addAttribute("sales_OrderDto", sales_OrderDto1);
			return "km/modifySales";
		} catch (IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/sales/list";
		}
	}

	@GetMapping("/detailPageModifyStart")
	public String detailPageModifyStartt(Sales_OrderDto sales_OrderDto, Model model, RedirectAttributes ra) {
		try {
			sales_OrderService.closeCheck();
			Sales_OrderDto sales_OrderDto1 = sales_OrderService.detailSales(sales_OrderDto);
			model.addAttribute("sales_OrderDto", sales_OrderDto1);
			model.addAttribute("client_Gubun", 1);
			return "km/modifySales";
		} catch (IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/sales/detail?sales_No=" + sales_OrderDto.getSales_No();
		}
	}
	
	@PostMapping("/modify")
	public String modify(Sales_OrderDto sales_OrderDto, RedirectAttributes ra) {
		sales_OrderService.closeCheck();
		int sales_No = sales_OrderDto.getSales_No();
		List<Sales_ItemDto> salesItemList = sales_OrderService.salesItemList(sales_No);
		String result = sales_OrderService.modifySales(sales_OrderDto, salesItemList);
		if(result == "수주 수정 성공") {
			ra.addFlashAttribute("success", result);
		} else if (result == "수주 수정 실패") {
			ra.addFlashAttribute("fail", result);
		}

		return "redirect:/sales/detail?sales_No=" + sales_OrderDto.getSales_No();
	}

	@PostMapping("modifyStatus")
	public String modifyStatus(Sales_OrderDto sales_OrderDto, RedirectAttributes ra) {
		try {
			
			sales_OrderService.closeCheck();
			int sales_No = sales_OrderDto.getSales_No();
			List<Sales_ItemDto> salesItemList = sales_OrderService.salesItemList(sales_No);
			String result = sales_OrderService.modifyStatus(sales_No, salesItemList);
			if(result == "수주 승인 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "수주 승인 실패") {
				ra.addFlashAttribute("fail", result);
			} else if (result == "수주 완료 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "수주 완료 실패") {
				ra.addFlashAttribute("fail", result);
			}
			
			return "redirect:/sales/detail?sales_No=" + sales_OrderDto.getSales_No();
			
		} catch (IllegalArgumentException e) {
			
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/sales/detail?sales_No=" + sales_OrderDto.getSales_No();
		}
	}
	
	@PostMapping("/accessModify")
	public String accessModify(Sales_OrderDto sales_OrderDto, RedirectAttributes ra) {
		try {
			sales_OrderService.closeCheck();
			sales_OrderService.accessModify(sales_OrderDto);
			Sales_OrderDto sales_OrderDto1 = sales_OrderService.detailSales(sales_OrderDto);
			System.out.println("Sales_OrderController sales_OrderDto-->" + sales_OrderDto);
			ra.addFlashAttribute("sales_OrderDto", sales_OrderDto1);
			ra.addFlashAttribute("client_Gubun", 1);
			return "redirect:/sales/modifyStart";
		} catch( IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/sales/detail?sales_No=" + sales_OrderDto.getSales_No();
		}
	}
	
	@PostMapping("/delete")
	public String deleteSales(Sales_OrderDto sales_OrderDto, RedirectAttributes ra) {
		try {
			sales_OrderService.closeCheck();
			System.out.println("Sales_OrderController sales_OrderDto-->" + sales_OrderDto);
			String result = sales_OrderService.deleteSales(sales_OrderDto);
			
			if(result == "수주 삭제 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "수주 삭제 실패") {
				ra.addFlashAttribute("fail", result);
			}
			return "redirect:/sales/list";
		} catch (IllegalArgumentException e) {	
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/sales/detail?sales_No=" + sales_OrderDto.getSales_No();
		}
	}

	@GetMapping("/productPopup")
	public String productPopup(@RequestParam("product_Name") String product_Name ,Model model) {

		List<ProductDTO> productList = sales_OrderService.productList(product_Name);
		model.addAttribute("productList", productList);
		return "km/productPop";
	}
	
	@PostMapping("returnStatus")
	public String returnOutStatus(@RequestParam("sales_No") int sales_No, RedirectAttributes ra) {
		try {
			sales_OrderService.closeCheck();
			
			String result = sales_OrderService.returnStatus(sales_No);
			
			if(result == "수주 완료 취소 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "수주 완료 취소 실패") {
				ra.addFlashAttribute("fail", result);
			} else if (result == "수주 승인 취소 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "수주 승인 취소 실패") {
				ra.addFlashAttribute("fail", result);
			}
			
			return "redirect:/sales/detail?sales_No="+sales_No;
		
		} catch (IllegalArgumentException e){
			ra.addFlashAttribute("error", e.getMessage());	
			return "redirect:/sales/detail?sales_No="+sales_No;
		}
		
		
		
	}

}
