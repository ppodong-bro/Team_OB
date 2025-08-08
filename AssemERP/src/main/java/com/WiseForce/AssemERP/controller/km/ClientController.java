package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
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
		model.addAttribute("clientDto", clientDto);
		
		return "km/detailClient";
	}
	
	@GetMapping("createStart")
	public String createStartClient(ClientDto clientDto, Model model) {
		System.out.println("ClientController createStartClient Start...");
		
		return "km/clientCreate";
	}
	
	@PostMapping("create")
	public String createClient(ClientDto clientDto) {
		System.out.println("ClientController createClient Start...");
		int result = clientService.createClient(clientDto);
		
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
	public String modifyClient(ClientDto clientDto1) {
		int result = clientService.modifyClient(clientDto1);
		
		System.out.println("ClientController modifyClient result->"+result);
		return"redirect:/client/list";
	}
	
	@PostMapping("delete")
	public String deleteClient(ClientDto clientDto1) {
		System.out.println("ClientController deleteClient Start...");
		int result = clientService.deleteClient(clientDto1);
		return "redirect:/client/list";
	}
	
	@GetMapping("popup")
	public String searchByName(Model model){
		List<ClientDto>listClientDto = clientService.clientAll();
		model.addAttribute("clientList", listClientDto);
		System.out.println("listClientDto"+listClientDto);
		return "km/salesPop";
	}

}

