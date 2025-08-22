package com.WiseForce.AssemERP.dto.sm;

import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class EmpDTO 
{
	// EMP 테이블
	private int 	empNo;
	private String 	empName;
	private String 	empTel;
	private String 	email;
	private long 	sal;
	private int 	deptCode;
	private int 	delStatus;
	private int 	registrar;
	private Date 	inDate;
	
	private LocalDate 	hireDate;  
	private int 		gradeCode;
	
	private String		deptName;
	
	// 페이징 처리를 위한 추가 필드
    private int		start;
    private int		end;
    
    // EMP_IMAGE 테이블 (대표 이미지 1개)
    private String 	empFilename;
    
    // COMMOM 테이블 
    private int 	middleStatus;	// 중분류
	private String 	context;		// 내용
    
    // 검색 조건
    private String searchType;
    private String searchKeyword;
	
}
