package com.WiseForce.AssemERP.dto.sm;

import lombok.Data;

@Data
public class DeptSearchDTO 
{
	private int    	deptCode;
	private String 	deptName;
	private int    	parentDeptCode;
}
