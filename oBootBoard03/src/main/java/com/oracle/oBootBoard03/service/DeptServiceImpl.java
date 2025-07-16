package com.oracle.oBootBoard03.service;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.oBootBoard03.domain.Dept;
import com.oracle.oBootBoard03.dto.DeptDto;
import com.oracle.oBootBoard03.dto.EmpDto;
import com.oracle.oBootBoard03.repository.DeptRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Transactional
@Log4j2
@RequiredArgsConstructor
public class DeptServiceImpl implements DeptService {

	//자동주입 대상은 final로 
    private final ModelMapper modelMapper;
    private final DeptRepository deptRepository;
    private final EmpService empService;
    
	@Override
	public Long totalDept() {
		System.out.println("DeptServiceImpl dept/list Strart...");
		Long totalCount =  deptRepository.deptTotalcount();
		return totalCount;
	}

	@Override
	public List<DeptDto> deptList(DeptDto deptDto) {
	    List<DeptDto> deptRtnList = deptRepository.findPageDept(deptDto);
	    System.out.println("DeptServiceImpl deptList deptRtnList->"+deptRtnList);	
	    return deptRtnList;
	 }

	@Override
	public int deptSave(DeptDto deptDto) {
		log.info("DeptServiceImpl deptSave start deptDto->"+deptDto);
		Dept dept = modelMapper.map(deptDto, Dept.class);
		if(dept.getDept_gubun()==null) dept.changeDept_gubun(false);
		Dept saveDept = deptRepository.deptSave(dept);
		return saveDept.getDept_code();
	}

	@Override
	public DeptDto getSingleDept(int dept_code) {
		// TODO Auto-generated method stub
		Dept dept = deptRepository.findById(dept_code);
		System.out.println("DeptServiceImpl getSingleDept dept->"+dept);
		DeptDto deptDto = modelMapper.map(dept, DeptDto.class );
		System.out.println("DeptServiceImpl getSingleDept deptDto->"+deptDto);
		
		return deptDto;
	}

	@Override
	public DeptDto deptUpdate(DeptDto deptDto) {
		Optional<Dept> maybeDept = deptRepository.findById2(deptDto.getDept_code());
		Dept dept = maybeDept.orElseThrow();
		dept.changeDept_name(deptDto.getDept_name());
		dept.changeDept_loc(deptDto.getDept_loc());
		dept.changeDept_tel(deptDto.getDept_tel());
		dept.changeDept_captain(deptDto.getDept_captain());
		dept.changeIn_date(deptDto.getIn_date());
	    System.out.println("DeptServiceImpl modify dept->"+dept);

	    Dept deptUpdateEntity = deptRepository.deptSave(dept);
		DeptDto deptRtnDto = modelMapper.map(deptUpdateEntity, DeptDto.class );
		return deptRtnDto;
    
	}

	@Override
	public void deleteDept(int dept_code) {
	    System.out.println("DeptServiceImpl deleteDept dept_code->"+dept_code);
		deptRepository.deleteById(dept_code);
		
	}

	@Override
	public List<DeptDto> deptAllList() {
		return deptRepository.findAllDept();
	}

	@Override
	public List<EmpDto> getempList() {
		
		return empService.allEmpList();
	}

}
