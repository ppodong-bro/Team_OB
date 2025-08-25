package com.WiseForce.AssemERP.account.config;

import java.io.IOException;

import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import com.WiseForce.AssemERP.account.service.CustomUserDetailsService;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig
{
	private final CustomUserDetailsService 		customUserDetailsService;
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
    
	  @Bean
	  public WebSecurityCustomizer webSecurityCustomizer() {
		  return (web) -> web.ignoring()
		            .requestMatchers(PathRequest.toStaticResources().atCommonLocations());
	  }
      
      @Bean
      public AuthenticationFailureHandler customFailureHandler() {
          return new SimpleUrlAuthenticationFailureHandler() {
              @Override
              public void onAuthenticationFailure(
                      HttpServletRequest request,
                      HttpServletResponse response,
                      AuthenticationException ex
              ) throws IOException, ServletException {
            	  
                  AuthenticationException root = ex;
                  if (ex instanceof InternalAuthenticationServiceException && ex.getCause() instanceof AuthenticationException) {
                      root = (AuthenticationException) ex.getCause();
                  }
                  
                  String code = "bad"; 			// 기본: 아이디/비밀번호 오류
                  
                  if (root instanceof DisabledException) {
                      String msg = root.getMessage();
                      if ("APPROVAL_PENDING".equals(msg))       code = "approval";
                      else if ("APPROVAL_REJECTED".equals(msg)) code = "rejected";
                      else if ("PRE_REGISTERED".equals(msg))    code = "pre";
                      else if ("APPROVAL_REQUIRED".equals(msg)) code = "required";
                      else if ("ACCOUNT_WITHDRAWN".equals(msg) || "STATUS_BLOCKED".equals(msg)) code = "withdrawn";
                      else                                      code = "status";   
                  }else if (root instanceof BadCredentialsException || root instanceof UsernameNotFoundException) {
                      code = "bad";
                  }
                  else if (root instanceof AccountExpiredException) {
                      code = "expired";
                  }
                  else if (root instanceof CredentialsExpiredException) {
                      code = "pwexpired";
                  }
                  else if (root instanceof LockedException) {
                      code = "locked";
                  }
              
                  getRedirectStrategy().sendRedirect(
                		  								request, response, 
                		  								request.getContextPath() + "/sm/loginForm?error=" + code
                		  							);
              }
          };
      }
      
      @Bean
      public AccessDeniedHandler accessDeniedHandler() {
          return (request, response, ex) -> {
              response.sendRedirect(request.getContextPath() + "/sm/loginForm?error=denied");
          };
      }
      
      
      @Bean
      public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
          http
              .csrf(csrf -> csrf.disable()) 
              
              .authorizeHttpRequests(auth -> auth
            		  
    	              .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()

    	              .requestMatchers("/", "/main", "/api/**"
    	            		  		  ,"/sm/profileForm"
		    	            		   ).authenticated()
    	              
	                  .dispatcherTypeMatchers(
	                		  DispatcherType.FORWARD, 
	                		  DispatcherType.ERROR,
	                		  DispatcherType.INCLUDE
	                		  ).permitAll()  
                  
	                  .requestMatchers(
	                      "/sm/loginForm", 
	                      "/account/loginPro",
	                      "/sm/rePasswordForm", 
	                      "/sm/accountRegisterForm",   		// 회원가입 폼
	                      "/account/accountRegisterPro",    // 회원가입 저장(POST)
	                      "/account/verifyPartnerPro",      // 회원가입 인증(GET)
	                      "/account/rePasswordPro",
	                      "/profile-images/**",
	                      "/upload/**"
	                  ).permitAll()

	                  // =======================================================================================
	                  // 각 업무별 인증 필요 URL(특정 권한이 필요한 URL들)
	                  // =======================================================================================
	                  
	                  // ---------------------------------------------------------------------------------------
	                  // 1) 각 업무별 인증 필요 URL (HR) - ROLE_HR_MANAGER, ROLE_HR_USER
	                  // ---------------------------------------------------------------------------------------
	                  .requestMatchers("/emp/**").hasAnyAuthority("ROLE_ADMIN",     "ROLE_HR_MANAGER")
	                  .requestMatchers("/emp/empListForm").hasAnyAuthority("ROLE_ADMIN",     "ROLE_HR_MANAGER",
	                  			  "ROLE_ITEM_MANAGER", "ROLE_ORDER_MANAGER", "ROLE_INVENTORY_MANAGER")
	                  
	                  .requestMatchers("/dept/**").hasAnyAuthority("ROLE_ADMIN",    "ROLE_HR_MANAGER")
	                  .requestMatchers("/dept/deptListForm").hasAnyAuthority("ROLE_ADMIN",     "ROLE_HR_MANAGER",
                  			  	  "ROLE_ITEM_MANAGER", "ROLE_ORDER_MANAGER", "ROLE_INVENTORY_MANAGER")
	                  
	                  .requestMatchers("/board/**").hasAnyAuthority("ROLE_ADMIN",   "ROLE_HR_MANAGER")
	                  .requestMatchers("/board/boardListForm").hasAnyAuthority("ROLE_ADMIN",     "ROLE_HR_MANAGER",
              			  	  	  "ROLE_ITEM_MANAGER", "ROLE_ORDER_MANAGER", "ROLE_INVENTORY_MANAGER")
	                  
	                  .requestMatchers("/empAcc/**").hasAnyAuthority("ROLE_ADMIN",  "ROLE_HR_MANAGER")
	                  .requestMatchers("/api/**").hasAnyAuthority("ROLE_ADMIN", 	"ROLE_HR_MANAGER")
	                  
	                  .requestMatchers("/account/accountRegisterPro").hasAnyAuthority("ROLE_ADMIN",  "ROLE_HR_MANAGER", "ROLE_PARTNER")
	                  .requestMatchers("/account/verifyPartnerPro").hasAnyAuthority("ROLE_ADMIN",  "ROLE_HR_MANAGER", "ROLE_PARTNER")
	                  
	                  // ---------------------------------------------------------------------------------------
	                  // 2) 각 업무별 인증 필요 URL (ITEM) - ROLE_ITEM_MANAGER, ROLE_ITEM_USER
	                  // ---------------------------------------------------------------------------------------
	                  
	                  // ---------------------------------------------------------------------------------------
	                  // 3) 각 업무별 인증 필요 URL (ORDER) - ROLE_ORDER_MANAGER, ROLE_ORDER_USER
	                  // ---------------------------------------------------------------------------------------
	                  
	                  // ---------------------------------------------------------------------------------------
	                  // 4) 각 업무별 인증 필요 URL (INVENTORY) - ROLE_INVENTORY_MANAGER, ROLE_INVENTORY_USER
	                  // ---------------------------------------------------------------------------------------
	                  
	                  .anyRequest().authenticated()
              )
              
              .formLogin(form -> form
                  .loginPage("/sm/loginForm")
                  .loginProcessingUrl("/account/loginPro")
                  .usernameParameter("userId")
                  .passwordParameter("password")
                  .failureHandler(customFailureHandler())   	
                  .defaultSuccessUrl("/main", true)				
              )
              
              .logout(logout -> logout
                      .logoutUrl("/logout")                    	
                      .logoutSuccessUrl("/sm/loginForm?logout")	
                      .invalidateHttpSession(true)
                      .deleteCookies("JSESSIONID")
              )
              
              .exceptionHandling(exception -> exception
                  .accessDeniedHandler(accessDeniedHandler())
              )
          
	          .userDetailsService(customUserDetailsService);
          
          return http.build();
      }
}
