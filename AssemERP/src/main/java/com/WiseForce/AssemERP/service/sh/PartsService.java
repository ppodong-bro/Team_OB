package com.WiseForce.AssemERP.service.sh;

import java.util.List;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;

public interface PartsService {

	List<PartsDTO> getPartsList(PartsDTO partsDTO);

	int getTotalcount();

}
