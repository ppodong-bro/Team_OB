package com.WiseForce.AssemERP.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.service.dg.CommonService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private final CommonService commonService; 
	
	@GetMapping("/")
	public String mainPage() {
		System.out.println("mainPage Strart...");
		return "main";
	}
	
    @ResponseBody
    @GetMapping("/common/{big_status}")
    public List<CommonDTO> getCommon(@PathVariable("big_status") int bigStatus) {
    	//big_status에 따라 common의 모든 상태값을 가져온다. 
    	List<CommonDTO> commonDTOs = commonService.getAllStatus(bigStatus);
    	
        return commonDTOs;
    }
}
