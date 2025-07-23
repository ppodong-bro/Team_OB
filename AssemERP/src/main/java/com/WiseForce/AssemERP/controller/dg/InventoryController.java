package com.WiseForce.AssemERP.controller.dg;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InventoryController {
	@GetMapping("/inventory")
	public String mainPage() {
		System.out.println("mainPage Strart...");
		return "main";
	}
}
