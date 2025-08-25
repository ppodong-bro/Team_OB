package com.WiseForce.AssemERP.controller.sm;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WiseForce.AssemERP.account.dto.AccountDTO;
import com.WiseForce.AssemERP.account.service.AccountService;
import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.sm.EmpAccountDTO;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.sm.EmpAccountService;
import com.WiseForce.AssemERP.service.sm.EmpService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/empAcc")
@RequiredArgsConstructor
public class EmpAccountController 
{
	private final EmpAccountService empAccountService;
	private final EmpService empService;
	private final AccountService accountService;
	
	@PostMapping("/empAccountSavePro")
    public String empAccountSavePro(
							    		@ModelAttribute EmpAccountDTO empAccountDTO,
									    @RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile,
									    @AuthenticationPrincipal(expression = "accountDTO.empNo") Integer  loginEmpNo,
									    Model model
    								) 
    {
		System.out.println("EmpAccountController empAccountSavePro Start");
		
		if (loginEmpNo == null) {
            return "redirect:/sm/loginForm?error=denied";
        }
		
		try {
		
			empAccountService.empAccountSavePro(empAccountDTO, profileImageFile, loginEmpNo); 
			
			EmpDTO searchCondition = new EmpDTO(); 
			int totalCount = empService.getTotalCount(searchCondition);
			int pageSize = 10;
	    	int totalPage = (int) Math.ceil((double)totalCount / pageSize);
	    	
	    	String redirectUrl = "redirect:/emp/empListForm?currentPage=" + totalPage + "&saveSuccess=true";
	        return redirectUrl;
	        
	    } catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "사원 등록 중 오류가 발생했습니다.");
	        return "sm/empRegisterForm"; 
		}
	}
    	
	@GetMapping("/empAccountModifyForm")
	public String empAccountModifyForm(@RequestParam("empNo") Integer empNo, Model model) {
		System.out.println("EmpAccountController empAccountModifyForm Start");

		EmpAccountDTO empAccountDTO = empAccountService.getEmpAccountDetail(empNo);

		model.addAttribute("empAccount", empAccountDTO); 
		model.addAttribute("emp", empAccountDTO.getEmp()); 
		model.addAttribute("account", empAccountDTO.getAccount()); 

		if (empAccountDTO.getEmp() != null) {
			model.addAttribute("gradeCode", empAccountDTO.getEmp().getGradeCode());
			model.addAttribute("sal", empAccountDTO.getEmp().getSal());
		}

		List<CommonDTO> rolesList = empService.selectRoleCodes();
		model.addAttribute("roleCodes", rolesList);

		return "sm/empModifyForm";
	}

	@PostMapping("/empAccountModifyPro")
	public String empAccountModifyPro(@ModelAttribute("emp") EmpDTO empDTO,
			@ModelAttribute("account") AccountDTO accountDTO, @ModelAttribute("empAccount") EmpAccountDTO empAccountDTO,
			@RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile,
			@RequestParam(value = "removeImage", defaultValue = "false") boolean removeImage, Model model,
			RedirectAttributes ra) {

		try {

			if ("INTERNAL".equalsIgnoreCase(empAccountDTO.getEmpType())) {
				empAccountDTO.setApprovalStatus(null);
			}

			empAccountService.updateEmpAccount(empDTO, accountDTO, empAccountDTO, profileImageFile, removeImage);
			ra.addFlashAttribute("msg", "수정이 완료되었습니다.");
			return "redirect:/emp/empListForm"; 

		} catch (IllegalArgumentException ex) {
			ra.addFlashAttribute("error", ex.getMessage());
			return "redirect:/empAcc/empAccountModifyForm?empNo=" + empDTO.getEmpNo();
		} catch (Exception ex) {
			ra.addFlashAttribute("error", "처리 중 오류가 발생했습니다.");
			return "redirect:/empAcc/empAccountModifyForm?empNo=" + empDTO.getEmpNo();
		}

	}

	@PostMapping("/empAccountDeletePro")
	public String empAccountDeletePro(@ModelAttribute("emp") EmpDTO empDTO,
			@ModelAttribute("account") AccountDTO accountDTO, Model model, RedirectAttributes ra) {
		System.out.println("EmpAccountController empAccountDeletePro Start");
		System.out.println("EmpAccountController empAccountDeletePro accountDTO" + accountDTO.toString());

		System.out.println(
				"EmpAccountController empAccountDeletePro " + empDTO.getEmpNo() + ":" + accountDTO.getUserId());

		Integer empNo = empDTO != null ? empDTO.getEmpNo() : null;
		String userId = accountDTO.getUserId();

		if (empNo == null && accountDTO != null)
			empNo = accountDTO.getEmpNo();

		if (empNo == null) {
			ra.addFlashAttribute("error", "사원번호(empNo)가 존재하지 않습니다. empNo=" + empNo);
		}

		if (userId == null) {
			ra.addFlashAttribute("error", "아이디(userId)가 존재하지 않습니다. userId=" + userId);
		}

		try {
			empAccountService.deleteEmpAccountUpt(empDTO, accountDTO);
			ra.addFlashAttribute("msg", "정상적으로 탈퇴/퇴사 처리되었습니다.");
			return "redirect:/emp/empListForm"; // empListForm.jsp 뷰를 반환
		} catch (IllegalArgumentException ex) {
			ra.addFlashAttribute("error", ex.getMessage());
			return "redirect:/empAcc/empAccountModifyForm?empNo=" + empNo;
		} catch (Exception ex) {
			ra.addFlashAttribute("error", "삭제 처리 중 오류가 발생했습니다.");
			return "redirect:/empAcc/empAccountModifyForm?empNo=" + empNo;
		}
	}
}
