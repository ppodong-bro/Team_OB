package com.WiseForce.AssemERP.controller.sh;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.service.sh.PartsService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("parts/")
@Controller
@RequiredArgsConstructor
public class PartsController {

	private final PartsService partsService;
	
	@GetMapping("partsList")
	public String partsListPage(PartsDTO partsDTO,Model model) {
		int totalcount = partsService.getTotalcount();
		System.out.println("PartsController partsListPage totalcount => "+totalcount);
		Paging paging = new Paging(totalcount, partsDTO.getCurrentpage());
		partsDTO.setStart(paging.getStart());
		partsDTO.setEnd(paging.getEnd());
		System.out.println("PartsController partsListPage partsDTO.setStart => "+paging.getStart());
		System.out.println("PartsController partsListPage partsDTO.setEnd => "+paging.getEnd());
		
		List<PartsDTO> partsDTOs = partsService.getPartsList(partsDTO);
		System.out.println("PartsController partsListPage partsDTOs => "+partsDTOs);
		
		model.addAttribute("totalParts", totalcount);
		model.addAttribute("partsDTOs", partsDTOs);
		model.addAttribute("page", paging);
		
		return "sh/partsList";
	}
	
}
