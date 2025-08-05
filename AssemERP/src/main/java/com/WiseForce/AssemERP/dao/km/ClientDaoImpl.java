package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ClientDaoImpl implements ClientDao{
	private final SqlSession session;

	@Override
	public List<ClientDto> listClient (ClientSearchDto clientSearchDto) {
		System.out.println("clientSearchDto"+clientSearchDto);
		List<ClientDto> searchList = session.selectList("clientList", clientSearchDto);
		System.out.println("searchList-->"+searchList);
		return searchList;
	}

	@Override
	public int totClient(ClientSearchDto clientSearchDto) {
		int totSearch = session.selectOne("totClient", clientSearchDto);
		System.out.println("totSearch--->"+totSearch);
		return totSearch;
	}

	@Override
	public ClientDto detailClient(ClientDto clientDto1) {
		ClientDto clientDto = session.selectOne("detailClient", clientDto1.getClient_No());
		System.out.println("getClient clientDto->"+clientDto);
		return clientDto;
	}

	@Override
	public int createClient(ClientDto clientDto) {
		System.out.println("ClientDao createClient Start...");
		System.out.println("ClientDao createClient clientDto-->"+clientDto);
		int result = session.insert("createClient", clientDto);
		System.out.println("ClientDao createClient result->"+result);
		return result;
	}

	@Override
	public int modifyClient(ClientDto clientDto1) {
		System.out.println("ClientDao modifyClient Start...");
		System.out.println("ClientDao modifyClient clientDto1->"+clientDto1);
		int result = session.update("modifyClient", clientDto1);
		return result;
	}

	@Override
	public int deleteClient(ClientDto clientDto1) {
		int result = session.update("deleteClient", clientDto1);
		return result;
	}

	@Override
	public void modifyClient_HisEnd(Client_HisDto client_HisDto) {
		session.update("client_HisEnd", client_HisDto);
		
	}

	@Override
	public void modifyClient_His(Client_HisDto client_HisDto) {
		
		session.update("client_HisEnd", client_HisDto);
		
		// 중복 제거를 위한 delete문
		session.delete("client_HisDelete", client_HisDto);
		
		session.insert("client_His", client_HisDto);
		
	}

}
