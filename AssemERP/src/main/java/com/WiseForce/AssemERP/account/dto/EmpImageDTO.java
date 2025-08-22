package com.WiseForce.AssemERP.account.dto;

import lombok.Data;

@Data
public class EmpImageDTO 
{
	private int 	empNo;       	
    private int 	orderNum;    	
    private String  empFilename; 	
    
    @Override
    public String toString() {
        return  "EmpImageDTO{" +
                "empNo=" + empNo +
                ", orderNum=" + orderNum +
                ", empFilename='" + empFilename + '\'' +
                '}';
    }
}
