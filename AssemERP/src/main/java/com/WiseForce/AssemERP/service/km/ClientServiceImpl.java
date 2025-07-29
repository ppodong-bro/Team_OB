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
	
}
