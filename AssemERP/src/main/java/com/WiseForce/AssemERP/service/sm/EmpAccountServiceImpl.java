package com.WiseForce.AssemERP.service.sm;

import java.io.File;
import java.io.IOException;
import java.util.NoSuchElementException;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.WiseForce.AssemERP.account.dao.AccountDAO;
import com.WiseForce.AssemERP.account.dto.AccountDTO;
import com.WiseForce.AssemERP.account.service.CustomUser;
import com.WiseForce.AssemERP.dao.sm.EmpDao;
import com.WiseForce.AssemERP.dto.sm.EmpAccountDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmpAccountServiceImpl implements EmpAccountService 
{
	private final EmpDao 		  	empDao;
	private final AccountDAO 		accountDAO;
	private final PasswordEncoder 	passwordEncoder;
	
    @Value("${file.upload-dir}")
    private String uploadDir;
    
    @Override	
    @Transactional(rollbackFor = Exception.class) 
	public void empAccountSavePro(
									  EmpAccountDTO 	empAccountDTO
									, MultipartFile 	profileImageFile
									, Integer 			loginEmpNo
								  ) 
	{
		System.out.println("EmpAccountServiceImpl empAccountSavePro Start");

		try {
			
			Integer empNo;
			if ("EXTERNAL".equals(empAccountDTO.getEmpType())) {
                empNo = empDao.getNextPartnerEmpNo(); 
                System.out.println("Generated Partner EmpNo: " + empNo);
                
                String generatedUserId = "user" + empNo;
                empAccountDTO.setUserId(generatedUserId); 
                empAccountDTO.setRegistrar(loginEmpNo);	
                
            } else {
                empNo = empDao.getNextInternalEmpNo(); 
                System.out.println("Generated Internal EmpNo: " + empNo);
                
                String generatedUserId = "user" + empNo;
                empAccountDTO.setUserId(generatedUserId); 
                empAccountDTO.setRegistrar(loginEmpNo);	
            }
			
            empAccountDTO.setEmpNo(empNo);
            
            EmpDTO empDTO = empAccountDTO.toEmpDTO();
            AccountDTO accountDTO = empAccountDTO.toAccountDTO();
            
            String encodedPassword = passwordEncoder.encode(accountDTO.getPassword());
            accountDTO.setPassword(encodedPassword);
            
 			empDao.insertEmpAuto(empDTO); 				
 			accountDAO.insertAccount(accountDTO); 	
 			
		    if (profileImageFile != null && !profileImageFile.isEmpty()) {
		        saveEmpImage(accountDTO, profileImageFile); 
		    }
            
		} catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("사원 및 계정 정보 저장에 실패했습니다.", e);
		}
	}
    
    @Override
	public void saveEmp(EmpDTO empDTO) 
	{
		System.out.println("EmpAccountServiceImpl saveEmp Start");
		
        Authentication authentication = SecurityContextHolder
        							   .getContext()
        							   .getAuthentication();

        if (authentication != null && authentication.getPrincipal() instanceof CustomUser) 
        {
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            
            int empNo = customUser.getAccountDTO().getEmpNo();
            
            System.out.println("EmpAccountServiceImpl saveEmp empNo->"+empNo);
            
            empDTO.setRegistrar(empNo);
            
            System.out.println("EmpAccountServiceImpl saveEmp 1 Registrar->"+empNo);
        } else {
        	empDTO.setRegistrar(1005); 
        	System.out.println("EmpAccountServiceImpl saveEmp 2 Registrar->"+empDTO.getRegistrar());
        }
        
        empDao.insertEmpResult(empDTO);
	}
	
	@Override
	public void saveAccount(AccountDTO accountDTO) 
	{
		System.out.println("EmpAccountServiceImpl saveAccount Start");
		
        accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
        accountDAO.insertAccount(accountDTO);	
		
	}
	
	@Override
	public void saveEmpImage(AccountDTO accountDTO, MultipartFile profileImageFile) 
	{
		System.out.println("EmpAccountServiceImpl saveEmpImage Start");
		
		File dest = null;
		
        if (profileImageFile != null && !profileImageFile.isEmpty()) {
            try {
            	
            	File baseDir = new File(uploadDir); 
            	if (!baseDir.isAbsolute()) {                                           
                    baseDir = new File(System.getProperty("user.dir"), uploadDir);     
                }                                                                       
                if (!baseDir.exists()) { baseDir.mkdirs(); }                           

                String originalFilename = profileImageFile.getOriginalFilename();       
                if (originalFilename == null || originalFilename.isBlank()) {           
                    originalFilename = "profile.jpg";                                   
                }                                                                        
                originalFilename = new File(originalFilename).getName();                
                String storedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
                
                dest = new File(baseDir, storedFilename);                               
                
                if (!dest.getParentFile().exists()) {
                    dest.getParentFile().mkdirs();
                }

                profileImageFile.transferTo(dest);
                accountDTO.setEmpFilename(storedFilename);
                
                System.out.println("EmpAccountServiceImpl saveEmpImage empNo->" + accountDTO.getEmpNo());
                System.out.println("EmpAccountServiceImpl saveEmpImage storedFilename->"+storedFilename);
                
                accountDAO.upsertEmpImage(accountDTO);

            } catch (IOException e) 
            {
            	if(dest != null && dest.exists()) dest.delete();
                throw new RuntimeException("프로필 이미지 저장에 실패했습니다.", e);
            }
        }
	}

	@Override
	public EmpAccountDTO getEmpAccountDetail(Integer empNo) 
	{
		System.out.println("EmpAccountServiceImpl getEmpAccountDetail Start");
		
		if (empNo == null) {
            throw new IllegalArgumentException("사번(empNo)은 필수 값입니다.");
        }
		
		EmpDTO empDTO = empDao.selectEmpDetail(empNo);
		
		if(empDTO == null)
		{
			throw new NoSuchElementException("해당 사번의 사원을 찾을 수 없습니다. empNo=" + empNo);
		}
		

        AccountDTO accountDTO = accountDAO.findByEmpNo(empNo); 
        String empFilename = accountDAO.selectEmpImageFilename(empNo);
        EmpAccountDTO mergeDto = new EmpAccountDTO();
        
        mergeDto.setEmpNo(empDTO.getEmpNo());
        mergeDto.setEmpName(empDTO.getEmpName());
        mergeDto.setEmpTel(empDTO.getEmpTel());
        mergeDto.setEmail(empDTO.getEmail());
        mergeDto.setSal(empDTO.getSal());
        mergeDto.setHireDate(empDTO.getHireDate());
        mergeDto.setGradeCode(empDTO.getGradeCode());
        mergeDto.setDeptCode(empDTO.getDeptCode());
        mergeDto.setDelStatus(empDTO.getDelStatus());
        mergeDto.setRegistrar(empDTO.getRegistrar());
        mergeDto.setInDate(empDTO.getInDate());
        mergeDto.setDeptName(empDTO.getDeptName());      

        mergeDto.setEmpFilename(empFilename);

        mergeDto.setUserId(accountDTO.getUserId());
        mergeDto.setPassword(null);  
        mergeDto.setRolesStatus(accountDTO.getRolesStatus());
        mergeDto.setWithdrawStatus(accountDTO.getWithdrawStatus());
        mergeDto.setEmpType(accountDTO.getEmpType());
        mergeDto.setApprovalStatus(accountDTO.getApprovalStatus());
        mergeDto.setRegDate(accountDTO.getRegDate());
        mergeDto.setAuthRoleName(accountDTO.getAuthRoleName());
        
        System.out.println("EmpAccountServiceImpl getEmpAccountDetail regDate->"+accountDTO.getRegDate());
        System.out.println("EmpAccountServiceImpl getEmpAccountDetail RolesStatus->"+accountDTO.getRolesStatus());
		
		return mergeDto;
	}
	
	@Override
	@Transactional
	public void updateEmpAccount(
										EmpDTO empDTO
									, 	AccountDTO accountDTO
									, 	EmpAccountDTO empAccountDTO
									,	MultipartFile profileImageFile
									, 	boolean removeImage
								 ) 
	{
		System.out.println("EmpAccountServiceImpl updateEmpAccount Start");

		System.out.println("EmpAccountServiceImpl updateEmpAccount profileImageFile->"+profileImageFile);
		
		int empCnt = empDao.updateEmp(empDTO);
		
		System.out.println("EmpAccountServiceImpl updateEmp empCnt->"+empCnt);
		System.out.println("EMP 테이블 정보 업데이트 완료.");
		
		handleProfileImage(empDTO.getEmpNo(), accountDTO, profileImageFile, removeImage);
        
     	AccountDTO existingAccount = accountDAO.findByEmpNo(empDTO.getEmpNo());
		if (existingAccount == null) {
			throw new RuntimeException("업데이트할 계정 정보를 찾을 수 없습니다. empNo=" + empDTO.getEmpNo());
		}
		
		existingAccount.setWithdrawStatus(empDTO.getDelStatus());
		
		if (accountDTO.getRolesStatus() != 0) { 
		    existingAccount.setRolesStatus(accountDTO.getRolesStatus());
		}
		
     	if (accountDTO.getPassword() != null && !accountDTO.getPassword().isBlank()) {
     		
        	accountDTO.setWithdrawStatus(empDTO.getDelStatus());
        	accountDTO.setApprovalStatus(accountDTO.getApprovalStatus());
            accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
            
            accountDAO.updateEmpAccountPasswd(accountDTO);
            System.out.println("ACCOUNT 비밀번호 포함 정보 업데이트 완료.");
            
        } else {

			accountDTO.setWithdrawStatus(empDTO.getDelStatus());
			accountDTO.setApprovalStatus(accountDTO.getApprovalStatus());
			
			accountDAO.updateEmpAccountStatus(accountDTO);
			System.out.println("ACCOUNT 비밀번호 미포함 / 상태 정보 업데이트 완료.");
        }
	}
	
	
	private void handleProfileImage(int empNo, AccountDTO accountDTO, MultipartFile newImageFile, boolean removeImage) 
	{
		File baseDir = new File(uploadDir);
		
		if (!baseDir.isAbsolute()) {                                                          
	        baseDir = new File(System.getProperty("user.dir"), uploadDir);                    
	    }                                                                                     
	    if (!baseDir.exists()) { baseDir.mkdirs(); }                                          
	    System.out.println("[IMG] baseDir -> " + baseDir.getAbsolutePath());                  
	    
     	String oldFilename = accountDAO.selectEmpImageFilename(empNo);
     	
     	if (removeImage || (newImageFile != null && !newImageFile.isEmpty())) {
     		
            Integer delResult = accountDAO.deleteEmpImageFilename(empNo);
            
            System.out.println("deleteEmpImageFilename result -> " + delResult);
     		
            if (oldFilename != null && !oldFilename.isBlank()) { 
	            try {
	            	File oldFile = new File(baseDir, oldFilename);                             
	                if (oldFile.exists() && oldFile.delete()) {                                
	                    System.out.println("기존 프로필 이미지 파일 삭제 성공: " + oldFile.getAbsolutePath());
	                }
	            } catch (Exception e) {
	                System.err.println("기존 프로필 이미지 파일 삭제 실패: " + e.getMessage());
	            }
            }
     	}
     	
     	if (!removeImage && newImageFile != null && !newImageFile.isEmpty()) {
     		
     		try {
     			String originalFilename = newImageFile.getOriginalFilename();                  
                if (originalFilename == null || originalFilename.isBlank()) {                  
                    originalFilename = "profile.jpg";                                          
                }                                                                              
                originalFilename = new java.io.File(originalFilename).getName();               

                String storedFilename = java.util.UUID.randomUUID() + "_" + originalFilename;
                
                File dest = new File(baseDir, storedFilename);                                 
                if (dest.getParentFile() != null && !dest.getParentFile().exists()) {          
                    dest.getParentFile().mkdirs();                                             
                }
                
                newImageFile.transferTo(dest);
                accountDTO.setEmpFilename(storedFilename);
                accountDAO.upsertEmpImage(accountDTO);
                
                System.out.println("새 프로필 이미지 파일 저장 및 DB 업데이트 완료.");
     			
     		}catch (IOException e) {
                e.printStackTrace();
                throw new RuntimeException("프로필 이미지 저장에 실패했습니다. 서버 로그를 확인하세요.", e);
     		}
     	}
	}
	
	@Override
	@Transactional
	public void deleteEmpAccountUpt(
									    EmpDTO empDTO
									  , AccountDTO accountDTO
									) 
	{
		System.out.println("EmpAccountServiceImpl deleteEmpAccountUpt Start");
		
		Integer empNo = (empDTO != null ? empDTO.getEmpNo() : null);
        if (empNo == null && accountDTO != null) empNo = accountDTO.getEmpNo();
        if (empNo == null) throw new IllegalArgumentException("사원번호(empNo)가 존재하지 않습니다.");
        
        if(accountDTO.getUserId() == null) {
        	throw new IllegalArgumentException("계정(아이디)가 존재하지 않습니다. userId=" + accountDTO.getUserId());
        }
        
        System.out.println("EmpAccountServiceImpl deleteEmpAccountUpt empNo->"+empNo);
        
        Integer empCnt = empDao.deleteEmpStatus(empNo);
        
        System.out.println("EmpAccountServiceImpl deleteEmpAccountUpt empCnt->"+empCnt);
        
        Integer accCnt = accountDAO.withdrawEmpAccount(accountDTO);
        
        System.out.println("EmpAccountServiceImpl deleteEmpAccountUpt accCnt->"+accCnt);
        
        if(empCnt == 0) throw new IllegalArgumentException("사원번호가 존재하지 않습니다. empNo=" + empNo);
        if(accCnt == 0) throw new IllegalArgumentException("계정(아이디)가 존재하지 않습니다. userId=" + accountDTO.getUserId());
	}
}
