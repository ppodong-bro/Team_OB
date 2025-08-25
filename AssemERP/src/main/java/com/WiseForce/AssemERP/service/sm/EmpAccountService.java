package com.WiseForce.AssemERP.service.sm;

import org.springframework.web.multipart.MultipartFile;

import com.WiseForce.AssemERP.account.dto.AccountDTO;
import com.WiseForce.AssemERP.dto.sm.EmpAccountDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

public interface EmpAccountService 
{
	void 			empAccountSavePro(
										EmpAccountDTO empAccountDTO
									  , MultipartFile profileImageFile, Integer loginEmpNo);
	
	void 			saveEmp(EmpDTO empDTO); 
	
	void 			saveAccount(AccountDTO accountDTO);
	
	void 			saveEmpImage(
									AccountDTO accountDTO
								  , MultipartFile profileImageFile);
	
	EmpAccountDTO 	getEmpAccountDetail(Integer empNo);
	
	void 			updateEmpAccount(
										  EmpDTO empDTO
										, AccountDTO accountDTO
										, EmpAccountDTO empAccountDTO
										, MultipartFile profileImageFile
										, boolean removeImage);
	
	void 			deleteEmpAccountUpt(
										  EmpDTO empDTO
									    , AccountDTO accountDTO);
	
}