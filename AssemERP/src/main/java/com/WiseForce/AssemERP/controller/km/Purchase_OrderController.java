package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.service.km.Purchase_OrderService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("/purchase")
@RequiredArgsConstructor
@Controller
public class Purchase_OrderController {
	private final Purchase_OrderService purchase_OrderService;
	
	@GetMapping("/list")
	public String listPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto, Model model) {
		System.out.println("listStart purchase_OrderSearchDto"+purchase_OrderSearchDto);
		int totCnt = purchase_OrderService.totPurchase(purchase_OrderSearchDto);
		Paging page = new Paging(totCnt, purchase_OrderSearchDto.getCurrentPage());
		purchase_OrderSearchDto.setStart(page.getStart());
		purchase_OrderSearchDto.setEnd(page.getEnd());
		List<Purchase_OrderDto> listPurchase = purchase_OrderService.listPurchaseOrder(purchase_OrderSearchDto); 
		model.addAttribute("listPurchase", listPurchase );
		model.addAttribute("paging", page);
		model.addAttribute("Purchase_OrderSearchDto", purchase_OrderSearchDto);
		return "km/purchase_OrderList";
	}
	
	@GetMapping("/detail")
	public String detailPurchase(@RequestParam("purchase_No") int purchase_No, Model model) {
		Purchase_OrderDto purchase_OrderDto = purchase_OrderService.detailPurchase(purchase_No);
		model.addAttribute("Purchase_OrderDto", purchase_OrderDto);
		return "km/detailPurchase";
	}
	
	@GetMapping("/createStart")
	public String createStart(Model model) {
		model.addAttribute("client_Gubun", 0);
		return "km/purchaseCreate";
	}
	
	@PostMapping("/create")
	public String createPurchase(Purchase_OrderDto purchase_OrderDto) {
		purchase_OrderService.createPurchase(purchase_OrderDto);
		return "redirect:/purchase/list";
	}
	
	@GetMapping("/partsPopup")
	public String partsPop(Model model) {
		List<PartsDTO> listParts = purchase_OrderService.partsPop();
		model.addAttribute("listParts", listParts);
		return "km/partsPop";
	}
	
	
}
