package com.WiseForce.AssemERP.controller.sh;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String partsListPageStart(PartsDTO partsDTO,Model model) {
		int totalcount = partsService.getTotalcount();
		System.out.println("PartsController partsListPage totalcount => "+totalcount);
		Paging page = new Paging(totalcount, partsDTO.getCurrentPage());
		partsDTO.setStart(page.getStart());
		partsDTO.setEnd(page.getEnd());
		System.out.println("PartsController partsListPage partsDTO.setStart => "+page.getStart());
		System.out.println("PartsController partsListPage partsDTO.setEnd => "+page.getEnd());
		
		List<PartsDTO> partsDTOs = partsService.getPartsList(partsDTO);
		System.out.println("PartsController partsListPage partsDTOs => "+partsDTOs);
		
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("partsDTOs", partsDTOs);
		model.addAttribute("page", page);
		
		return "sh/partsList";
	}

	@GetMapping("create")
	public String partsCreateStart(Model model) {
		
		return "sh/partsCreate";
	}
	
	@PostMapping("partsCreate")
	public String partsCreate(PartsDTO partsDTO, Model model) {
		System.out.println("PartsController partsCreate partsCreate => "+partsDTO);
		
		int createResult = partsService.createParts(partsDTO);
				
		
		
		model.addAttribute("createResult", createResult);
		
		return "redirect:parts/partsList";
	}
	
	@GetMapping("searchPartsList")
	public String searchPartList(PartsDTO partsDTO,Model model ) {
		System.out.println("PartsController searchPartList partsDTO => "+partsDTO );
		int totalcount = partsService.getTotalSeartchcount(partsDTO);
		Paging page = new Paging(totalcount, partsDTO.getCurrentPage());
		partsDTO.setStart(page.getStart());
		partsDTO.setEnd(page.getEnd());
		
		List<PartsDTO> partsDTOs = partsService.getpartsSearchList(partsDTO);
		System.out.println("PartsController searchPartList partsDTOs => "+partsDTOs);
		
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("page", page);
		model.addAttribute("partsDTOs", partsDTOs);
		
		return "sh/partsList";
	}
}
