package com.WiseForce.AssemERP.controller.sm;

import java.util.List;
import java.util.Objects;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.WiseForce.AssemERP.account.dto.AccountDTO;
import com.WiseForce.AssemERP.account.service.CustomUser;
import com.WiseForce.AssemERP.dto.sm.BoardDTO;
import com.WiseForce.AssemERP.service.sm.BoardService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardController 
{
	private final BoardService boardService;
	
    @GetMapping("/boardRegisterForm")
    @PreAuthorize("isAuthenticated()")
    public String boardRegisterForm(
    									@AuthenticationPrincipal(expression = "accountDTO") AccountDTO accountDTO,
    									Model model) 
    {
        System.out.println("BoardController boardRegisterForm Start");

        if (accountDTO == null) {
            return "redirect:/sm/loginForm?error=denied";
        }
        
        Integer empNo = accountDTO.getEmpNo();
        System.out.println("BoardController boardRegisterForm empNo -> " + empNo);

        model.addAttribute("loginEmpNo", empNo);
        return "sm/boardRegisterForm";
        
    }
    
//    @GetMapping("/boardRegisterForm")
//    public String boardRegisterForm(@AuthenticationPrincipal CustomUser principal, Model model) 
//    {
//        System.out.println("BoardController boardRegisterForm Start");
//        
//        Integer empNo = principal.getAccountDTO().getEmpNo();
//        
//        System.out.println("BoardController boardRegisterForm empNo->"+empNo);
//        
//        model.addAttribute("loginEmpNo", empNo);
//        
//    	return "sm/boardRegisterForm"; 	
//    }
    
    @PostMapping("/boardSavePro")
    public String boardSavePro(
    							  @ModelAttribute BoardDTO boardDTO
    							, Model model
    						  ) 
    {
    	System.out.println("BoardController boardSavePro Start");
    	
    	boardService.saveBoard(boardDTO); 
    	
    	int totalCount = boardService.getTotalCount(boardDTO);
    	
		int pageSize   = 10;
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		
		System.out.println("DeptController deptSavePro saveDept - OK");
    	
        return "redirect:/board/boardListForm?currentPage=1"; 
    }
    
    @GetMapping("/boardModifyForm")
    public String boardModifyForm(
    								  @RequestParam("boardNo") int boardNo
    								, Model model
    							 ) 
    {
    	System.out.println("BoardController boardModifyForm Start");
    	
    	BoardDTO boardDTO =  boardService.getBoardDetail(boardNo);
    	
    	model.addAttribute("board", boardDTO);
    	 
    	return "sm/boardModifyForm";  	
    }
    
    @PostMapping("/boardModifyPro")
    public String boardModifyPro(
								  	@ModelAttribute BoardDTO boardDTO
								  , Model model
								) 
    {
    	System.out.println("BoardController boardModifyPro Start");
    	
    	boardService.updateBoard(boardDTO);
    	
//    	return "redirect:/board/boardListForm";		
    	return "redirect:/board/boardListForm?currentPage=1"; 
	}
    
    @PostMapping("/boardDeletePro")
    public String boardDeletePro(
    								  @RequestParam("boardNo") int boardNo
    								, Model model
    							) 
    {
    	System.out.println("BoardController boardDeletePro Start");
    	
    	boardService.deleteBoard(boardNo);
    	
//    	return "redirect:/board/boardListForm";		
    	return "redirect:/board/boardListForm?currentPage=1"; 
	}
    
    @GetMapping("/boardListForm")
    public String boardListForm(
    								  BoardDTO boardDTO
    								, @RequestParam(value = "currentPage", defaultValue = "1") String currentPage  
    								, Model model
    						    ) 
    {
    	System.out.println("BoardController boardListForm Start");
    	
    	int totalCount = boardService.getTotalCount(boardDTO);
    	
    	System.out.println("BoardController boardListForm totalCount->"+totalCount);
    	System.out.println("BoardController boardListForm currentPage->"+Integer.parseInt(currentPage));
    	
    	Paging paging  = new Paging(totalCount, currentPage);
    	
    	boardDTO.setStart(paging.getStart());
    	boardDTO.setEnd(paging.getEnd());
    	
    	List<BoardDTO> boardList = boardService.getBoardList(boardDTO);
    	
    	model.addAttribute("totalCount", 	totalCount);
    	model.addAttribute("boardList", 	boardList);
    	model.addAttribute("paging", 		paging);
    	 
        return "sm/boardListForm"; 	
    }
}
