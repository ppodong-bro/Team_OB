package com.WiseForce.AssemERP.service.sm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.WiseForce.AssemERP.account.service.CustomUser;
import com.WiseForce.AssemERP.dao.sm.DeptDao;
import com.WiseForce.AssemERP.dto.sm.DeptDTO;
import com.WiseForce.AssemERP.dto.sm.DeptSearchDTO;
import com.WiseForce.AssemERP.dto.sm.EmpSearchDTO;
import com.WiseForce.AssemERP.mapper.sm.DeptMapper;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class DeptServiceImpl implements DeptService 
{
	private final DeptDao deptDao;
	
	@Autowired
	private DeptMapper deptMapper;
	
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
		
        Authentication authentication = SecurityContextHolder
        							   .getContext()
        							   .getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) 
        {
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            
            int empNo = customUser.getAccountDTO().getEmpNo();
            
            deptDTO.setRegistrar(empNo);
            
            System.out.println("DeptServiceImpl saveDept 1 Registrar->"+empNo);
        } else {
        	deptDTO.setRegistrar(1005); 
        	System.out.println("DeptServiceImpl saveDept 2 Registrar->"+deptDTO.getRegistrar());
        }
        
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

	@Override
	public List<EmpSearchDTO> searchEmployeesByName(String keyword) 
	{
		System.out.println("DeptServiceImpl searchEmployeesByName Start");
		
		return deptMapper.searchEmployeesByName(keyword);
	}

	@Override
	public List<DeptSearchDTO> findDepts(String deptName) 
	{
		System.out.println("DeptServiceImpl findDepts Start");
		
		return deptMapper.searchDeptModalList(deptName);
	}

	@Override
	public List<DeptDTO> searchEmpAccByName(String deptName) 
	{
		System.out.println("DeptServiceImpl searchEmpAccByName Start");
		List<DeptDTO> rtnDeptList = deptMapper.searchEmpAccByName(deptName);
		System.out.println("DeptServiceImpl searchEmpAccByName rtnDeptList->"+rtnDeptList);
		
		return rtnDeptList;
	}

}
