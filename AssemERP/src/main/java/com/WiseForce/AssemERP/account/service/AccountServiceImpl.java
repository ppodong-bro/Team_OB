package com.WiseForce.AssemERP.account.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.WiseForce.AssemERP.account.dao.AccountDAO;
import com.WiseForce.AssemERP.account.dto.AccountDTO;

@Service
public class AccountServiceImpl implements AccountService  //, UserDetailsService
{

    @Autowired
    private AccountDAO accountDAO;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Value("${file.upload-dir}")
    private String uploadDir;

    @Override
    public int getAccountTotalCount(Map<String, Object> params) 
    {
    	System.out.println("AccountServiceImpl getAccountTotalCount Start");
    	System.out.println("AccountServiceImpl getAccountTotalCount params->"+params);
    	
        return accountDAO.getAccountTotalCount(params);
    }

    @Override
    public List<AccountDTO> getAllAccounts(Map<String, Object> params) 
    {
    	System.out.println("AccountServiceImpl getAllAccounts Start");
    	System.out.println("AccountServiceImpl getAllAccounts params->"+params);
    	
        return accountDAO.findAllAccounts(params);
    }

    @Override
    public AccountDTO getAccountByEmpNo(int empNo) 
    {
    	System.out.println("AccountServiceImpl getAccountByEmpNo Start");
    	System.out.println("AccountServiceImpl getAccountByEmpNo empNo->"+empNo);
    	
        return accountDAO.findByEmpNo(empNo);
    }
    
    @Override
    public AccountDTO getAccountByUserId(String userId) 
    {
    	System.out.println("AccountServiceImpl getAccountByUserId Start");
    	System.out.println("AccountServiceImpl getAccountByUserId userId->"+userId);
    	
        return accountDAO.findByUserId(userId);
    }

    @Override
    @Transactional 
    public void registerAccount(AccountDTO accountDTO) 
    {
    	System.out.println("AccountServiceImpl registerAccount Start");
    	System.out.println("AccountServiceImpl registerAccount accountDTO->"+accountDTO.toString());
    	
        accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
        accountDTO.setRolesStatus(2);
        accountDAO.insertAccount(accountDTO);
    }

    @Override
    @Transactional
    public void modifyAccount(AccountDTO accountDTO) 
    {
    	System.out.println("AccountServiceImpl modifyAccount Start");
    	System.out.println("AccountServiceImpl modifyAccount accountDTO->"+accountDTO.toString());
    	
        accountDAO.updateAccount(accountDTO);
    }

    @Override
    @Transactional
    public void modifyPassword(AccountDTO accountDTO) 
    {
    	System.out.println("AccountServiceImpl modifyPassword Start");
    	System.out.println("AccountServiceImpl modifyPassword accountDTO->"+accountDTO.toString());
    	
        accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
        accountDAO.updatePassword(accountDTO);
    }

    @Override
    @Transactional
    public void modifyProfile(AccountDTO accountDTO, MultipartFile profileImageFile) 
    {
    	System.out.println("AccountServiceImpl modifyProfile Start");
    	System.out.println("AccountServiceImpl modifyProfile accountDTO->"+accountDTO.toString());
    	
        if (profileImageFile != null && !profileImageFile.isEmpty()) {
            try {
                String originalFilename = profileImageFile.getOriginalFilename();
                String storedFilename = UUID.randomUUID().toString() + "_" + originalFilename;

                File dest = new File(uploadDir + File.separator + storedFilename);
                
                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }

                profileImageFile.transferTo(dest);

                accountDTO.setEmpFilename(storedFilename);
                
                accountDAO.upsertEmpImage(accountDTO);

            } catch (IOException e) {
                e.printStackTrace();
                throw new RuntimeException("프로필 이미지 저장에 실패했습니다.", e);
            }
        }

        accountDAO.updateProfile(accountDTO);
    }

    @Override
    @Transactional
    public void withdrawAccount(String userId) 
    {
    	System.out.println("AccountServiceImpl withdrawAccount Start");
    	System.out.println("AccountServiceImpl withdrawAccount userId->"+userId);
    	
        accountDAO.withdrawAccount(userId);
    }

	@Override
	public void saveAccount(AccountDTO accountDTO) 
	{
		System.out.println("AccountServiceImpl saveAccount Start");
		
        accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
        accountDAO.insertAccount(accountDTO);
	}

	@Override
	public Integer selectVerify(AccountDTO accountDTO) 
	{
		System.out.println("AccountServiceImpl selectVerify Start");
		
		return accountDAO.selectVerify(accountDTO);
	}

	@Override
	public int updatePartnerAccount(AccountDTO accountDTO) 
	{
		System.out.println("AccountServiceImpl updatePartnerAccount Start");
		
		return accountDAO.updatePartnerAccount(accountDTO);
	}

}
