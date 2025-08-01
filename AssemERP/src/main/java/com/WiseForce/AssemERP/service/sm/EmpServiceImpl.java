package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.WiseForce.AssemERP.dao.sm.EmpDao;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.security.CustomUser;

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
	
	@Override
	public void saveEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpServiceImpl saveEmp Start");
		
		// 1. Spring Security의 컨텍스트에서 현재 사용자 인증 정보를 가져옵니다.
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 2. 인증된 사용자인지 확인하고 등록자(REGISTRAR)를 설정합니다.
        // principal이 CustomUser의 인스턴스인지 확인하여 로그인한 사용자인지 판별
        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            // 로그인한 사용자의 사원번호를 등록자로 설정
            empDTO.setRegistrar(customUser.getEmp().getEmpNo());
            
            System.out.println("DeptServiceImpl saveEmp 1 empDTO.setRegistrar->"+customUser.getEmp().getEmpNo());
        } else {
            // 로그인하지 않은 경우 (시스템 초기 데이터 등) '시스템 관리자'의 번호를 등록자로 설정
        	empDTO.setRegistrar(100); 
        	System.out.println("DeptServiceImpl saveEmp 2 empDTO.setRegistrar->"+empDTO.getRegistrar());
        }
        
        // 3. 등록자 정보가 포함된 DTO를 DAO로 전달하여 저장합니다.
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
		
        String rawPassword = emp.getPassword();
        String encodedPassword = passwordEncoder.encode(rawPassword);
        emp.setPassword(encodedPassword);
        //empDao.save(emp);
	}
}
