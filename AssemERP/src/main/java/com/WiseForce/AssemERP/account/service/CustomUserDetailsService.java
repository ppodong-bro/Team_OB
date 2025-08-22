package com.WiseForce.AssemERP.account.service;

import java.util.Collection;

import org.springframework.context.annotation.Primary;
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
		
		System.out.println("CustomUserDetailsService loadUserByUsername getDelStatus->"+accountDTO.getDelStatus());
		System.out.println("CustomUserDetailsService loadUserByUsername getWithdrawStatus->"+accountDTO.getWithdrawStatus());
		
		boolean blocked = Integer.valueOf(1).equals(accountDTO.getDelStatus())
                       && Integer.valueOf(1).equals(accountDTO.getWithdrawStatus());
		
		Collection<? extends GrantedAuthority> auths = AuthorityUtils.createAuthorityList(accountDTO.getAuthRoleName());
		
        return new CustomUser(accountDTO, auths, !blocked);
	}
}   
        