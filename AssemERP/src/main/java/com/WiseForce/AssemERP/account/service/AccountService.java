package com.WiseForce.AssemERP.account.service;

import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;
import com.WiseForce.AssemERP.account.dto.AccountDTO;

public interface AccountService {

    int 				getAccountTotalCount(Map<String, Object> params);

    List<AccountDTO> 	getAllAccounts(Map<String, Object> params);

    AccountDTO 			getAccountByEmpNo(int empNo);

    AccountDTO 			getAccountByUserId(String userId);

    void 				registerAccount(AccountDTO accountDTO);

    void 				modifyAccount(AccountDTO accountDTO);

    void 				modifyPassword(AccountDTO accountDTO);

    void 				modifyProfile(AccountDTO accountDTO, MultipartFile profileImageFile);

    void 				withdrawAccount(String userId);

	void 				saveAccount(AccountDTO accountDTO);

	Integer 			selectVerify(AccountDTO accountDTO);

	int 				updatePartnerAccount(AccountDTO accountDTO);

}

