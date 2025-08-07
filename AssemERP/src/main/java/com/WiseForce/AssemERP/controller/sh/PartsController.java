package com.WiseForce.AssemERP.controller.sh;

import java.beans.BeanProperty;
import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.domain.sh.Parts;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.service.sh.PartsService;
import com.WiseForce.AssemERP.util.CustomFileUtil;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("parts/")
@Controller
@RequiredArgsConstructor
public class PartsController {

	private final PartsService partsService;
	private final CustomFileUtil fileUtil;
	
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
		partsDTO.setFilename(fileUtil.saveFile(partsDTO.getFile()));
		int createResult = partsService.createParts(partsDTO);



		model.addAttribute("createResult", createResult);

		return "redirect:partsList";
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

	@GetMapping("partsModify/{parts_no}")
	public String partsMOdifyStart(@PathVariable(name = "parts_no") int parts_no, Model model ) {
		System.out.println("PartsController partsMOdifyStart Start... ");
		System.out.println("PartsController partsMOdifyStart parts_no => "+parts_no);
		PartsDTO partsDTO = partsService.findbyID(parts_no);

		
		model.addAttribute("partsDTO", partsDTO);


		return "sh/partsModifyForm";
	}
	
	@PostMapping("partsUpdate")
	public String partsUpdate(PartsDTO partsDTO, Model model) {
		PartsDTO dto = partsService.findbyID(partsDTO.getParts_no());
		
		
		System.out.println("PartsController partsUpdate partsDTO  => "+partsDTO.getParts_no());
		partsDTO.setEmp_no(1001);   // 테스트용
		if(partsDTO.getFile() != null || partsDTO.getFile().getSize() != 0) {
			deleteFile(dto.getParts_no());
		}
		
		
		partsDTO.setFilename(fileUtil.saveFile(partsDTO.getFile())); 
		
		
		Parts parts = partsDTO.changeParts();
		
		partsService.updateParts(parts);
		
		return "redirect:partsList";
	}
	
	
	@DeleteMapping("deleteFile/{parts_no}")
	public ResponseEntity<String> deleteFile(@PathVariable(name = "parts_no") int parts_no) {
	    try {
	        PartsDTO partsDTO = partsService.findbyID(parts_no);
	        if (partsDTO == null) {
	            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당 부품이 존재하지 않습니다.");
	        }
	        // 파일삭제
	        fileUtil.deleteFiles(partsDTO.getFilename());
	        
	        // DTO => Entity변환
	        partsDTO.setFilename(null);
	        Parts parts = partsDTO.changeParts();
	        // DB삭제
	        partsService.updateParts(parts);
	        
	        return ResponseEntity.ok("삭제 성공");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
	    }
	}
	
	
	@PostMapping("partsDeletePro")
	public String partsDeletePro(PartsDTO partsDTO) {
		
		partsService.deleteParts(partsDTO.getParts_no());
		
		
		return "redirect:partsList";
	}
	
	
}
