package com.WiseForce.AssemERP.dao.sm;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.WiseForce.AssemERP.dto.CommonDTO;
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
    int 			updateEmp(EmpDTO empDTO);

    // 사원 정보 삭제
    void 			deleteEmp(int empNo);
    
    // [사부서 조회용] 사원번호로 사원명 조회
    EmpDTO 			searchEmpName(int empNo);

    // [Custom조회용] 사원 정보 조회를 요청
	EmpDTO 			findByUsernam(String empName);
	
	// 프리셋 급여 조회
	Integer 		selectSalaryPresetById(Integer presetId);

	// 직급 조회
	Integer 		selecteDefaultPresetIdByGrade(Integer defaultGradeCode);

	// 급여 프리셋 + 직급에 따른 급여 조회 
	Long     		selecteSalaryByGradePreset(@Param("gradeCode") Integer gradeCode);

	// 신규 사원 등록(empNo) 결과 리턴
	void insertEmpResult(EmpDTO empDTO);
	
	// 사원 정보 삭제(Return)
    Integer 		deleteEmpStatus(int empNo);

    // 권한구분 공통코드 조회
	List<CommonDTO> selectRoleCodes();
	
	// 사내 계정용 시퀀스(EMP_NO_SEQ)에서 다음 사원번호를 가져오는 쿼리
	Integer getNextInternalEmpNo();
	
	// 파트너 계정용 시퀀스(EMP_NO_PARTNER_SEQ)에서 다음 사원번호를 가져오는 쿼리
	Integer getNextPartnerEmpNo();

    // 신규 사원 등록(사원번호 자동 채번)
	void insertEmpAuto(EmpDTO empDTO);

}
