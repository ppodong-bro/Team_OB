package com.oracle.oBootBoard03.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.oracle.oBootBoard03.dto.DeptDto;
import com.oracle.oBootBoard03.dto.EmpDto;
import com.oracle.oBootBoard03.service.DeptService;
import com.oracle.oBootBoard03.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/dept")
public class DeptController {

	private final DeptService deptService;
	
	@GetMapping("/list")
	public String listPage(DeptDto deptDto , Model model) {
		System.out.println("dept/list Strart...");
		Long totalCountLong =  deptService.totalDept();	
		int totalCountInt = totalCountLong.intValue(); 
		System.out.println("1.DeptController list totalCount->"+totalCountInt);
		Paging page = new Paging(totalCountInt, deptDto.getCurrentPage());

		// Parameter deptDto --> Page만 추가 Setting
		deptDto.setStart(page.getStart());   // 시작시 1
		deptDto.setEnd(page.getEnd());       // 시작시 10 
		
		System.out.println("2. DeptController list deptDto->"+deptDto);
		List<DeptDto> deptDtoList = deptService.deptList(deptDto);
		System.out.println("3. DeptController list listDept.size()=>" + deptDtoList.size());

		model.addAttribute("totalCount", totalCountInt);
		model.addAttribute("deptDtoList" , deptDtoList);
		model.addAttribute("page"    , page);

		return "dept/list";
	}
	
	@GetMapping("/")
	public String deptMain() {
		System.out.println("dept/deptMain Strart...");

		return "main";
	}
	@GetMapping("/deptInForm")
	public String deptInForm() {
		System.out.println("dept/deptInForm Strart...");

		return "dept/deptInform";
	}
	
	@GetMapping("/deptDetail")
	public String deptDetail(DeptDto deptDto , Model model) {
		System.out.println("DeptController dept/deptDetail Start...");
		System.out.println("DeptController dept/deptDetail deptDto->"+deptDto);
		DeptDto deptRtnDto = deptService.getSingleDept(deptDto.getDept_code());
		model.addAttribute("deptDto", deptRtnDto);

		return "dept/deptDetail";
	}

	@GetMapping("/modifyForm")
	public String modifyForm(DeptDto deptDto , Model model) {
		System.out.println("DeptController dept/modifyForm Start...");
		System.out.println("DeptController dept/modifyForm deptDto->"+deptDto);
		List<EmpDto> empList = deptService.getempList();
		DeptDto deptRtnDto = deptService.getSingleDept(deptDto.getDept_code());
		model.addAttribute("deptDto", deptRtnDto);
		model.addAttribute("empAllList", empList);
		return "dept/modifyForm";
	}
	
	@PostMapping("update")
	public String deptUpdate(DeptDto deptDto) {
		System.out.println("dept/deptUpdate Strart...");
		System.out.println("dept/deptUpdate deptDto->"+deptDto);
		// 여러분의 Logic 
		DeptDto deptUpdateDto = deptService.deptUpdate(deptDto);
		log.info("deptUpdate deptUpdateDto-->", deptUpdateDto);
		return "redirect:list"; 
		
	}	
	
	@PostMapping("saveDept")
	public String saveDept(DeptDto deptDto) {
		System.out.println("dept/saveDept Strart...");
		System.out.println("dept/saveDept deptDto->"+deptDto);
		// 여러분의 Logic 
		int dept_code = deptService.deptSave(deptDto);
		log.info("Save dept_code-->", dept_code);
		return "redirect:list";
		
	}
	
	
	@GetMapping("/deleteDept")
	public String deleteDept(DeptDto deptDto , Model model) {
		System.out.println("DeptController dept/deleteDept Start...");
		System.out.println("DeptController dept/deleteDept deptDto->"+deptDto);
		deptService.deleteDept(deptDto.getDept_code());

		return "redirect:list";
	}

}
