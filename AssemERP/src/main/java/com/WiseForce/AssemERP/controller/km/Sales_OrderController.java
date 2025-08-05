package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderDto;
import com.WiseForce.AssemERP.dto.km.Sales_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.km.Sales_OrderService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("/sales")
@RequiredArgsConstructor
@Controller
public class Sales_OrderController {
	private final Sales_OrderService sales_OrderService;
	
	@GetMapping("/list")
	public String listSales(Sales_OrderSearchDto sales_OrderSearchDto, Model model ) {
		System.out.println("Sales_OrderController salesSearchList Start...");
		int totCnt = sales_OrderService.totSales(sales_OrderSearchDto);
		Paging page = new Paging(totCnt, sales_OrderSearchDto.getCurrentPage());
		sales_OrderSearchDto.setStart(page.getStart());
		sales_OrderSearchDto.setEnd(page.getEnd());
		List<Sales_OrderDto> searchList = sales_OrderService.listSales(sales_OrderSearchDto);
		model.addAttribute("listSales", searchList);
		model.addAttribute("page", page);
		
		return "km/sales_OrderList";
	}
	
	@GetMapping("/detail")
	public String detailSales(Sales_OrderDto sales_OrderDto1,Model model){
		
		Sales_OrderDto sales_OrderDto = sales_OrderService.detailSales(sales_OrderDto1);
		model.addAttribute("sales_OrderDto", sales_OrderDto);
		return "km/detailSales";
	}
	
	@GetMapping("/createStart")
	public String createStartSales(Model model) {
		System.out.println("Sales_OrderController createStart Start...");
		List<ProductDTO> productList = sales_OrderService.productList();
	    List<ClientDto> clientList = sales_OrderService.clientList();
	    model.addAttribute("productList", productList);
	    model.addAttribute("clientList", clientList);
		return "km/salesCreate";
	}
	


	
	
}
