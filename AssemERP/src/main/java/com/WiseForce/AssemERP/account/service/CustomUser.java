package com.WiseForce.AssemERP.account.service;

import java.util.Collection;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import com.WiseForce.AssemERP.account.dto.AccountDTO;
import lombok.Getter;

@Getter
public class CustomUser extends User
{

	private final AccountDTO accountDTO;

 	public CustomUser(	  
 						  AccountDTO accountDTO
 						, Collection<? extends GrantedAuthority> auths
 						, boolean enabled
 					 ) 
 	{
		super(
				accountDTO.getUserId(), 
				accountDTO.getPassword(), 
				enabled, 
				true, true, true, auths

			 );
		this.accountDTO = accountDTO;
	}

 	public AccountDTO getAccountDTO() { return accountDTO; }
// 	public AccountDTO getAccount() { return accountDTO; }

    private static Collection<? extends GrantedAuthority> mapRolesToAuthorities(int rolesStatus) 
    {
        String roleName;
        switch (rolesStatus) {
            case 0:  roleName  = "ROLE_ADMIN";   break;
            case 1:  roleName  = "ROLE_MANAGER"; break;
            case 2:  roleName  = "ROLE_USER";    break;
            default: roleName  = "ROLE_USER";    break;
        }
        return List.of(new SimpleGrantedAuthority(roleName));
    }

}

