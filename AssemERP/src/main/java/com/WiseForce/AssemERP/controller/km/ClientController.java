package com.WiseForce.AssemERP.controller.km;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;
import com.WiseForce.AssemERP.service.km.ClientService;
import com.WiseForce.AssemERP.util.Paging;

import lombok.RequiredArgsConstructor;


@RequestMapping("client/")
@RequiredArgsConstructor
@Controller
public class ClientController {
	private final ClientService clientService;

	@GetMapping("list")
	public String listClient(ClientSearchDto clientSearchDto, Model model) {
		System.out.println("clientSearchDto--->"+clientSearchDto);
		int totSearch = clientService.totClient(clientSearchDto);
		ClientDto clientDto = new ClientDto();
		Paging page = new Paging(totSearch, clientSearchDto.getCurrentPage());
		clientSearchDto.setStart(page.getStart());
		clientSearchDto.setEnd(page.getEnd());
		List<ClientDto> searchList = clientService.listClient(clientSearchDto);
		model.addAttribute("clientList", searchList);
		model.addAttribute("paging", page);
		model.addAttribute("clientSearchDto", clientSearchDto);
		
		return "km/clientList";
	}
	
	@GetMapping("detail")
	public String detailClient(ClientDto clientDto1, Model model) {
		System.out.println("ClientController detailClient Start...");
		ClientDto clientDto = clientService.detailClient(clientDto1);
//		LocalDateTime inDate =clientDto.getIn_Date();
//		LocalDateTime modifyDate = clientDto.getModify_Date();
//		
//		DateTimeFormatter dateTimeFormat = DateTimeFormatter.ofPattern("yy-MM-dd HH:mm:ss");
//		String modifyFmt = modifyDate.format(dateTimeFormat);
//		String inDateFmt = modifyDate.format(dateTimeFormat);
		
		model.addAttribute("clientDto", clientDto);
//		model.addAttribute("modify", modifyFmt);
//		model.addAttribute("inDate", inDateFmt);
		
		return "km/detailClient";
	}
	
	@GetMapping("createStart")
	public String createStartClient(ClientDto clientDto, Model model) {
		System.out.println("ClientController createStartClient Start...");
		
		return "km/clientCreate";
	}
	
	@PostMapping("create")
	public String createClient(ClientDto clientDto, RedirectAttributes ra) {
		System.out.println("ClientController createClient Start...");
		
		String result = clientService.createClient(clientDto);
		
		if(result == "거래처 등록 성공") {
			ra.addFlashAttribute("success", result);
		} else if(result == "거래처 등록 실패") {
			ra.addFlashAttribute("error", result);
		}
		
		return "redirect:/client/list";
	}
	
	@GetMapping("modifyStart")
	public String modifyStartClient(ClientDto clientDto1, Model model) {
		System.out.println("ClientController modifyClient Start...");
		ClientDto clientDto = clientService.detailClient(clientDto1);
		model.addAttribute("clientDto", clientDto);
		return "km/modifyClient";
	}
	
	@PostMapping("modify")
	public String modifyClient(ClientDto clientDto1, RedirectAttributes ra) {
		String result = clientService.modifyClient(clientDto1);
		
		if(result == "거래처 수정 성공") {
			ra.addFlashAttribute("success", result);
		} else if(result =="거래처 수정 실패") {
			ra.addFlashAttribute("error", result);
		}
		
		System.out.println("ClientController modifyClient result->"+result);
		return"redirect:/client/list";
	}
	
	@PostMapping("delete")
	public String deleteClient(ClientDto clientDto1, RedirectAttributes ra) {
		System.out.println("ClientController deleteClient Start...");
		String result = clientService.deleteClient(clientDto1);
		
		if(result == "거래처 삭제 성공") {
			ra.addFlashAttribute("success", result);
		} else if(result == "거래처 삭제 실패") {
			ra.addFlashAttribute("error", result);
		}
		
		return "redirect:/client/list";
	}
	
	@GetMapping("popup")
	public String searchByName(@RequestParam("client_Gubun") int client_Gubun, @RequestParam("client_Name") String client_Name ,Model model){
		List<ClientDto>listClientDto = clientService.clientAll(client_Gubun, client_Name);
		model.addAttribute("clientList", listClientDto);
		model.addAttribute("client_Gubun", client_Gubun);
		System.out.println("listClientDto"+listClientDto);
		return "km/clientPop";
	}
	
	@GetMapping("empPopup")
	public String empPopup(@RequestParam("empName") String empName, Model model) {
		List<EmpDTO> listEmp = clientService.listEmp(empName);
		model.addAttribute("empList", listEmp);
		return "km/empPop";
	}

}

