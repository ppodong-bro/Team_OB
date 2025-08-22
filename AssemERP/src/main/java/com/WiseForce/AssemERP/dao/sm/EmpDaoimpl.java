package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.CommonDTO;
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
	public int updateEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl updateEmp Start");
		
		int updateCnt = empMapper.updateEmp(empDTO);
		
		System.out.println("EmpDaoimpl updateEmp ok");
		return updateCnt;
		
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
		
		return empMapper.findByUsernam(empName); 
	}
	
	// 프리셋 급여 조회
	public Integer selectSalaryPresetById(Integer presetId)
	{
		System.out.println("EmpDaoimpl selectSalaryPresetById Start");
		
		return empMapper.selectSalaryPresetById(presetId);
	}

	// 직급 조회
	@Override
	public Integer selecteDefaultPresetIdByGrade(Integer defaultGradeCode) 
	{
		System.out.println("EmpDaoimpl selectDefaultPresetIdByGrade Start");
		
		return empMapper.selectDefaultPresetIdByGrade(defaultGradeCode);
	}

	// 급여 프리셋 + 직급에 따른 급여 조회 
	@Override
	public Long selecteSalaryByGradePreset(
									@Param("gradeCode") Integer gradeCode
//            @Param("salaryCode") Integer salaryCode
            ) 
	{
		System.out.println("EmpDaoimpl selecteDefaultPresetIdByGrade Start");
		
		return empMapper.selecteSalaryByGradePreset(gradeCode);
	}

	@Override
	public void insertEmpResult(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl insertEmpResult Start");
		
		empMapper.insertEmpResult(empDTO);
		
		System.out.println("EmpDaoimpl insertEmpResult ok");
	}

	@Override
	public Integer deleteEmpStatus(int empNo) 
	{
		System.out.println("EmpDaoimpl deleteEmpStatus Start");
		
		return empMapper.deleteEmpStatus(empNo);
	}

	// 권한구분 공통코드 조회
	@Override
	public List<CommonDTO> selectRoleCodes() 
	{
		System.out.println("EmpDaoimpl selectRoleCodes Start");
		
		return empMapper.selectRoleCodes();
	}

	// 사내 계정용 시퀀스(EMP_NO_SEQ)에서 다음 사원번호를 가져오는 쿼리
	@Override
	public Integer getNextInternalEmpNo() 
	{
		return empMapper.getNextInternalEmpNo();
	}

	// 파트너 계정용 시퀀스(EMP_NO_PARTNER_SEQ)에서 다음 사원번호를 가져오는 쿼리
	@Override
	public Integer getNextPartnerEmpNo() 
	{
		return empMapper.getNextPartnerEmpNo();
	}

	// 신규 사원 등록(사원번호 자동 채번)
	@Override
	public void insertEmpAuto(EmpDTO empDTO) 
	{
		System.out.println("EmpDaoimpl insertEmpAuto Start");
		
		empMapper.insertEmpAuto(empDTO);
		
		System.out.println("EmpDaoimpl insertEmpAuto ok");
	}
}
