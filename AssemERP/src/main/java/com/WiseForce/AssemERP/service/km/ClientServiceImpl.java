package com.WiseForce.AssemERP.service.km;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.ClientDao;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Transactional
@Service
public class ClientServiceImpl implements ClientService {
	private final ClientDao clientDao;
	
	@Override
	public int totCnt() {
		int totCnt = clientDao.totCnt();
		return totCnt;
	}

	@Override
	public List<ClientDto> getList(ClientDto clientDto) {
		List<ClientDto> listClient = clientDao.getList(clientDto);
		return listClient;
	}

	@Override
	public List<ClientDto> searchList(ClientSearchDto clientSearchDto) {
		List<ClientDto> searchList = clientDao.searchList(clientSearchDto);
		return searchList;
	}

	@Override
	public int totSearch(ClientSearchDto clientSearchDto) {
		int totSearch = clientDao.totSearch(clientSearchDto);
		return totSearch;
	}

	@Override
	public ClientDto detailClient(ClientDto clientDto1) {
		ClientDto clientDto = clientDao.detailClient(clientDto1);
		return clientDto;
	}

	@Override
	public int createClient(ClientDto clientDto) {
		int result = clientDao.createClient(clientDto);
		return result;
	}

	@Override
	public int modifyClient(ClientDto clientDto1) {
		int result = clientDao.modifyClient(clientDto1);
		
		return result;
	}

	@Override
	public int deleteClient(ClientDto clientDto1) {
		int result = clientDao.deleteClient(clientDto1);
		return result;
	}
	
}
