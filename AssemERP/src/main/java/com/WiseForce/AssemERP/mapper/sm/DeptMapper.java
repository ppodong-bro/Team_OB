package com.WiseForce.AssemERP.mapper.sm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.DeptSearchDTO;
import com.WiseForce.AssemERP.dto.sm.EmpSearchDTO;

@Mapper
public interface DeptMapper  
{
	int 				selectTotalDeptCount(DeptDTO deptDTO);
	
	List<DeptDTO>		selectDeptList(DeptDTO deptDTO);
	
	DeptDTO				selectDeptDetail(int deptCode);
	
	void 				insertDept(DeptDTO deptDTO);

	void 				updateDept(DeptDTO deptDTO);
	
	void 				deleteDeptUpt(int deptCode);
	
	List<EmpSearchDTO> 	searchEmployeesByName(@Param("keyword") String keyword);
	
	DeptDTO 			selectDeptByCode(int deptCode);

	List<DeptSearchDTO> searchDeptModalList(@Param("deptName") String deptName);

	List<DeptDTO>       searchEmpAccByName(@Param("deptName") String deptName);
}
