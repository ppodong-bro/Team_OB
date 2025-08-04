package com.WiseForce.AssemERP.mapper.sm;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.WiseForce.AssemERP.dto.sm.EmpDTO;

@Mapper
public interface EmpMapper 
{
	// 사원 총건수 조회
	int 			selectTotalEmpCount(EmpDTO empDTO);
	
	// 사원 목록 조회
	List<EmpDTO>	selectEmpList(EmpDTO empDTO);
	
	// 사원 상세 조회
	EmpDTO			selectEmpDetail(int empNo);
	
	// 신규 사원 등록
	void 			insertEmp(EmpDTO empDTO);
	
	// 사원 정보 수정
	void 			updateEmp(EmpDTO empDTO);
	
	// 사원 정보 삭제
	void 			deleteEmpUpt(int empNo);
	
	// 타파트 조회용(사원명 조회) 추가예정
	EmpDTO			searchEmpName(int empNo);
	
	// [Custom조회용] 사원 정보 조회를 요청
	EmpDTO findByUsernam(String empName); 
}
