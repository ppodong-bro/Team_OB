package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

public interface EmpDao 
{
	// 전체 사원 건수 조회 (페이징)
	int 			selectTotalEmpCount(EmpDTO empDTO);
	
	// 사원 목록 조회
    List<EmpDTO>	selectEmpList(EmpDTO empDTO);
    
    // 사원 상세 조회
    EmpDTO  	  	selectEmpDetail(int empNo);

    // 신규 사원 등록
    void 			insertEmp(EmpDTO empDTO);

    // 사원 정보 수정
    void 			updateEmp(EmpDTO empDTO);

    // 사원 정보 삭제
    void 			deleteEmp(int empNo);
    
    // [사부서 조회용] 사원번호로 사원명 조회
    EmpDTO searchEmpName(int empNo);

    // [Custom조회용] 사원 정보 조회를 요청
	EmpDTO findByUsernam(String empName);

}
