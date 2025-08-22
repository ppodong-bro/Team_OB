package com.WiseForce.AssemERP.dto.sm;

import java.time.LocalDate;
import java.util.Date;

import com.WiseForce.AssemERP.account.dto.AccountDTO;

import lombok.Data;

@Data
public class EmpAccountDTO 
{ 
		// EMP 테이블
		private int 		empNo;
		private String 		empName;
		private String 		empTel;
		private String 		email;
		private long 		sal;
		private LocalDate 	hireDate;  
		private int 		gradeCode;
		private int 		deptCode;
		private int 		delStatus;
		private int 		registrar;
		private Date 		inDate;
		
		//-----------------------------------------------
		
	    private String      deptName;
		
		//-----------------------------------------------
		
	    private String 	empFilename;
	    
	    //-----------------------------------------------
		
		public EmpDTO toEmpDTO() 
		{
			EmpDTO empDTO = new EmpDTO();
			
			empDTO.setEmpNo(this.empNo);
			empDTO.setEmpName(this.empName);
			empDTO.setEmpTel(this.empTel);
			empDTO.setEmail(this.email);
			empDTO.setSal(this.sal);
			empDTO.setHireDate(this.hireDate);
			empDTO.setGradeCode(this.gradeCode);
			empDTO.setDeptCode(this.deptCode);
			empDTO.setDelStatus(this.delStatus);
			empDTO.setRegistrar(this.registrar);
			empDTO.setInDate(this.inDate);
			empDTO.setEmpFilename(this.empFilename);
			
			return empDTO;
		}
		
		//-----------------------------------------------
		
	    public EmpDTO getEmp() {
	        EmpDTO empDTO = new EmpDTO();
	        empDTO.setEmpNo(this.empNo);
	        empDTO.setEmpName(this.empName);
	        empDTO.setEmpTel(this.empTel);
	        empDTO.setEmail(this.email);
	        empDTO.setSal(this.sal);
	        empDTO.setHireDate(this.hireDate);
	        empDTO.setGradeCode(this.gradeCode);
	        empDTO.setDeptCode(this.deptCode);
	        empDTO.setDelStatus(this.delStatus);
	        empDTO.setRegistrar(this.registrar);
	        empDTO.setInDate(this.inDate);

	        empDTO.setDeptName(this.deptName);

	        return empDTO;
	    }
		
	    //-----------------------------------------------
	    
	    private String 		userId;
	    private String 		password;
	    private int 		rolesStatus;
	    private String		empType;		 
	    private Integer		approvalStatus;	 
	    private int 		withdrawStatus;
	    private LocalDate 	regDate;
	    
	    private String 	authRoleName;
	    
	    //-----------------------------------------------
	    
	    public AccountDTO toAccountDTO() 
	    {
	    	AccountDTO accountDTO = new AccountDTO();
	    	
	    	accountDTO.setUserId(this.userId);
	    	accountDTO.setPassword(this.password);
	    	accountDTO.setRolesStatus(this.rolesStatus);
	    	accountDTO.setEmpType(this.empType);
	    	accountDTO.setApprovalStatus(this.approvalStatus);
	    	accountDTO.setWithdrawStatus(this.withdrawStatus);
	    	accountDTO.setRegDate(this.regDate);
	    	accountDTO.setEmpNo(this.empNo);
	    	accountDTO.setAuthRoleName(this.authRoleName);

	    	return accountDTO;
		}
	    
	    //-----------------------------------------------
	    
	    public AccountDTO getAccount() 
	    {
	        if (this.userId == null || this.userId.isBlank()) {
	            return null; 
	        }
	        
	        AccountDTO accountDTO = new AccountDTO();
	        accountDTO.setUserId(this.userId);
	        accountDTO.setPassword(this.password);
	        accountDTO.setRolesStatus(this.rolesStatus);
	        accountDTO.setEmpType(this.empType);
	    	accountDTO.setApprovalStatus(this.approvalStatus);
	        accountDTO.setWithdrawStatus(this.withdrawStatus);
	        accountDTO.setRegDate(this.regDate);
	        accountDTO.setEmpNo(this.empNo);
	        
	        return accountDTO;
	    }
}
