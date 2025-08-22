package com.WiseForce.AssemERP.account.mapper;

import org.apache.ibatis.annotations.Param;

import com.WiseForce.AssemERP.account.dto.AccountDTO;

public interface EmpImageMapper 
{

    int 	upsertEmpImage(AccountDTO accountDTO);

	String 	selectEmpImageFilename(@Param(value = "empNo") Integer empNo);

	int 	deleteEmpImageFilename(@Param(value = "empNo") Integer empNo);
}

