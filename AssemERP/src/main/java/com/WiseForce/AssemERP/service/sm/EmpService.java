package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.EmpAccountDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

public interface EmpService 
{
	int 			getTotalCount(EmpDTO empDTO);
	
	List<EmpDTO> 	empListForm(EmpDTO empDTO);
	
	void            saveEmp(EmpDTO empDTO); 
	
	EmpDTO			getEmpDetail(int empNo);
	
	void 			updateEmp(EmpDTO empDTO);
	
	void 			deleteEmp(int empNo);
	
	void 			registerEmployee(EmpDTO emp);
	
	Integer	 		getSalaryByPresetId(Integer presetId);
	
	Integer         getDefaultPresetIdByGrade(Integer defaultGradeCode);
	
	Long            getSalaryByGradePreset(Integer gradeCode);
	
	List<CommonDTO> selectRoleCodes();
}
