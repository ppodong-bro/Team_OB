package com.WiseForce.AssemERP.mapper.sm;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;

@Mapper
public interface DeptMapper 
{
	// 부서 총건수 조회
	int 			selectTotalDeptCount(DeptDTO deptDTO);
	
	// 부서 목록 조회
	List<DeptDTO>	selectDeptList(DeptDTO deptDTO);
	
	// 부서 상세 조회
	DeptDTO			selectDeptDetail(int deptCode);
	
	// 신규 부서 등록
	void 			insertDept(DeptDTO deptDTO);
	
	// 부서 정보 수정
	void 			updateDept(DeptDTO deptDTO);
	
	// 부서 정보 삭제
	void 			deleteDeptUpt(int deptCode);
}
