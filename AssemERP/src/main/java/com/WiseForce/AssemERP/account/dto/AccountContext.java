package com.WiseForce.AssemERP.account.dto;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import lombok.Data;

@Data
public class AccountContext implements UserDetails {
	private static final long serialVersionUID = 1L;
	
	private AccountDTO accountDto;
	private final List<GrantedAuthority> roles;
	

	public AccountContext(AccountDTO accountDto , List<GrantedAuthority> roles) {
        this.accountDto = accountDto;
        this.roles = roles;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return roles;
	}

	@Override
	public String getUsername() {
		return accountDto.getUserId();
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return accountDto.getPassword();
	}
}
