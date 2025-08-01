package com.WiseForce.AssemERP.controller.sm;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.service.sm.DeptService;
import com.WiseForce.AssemERP.service.sm.Paging;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/dept")
@RequiredArgsConstructor
public class DeptController 
{
	private final DeptService deptService; 

    // 부서 등록 페이지를 보여주는 메서드
    @GetMapping("/deptRegisterForm")
    public String deptRegisterForm() 
    {
    	System.out.println("DeptController deptRegisterForm start");
    	
        return "sm/deptRegisterForm"; 	// deptRegisterForm.jsp 뷰를 반환
    }
    
    // 부서 정보를 등록하는 메서드
    @PostMapping("/deptSavePro")
    public String deptSavePro(
    							  @ModelAttribute DeptDTO deptDTO
    							, Model model
    						  ) 
    {
    	System.out.println("DeptController deptSavePro Start");
    	
    	deptService.saveDept(deptDTO); 
    	
    	int totalCount = deptService.getTotalCount(deptDTO);
    	
    	// Paging 객체를 이용해 마지막 페이지 번호 계산
		int pageSize   = 10;
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		
		System.out.println("DeptController deptSavePro saveDept - OK");
    	
        return "redirect:/dept/deptListForm?currentPage="+totalPage; 		// deptListForm.jsp 뷰를 반환
	}
    
    // 부서 수정 페이지를 보여주는 메서드
    @GetMapping("/deptModifyForm")
    public String deptModifyForm(
    								  @RequestParam("deptCode") int deptCode
    								, Model model
    							) 
    {
    	System.out.println("DeptController deptModifyForm start");
    	
    	System.out.println("DeptController deptModifyForm deptCode->"+deptCode);
    	
    	DeptDTO deptDTO = deptService.getDeptDetail(deptCode);
    
    	model.addAttribute("dept", deptDTO);
    	
    	System.out.println("DeptController deptModifyForm ok");
    	
        return "sm/deptModifyForm"; 	// deptModifyForm.jsp 뷰를 반환
    }
    
    // 부서 정보를 수정하는 메서드
    @PostMapping("/deptModifyPro")
    public String deptModifyPro(
    								@ModelAttribute DeptDTO deptDTO,
    								Model model
    							) 
    {
    	System.out.println("DeptController deptModifyPro Start");
    	
    	deptService.updateDept(deptDTO);
    	
    	return "redirect:/dept/deptListForm"; 		// deptListForm.jsp 뷰를 반환
	}
    
    // 부서 정보를 삭제하는 메서드
    @PostMapping("/deptDeletePro")
    public String deptDeletePro(
    								  @RequestParam("deptCode") int deptCode
    								, Model model
    							)
    {
    	System.out.println("DeptController deptDeletePro Start");
    	
    	deptService.deleteDept(deptCode);
    	
    	System.out.println("DeptController deptDeletePro deleteDept ok");
    	
    	return "redirect:/dept/deptListForm"; 		// deptListForm.jsp 뷰를 반환
	}
    
    // 부서 목록 조회 페이지를 보여주는 메서드
    @GetMapping("/deptListForm")
    public String deptListForm(
    							  DeptDTO deptDTO
    							, @RequestParam(value = "currentPage", defaultValue = "1") String currentPage
    							, Model model
    						  ) 
    {
    	System.out.println("DeptController deptListForm start");
    	
    	int totalCnt = deptService.getTotalCount(deptDTO); 
    	
    	System.out.println("DeptController deptListForm totalCnt->"+ totalCnt);
    	
    	Paging paging = new Paging(totalCnt, Integer.parseInt(currentPage));
    	deptDTO.setStart(paging.getStart());
    	deptDTO.setEnd(paging.getEnd());
    	
    	List<DeptDTO> deptDtoList = deptService.getDeptList(deptDTO);
    	
    	System.out.println("DeptController deptListForm deptList1->"+ deptDtoList.toString());
    	System.out.println("DeptController deptListForm deptDTO.getStart()->"+ deptDTO.getStart());
    	System.out.println("DeptController deptListForm deptDTO.getEnd()->"+ deptDTO.getEnd());
    	
    	model.addAttribute("totalCount",  	totalCnt);
    	model.addAttribute("deptList", 		deptDtoList);
    	model.addAttribute("paging", 		paging);
    	model.addAttribute("searchType",	deptDTO.getSearchType());
    	model.addAttribute("searchKeyword",	deptDTO.getSearchKeyword());
    	
        return "sm/deptListForm"; 		// deptListForm.jsp 뷰를 반환
    }
    
}
