package com.WiseForce.AssemERP.controller.dg;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.service.dg.CommonService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class RestAPIController {
	private final CommonService commonService;

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
}

