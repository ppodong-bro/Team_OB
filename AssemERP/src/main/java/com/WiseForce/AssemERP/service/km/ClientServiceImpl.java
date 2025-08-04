package com.WiseForce.AssemERP.service.km;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.ClientDao;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Transactional
@Service
public class ClientServiceImpl implements ClientService {
	private final ClientDao clientDao;
	
	@Override
	public List<ClientDto> listClient(ClientSearchDto clientSearchDto) {
		List<ClientDto> searchList = clientDao.listClient(clientSearchDto);
		return searchList;
	}

	@Override
	public int totClient(ClientSearchDto clientSearchDto) {
		int totSearch = clientDao.totClient(clientSearchDto);
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
		
		LocalDateTime localDateTime = LocalDateTime.now();
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String modifyDate = localDateTime.format(dateTimeFormatter);
		
		Client_HisDto client_HisDto = Client_HisDto.builder()
												   .client_No(clientDto1.getClient_No())
												   .end_Date(modifyDate)
												   .build()
												   ;
		
		Client_HisDto client_HisDto1 = Client_HisDto.builder()
												   .client_No(clientDto1.getClient_No())
												   .start_Date(modifyDate)
												   .end_Date("99991231")
												   .emp_No(clientDto1.getEmpDTO().getEmpNo())
												   .client_Name(clientDto1.getClient_Name())
												   .client_Gubun(clientDto1.getClient_Gubun())
												   .client_Man(clientDto1.getClient_Man())
												   .client_Email(clientDto1.getClient_Email())
												   .client_Tel(clientDto1.getClient_Tel())
												   .client_Address(clientDto1.getClient_Address())
												   .build()
												   ;
		clientDao.modifyClient_HisEnd(client_HisDto);
		clientDao.modifyClient_His(client_HisDto1);
		
		
													   
		return result;
	}

	@Override
	public int deleteClient(ClientDto clientDto1) {
		int result = clientDao.deleteClient(clientDto1);
		return result;
	}
	
}
