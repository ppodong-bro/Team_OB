package com.WiseForce.AssemERP.service.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

public interface ClientService {


	List<ClientDto> 	listClient(ClientSearchDto clientSearchDto);

	int 				totClient(ClientSearchDto clientSearchDto);

	ClientDto 			detailClient(ClientDto clientDto1);

	String 				createClient(ClientDto clientDto);

	String 				modifyClient(ClientDto clientDto1);

	String 				deleteClient(ClientDto clientDto1);

	List<ClientDto> 	searchByName(String client_Name);

	List<ClientDto> 	clientAll(int client_Gubun, String client_Name);

	List<EmpDTO> 		listEmp(String empName);

}
