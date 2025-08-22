package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.DeptSearchDTO;
import com.WiseForce.AssemERP.dto.sm.EmpSearchDTO;

public interface DeptService 
{
	int 				getTotalCount(DeptDTO deptDTO);
	
	List<DeptDTO>  		getDeptList(DeptDTO deptDTO);
	
	DeptDTO				getDeptDetail(int deptCode);
	
	void 				saveDept(DeptDTO deptDTO);
	
	void 				updateDept(DeptDTO deptDTO);
	
	void 				deleteDept(int deptCode);
	
	List<EmpSearchDTO> 	searchEmployeesByName(String keyword);
	
	List<DeptSearchDTO> findDepts(String deptName);
	
	List<DeptDTO> 		searchEmpAccByName(String deptName);
}
