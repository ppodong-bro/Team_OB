package com.WiseForce.AssemERP.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.Getter;

@Getter
public class CustomUser extends User{
	
	private final EmpDTO emp;

    public CustomUser(
    					String username, 
    					String password, 
    					Collection<? extends GrantedAuthority> authorities, 
    					EmpDTO emp) {
        super(username, password, authorities);
        this.emp = emp;
    }

}
