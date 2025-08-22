package com.WiseForce.AssemERP.account.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class AccountDTO 
{
	private String 		userId;
    private String 		password;
    private int 		rolesStatus;
    private int 		empNo;
    private String		empType;		 
    private Integer		approvalStatus;	 
    private int 		withdrawStatus;
    private LocalDate 	regDate;

    private String 	empName;
    private String 	email;
    private String 	empTel;
    
    private String 	authRoleName; 
    
    private String 	empFilename;
    
    private int 	delStatus;
    
}
