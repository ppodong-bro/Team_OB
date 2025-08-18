package com.WiseForce.AssemERP.dao.km;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;
import com.WiseForce.AssemERP.dto.km.Client_PerformDto;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ClientDaoImpl implements ClientDao {
	private final SqlSession session;

	@Override
	public List<ClientDto> listClient(ClientSearchDto clientSearchDto) {
		System.out.println("clientSearchDto" + clientSearchDto);
		List<ClientDto> searchList = session.selectList("clientList", clientSearchDto);
		System.out.println("searchList-->" + searchList);
		return searchList;
	}

	@Override
	public int totClient(ClientSearchDto clientSearchDto) {
		int totSearch = session.selectOne("totClient", clientSearchDto);
		System.out.println("totSearch--->" + totSearch);
		return totSearch;
	}

	@Override
	public ClientDto detailClient(ClientDto clientDto1) {
		ClientDto clientDto = session.selectOne("detailClient", clientDto1.getClient_No());
		System.out.println("getClient clientDto->" + clientDto);
		return clientDto;
	}

	@Override
	public int createClient(ClientDto clientDto) {
		System.out.println("ClientDao createClient Start...");
		System.out.println("ClientDao createClient clientDto-->" + clientDto);
		int result = session.insert("createClient", clientDto);
		System.out.println("ClientDao createClient result->" + result);
		return result;
	}
	
	@Override
	public int createClient_His(ClientDto clientDto) {
		System.out.println("clientDto-------------------------------->"+clientDto);
		int result = session.insert("createClient_His", clientDto);
		return result;
	}

	@Override
	public int modifyClient(ClientDto clientDto1) {
		System.out.println("ClientDao modifyClient Start...");
		System.out.println("ClientDao modifyClient clientDto1->" + clientDto1);
		int result = session.update("modifyClient", clientDto1);
		return result;
	}

	@Override
	public int deleteClient(ClientDto clientDto1) {
		int result = session.update("deleteClient", clientDto1);
		return result;
	}

//	@Override
//	public void modifyClient_HisEnd(Client_HisDto client_HisDto) {
//		session.update("client_HisEnd", client_HisDto);
//
//	}

	@Override
	public void modifyClient_His(Client_HisDto client_HisDto) {


		session.update("client_HisEnd", client_HisDto);

//		session.insert("createClient_His", client_HisDto);

	}

	@Override
	public List<ClientDto> searchByName(String client_Name) {
		List<ClientDto> clientList = session.selectList("clientSearchList", client_Name);
		return clientList;
	}

	@Override
	public List<ClientDto> clientAll(int client_Gubun, String client_Name) {
		Map<String, Object> clientPopMap = Map.of("client_Gubun", client_Gubun, "client_Name", client_Name);
		List<ClientDto> clientList = session.selectList("clientAll", clientPopMap);
		return clientList;
	}

	@Override
	public int perform(Client_PerformDto client_PerformDto) {
		int result = session.insert("client_Perform", client_PerformDto);
		return result;
	}

	@Override
	public void returnPerform(Client_PerformDto client_PerformDto) {
		session.update("returnPerform", client_PerformDto);
		session.delete("deletePerform", client_PerformDto);
		
	}

	@Override
	public List<EmpDTO> listEmp(String empName) {
		List<EmpDTO> listEmp = session.selectList("listEmpOfClient",empName);
		System.out.println("listEmp->"+listEmp);
		return listEmp;
	}



}
