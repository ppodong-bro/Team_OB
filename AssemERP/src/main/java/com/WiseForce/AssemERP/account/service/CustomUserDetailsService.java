package com.WiseForce.AssemERP.account.service;

import java.util.Collection;

import org.springframework.context.annotation.Primary;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.account.dao.AccountDAO;
import com.WiseForce.AssemERP.account.dto.AccountDTO;

import lombok.RequiredArgsConstructor;

@Service
@Primary
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService 
{
	private final AccountDAO accountDAO;	
	
	@Override
	public UserDetails loadUserByUsername(String userId) 
			throws UsernameNotFoundException  
	{
		System.out.println("CustomUserDetailsService loadUserByUsername Start");
    	System.out.println("CustomUserDetailsService loadUserByUsername userId->"+userId);
    	
		AccountDTO accountDTO = accountDAO.findByUserId(userId);
		
		System.out.println("CustomUserDetailsService loadUserByUsername accountDTO->"+accountDTO.toString());
		
		if(accountDTO == null)
		{
			throw new UsernameNotFoundException("User not found");
		}
		
		if(accountDTO.getPassword() == null || accountDTO.getPassword().isBlank()) {
			throw new InternalAuthenticationServiceException("Password not loaded");
		}
		
		System.out.println("CustomUserDetailsService getDelStatus->" + accountDTO.getDelStatus());
        System.out.println("CustomUserDetailsService getWithdrawStatus->" + accountDTO.getWithdrawStatus());
        System.out.println("CustomUserDetailsService getApprovalStatus->" + accountDTO.getApprovalStatus());
        
        String  empType   = accountDTO.getEmpType();                    // "INTERNAL" | "EXTERNAL"
        Integer approval  = accountDTO.getApprovalStatus();             // 1:대기, 2:승인, 3:반려, 8:선등록, 9:내부-승인불필요
        
		if( Integer.valueOf(1).equals(accountDTO.getDelStatus()) && 
            Integer.valueOf(1).equals(accountDTO.getWithdrawStatus())) {
			throw new DisabledException("ACCOUNT_WITHDRAWN");
		}
		
	    if ("EXTERNAL".equalsIgnoreCase(empType)) {
	        int ap = (approval == null ? -1 : approval);
	        switch (ap) {
	            case 2: break; // 승인만 통과
	            case 1: throw new DisabledException("APPROVAL_PENDING");
	            case 3: throw new DisabledException("APPROVAL_REJECTED");
	            case 8: throw new DisabledException("PRE_REGISTERED");
	            default: throw new DisabledException("APPROVAL_REQUIRED");
	        }
	    }
	    
	    Collection<? extends GrantedAuthority> auths;
	    
	    String rolesStr = accountDTO.getAuthRoleName();
	    if (rolesStr != null && !rolesStr.isBlank()) {
	        auths = AuthorityUtils.commaSeparatedStringToAuthorityList(rolesStr.trim());
	    } else {
	        auths = AuthorityUtils.createAuthorityList("ROLE_USER");
	    }
	    
	    boolean enabled = true; // 계정 활성화 상태 (필요에 따라 로직 추가)
	    
	    return new CustomUser(accountDTO, auths, enabled);
	    
//	    return org.springframework.security.core.userdetails.User
//	            .withUsername(accountDTO.getUserId())
//	            .password(accountDTO.getPassword())
//	            .authorities(auths)     
//	            .accountExpired(false)
//	            .accountLocked(false)
//	            .credentialsExpired(false)
//	            .disabled(false)                       
//	            .build();
	}
	
	private Collection<? extends GrantedAuthority> authoritiesFromDb(AccountDTO a) {
	    String s = a.getAuthRoleName();
	    if (s != null && !s.isBlank()) {
	        return AuthorityUtils.commaSeparatedStringToAuthorityList(s.trim());
	    }
	    return AuthorityUtils.createAuthorityList("ROLE_USER");
	}
}   
	
