package com.oracle.oBootBoard03.repository;

import java.util.List;
import java.util.Optional;

import com.oracle.oBootBoard03.domain.Dept;
import com.oracle.oBootBoard03.dto.DeptDto;

public interface DeptRepository  {
	
	Long           deptTotalcount();
	
	List<DeptDto>  findAllDept();
	List<DeptDto>  findPageDept(DeptDto deptDto);
	Dept           deptSave(Dept dept);
	Dept           findById(int dept_code);
	Optional<Dept> findById2(int dept_code);
	void           deleteById(int dept_code);

	
}
