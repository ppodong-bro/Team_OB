package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping("clientCreate")
	public String clientCreate() {
		return "km/clientCreate";
	}

	
}
