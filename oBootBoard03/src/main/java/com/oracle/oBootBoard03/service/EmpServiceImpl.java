package com.oracle.oBootBoard03.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.oBootBoard03.domain.Dept;
import com.oracle.oBootBoard03.domain.Emp;
import com.oracle.oBootBoard03.dto.DeptDto;
import com.oracle.oBootBoard03.dto.EmpDto;
import com.oracle.oBootBoard03.repository.DeptRepository;
import com.oracle.oBootBoard03.repository.EmpRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class EmpServiceImpl implements EmpService {

	private final EmpRepository empRepository;
	private final ModelMapper modelMapper;
	private final DeptRepository deptRepository;
	
	@Override
	public int totalEmp() {
		System.out.println("EmpServiceImpl totalEmp start...");
		
		
		return empRepository.getTotalCount();
	}

	@Override
	public List<EmpDto> empList(EmpDto empDto) {
		
		List<EmpDto> empList = empRepository.findAllEmp(empDto);
		System.out.println("EmpServiceImpl empList =>"+empList);
		
		List<EmpDto> empDtoList = new ArrayList<>();
		for(EmpDto dto : empList) {
			Dept dept = deptRepository.findById(dto.getDept_code());
		    dto.setDept_name(dept.getDept_name());
		    
			empDtoList.add(dto);
		}
		System.out.println("EmpServiceImpl empDtoList =>"+empDtoList);
		
		
		return empDtoList;
	}

	@Override
	public int empsave(EmpDto empDto) {
		Emp emp = addfile(empDto);
		System.out.println("EmpServiceImpl empsave emp => "+emp);
		if(emp.getDel_status()==null) emp.changeDel_status(false);
		Emp resultemp = empRepository.empSave(emp);
		System.out.println("EmpServiceImpl empsave emp => "+resultemp);
		
		
		return resultemp.getEmp_no();
	}

	private Emp addfile(EmpDto empDto) {
		// 업로드 처리가 끝난 파일들의 이름 리스트
		Emp emp = modelMapper.map(empDto, Emp.class);
		
		List<String> uploadfileNames = empDto.getUploadFileNames();
		if(uploadfileNames == null) return emp; 
		
		// Entity에게 uploadName명 넘겨줌  --> List<ProductImage> imageList 누적
		uploadfileNames.stream()
					   .forEach(uploadfileName->{
						   						emp.addImageString(uploadfileName);
					   			}
					   );
		
		return emp;
	}

	@Override
	public EmpDto getSingleEmp(int emp_no) {
		System.out.println("EmpServiceImpl getSingleEmp emp_no=>"+emp_no);
		Emp emp = empRepository.findById(emp_no);
		
		
		return new EmpDto(emp);
	}

	@Override
	public void updateEmp(EmpDto empDto) {
		System.out.println("EmpServiceImpl updateEmp empDto => "+empDto);
		
		Emp emp = empRepository.findById(empDto.getEmp_no());
		
		emp.changeEmpno(empDto.getEmp_no());
		emp.changeEmp_name(empDto.getEmp_name());
		emp.changeEmp_tel(empDto.getEmp_tel());
		emp.changeEmail(empDto.getEmail());
		emp.changeSal(empDto.getSal());
		emp.changeDept_code(empDto.getDept_code());
		emp.changeEmpId(empDto.getEmp_id());
		emp.changeEmp_password(empDto.getEmp_password());
		
			
		
		List<String> uploadFileNames = empDto.getUploadFileNames();
		if(uploadFileNames != null && uploadFileNames.size() > 0 ) {
			uploadFileNames.stream().forEach(
											uploadName -> {
															emp.addImageString(uploadName);
														   }
											);
		}
		empRepository.empSave(emp);
	}

	@Override
	public void deleteEmp(int emp_no) {
		System.out.println("EmpServiceImpl deleteEmp emp_no => "+emp_no);
		empRepository.deleteEmp(emp_no);
		
	}

	@Override
	public List<EmpDto> allEmpList() {
		
		return empRepository.allEmpList();
	}

	@Override
	public List<String> getEmpList(int emp_no) {
		System.out.println("EmpServiceImpl getEmpList emp_no=> "+emp_no);
		return empRepository.getEmpImgeLIst(emp_no);
	}

	@Override
	public void deleteEmpImage(List<String> removeFiles) {
		empRepository.deleteEmpImages(removeFiles);
		
	}

	

}
