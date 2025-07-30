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
	private String 	password;	 // 평문 비밀번호를 임시 저장
	private String 	rolesStatus; // "ROLE_ADMIN,ROLE_USER" 형태
	private int 	delStatus;
	private int 	registrar;
	private Date 	inDate;
    
    // EMP_IMAGE 테이블 (대표 이미지 1개)
    private String empFilename;
}
