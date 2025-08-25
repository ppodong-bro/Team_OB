package com.WiseForce.AssemERP.account.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.account.dto.AccountDTO;
import com.WiseForce.AssemERP.account.mapper.AccountMapper;
import com.WiseForce.AssemERP.account.mapper.EmpImageMapper;

@Repository
public class AccountDAO {

	@Autowired
	private AccountMapper accountMapper;
	
    @Autowired
    private EmpImageMapper empImageMapper;

	public AccountDTO findByUserId(String userId) {
		return accountMapper.findByUserId(userId);
	}

	public int getAccountTotalCount(Map<String, Object> params) {
        return accountMapper.getAccountTotalCount(params);
    }

    public List<AccountDTO> findAllAccounts(Map<String, Object> params) {
        return accountMapper.findAllAccounts(params);
    }

    public AccountDTO findByEmpNo(int empNo) {
        return accountMapper.findByEmpNo(empNo);
    }

    public int insertAccount(AccountDTO account) {
        return accountMapper.insertAccount(account);
    }

    public int updateAccount(AccountDTO account) {
        return accountMapper.updateAccount(account);
    }

	public int updatePassword(AccountDTO accountDTO) {
		return accountMapper.updatePassword(accountDTO);
	}

	public int updateProfile(AccountDTO accountDTO) {
		return accountMapper.updateProfile(accountDTO);
	}

	public int withdrawAccount(String userId) {
		return accountMapper.withdrawAccount(userId);
	}

    public int upsertEmpImage(AccountDTO accountDTO) {
        return empImageMapper.upsertEmpImage(accountDTO);
    }

	public String selectEmpImageFilename(Integer empNo) {
		return empImageMapper.selectEmpImageFilename(empNo);
	}
	
    public int updateEmpAccountPasswd(AccountDTO account) {
        return accountMapper.updateEmpAccountPasswd(account);
    }
    
    public int updateEmpAccountStatus(AccountDTO account) {
        return accountMapper.updateEmpAccountStatus(account);
    }
    
    public int deleteEmpImageFilename(Integer empNo) 
    {
    	System.out.println("AccountDAO deleteEmpImageFilename Start");
    	System.out.println("AccountDAO deleteEmpImageFilename empNo->"+empNo);
    	
    	Integer result = empImageMapper.deleteEmpImageFilename(empNo);
    	
    	System.out.println("AccountDAO deleteEmpImageFilename result->"+result);
        return result;
    }
    
	public Integer withdrawEmpAccount(AccountDTO account) {
		System.out.println("AccountDAO withdrawEmpAccount getEmpNo->"+account.getEmpNo());
		System.out.println("AccountDAO withdrawEmpAccount getUserId"+account.getUserId());
		return accountMapper.withdrawEmpAccount(account);
	}

	public String selectVerify(AccountDTO accountDTO) 
	{
		System.out.println("AccountDAO selectVerify Start");
    	System.out.println("AccountDAO selectVerify empNo->"+accountDTO.getEmpNo());
    	System.out.println("AccountDAO selectVerify userId->"+accountDTO.getUserId());
    	
		return accountMapper.selectVerify(accountDTO);
	}

	public int updatePartnerAccount(AccountDTO accountDTO) 
	{
		System.out.println("AccountDAO updatePartnerAccount Start");
		return accountMapper.updatePartnerAccount(accountDTO);
	}

}
