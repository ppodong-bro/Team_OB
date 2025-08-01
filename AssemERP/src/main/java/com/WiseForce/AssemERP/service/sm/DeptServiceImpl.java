package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.WiseForce.AssemERP.dao.sm.DeptDao;
import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.security.CustomUser;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class DeptServiceImpl implements DeptService 
{
	private final DeptDao deptDao;
	
	@Override
	public int getTotalCount(DeptDTO deptDTO) 
	{
		System.out.println("DeptServiceImpl getTotalCount Start");
		
		return deptDao.selectTotalDeptCount(deptDTO);
	}
	
	@Override
	public List<DeptDTO> getDeptList(DeptDTO deptDTO) 
	{
		System.out.println("DeptServiceImpl getDeptList Start");
		
		return deptDao.selectDeptList(deptDTO);
	}

	@Override
	public DeptDTO getDeptDetail(int deptCode) 
	{
		System.out.println("DeptServiceImpl getDeptDetail Start");
		
		System.out.println("DeptServiceImpl getDeptDetail deptCode->"+deptCode);
		
		return deptDao.selectDeptDetail(deptCode);
	}

	@Override
	public void saveDept(DeptDTO deptDTO) 
	{
		System.out.println("DeptServiceImpl saveDept Start");
		
		// 1. Spring Security의 컨텍스트에서 현재 사용자 인증 정보를 가져옵니다.
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 2. 인증된 사용자인지 확인하고 등록자(REGISTRAR)를 설정합니다.
        // principal이 CustomUser의 인스턴스인지 확인하여 로그인한 사용자인지 판별
        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) {
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            // 로그인한 사용자의 사원번호를 등록자로 설정
            deptDTO.setRegistrar(customUser.getEmp().getEmpNo());
            
            System.out.println("DeptServiceImpl saveDept 1 deptDTO.setRegistrar->"+customUser.getEmp().getEmpNo());
        } else {
            // 로그인하지 않은 경우 (시스템 초기 데이터 등) '시스템 관리자'의 번호를 등록자로 설정
        	deptDTO.setRegistrar(100); 
        	System.out.println("DeptServiceImpl saveDept 2 deptDTO.setRegistrar->"+deptDTO.getRegistrar());
        }
        
        // 3. 등록자 정보가 포함된 DTO를 DAO로 전달하여 저장합니다.
		deptDao.insertDept(deptDTO);
		
		System.out.println("DeptServiceImpl saveDept insertDept OK");
	}

	@Override
	public void updateDept(DeptDTO deptDTO) 
	{
		System.out.println("DeptServiceImpl updateDept Start");
		
		deptDao.updateDept(deptDTO);
	}

	@Override
	public void deleteDept(int deptCode) 
	{
		System.out.println("DeptServiceImpl deleteDept Start");
		
		deptDao.deleteDept(deptCode);
	}

}
