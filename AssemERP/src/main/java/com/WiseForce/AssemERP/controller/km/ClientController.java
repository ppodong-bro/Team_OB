package com.WiseForce.AssemERP.controller.km;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.service.km.ClientService;
import com.WiseForce.AssemERP.service.km.Paging;

import lombok.RequiredArgsConstructor;


@RequestMapping("business/")
@RequiredArgsConstructor
@Controller
public class ClientController {
	private final ClientService clientService;
	
	@GetMapping("clientStartList")
	public String listStart(ClientDto clientDto,Model model) {
		int totCnt = clientService.totCnt();
		String currentPage = "1";
		Paging page = new Paging(totCnt, currentPage);
		clientDto.setStart(page.getStart());
		clientDto.setEnd(page.getEnd());
		List<ClientDto> clientList = clientService.getList(clientDto);
		
		return "km/clientList";
	}
	
	@GetMapping("clientCreate")
	public String clientCreate() {
		return "km/clientCreate";
	}

	
}
