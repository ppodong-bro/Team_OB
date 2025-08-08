package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;

public interface ClientService {


	List<ClientDto> 	listClient(ClientSearchDto clientSearchDto);

	int 				totClient(ClientSearchDto clientSearchDto);

	ClientDto 			detailClient(ClientDto clientDto1);

	int 				createClient(ClientDto clientDto);

	int 				modifyClient(ClientDto clientDto1);

	int 				deleteClient(ClientDto clientDto1);

	List<ClientDto> 	searchByName(String client_Name);

	List<ClientDto> 	clientAll();

}
