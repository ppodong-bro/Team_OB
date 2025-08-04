package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.sm.EmpDTO;

public interface EmpService 
{
	int 			getTotalCount(EmpDTO empDTO);
	List<EmpDTO> 	empListForm(EmpDTO empDTO);
	void            saveEmp(EmpDTO empDTO); 
	EmpDTO			getEmpDetail(int empNo);
	void 			updateEmp(EmpDTO empDTO);
	void 			deleteEmp(int empNo);
	
	void 			registerEmployee(EmpDTO emp);
	
}
