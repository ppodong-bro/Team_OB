package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.mapper.sm.EmpMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmpDaoimpl implements EmpDao 
{
	private final EmpMapper empMapper;	// Mapper를 주입받음

	// 전체 사원 건수 조회 (페이징)
	@Override
	public int selectTotalEmpCount(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl selectTotalEmpCount Start");
		
		int totalCnt = empMapper.selectTotalEmpCount(empDTO);
		
		System.out.println("EmpDaoimpl selectTotalEmpCount totalCnt->"+totalCnt);
		
		return totalCnt;
	}

	// 사원 목록 조회
	@Override
	public List<EmpDTO> selectEmpList(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl selectEmpList Start");
		
		List<EmpDTO> empList = empMapper.selectEmpList(empDTO);
		
		System.out.println("EmpDaoimpl selectEmpList empList.size()->"+empList.size());
		
		return empList;
	}
	
	// 사원 상세 조회
	@Override
	public EmpDTO selectEmpDetail(int empNo) 
	{
		System.out.println("EmpDaoimpl selectDeptDetail Start");
		
		EmpDTO empDetail =  empMapper.selectEmpDetail(empNo);
		
		System.out.println("EmpDaoimpl selectDeptDetail empNo->"+empNo);
		
		return empDetail;
	}

	// 신규 사원 등록
	@Override
	public void insertEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl insertEmp Start");
		
		empMapper.insertEmp(empDTO);
		
		System.out.println("EmpDaoimpl insertEmp ok");
		
	}

	// 사원 정보 수정
	@Override
	public void updateEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl updateEmp Start");
		
		empMapper.updateEmp(empDTO);
		
		System.out.println("EmpDaoimpl updateEmp ok");
		
	}
	
	// 사원 정보 삭제
	@Override
	public void deleteEmp(int empNo) 
	{
		System.out.println("EmpDaoimpl deleteEmp Start");
		
		empMapper.deleteEmpUpt(empNo);
		
		System.out.println("EmpDaoimpl deleteEmp ok");
		
	}

	// [타부서 조회용] 사원번호로 사원명 조회
	@Override
	public EmpDTO searchEmpName(int empNo) 
	{
		System.out.println("EmpDaoimpl searchEmpName Start");
		
		return empMapper.searchEmpName(empNo);
	}

	// [Custom조회용] 사원 정보 조회를 요청
	@Override
	public EmpDTO findByUsernam(String empName) 
	{
		System.out.println("EmpDaoimpl findByUsernam Start");
		
		return null;
	}

}
