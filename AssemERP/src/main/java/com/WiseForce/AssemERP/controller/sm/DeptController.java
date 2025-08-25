package com.WiseForce.AssemERP.controller.sm;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.sm.DeptService;
import com.WiseForce.AssemERP.service.sm.EmpService;
import com.WiseForce.AssemERP.util.Paging;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/dept")
@RequiredArgsConstructor
public class DeptController 
{
	private final DeptService 	deptService; 

    @GetMapping("/deptRegisterForm")
    public String deptRegisterForm() 
    {
    	System.out.println("DeptController deptRegisterForm start");
        return "sm/deptRegisterForm"; 	
    }
    
//    @PostMapping("/deptSavePro")
//    public String deptSavePro(
//    							  @ModelAttribute DeptDTO deptDTO
//    							, Model model
//    						  ) 
//    {
//    	System.out.println("DeptController deptSavePro Start");
//    	
//    	deptService.saveDept(deptDTO); 
//    	
//    	int totalCount = deptService.getTotalCount(deptDTO);
//    	
//		int pageSize   = 10;
//		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
//		
//		System.out.println("DeptController deptSavePro saveDept - OK");
//    	
//        return "redirect:/dept/deptListForm?currentPage="+totalPage; 		
//	}
    
    @PostMapping("/deptSavePro")
    public String deptSavePro(
    							  @ModelAttribute DeptDTO deptDTO
    							, @AuthenticationPrincipal(expression = "accountDTO.empNo") Integer  loginEmpNo
    							, Model model
    						  ) 
    {
    	System.out.println("DeptController deptSavePro Start");
    	
    	if (loginEmpNo == null) {
            return "redirect:/sm/loginForm?error=denied";
        }
    	
    	deptDTO.setRegistrar(loginEmpNo);
    	
    	deptService.saveDept(deptDTO); 
    	
    	int totalCount = deptService.getTotalCount(deptDTO);
    	
		int pageSize   = 10;
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		
		System.out.println("DeptController deptSavePro saveDept - OK");
    	
        return "redirect:/dept/deptListForm?currentPage="+totalPage; 		
	}
    
    @GetMapping("/deptModifyForm")
    public String deptModifyForm(
    								  @RequestParam("deptCode") int deptCode
    								, Model model
    							) 
    {
    	System.out.println("DeptController deptModifyForm start");
    	
    	System.out.println("DeptController deptModifyForm deptCode->"+deptCode);
    	
    	DeptDTO deptDTO = deptService.getDeptDetail(deptCode);
        
        if (deptDTO == null) {
            throw new IllegalArgumentException("부서를 찾을 수 없습니다. deptCode=" + deptCode);
        }

        if (deptDTO.getDeptCaptainName() == null) deptDTO.setDeptCaptainName("");
        if (deptDTO.getParentDeptName() == null)   deptDTO.setParentDeptName("");
    	
    	model.addAttribute("dept", deptDTO);
    	
    	System.out.println("DeptController deptModifyForm ok");
    	
        return "sm/deptModifyForm"; 	
    }
    
    @PostMapping("/deptModifyPro")
    public String deptModifyPro(
    								@ModelAttribute DeptDTO deptDTO,
    								Model model
    							) 
    {
    	System.out.println("DeptController deptModifyPro Start");
    	
    	System.out.println("DeptController deptModifyPro deptCode=" + deptDTO.getDeptCode()
														        	+ ", deptCaptain=" + deptDTO.getDeptCaptain()
														        	+ ", parentDeptCode=" + deptDTO.getParentDeptCode());
    	
    	deptService.updateDept(deptDTO);
    	
    	return "redirect:/dept/deptListForm"; 		
	}
    
    @PostMapping("/deptDeletePro")
    public String deptDeletePro(
    								  @RequestParam("deptCode") int deptCode
    								, Model model
    							)
    {
    	System.out.println("DeptController deptDeletePro Start");
    	
    	deptService.deleteDept(deptCode);
    	
    	System.out.println("DeptController deptDeletePro deleteDept ok");
    	
    	return "redirect:/dept/deptListForm"; 		
	}
    
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
    	
    	Paging paging = new Paging(totalCnt, currentPage);
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
    	
        return "sm/deptListForm"; 		
    }
    
}
