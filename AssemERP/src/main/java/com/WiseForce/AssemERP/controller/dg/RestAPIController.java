package com.WiseForce.AssemERP.controller.dg;

import java.io.File;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.dg.CommonService;
import com.WiseForce.AssemERP.service.dg.FilesService;
import com.WiseForce.AssemERP.service.dg.InventoryService;
import com.WiseForce.AssemERP.service.sm.DeptService;
import com.WiseForce.AssemERP.service.sm.EmpService;
import com.WiseForce.AssemERP.util.CustomFileUtil;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestAPIController {
	private final CustomFileUtil customFileUtil;
	
	private final CommonService commonService;
	private final FilesService filesService;
	
	private final EmpService empService;
	private final DeptService deptService;

	@ResponseBody
	@GetMapping("/common/{big_status}")
	public List<CommonDTO> getCommon(@PathVariable("big_status") int bigStatus) {
		// big_status에 따라 common의 모든 상태값을 가져온다.
		List<CommonDTO> commonDTOs = commonService.getAllStatus(bigStatus);

		return commonDTOs;
	}

	@ResponseBody
	@GetMapping("/common/{big_status}/{middle_status}")
	public CommonDTO getCommon(@PathVariable("big_status") int bigStatus,
			@PathVariable("middle_status") int middleStatus) {
		// big_status에 따라 common의 모든 상태값을 가져온다.
		CommonDTO commonDTO = commonService.getAllStatus(bigStatus, middleStatus);

		return commonDTO;
	}
	
	@ResponseBody
	@GetMapping("/commonText/{big_status}/{middle_status}")
	public String getCommonText(@PathVariable("big_status") int bigStatus,
			@PathVariable("middle_status") int middleStatus) {
		// big_status에 따라 common의 모든 상태값을 가져온다.
		String commonText = commonService.getAllStatusText(bigStatus, middleStatus);

		return commonText;
	}

	@ResponseBody
	@PostMapping("/files")
	public ResponseEntity<Resource> getFileDownload(@RequestParam("filePath") String filePath) {
		return customFileUtil.getFileRealPath(filePath);
	}
	
	@ResponseBody
	@GetMapping("/files/adjust/{adjust_id}")
	public List<Map<String, String>> getFiles_Adjust(@PathVariable("adjust_id") int adjust_id) {
		// 파일경로, 파일명을 반환한다
		List<Map<String, String>> fileList = filesService.getFilesByFilesNo(adjust_id);
		
		System.out.println(fileList);
		
	    return fileList;
	}

	@ResponseBody
	@GetMapping("/getdept/{dept_no}")
	public DeptDTO getDeptById(@PathVariable("dept_no") int dept_no) {
		System.out.println("dept_no" + dept_no);
		// dept 정보 가져오기
		DeptDTO deptDTO = deptService.getDeptDetail(dept_no);
    
	    return deptDTO;
	}
	@ResponseBody
	@GetMapping("/getemp/{emp_no}")
	public EmpDTO getEmpById(@PathVariable("emp_no") int emp_no) {
		System.out.println("emp_no" + emp_no);
		// emp 정보 가져오기
    	EmpDTO empDTO = empService.getEmpDetail(emp_no);
    
	    return empDTO;
	}
}

