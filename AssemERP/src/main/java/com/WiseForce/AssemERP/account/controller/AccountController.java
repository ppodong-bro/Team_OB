package com.WiseForce.AssemERP.account.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WiseForce.AssemERP.account.dto.AccountDTO;
import com.WiseForce.AssemERP.account.service.AccountService;
import com.WiseForce.AssemERP.account.service.CustomUser;
import com.WiseForce.AssemERP.util.Paging; // Paging 클래스의 실제 경로로 수정해주세요.

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AccountController {

    private final AccountService accountService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/sm/loginForm")
    public String loginForm(
				    		@RequestParam(value = "error" , required = false) String error,
				            @RequestParam(value = "exception" , required = false ) String exception,
				            Model model)
    {
    	System.out.println("AccountController loginForm Start");
    	
        model.addAttribute("error",error);
        model.addAttribute("exception",exception);
    	
        return "sm/loginForm";
    }
    
    @GetMapping("/sm/accountRegisterForm")
    public String accountRegisterForm() 
    {
    	System.out.println("AccountController accountRegisterForm Start");
        return "sm/accountRegisterForm";
    }

    @GetMapping("/sm/rePasswordForm")
    public String rePasswordForm() {
        return "sm/rePasswordForm";
    }

    @PostMapping("/account/rePasswordPro")
    public String rePasswordPro(AccountDTO accountDTO) {
        accountService.modifyPassword(accountDTO);
        return "redirect:/sm/loginForm";
    }

    @GetMapping("/sm/accountListForm")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    public String accountListForm(Model model,
                                  @RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
                                  @RequestParam(value = "searchType", required = false) String searchType,
                                  @RequestParam(value = "searchKeyword", required = false) String searchKeyword) {

        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("searchKeyword", searchKeyword);

        int totalCount = accountService.getAccountTotalCount(params);
        Paging paging = new Paging(totalCount, currentPage); 
        params.put("start", paging.getStart());
        params.put("end", paging.getEnd());

        List<AccountDTO> accountList = accountService.getAllAccounts(params);

        model.addAttribute("accountList",    accountList);
        model.addAttribute("paging",         paging);
        model.addAttribute("searchType",     searchType);
        model.addAttribute("searchKeyword",  searchKeyword);

        return "sm/accountListForm";
    }

    @GetMapping("/sm/accountModifyForm")
    @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
    public String accountModifyForm(@RequestParam("userId") String userId, Model model) {
        AccountDTO account = accountService.getAccountByUserId(userId);
        model.addAttribute("account", account);
        return "sm/accountModifyForm";
    }

    @PostMapping("/account/accountModifyPro")
    @PreAuthorize("hasRole('ADMIN')")
    public String accountModifyPro(AccountDTO accountDTO) {
        accountService.modifyAccount(accountDTO);
        return "redirect:/sm/accountListForm";
    }

    @GetMapping("/sm/profileForm")
    @PreAuthorize("isAuthenticated()") 
    public String profileForm(
    							Authentication  authentication, 
    							Model model
    						) {
    	CustomUser  userDetails = (CustomUser) authentication.getPrincipal();
        
        AccountDTO account = accountService.getAccountByUserId(userDetails.getUsername());
        model.addAttribute("account", account);
        
        return "sm/profileForm";
    }

    @PostMapping("/account/profilePro")
    @PreAuthorize("isAuthenticated()")
    public String profilePro(
    							  AccountDTO accountDTO
    							, @RequestParam("profileImageFile") MultipartFile profileImageFile
    						) 
    {
    	
    	System.out.println("AccountController profilePro Start");
    	
    	String redirectUrl = "redirect:/sm/profileForm";
    	
    	try {
            accountService.modifyProfile(accountDTO, profileImageFile); 
            redirectUrl += "?updateSuccess=true";
            
    	} catch (Exception e) {
    		
            redirectUrl += "?updateError=true";
            e.printStackTrace();
		}
    	
        System.out.println("AccountController profilePro End");
        
        return redirectUrl;
    }
    
    @GetMapping("/account/verifyPartnerPro")
    public String verifyPartnerPro(
    							  	AccountDTO accountDTO,
    							  	RedirectAttributes ra
    							  ) 
    {
    	System.out.println("AccountController verifyPartnerPro Start");
    	
    	String redirectUrl = "redirect:/sm/accountRegisterForm";
    	
    	try {
            Integer result = accountService.selectVerify(accountDTO); 
            
            ra.addAttribute("empNo",  accountDTO.getEmpNo());
            ra.addAttribute("userId", accountDTO.getUserId());
            
            if (result != null && result > 0)
            {
            	if (result != null && result > 0) {
                    ra.addAttribute("verified", "true");
                    ra.addAttribute("msg", "인증이 완료되었습니다.");
                } else {
                    ra.addAttribute("verified", "false");
                    ra.addAttribute("msg", "일치하는 사원 정보가 없습니다.");
                }
            } 
            
    	} catch (Exception e) {
    		
    		ra.addAttribute("verified", "false");
            ra.addAttribute("msg", "인증 중 오류가 발생했습니다.");
            e.printStackTrace();
    	}
    	
    	System.out.println("AccountController verifyPartnerPro End");
        return redirectUrl;
    }
    
    @PostMapping("/account/accountRegisterPro")
    public String accountRegisterPro(
    									@ModelAttribute AccountDTO accountDTO,
    									RedirectAttributes ra
    								) 
    {
        if (accountDTO.getUserId() == null || accountDTO.getUserId().isBlank()) {
        	accountDTO.setUserId("user" + accountDTO.getEmpNo());
        }
        
        accountDTO.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
        
        accountDTO.setApprovalStatus(2);
        accountDTO.setEmpType("EXTERNAL");

        try {
            int affected = accountService.updatePartnerAccount(accountDTO);
            if (affected > 0) 
            {
                ra.addFlashAttribute("toastSuccess", "가입되셨습니다. 관리자가 승인이 필요합니다.");
                return "redirect:/sm/accountRegisterForm";
            } else {
                ra.addFlashAttribute("toastError", "처리 대상이 없습니다. 사원번호를 확인해주세요.");
                return "redirect:/sm/accountRegisterForm";
            }
        } catch (org.springframework.dao.DuplicateKeyException e) {
            ra.addFlashAttribute("toastError", "이미 사용 중인 아이디입니다. 다른 아이디로 시도해주세요.");
            return "redirect:/sm/accountRegisterForm";
        } catch (Exception e) {
            ra.addFlashAttribute("toastError", "가입 처리 중 오류가 발생했습니다.");
            return "redirect:/sm/accountRegisterForm";
        }
    }
}
