package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.service.km.ClientService;
import com.WiseForce.AssemERP.service.km.Paging;

import lombok.RequiredArgsConstructor;


@RequestMapping("business/")
@RequiredArgsConstructor
@Controller
public class ClientController {
	private final ClientService clientService;
	
	@GetMapping("clientList")
	public String listStart(ClientDto clientDto,Model model) {
		int totCnt = clientService.totCnt();
		
		Paging page = new Paging(totCnt, clientDto.getCurrentPage());
		clientDto.setStart(page.getStart());
		clientDto.setEnd(page.getEnd());
		List<ClientDto> clientList = clientService.getList(clientDto);
		model.addAttribute("clientList", clientList);
		model.addAttribute("page", page);
		return "km/clientList";
	}
	
	@GetMapping("clientSearchList")
	public String clientSearchList(ClientSearchDto clientSearchDto, Model model) {
		int totSearch = clientService.totSearch(clientSearchDto);
		ClientDto clientDto = new ClientDto();
		Paging page = new Paging(totSearch, clientSearchDto.getCurrentPage());
		clientSearchDto.setStart(page.getStart());
		clientSearchDto.setEnd(page.getEnd());
		List<ClientDto> searchList = clientService.searchList(clientSearchDto);
		model.addAttribute("clientList", searchList);
		model.addAttribute("page", page);
		
		return "km/clientList";
	}
	
	@GetMapping("detailClient")
	public String detailClient(ClientDto clientDto1, Model model) {
		System.out.println("ClientController detailClient Start...");
		ClientDto clientDto = clientService.detailClient(clientDto1);
		model.addAttribute("clientDto", clientDto);
		
		return "km/detailClient";
	}
	
	@GetMapping("createStartClient")
	public String createStartClient(ClientDto clientDto, Model model) {
		System.out.println("ClientController createStartClient Start...");
		
		return "km/clientCreate";
	}
	
	@PostMapping("createClient")
	public String createClient(ClientDto clientDto, Model model) {
		System.out.println("ClientController createClient Start...");
		int result = clientService.createClient(clientDto);
		
		return "redirect:/business/clientList";
	}
	
	@PostMapping("modifyClient")
	public String modifyClient(ClientDto clientDto, Model model) {
		System.out.println("ClientController modifyClient Start...");
		
		return "km/modifyClient";
	}

}

