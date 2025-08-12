package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.service.km.Purchase_OrderService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("/purchase")
@RequiredArgsConstructor
@Controller
public class Purchase_OrderController {
	private final Purchase_OrderService purchase_OrderService;
	
	@GetMapping("list")
	public String listStart(Purchase_OrderSearchDto purchase_OrderSearchDto, Model model) {
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
}
