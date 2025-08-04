package com.WiseForce.AssemERP.dto.sm;

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
	private String 	username;
	private String 	password;	 
	private String 	rolesStatus; // "ROLE_ADMIN,ROLE_USER" 형태
	private int 	delStatus;
	private int 	registrar;
	private Date 	inDate;
	
	// 페이징 처리를 위한 추가 필드
    private int		start;
    private int		end;
    
    // EMP_IMAGE 테이블 (대표 이미지 1개)
    private String empFilename;
    
    // 검색 조건
    private String searchType;
    private String searchKeyword;
}
