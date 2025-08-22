package com.WiseForce.AssemERP.mapper.sm;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

@Mapper
public interface EmpMapper  
{

	int 			selectTotalEmpCount(EmpDTO empDTO);

	List<EmpDTO>	selectEmpList(EmpDTO empDTO);

	EmpDTO			selectEmpDetail(int empNo);

	void 			insertEmp(EmpDTO empDTO);

	void 			insertEmpAuto(EmpDTO empDTO);

	int 			updateEmp(EmpDTO empDTO);

	void 			deleteEmpUpt(int empNo);

	EmpDTO			searchEmpName(int empNo);

	EmpDTO 			findByUsernam(String empName); 

	Integer			selectSalaryPresetById(Integer presetId);

	Integer 		selectDefaultPresetIdByGrade(Integer defaultGradeCode);

	Long 			selecteSalaryByGradePreset(@Param("gradeCode") Integer gradeCode);

	void 			insertEmpResult(EmpDTO empDTO);

	Integer 		deleteEmpStatus(int empNo);

	List<CommonDTO> selectRoleCodes();

	Integer  		getNextInternalEmpNo();

	Integer  		getNextPartnerEmpNo();
}	

