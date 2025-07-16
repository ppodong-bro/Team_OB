package com.oracle.oBootBoard03.controller;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.oBootBoard03.domain.EmpImage;
import com.oracle.oBootBoard03.dto.DeptDto;
import com.oracle.oBootBoard03.dto.EmpDto;
import com.oracle.oBootBoard03.dto.Emp_picDto;
import com.oracle.oBootBoard03.service.DeptService;
import com.oracle.oBootBoard03.service.EmpService;
import com.oracle.oBootBoard03.service.Paging;
import com.oracle.oBootBoard03.util.CustomFileUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/emp")
@RequiredArgsConstructor
public class EmpController {

	private final EmpService empService;
	private final DeptService deptService;
	private final CustomFileUtil customFileUtil;
	
	@GetMapping("/list")
	public String mainPage(EmpDto empDto, Model model) {
		System.out.println("emp/list Strart...");
		int totalCount = empService.totalEmp();
		System.out.println("EmpController mainPage totalCount => "+totalCount);
		
		Paging paging = new Paging(totalCount, empDto.getCurrentPage());
		
		empDto.setStart(paging.getStart());
		empDto.setEnd(paging.getEnd());
		
		List<EmpDto> empDtoList = empService.empList(empDto);
		System.out.println("EmpController mainPage empDtoList => "+empDtoList);
		 
		model.addAttribute("empDtoList", empDtoList);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("page", paging);
		
		return "emp/list";
	}
	
	
	@GetMapping("/empInform")
	public String empInform(Model model) {
		System.out.println("EmpController empInform start...");
		List<DeptDto> deptAllList = deptService.deptAllList();
		
		model.addAttribute("deptAllList", deptAllList);
		return "emp/empInform"; 
	}
	
	@PostMapping("/saveEmp")
	public String saveEmp(EmpDto empDto) {
		System.out.println("EmpController saveEmp =>"+empDto);
		
		
		List<MultipartFile> files = empDto.getFiles();
		System.out.println("EmpController saveEmp files =>"+files);
		// File upload
		List<String> uploadFileNames = customFileUtil.saveFiles(files);
		empDto.setUploadFileNames(uploadFileNames);
		System.out.println("EmpController saveEmp uploadFileNames =>"+uploadFileNames);
		
		int result = empService.empsave(empDto);
		
		return "redirect:list";
	}
	
	@GetMapping("/empDetail")
	public String empDetail(EmpDto empDto, Model model) {
		System.out.println("EmpController empDetail Start...");
		EmpDto resultdto = empService.getSingleEmp(empDto.getEmp_no());
		List<String> empImageList = empService.getEmpList(empDto.getEmp_no());
		System.out.println("EmpController empDetail empImageList => "+empImageList);
		
		model.addAttribute("empDto", resultdto);
		model.addAttribute("empImageList", empImageList);
		return "emp/empDetail";
	}
	
	@GetMapping("/modifyForm")
	public String modifyEmp(EmpDto empDto,Model model) {
		System.out.println("EmpController modifyEmp Start...");
		System.out.println("EmpController modifyEmp empDto => "+empDto);
		EmpDto resultdto = empService.getSingleEmp(empDto.getEmp_no());
		List<DeptDto> deptAllList = deptService.deptAllList();
		List<String> empImageList = empService.getEmpList(empDto.getEmp_no());
		
		
		model.addAttribute("empDto", resultdto);
		model.addAttribute("deptAllList", deptAllList);
		model.addAttribute("empImageList", empImageList);
		return "emp/modifyForm";
	}
	
	
	@PostMapping("update")
	public String empUpdate(EmpDto empDto) {
		System.out.println("EmpController empUpdate empDto => " +empDto);
		System.out.println("EmpController empUpdate empPicDto => +empPicDto");
		
		
		
		List<MultipartFile> files = empDto.getFiles();
		System.out.println("EmpController update files => "+files);
		
		List<String> oldFileNames = empService.getEmpList(empDto.getEmp_no());
		System.out.println("empUpdate oldFileNames => "+oldFileNames);
		
		List<String> currentUploadNames = customFileUtil.saveFiles(files);
		System.out.println("empUpdate currentUploadNames => "+currentUploadNames);
		
		List<String> uploadFIleNames = empDto.getUploadFileNames();
		System.out.println("empUpdate uploadFIleNames =>"+uploadFIleNames);
		
		if(currentUploadNames != null && currentUploadNames.size() > 0 ) {
			uploadFIleNames.addAll(currentUploadNames);
		}
		
		empDto.setUploadFileNames(uploadFIleNames);
		
		
		empService.updateEmp(empDto);
		
		if(oldFileNames != null && oldFileNames.size() > 0) {
			
			List<String> removeFiles = oldFileNames.stream()
												   .filter(fileName-> uploadFIleNames.indexOf(fileName) == -1)
												   .collect(Collectors.toList());
			System.out.println("empUpdate removeFiles =>"+removeFiles);
			customFileUtil.deleteFiles(removeFiles);
			removeFiles(removeFiles);
		}
		
		return "redirect:list";
	}
	
	@GetMapping("/deleteEmp")
	public String deleteEmp(EmpDto dto,Model model) {
		System.out.println("EmpController deleteEmp dto.getEmp_no => "+dto.getEmp_no());
		empService.deleteEmp(dto.getEmp_no());
		
		
		return "redirect:list";
	}
	
	public void removeFiles(List<String> removeFiles) {
		empService.deleteEmpImage(removeFiles);
	}
	
}
