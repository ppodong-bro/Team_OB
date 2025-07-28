package com.WiseForce.AssemERP.dao.km;

import java.util.List;

import com.WiseForce.AssemERP.dto.km.ClientDto;

public interface ClientDao {

	int 			totCnt();

	List<ClientDto> getList(ClientDto clientDto);

}
