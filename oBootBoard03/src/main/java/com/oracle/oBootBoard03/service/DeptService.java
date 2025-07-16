package com.oracle.oBootBoard03.service;

import java.util.List;

import com.oracle.oBootBoard03.dto.DeptDto;
import com.oracle.oBootBoard03.dto.EmpDto;

public interface DeptService {
	Long 			totalDept();
	List<DeptDto>	deptList(DeptDto deptDto);
	int             deptSave(DeptDto deptDto);
	DeptDto         getSingleDept(int dept_code);
	DeptDto         deptUpdate(DeptDto deptDto);
	void            deleteDept(int dept_code);
	List<DeptDto> 	deptAllList();
	List<EmpDto> 	getempList(); 
}
