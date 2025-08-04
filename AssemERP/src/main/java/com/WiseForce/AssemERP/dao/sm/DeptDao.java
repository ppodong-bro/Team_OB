package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;

public interface DeptDao 
{
	// 전체 부서 건수 조회(페이징)
    int 			selectTotalDeptCount(DeptDTO deptDTO);
	
	// 부서 목록 조회
    List<DeptDTO> 	selectDeptList(DeptDTO deptDTO);
    
    // 부서 상세 조회
    DeptDTO  	  	selectDeptDetail(int deptCode);

    // 신규 부서 등록
    void 			insertDept(DeptDTO dept);

    // 부서 정보 수정
    void 			updateDept(DeptDTO dept);

    // 부서 정보 삭제
    void 			deleteDept(int deptCode);

}