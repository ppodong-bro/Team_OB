package com.oracle.oBootBoard03.dto;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;


import com.oracle.oBootBoard03.domain.Emp;
import com.oracle.oBootBoard03.domain.EmpImage;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmpDto {
	private int 		emp_no;
	private String  	emp_password;
	private String  	emp_name;
	private String  	email;
	private String  	emp_tel;
	private Long    	sal;
	private Boolean  	del_status;
	private int         dept_code;
	private LocalDate   in_date;
	private String      emp_id;
	
	
	
	
	// Dept Name 조회용
	private String		dept_name;
	
	// page 조회용
	private String 		currentPage;
	private int			start;
	private int			end;
	private	String		pageNum;
	
    // 2. 엔티티 객체를 받아서 DTO로 변환하는 생성자 (더 편리!)
    public	EmpDto(Emp emp) {
        this.emp_no 		= emp.getEmp_no();
        this.emp_password 	= emp.getEmp_password();
        this.emp_name   	= emp.getEmp_name();
        this.email 			= emp.getEmail();
        this.emp_tel 		= emp.getEmp_tel();
        this.sal     		= emp.getSal();
        this.del_status		= emp.getDel_status();
        this.in_date     	= emp.getIn_date();
        this.dept_code		= emp.getDept_code();
        this.emp_id			= emp.getEmp_id();
        
        
    }
    
    private String simage;
    
    @Builder.Default
    private List<MultipartFile> files = new ArrayList<>();
    
    @Builder.Default
    private List<String> uploadFileNames = new ArrayList<>();
    

	

}
