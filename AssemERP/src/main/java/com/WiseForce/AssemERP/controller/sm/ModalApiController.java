package com.WiseForce.AssemERP.controller.sm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.DeptSearchDTO;
import com.WiseForce.AssemERP.dto.sm.EmpSearchDTO;
import com.WiseForce.AssemERP.service.sm.DeptService;

import lombok.RequiredArgsConstructor;

@Controller 
@RequestMapping("/api/search")
@RequiredArgsConstructor
public class ModalApiController 
{
    private final DeptService deptService;

    @GetMapping(value = "/searchEmpModal", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public ResponseEntity<List<EmpSearchDTO>> searchEmpModal(
    		 @RequestParam(name = "empName", required = false, defaultValue = "") String empName) 
    {
    	System.out.println("ModalApiController searchEmpModal Start");
    	System.out.println("ModalApiController searchEmpModal empName->"+empName);
    	
    	String keyword = (empName == null) ? "" : empName.trim();
    	
    	List<EmpSearchDTO> empList = deptService.searchEmployeesByName(keyword.trim());
    	
    	System.out.println("ModalApiController searchEmpModal empList->"+empList.toString());
    	
        return ResponseEntity.ok(empList);
    }
    
    @GetMapping(value = "/searchParentDeptModal", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public ResponseEntity<List<DeptSearchDTO>> searchParentDeptModal(
		    									@RequestParam(value = "deptName", required = false) String  deptName
		    							 	   ) 
    {
    	System.out.println("ModalApiController searchParentDeptModal Start");
    	System.out.println("ModalApiController searchParentDeptModal deptName->"+deptName);
    	
    	String keyword = (deptName == null) ? "" : deptName.trim();
    	
        List<DeptSearchDTO> deptList = deptService.findDepts(keyword.trim());
        
        System.out.println("ModalApiController searchParentDeptModal deptList->"+deptList.toString());
        
        return ResponseEntity.ok(deptList);	
    }
    
    @GetMapping("/searchEmpAccountModal")
    public String searchEmpAccountModal(
    										  @RequestParam(value = "deptName", required = false) String  deptName
    										, Model model
										) 
    {
    	if (deptName == null) deptName = "%";
    	System.out.println("ModalApiController searchEmpAccountModal Start");
    	System.out.println("ModalApiController searchEmpAccountModal k2 keyword->"+deptName);
    	
        List<DeptDTO> deptList = deptService.searchEmpAccByName(deptName);
        
        model.addAttribute("deptModalList", deptList);	
        
        return "sm/deptSearchModal";	
    }
}
