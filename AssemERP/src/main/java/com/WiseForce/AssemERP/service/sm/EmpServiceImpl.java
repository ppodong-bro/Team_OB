package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.WiseForce.AssemERP.account.service.CustomUser;
import com.WiseForce.AssemERP.dao.sm.EmpDao;
import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class EmpServiceImpl implements EmpService 
{
	private final EmpDao 		  empDao;
	private final PasswordEncoder passwordEncoder;

	@Override
	public int getTotalCount(EmpDTO empDTO) 
	{
		System.out.println("EmpServiceImpl getTotalCount Start");
		
		int totalCount = empDao.selectTotalEmpCount(empDTO);
		
		System.out.println("EmpServiceImpl getTotalCount totalCount->"+totalCount);
		
		return totalCount;
	}

	@Override
	public List<EmpDTO> empListForm(EmpDTO empDTO) 
	{
		System.out.println("EmpServiceImpl empListForm Start");
		
		List<EmpDTO> empList = empDao.selectEmpList(empDTO);
		
		System.out.println("EmpServiceImpl empListForm empList.size()->"+empList.size());
		
		return empList;
	}
	
//	@Override
//	public void saveEmp(EmpDTO empDTO) 
//	{
//		System.out.println("EmpServiceImpl saveEmp Start");
//		
//        Authentication authentication = SecurityContextHolder
//        							   .getContext()
//        							   .getAuthentication();
//
//        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) 
//        {
//            CustomUser customUser = (CustomUser) authentication.getPrincipal();
//            int empNo = customUser.getAccountDTO().getEmpNo();
//            empDTO.setRegistrar(empNo);
//            
//            System.out.println("EmpServiceImpl saveEmp 1 Registrar->"+empNo);
//        } else {
//        	empDTO.setRegistrar(1005); 
//        	System.out.println("EmpServiceImpl saveEmp 2 Registrar->"+empDTO.getRegistrar());
//        }
//        
//        empDao.insertEmp(empDTO);
//	}
	
	@Override
	public void saveEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpServiceImpl saveEmp Start");
		
//        Authentication authentication = SecurityContextHolder
//        							   .getContext()
//        							   .getAuthentication();

//        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) 
//        {
//            CustomUser customUser = (CustomUser) authentication.getPrincipal();
//            int empNo = customUser.getAccountDTO().getEmpNo();
//            empDTO.setRegistrar(empNo);
//            
//            System.out.println("EmpServiceImpl saveEmp 1 Registrar->"+empNo);
//        } else {
//        	empDTO.setRegistrar(1005); 
//        	System.out.println("EmpServiceImpl saveEmp 2 Registrar->"+empDTO.getRegistrar());
//        }
		
		System.out.println("EmpServiceImpl saveEmp  Registrar->"+empDTO.getRegistrar());
        
        empDao.insertEmp(empDTO);
	}
	
	@Override
	public EmpDTO getEmpDetail(int empNo) 
	{
		System.out.println("EmpServiceImpl getEmpDetail Start");
		
		System.out.println("EmpServiceImpl getEmpDetail empNo->"+empNo);
		
		return empDao.selectEmpDetail(empNo);
	}

	@Override
	public void updateEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpServiceImpl updateEmp Start");
		
		empDao.updateEmp(empDTO);
	}

	@Override
	public void deleteEmp(int empNo) 
	{
		System.out.println("EmpServiceImpl deleteEmp Start");
		
		empDao.deleteEmp(empNo);
	}
	
	@Override
	public void registerEmployee(EmpDTO emp) 
	{
		System.out.println("EmpServiceImpl registerEmployee start");
	}

	@Override
	public Integer getSalaryByPresetId(Integer presetId) 
	{
		System.out.println("EmpServiceImpl getSalaryByPresetId start");
		
		return empDao.selectSalaryPresetById(presetId);
	}

	@Override
	public Integer getDefaultPresetIdByGrade(Integer defaultGradeCode) 
	{
		System.out.println("EmpServiceImpl getDefaultPresetIdByGrade start");
		
		return empDao.selecteDefaultPresetIdByGrade(defaultGradeCode);	
	}

	@Override
	public Long getSalaryByGradePreset(Integer gradeCode) 
	{
		System.out.println("EmpServiceImpl getSalaryByGradePreset start");
		
        if (gradeCode == null ) return 0L;
        if (gradeCode < 10 || gradeCode > 100 || gradeCode % 10 != 0) return 0L;
        if (gradeCode == 888) return 0L; 
        
        Long sal = empDao.selecteSalaryByGradePreset(gradeCode);
		return sal != null ? sal : 0L;
	}

	@Override
	public List<CommonDTO> selectRoleCodes() 
	{
		System.out.println("EmpServiceImpl selectRoleCodes start");
		return empDao.selectRoleCodes();
	}
}
