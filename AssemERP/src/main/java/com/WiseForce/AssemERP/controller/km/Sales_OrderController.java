package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.service.km.Sales_OrderService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("/sales")
@RequiredArgsConstructor
@Controller
public class Sales_OrderController {
	private final Sales_OrderService sales_OrderService;
	
	@GetMapping("/list")
	public String salesList(Sales_OrderDto sales_OrderDto, Model model) {
		System.out.println("Sales_OrderController list Start...");
		int totCnt = sales_OrderService.salesTotCnt();
		Paging page = new Paging(totCnt, sales_OrderDto.getCurrentPage());
		sales_OrderDto.setStart(page.getStart());
		sales_OrderDto.setEnd(page.getEnd());
		List<Sales_OrderDto> listSales = sales_OrderService.salesList(sales_OrderDto);
		model.addAttribute("listSales", listSales);
		model.addAttribute("page", page);
		return "km/sales_OrderList";
	}
	
	@GetMapping("/searchList")
	public String salesSearchList(Sales_OrderSearchDto sales_OrderSearchDto, Model model ) {
		System.out.println("Sales_OrderController salesSearchList Start...");
		int searchTotCnt = sales_OrderService.searchTotCnt(sales_OrderSearchDto);
		Paging page = new Paging(searchTotCnt, sales_OrderSearchDto.getCurrentPage());
		sales_OrderSearchDto.setStart(page.getStart());
		sales_OrderSearchDto.setEnd(page.getEnd());
		List<Sales_OrderDto> searchList = sales_OrderService.searchSales(sales_OrderSearchDto);
		model.addAttribute("listSales", searchList);
		model.addAttribute("page", page);
		
		return "km/sales_OrderList";
		
	}

	
	
}
