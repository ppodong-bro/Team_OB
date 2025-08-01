package com.WiseForce.AssemERP.dto.sm;

import java.util.Date;

import lombok.Data;

@Data
public class DeptDTO 
{
	// Dept 테이블 컬럼
	private int    	deptCode;
	private String 	deptName;
	private int    	deptCaptain;
	private int    	parentDeptCode;
	private String 	deptLoc;
	private String 	locDetail;
	private int    	delStatus;
	private int    	registrar;
	private Date   	inDate;

    // 페이징 처리를 위한 추가 필드
    private int		start;
    private int		end;
    
    // Emp Ref.
    private String  registrarName;
    
    // 검색 조건
    private String searchType;
    private String searchKeyword;
  
}