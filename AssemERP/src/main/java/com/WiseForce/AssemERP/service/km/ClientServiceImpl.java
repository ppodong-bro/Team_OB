package com.WiseForce.AssemERP.service.km;

import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.ClientDao;
import com.WiseForce.AssemERP.dto.km.ClientDto;

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
	
}
