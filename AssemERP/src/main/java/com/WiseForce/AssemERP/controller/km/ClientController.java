package com.WiseForce.AssemERP.controller.km;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@RequestMapping("business/")
@Controller
public class ClientController {
	
	@GetMapping("clientStartList")
	public String listStart() {
		return "km/clientList";
	}
}
