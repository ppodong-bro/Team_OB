package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;
import com.WiseForce.AssemERP.dto.km.Client_PerformDto;
import com.WiseForce.AssemERP.dto.km.Sales_ItemDto;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

public interface ClientDao {

	List<ClientDto> listClient(ClientSearchDto clientSearchDto);

	int 			totClient(ClientSearchDto clientSearchDto);

	ClientDto 		detailClient(ClientDto clientDto1);

	int 			createClient(ClientDto clientDto);

	int				modifyClient(ClientDto clientDto1);

	int 			deleteClient(ClientDto clientDto1);

	void 			modifyClient_HisEnd(Client_HisDto client_HisDto);

	void 			modifyClient_His(Client_HisDto client_HisDto1);

	List<ClientDto> searchByName(String client_Name);

	List<ClientDto> clientAll(int client_Gubun, String client_Name);

	int 			createClient_His(ClientDto clientDto);

	void 			perform(Client_PerformDto client_PerformDto);

	void 			returnPerform(Client_PerformDto client_PerformDto);

	List<EmpDTO> 	listEmp(String empName);
		
}


