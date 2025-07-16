package com.oracle.oBootBoard03.dto;


import java.time.LocalDateTime;
import com.oracle.oBootBoard03.domain.Dept;


import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeptDto {
	private int 			dept_code;
	private String 			dept_name;
	private int 			dept_captain;
	private String 			dept_tel;
	private String 			dept_loc;
	private Boolean 		dept_gubun;
	private LocalDateTime   in_date;
	
	// 조회용
	private String      pageNum;  
	private int 		start; 		 	   
	private int 		end;
	private String      currentPage;

	
    // 2. 엔티티 객체를 받아서 DTO로 변환하는 생성자 (더 편리!)
    public DeptDto(Dept dept) {
        this.dept_code 		= dept.getDept_code();
        this.dept_name 		= dept.getDept_name();
        this.dept_captain   = dept.getDept_captain();
        this.dept_tel 		= dept.getDept_tel();
        this.dept_loc 		= dept.getDept_loc();
        this.dept_gubun     = dept.getDept_gubun();
        this.in_date        = dept.getIn_date();
    }
}
