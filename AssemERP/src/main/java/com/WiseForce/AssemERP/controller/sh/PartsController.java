package com.WiseForce.AssemERP.controller.sh;

import java.util.List;

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
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.sh.PartsService;
import com.WiseForce.AssemERP.service.sm.EmpService;
import com.WiseForce.AssemERP.util.CustomFileUtil;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("parts/")
@Controller
@RequiredArgsConstructor
public class PartsController {

	private final PartsService partsService;
	private final CustomFileUtil fileUtil;
	private final EmpService empService;

	@GetMapping("partsList")
	public String partsListPageStart(PartsDTO partsDTO, Model model) {
		// Del_status = 0인 부품 총량 가져오기
		int totalcount = partsService.getTotalcount();
		System.out.println("PartsController partsListPage totalcount => " + totalcount);
		// 페이징 적용
		Paging page = new Paging(totalcount, partsDTO.getCurrentPage());
		partsDTO.setStart(page.getStart());
		partsDTO.setEnd(page.getEnd());
		System.out.println("PartsController partsListPage partsDTO.setStart => " + page.getStart());
		System.out.println("PartsController partsListPage partsDTO.setEnd => " + page.getEnd());

		// 리스트받아오기
		List<PartsDTO> partsDTOs = partsService.getPartsList(partsDTO);
		System.out.println("PartsController partsListPage partsDTOs => " + partsDTOs.size());

		model.addAttribute("totalcount", totalcount);
		model.addAttribute("partsDTOs", partsDTOs);
		model.addAttribute("page", page);

		return "sh/partsList";
	}

	@GetMapping("create")
	public String partsCreateStart(Model model) {

		// Emp 총원가져오기
		EmpDTO dto = new EmpDTO();
		int empTotalCount = empService.getTotalCount(dto);

		// Emp 검색범위 세팅하기(총인원 가져오기)
		dto.setStart(0);
		dto.setEnd(empTotalCount);

		// EmpList 가져오기
		List<EmpDTO> EmpList = empService.empListForm(dto);

		model.addAttribute("EmpList", EmpList);

		return "sh/partsCreate";
	}

	@PostMapping("partsCreate")
	public String partsCreate(PartsDTO partsDTO, Model model) {
		System.out.println("PartsController partsCreate partsCreate => " + partsDTO);
		
		// 서버에 파일 저장
		partsDTO.setFilename(fileUtil.saveFile(partsDTO.getFile()));
		
		// DB 저장
		int createResult = partsService.createParts(partsDTO);

		model.addAttribute("createResult", createResult);

		return "redirect:partsList";
	}

	@GetMapping("searchPartsList")
	public String searchPartList(PartsDTO partsDTO, Model model) {
		System.out.println("PartsController searchPartList partsDTO => " + partsDTO);

		// 검색조건에 맞는 부품 총량 가져오기
		int totalcount = partsService.getTotalSeartchcount(partsDTO);
		
		// 페이징 작업
		Paging page = new Paging(totalcount, partsDTO.getCurrentPage());
		partsDTO.setStart(page.getStart());
		partsDTO.setEnd(page.getEnd());
		
		// 조건에 맞는 리스트 가져오기
		List<PartsDTO> partsDTOs = partsService.getpartsSearchList(partsDTO);
		System.out.println("PartsController searchPartList partsDTOs => " + partsDTOs.size());

		model.addAttribute("totalcount", totalcount);
		model.addAttribute("page", page);
		model.addAttribute("partsDTOs", partsDTOs);

		return "sh/partsList";
	}

	@GetMapping("partsModify/{parts_no}")
	public String partsMOdifyStart(@PathVariable(name = "parts_no") int parts_no, Model model) {
		System.out.println("PartsController partsMOdifyStart Start... ");
		System.out.println("PartsController partsMOdifyStart parts_no => " + parts_no);
		// 부품 기본정보 가져오기
		PartsDTO partsDTO = partsService.findbyID(parts_no);

		// Emp 총원가져오기
		EmpDTO dto = new EmpDTO();
		int empTotalCount = empService.getTotalCount(dto);

		// Emp 검색범위 세팅하기(총인원 가져오기)
		dto.setStart(0);
		dto.setEnd(empTotalCount);

		// EmpList 가져오기
		List<EmpDTO> EmpList = empService.empListForm(dto);

		model.addAttribute("partsDTO", partsDTO);
		model.addAttribute("EmpList", EmpList);

		return "sh/partsModifyForm";
	}

	@PostMapping("partsUpdate")
	public String partsUpdate(PartsDTO partsDTO, Model model) {
		PartsDTO dto = partsService.findbyID(partsDTO.getParts_no());

		System.out.println("PartsController partsUpdate partsDTO  => " + partsDTO.getParts_no());
		
		// 원본파일 삭제하기
		if (partsDTO.getFile() != null || partsDTO.getFile().getSize() != 0) {
			deleteFile(dto.getParts_no());
		}
		
		// 서버에 새로운 파일 저장
		partsDTO.setFilename(fileUtil.saveFile(partsDTO.getFile()));
		
		// PartsDTO -> Parts 형변환(PatsDTO.class 참조)
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
			
			// DB저장값 초기화를 위해 null값 적용
			partsDTO.setFilename(null);
			
			// DTO => Entity변환
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

	@GetMapping("partsDetail/{parts_no}")
	public String partsDetail(@PathVariable(name = "parts_no")int parts_no, Model model) {
		
		return "sh/partsDetail";
	}
}
