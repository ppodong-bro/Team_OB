package com.oracle.oBootBoard03.service;

import java.util.List;

import com.oracle.oBootBoard03.dto.EmpDto;

public interface EmpService {
	int 			totalEmp();
	List<EmpDto>	empList(EmpDto empDto);
	int 			empsave(EmpDto empDto);
	EmpDto 			getSingleEmp(int emp_no);
	void 			updateEmp(EmpDto empDto);
	void 			deleteEmp(int emp_no);
	List<EmpDto> 	allEmpList();
	List<String> 	getEmpList(int emp_no);
	void 			deleteEmpImage(List<String> removeFiles);
	
	
}
