package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;

public interface ClientService {

	int 				totCnt();

	List<ClientDto> 	getList(ClientDto clientDto);

	List<ClientDto> 	searchList(ClientSearchDto clientSearchDto);

	int 				totSearch(ClientSearchDto clientSearchDto);

	ClientDto 			detailClient(ClientDto clientDto1);

	int 				createClient(ClientDto clientDto);

	int 				modifyClient(ClientDto clientDto1);

	int 				deleteClient(ClientDto clientDto1);

}
