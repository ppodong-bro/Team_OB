package com.WiseForce.AssemERP.controller.km;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.service.km.Sales_OrderService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/sales")
@RequiredArgsConstructor
@Controller
public class Sales_OrderController {
	private final Sales_OrderService sales_OrderService;
	
	@GetMapping("/list")
	public String startSales_OrederList() {
		System.out.println("Sales_OrderController list Start...");
		
		return "km/sales_OrderList";
	}
	
}
