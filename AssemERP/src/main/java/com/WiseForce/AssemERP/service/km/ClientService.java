package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.ClientDto;

public interface ClientService {

	int 				totCnt();

	List<ClientDto> 	getList(ClientDto clientDto);

}
