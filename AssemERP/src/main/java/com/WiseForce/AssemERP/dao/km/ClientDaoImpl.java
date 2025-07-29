package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class ClientDaoImpl implements ClientDao{
	private final SqlSession session;
	@Override
	public int totCnt() {
		int totCnt = session.selectOne("com.WiseForce.AssemERP.ClientMapper.clientTotCnt");
		System.out.println("ClientDaoImpl totCnt totCnt->"+totCnt);
		return totCnt;
	}
	
	@Override
	public List<ClientDto> getList(ClientDto clientDto) {
		List<ClientDto> listClient = session.selectList("clientList", clientDto);
		System.out.println("ClientDaoImpl getList listClient->"+listClient);
		
		return listClient;
	}

	@Override
	public List<ClientDto> searchList(ClientSearchDto clientSearchDto) {
		System.out.println("clientSearchDto"+clientSearchDto);
		List<ClientDto> searchList = session.selectList("clientSearchList", clientSearchDto);
		System.out.println("searchList-->"+searchList);
		return searchList;
	}

	@Override
	public int totSearch(ClientSearchDto clientSearchDto) {
		int totSearch = session.selectOne("totSearchClient", clientSearchDto);
		System.out.println("totSearch--->"+totSearch);
		return totSearch;
	}

}
