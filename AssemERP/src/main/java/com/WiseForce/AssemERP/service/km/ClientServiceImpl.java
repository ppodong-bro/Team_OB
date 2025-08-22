package com.WiseForce.AssemERP.service.km;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.km.ClientDao;
import com.WiseForce.AssemERP.dto.CommonDTO;
import com.WiseForce.AssemERP.dto.km.ClientDto;
import com.WiseForce.AssemERP.dto.km.ClientSearchDto;
import com.WiseForce.AssemERP.dto.km.Client_HisDto;
import com.WiseForce.AssemERP.dto.sm.EmpDTO;

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
	public String createClient(ClientDto clientDto) {
		
		int result = clientDao.createClient(clientDto);
		int result1 = clientDao.createClient_His(clientDto);
		
		
		if(result1 == 1) {
			String success = "거래처 등록 성공";
			return success;
		} else if(result == 0) {
			String fail = "거래처 등록 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}

	}

	@Override
	public String modifyClient(ClientDto clientDto1) {
		
		LocalDateTime modifyDay 			= LocalDateTime.now();
		
		
		DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		
	
		
		Client_HisDto client_HisDto = Client_HisDto.builder()
												   .client_No(clientDto1.getClient_No())
												   .start_Date(modifyDay)
												   .emp_No(clientDto1.getEmpDTO().getEmpNo())
												   .client_Name(clientDto1.getClient_Name())
												   .client_Gubun(clientDto1.getClient_Gubun())
												   .client_Man(clientDto1.getClient_Man())
												   .client_Email(clientDto1.getClient_Email())
												   .client_Tel(clientDto1.getClient_Tel())
												   .client_Address(clientDto1.getClient_Address())
												   .build()
												   ;
		
		
		clientDto1.setModify_Date(modifyDay);
		
		clientDao.modifyClient_His(client_HisDto);
		
		int result1 = clientDao.createClient_His(clientDto1);
		int result = clientDao.modifyClient(clientDto1);
		
		if(result == 1) {
			String success = "거래처 수정 성공";
			return success;
		} else if(result == 0) {
			String fail = "거래처 수정 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
													   
	}

	@Override
	public String deleteClient(ClientDto clientDto1) {
		int result = clientDao.deleteClient(clientDto1);
		
		if(result == 1) {
			String success = "거래처 삭제 성공";
			return success;
		} else if (result == 0) {
			String fail = "거래처 삭제 실패";
			return fail;
		} else {
			throw new IllegalArgumentException("잘못된 요청");
		}
		
	}

	@Override
	public List<ClientDto> searchByName(String client_Name) {
			
		return clientDao.searchByName(client_Name);
	}

	@Override
	public List<ClientDto> clientAll(int client_Gubun, String client_Name) {
		List<ClientDto> clientList = clientDao.clientAll(client_Gubun, client_Name);
		return clientList;
	}

	@Override
	public List<EmpDTO> listEmp(String empName) {
		List<EmpDTO> listEmp = clientDao.listEmp(empName);
		return listEmp;
	}

	@Override
	public String deptName() {
		String deptName = clientDao.deptName();
		return deptName;
	}
	
}
