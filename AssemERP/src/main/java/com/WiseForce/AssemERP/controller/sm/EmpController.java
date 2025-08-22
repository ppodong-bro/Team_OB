package com.WiseForce.AssemERP.controller.sm;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.sm.EmpService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/emp")
@RequiredArgsConstructor
public class EmpController 
{
    private final EmpService empService;
    
    @GetMapping("/empRegisterForm")
    public String empRegisterForm(
    								@RequestParam(value = "presetId", required = false) Integer presetId,
    								Model model
    							  ){
    	System.out.println("EmpController empRegisterForm Start");
    	
    	Integer defaultGradeCode = 10; 
    	
    	System.out.println("EmpController empRegisterForm defaultGradeCode->"+defaultGradeCode);
    	
        if (presetId == null) {
        	
        	Integer defaultPresetId = empService.getDefaultPresetIdByGrade(defaultGradeCode);
        	
        	System.out.println("EmpController presetId == null defaultPresetId->"+defaultPresetId);
            presetId = defaultPresetId;
        }
        
        List<CommonDTO> rolesList = empService.selectRoleCodes();
        
        Integer sal = null;
        Integer sal2 = null;
        if (presetId != null) {
            sal = empService.getSalaryByPresetId(presetId);
            sal2 = sal;
            System.out.println("EmpController presetId not null sal->"+sal);
        }
    	
        model.addAttribute("roleCodes", rolesList);
        model.addAttribute("gradeCode", defaultGradeCode);
        model.addAttribute("presetId",  presetId);
        model.addAttribute("sal", sal); 
    	
        return "sm/empRegisterForm"; 	
    }
    
    @GetMapping(value = "/empSalaryByGradePreset", produces = "application/json")
    public ResponseEntity<Long> empSalaryByGradePreset(
					            @RequestParam("gradeCode") Integer  gradeCode
    ) {
    	System.out.println("EmpController getSalaryByGradePreset gradeCode->"+gradeCode);
    	
        Long salary = empService.getSalaryByGradePreset(gradeCode);
        
        System.out.println("EmpController getSalaryByGradePreset salary->"+salary);
     
        if (salary == null) salary = 0L;
        
        return ResponseEntity.ok(salary);
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
    	
        return "redirect:/emp/empListForm?currentPage="+totalPage; 		
    }
    
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
    	
    	return "sm/empModifyForm"; 	
    }

    @PostMapping("/empModifyPro")
    public String empModifyPro(
    							  @ModelAttribute EmpDTO empDTO
    							, Model model
    							) 
    {
    	System.out.println("EmpController empModifyPro Start");
    	
    	empService.updateEmp(empDTO);
    	
    	return "redirect:/emp/empListForm"; 		
    }
    
    @PostMapping("/empDeletePro")
    public String empDeletePro(
						    		  @RequestParam("empNo") int empNo
									, Model model
    							)
    {
    	System.out.println("EmpController empDeletePro Start");
    	
    	empService.deleteEmp(empNo);
    	
    	return "redirect:/emp/empListForm"; 		
    }
    
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
    	
    	Paging paging = new Paging(totalCnt, currentPage);
    	
    	empDTO.setStart(paging.getStart());
    	empDTO.setEnd(paging.getEnd());
    	
    	List<EmpDTO> empDtoList = empService.empListForm(empDTO);
    	
    	model.addAttribute("totalCount", 	totalCnt);
    	model.addAttribute("empList", 		empDtoList);
    	model.addAttribute("paging", 		paging);
    	model.addAttribute("searchType", 	empDTO.getSearchType());
    	model.addAttribute("searchKeyword", empDTO.getSearchKeyword());
    	
        return "sm/empListForm"; 		
    }

}