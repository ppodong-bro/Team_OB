package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.mapper.sm.DeptMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DeptDaoImpl implements DeptDao 
{
	private final DeptMapper deptMapper;
	
	// 전체 부서 건수 조회(페이징)
	@Override
	public int selectTotalDeptCount(DeptDTO deptDTO) 
	{
		System.out.println("DeptDaoImpl getTotalDeptCount Start");
		
		return deptMapper.selectTotalDeptCount(deptDTO);
	}
	
	// 부서 목록 조회
	@Override
	public List<DeptDTO> selectDeptList(DeptDTO deptDTO) 
	{
		System.out.println("DeptDaoImpl selectDeptList Start");
		
		List<DeptDTO> deptList = deptMapper.selectDeptList(deptDTO);
		
		System.out.println("DeptDaoImpl selectDeptList deptList.size->"+deptList.size());
		
		return deptList;
	}
	
	// 부서 상세 조회
	@Override
	public DeptDTO selectDeptDetail(int deptCode) 
	{
		System.out.println("DeptDaoImpl selectDeptDetail Start");
		
		System.out.println("DeptDaoImpl selectDeptDetail deptCode->"+deptCode);
		
		return deptMapper.selectDeptDetail(deptCode);
	}

	// 신규 부서 등록
	@Override
	public void insertDept(DeptDTO deptDTO) 
	{
		System.out.println("DeptDaoImpl insertDept Start");
		
		deptMapper.insertDept(deptDTO);
		
		System.out.println("DeptDaoImpl insertDept -OK");
	}

	// 부서 정보 수정
	@Override
	public void updateDept(DeptDTO deptDTO) 
	{
		System.out.println("DeptDaoImpl updateDept Start");
		
		deptMapper.updateDept(deptDTO);
		
		System.out.println("DeptDaoImpl updateDept -OK");
	}

	// 부서 정보 삭제(삭제구분 업데이트)
	@Override
	public void deleteDept(int deptCode) 
	{
		System.out.println("DeptDaoImpl deleteDept Start");
		
		deptMapper.deleteDeptUpt(deptCode);
		
		System.out.println("DeptDaoImpl deleteDept -OK");
	}

}
