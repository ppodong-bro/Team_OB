package com.oracle.oBootBoard03.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
// Main , Login , 비밀번호 찾기
public class MainController {

	@GetMapping("/main")
	public String mainPage() {
		System.out.println("mainPage Strart...");
		return "main";
	}
}
