package com.WiseForce.AssemERP.account.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.WiseForce.AssemERP.account.dto.AccountDTO;

@Mapper
public interface AccountMapper 
{
	AccountDTO 			findByUserId(String userId);

	int 				getAccountTotalCount(Map<String, Object> params);

	List<AccountDTO> 	findAllAccounts(Map<String, Object> params);

	AccountDTO 			findByEmpNo(int empNo);

	int 				insertAccount(AccountDTO accountDTO);

	int 				updateAccount(AccountDTO accountDTO);

	int 				updatePassword(AccountDTO accountDTO);

	int 				updateProfile(AccountDTO accountDTO);

	int 				withdrawAccount(String userId);

	int 				updateEmpAccountPasswd(AccountDTO account);
	
	int 				updateEmpAccountStatus(AccountDTO account);
	
	Integer 			withdrawEmpAccount(AccountDTO account);

	String 				selectVerify(AccountDTO accountDTO);

	int 				updatePartnerAccount(AccountDTO accountDTO);
	
}
