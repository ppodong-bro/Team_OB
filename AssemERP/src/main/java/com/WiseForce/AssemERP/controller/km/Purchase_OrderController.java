package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WiseForce.AssemERP.dto.km.Purchase_OrderDto;
import com.WiseForce.AssemERP.dto.km.Purchase_OrderSearchDto;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.service.km.Purchase_OrderService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;

@RequestMapping("/purchase")
@RequiredArgsConstructor
@Controller
public class Purchase_OrderController {
	private final Purchase_OrderService purchase_OrderService;
	
	@GetMapping("/list")
	public String listPurchase(Purchase_OrderSearchDto purchase_OrderSearchDto, Model model) {
		System.out.println("listStart purchase_OrderSearchDto"+purchase_OrderSearchDto);
		int totCnt = purchase_OrderService.totPurchase(purchase_OrderSearchDto);
		Paging page = new Paging(totCnt, purchase_OrderSearchDto.getCurrentPage());
		purchase_OrderSearchDto.setStart(page.getStart());
		purchase_OrderSearchDto.setEnd(page.getEnd());
		List<Purchase_OrderDto> listPurchase = purchase_OrderService.listPurchaseOrder(purchase_OrderSearchDto); 
		model.addAttribute("listPurchase", listPurchase );
		model.addAttribute("paging", page);
		model.addAttribute("Purchase_OrderSearchDto", purchase_OrderSearchDto);
		return "km/purchase_OrderList";
	}
	
	@GetMapping("/detail")
	public String detailPurchase(@RequestParam("purchase_No") int purchase_No, Model model) {
		Purchase_OrderDto purchase_OrderDto = purchase_OrderService.detailPurchase(purchase_No);
		model.addAttribute("Purchase_OrderDto", purchase_OrderDto);
		return "km/detailPurchase";
	}
	
//	@GetMapping("/createStart")
//	public String createStart(Model model, RedirectAttributes ra) {
//		try {
//			
//			purchase_OrderService.checkClose();
//			model.addAttribute("client_Gubun", 0);
//			return "km/purchaseCreate";
//			
//		} catch(IllegalArgumentException e) {
//			
//			ra.addFlashAttribute("error", e.getMessage());
//			return "redirect:/purchase/list";
//		}
//	}
	
	@GetMapping("/createStart")
	public String purchaseCreateStart(
	        @ModelAttribute("prefillShortagesJson") String prefillShortagesJson,
	        Model model, RedirectAttributes ra) {
		try {		
			purchase_OrderService.checkClose();
			   // 플래시에 없다면 빈 배열 문자열로 기본값
		    if (prefillShortagesJson == null || prefillShortagesJson.isBlank()) {
		        prefillShortagesJson = "[]";
		    }
		    model.addAttribute("client_Gubun", 0);
		    model.addAttribute("prefillShortagesJson", prefillShortagesJson);
			return "km/purchaseCreate";
			
		} catch(IllegalArgumentException e) {
			
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/purchase/list";
		}
		
	}
	
	@PostMapping("/create")
	public String createPurchase(Purchase_OrderDto purchase_OrderDto, RedirectAttributes ra) {
		String result = purchase_OrderService.createPurchase(purchase_OrderDto);
		
		if(result == "발주 등록 성공") {
			ra.addFlashAttribute("success", result);
		} else if(result == "발주 등록 실패") {
			ra.addFlashAttribute("error", result);
		}
		
		return "redirect:/purchase/list";
	}
	
	@GetMapping("/partsPopup")
	public String partsPop(@RequestParam("parts_Name") String parts_Name, Model model) {
		List<PartsDTO> listParts = purchase_OrderService.partsPop(parts_Name);
		model.addAttribute("listParts", listParts);
		return "km/partsPop";
	}
	
	@GetMapping("/modifyStart")
	public String modifyStart(@RequestParam("purchase_No")int purchase_No, Model model, RedirectAttributes ra) {
		try {
			purchase_OrderService.checkClose();
			Purchase_OrderDto purchase_OrderDto = purchase_OrderService.detailPurchase(purchase_No);
			model.addAttribute("purchase_OrderDto", purchase_OrderDto);
			model.addAttribute("client_Gubun", 0);
			return "km/modifyPurchase";
		
		} catch(IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/purchase/list";
		}
	}
	
	@GetMapping("/detailPageModifyStart")
	public String detailPageModifyStart(@RequestParam("purchase_No")int purchase_No, Model model, RedirectAttributes ra) {
		try {
			purchase_OrderService.checkClose();
			Purchase_OrderDto purchase_OrderDto = purchase_OrderService.detailPurchase(purchase_No);
			model.addAttribute("purchase_OrderDto", purchase_OrderDto);
			model.addAttribute("client_Gubun", 0);
			return "km/modifyPurchase";
		
		} catch(IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/purchase/detail?purchase_No="+purchase_No;
		}
	}
	
	@PostMapping("/modify")
	public String modifyPurchase(Purchase_OrderDto purchase_OrderDto, RedirectAttributes ra) {
			
			System.out.println("purchase_OrderDto---------------->"+purchase_OrderDto);
			String result = purchase_OrderService.modifyPurchase(purchase_OrderDto);
			
			if(result == "발주 수정 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "발주 수정 실패") {
				ra.addFlashAttribute("error", result);
			}
			
		return "redirect:/purchase/detail?purchase_No="+purchase_OrderDto.getPurchase_No();
	}
	
	@PostMapping("/modifyStatus")
	public String modifyStatus(@RequestParam("purchase_No") int purchase_No, RedirectAttributes ra) {
		try {
			purchase_OrderService.checkClose();
			System.out.println("purchase_No"+purchase_No);
			String result = purchase_OrderService.modifyStatus(purchase_No);
			
			if(result == "발주 승인 성공") {
				ra.addFlashAttribute("success", result);
			} else if(result == "발주 승인 실패") {
				ra.addFlashAttribute("error", result);
			} else if(result == "발주 완료 성공") {
				ra.addFlashAttribute("success", result);
			} else if(result == "발주 완료 실패") {
				ra.addFlashAttribute("error", result);
			}
			
		return "redirect:/purchase/detail?purchase_No="+purchase_No;
		
	} catch(IllegalArgumentException e)	{
		ra.addFlashAttribute("error", e.getMessage());
		return "redirect:/purchase/detail?purchase_No="+purchase_No;
	}
		
	}
	
	@PostMapping("returnStatus")
	public String returnInStatus(@RequestParam("purchase_No") int purchase_No, RedirectAttributes ra) {
		try {
			purchase_OrderService.checkClose();
			
			String result = purchase_OrderService.returnInStatus(purchase_No);
			if(result == "발주 완료 취소 성공") {
				ra.addFlashAttribute("success", result);
			} else if(result == "발주 완료 취소 실패") {
				ra.addFlashAttribute("error", result);
			} else if(result == "발주 승인 취소 성공") {
				ra.addFlashAttribute("success", result);
			} else if(result == "발주 승인 취소 실패") {
				ra.addFlashAttribute("error", result);
			}
			
			return "redirect:/purchase/detail?purchase_No="+purchase_No;
		
	} catch(IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			
			return"redirect:/purchase/detail?purchase_No="+purchase_No;
	}
	
	}
	
	@PostMapping("accessModify")
	public String accessModify(@RequestParam("purchase_No") int purchase_No, RedirectAttributes ra) {
		try {
			purchase_OrderService.checkClose();
			String result = purchase_OrderService.returnInStatus(purchase_No);
			Purchase_OrderDto purchase_OrderDto = purchase_OrderService.detailPurchase(purchase_No);
		
		ra.addFlashAttribute("purchase_OrderDto", purchase_OrderDto);
		ra.addFlashAttribute("client_Gubun", 0);
		return "redirect:/purchase/modifyStart?purchase_No="+purchase_No;
		} catch(IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return "redirect:/purchase/detail?purchase_No="+purchase_No;
		}
	}
	
	@PostMapping("delete")
	public String deletePurchase(@RequestParam("purchase_No") int purchase_No ,RedirectAttributes ra) {
		try {
			purchase_OrderService.checkClose();
			
			String result = purchase_OrderService.deletePurchase(purchase_No);
			if(result == "발주 삭제 성공") {
				ra.addFlashAttribute("success", result);
			} else if (result == "발주 삭제 실패") {
				ra.addFlashAttribute("error", result);
			}
			
			return"redirect:/purchase/list";
		} catch (IllegalArgumentException e) {
			ra.addFlashAttribute("error", e.getMessage());
			return"redirect:/purchase/detail?purchase_No="+purchase_No;
		}
		
	}
	
}
