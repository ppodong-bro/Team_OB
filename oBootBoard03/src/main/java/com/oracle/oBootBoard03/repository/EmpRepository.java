package com.oracle.oBootBoard03.repository;

import java.util.List;

import com.oracle.oBootBoard03.domain.Emp;
import com.oracle.oBootBoard03.dto.EmpDto;

public interface EmpRepository {
	List<EmpDto> 	findAllEmp(EmpDto empDto);
	Emp         	empSave(Emp emp);
	int 			getTotalCount();
	Emp 			findById(int emp_no);
	int 			updateEmp(EmpDto empDto);
	void 			deleteEmp(int emp_no);
	List<EmpDto> 	allEmpList();
	List<String> 	getEmpImgeLIst(int emp_no);
	void 			deleteEmpImages(List<String> removeFiles);

}
