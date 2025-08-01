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
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.sm.EmpService;
import com.WiseForce.AssemERP.service.sm.Paging;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/emp")
@RequiredArgsConstructor
public class EmpController 
{
    private final EmpService empService;
    
    // 사원 등록 페이지를 보여주는 메서드
    @GetMapping("/empRegisterForm")
    public String empRegisterForm() 
    {
    	System.out.println("EmpController empRegisterForm Start");
    	
        return "sm/empRegisterForm"; 	// empRegisterForm.jsp 뷰를 반환
    }
    
    // 사원 정보를 등록하는 메서드
    @PostMapping("/empSavePro")
    public String empSavePro(
    							  @ModelAttribute EmpDTO empDTO
    							, Model model
    						) 
    {
    	System.out.println("EmpController empSavePro Start");
    	
    	empService.saveEmp(empDTO);
    	
    	int totalCount = empService.getTotalCount(empDTO);
    	
    	int pageSize = 10;
    	int totalPage = (int) Math.ceil((double)totalCount / pageSize);
    	
    	System.out.println("EmpController empSavePro totalPage-> "+totalPage);
    	
        return "redirect:/emp/empListForm?currentPage="+totalPage; 		// empListForm.jsp 뷰를 반환
    }
    
    // 사원 수정 페이지를 보여주는 메서드
    @GetMapping("/empModifyForm")
    public String empModifyForm(
						    		   @RequestParam("empNo") int empNo
						    		 , Model model
    							) 
    {
    	System.out.println("EmpController empModifyForm Start");
    	
    	System.out.println("EmpController empModifyForm empNo->"+empNo);
    	
    	EmpDTO empDTO = empService.getEmpDetail(empNo);
    
    	model.addAttribute("emp", empDTO);
    	
    	System.out.println("EmpController empModifyForm ok");
    	
    	return "sm/empModifyForm"; 	// empModifyForm.jsp 뷰를 반환
    }
    
    // 사원 정보를 수정하는 메서드
    @PostMapping("/empModifyPro")
    public String empModifyPro(
    							  @ModelAttribute EmpDTO empDTO
    							, Model model
    							) 
    {
    	System.out.println("EmpController empModifyPro Start");
    	
    	empService.updateEmp(empDTO);
    	
    	return "redirect:/emp/empListForm"; 		// empListForm.jsp 뷰를 반환
    }
    
    // 사원 정보를 삭제하는 메서드
    @PostMapping("/empDeletePro")
    public String empDeletePro(
						    		  @RequestParam("empNo") int empNo
									, Model model
    							)
    {
    	System.out.println("EmpController empDeletePro Start");
    	
    	empService.deleteEmp(empNo);
    	
    	return "redirect:/emp/empListForm"; 		// empListForm.jsp 뷰를 반환
    }
    
    // 사원 목록 조회 페이지를 보여주는 메서드
    @GetMapping("/empListForm")
    public String empListForm(
    							  EmpDTO empDTO
    							, @RequestParam(value = "currentPage", defaultValue = "1") String currentPage
    							, Model model
    						  ) 
    {
    	System.out.println("EmpController empListForm Start");
    	
    	int totalCnt = empService.getTotalCount(empDTO);
    	
    	System.out.println("EmpController empListForm totalCnt->"+ totalCnt);
    	
    	Paging paging = new Paging(totalCnt, Integer.parseInt(currentPage));
    	
    	empDTO.setStart(paging.getStart());
    	empDTO.setEnd(paging.getEnd());
    	
    	List<EmpDTO> empDtoList = empService.empListForm(empDTO);
    	
    	model.addAttribute("totalCount", 	totalCnt);
    	model.addAttribute("empList", 		empDtoList);
    	model.addAttribute("paging", 		paging);
    	model.addAttribute("searchType", 	empDTO.getSearchType());
    	model.addAttribute("searchKeyword", empDTO.getSearchKeyword());
    	
        return "sm/empListForm"; 		// empListForm.jsp 뷰를 반환
    }

}