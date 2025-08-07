package com.WiseForce.AssemERP.service.sh;

import java.util.List;

import com.WiseForce.AssemERP.domain.sh.Parts;
import com.WiseForce.AssemERP.dto.sh.PartsDTO;

public interface PartsService {

	List<PartsDTO> getPartsList(PartsDTO partsDTO);

	int getTotalcount();

	int createParts(PartsDTO partsDTO);

	int getTotalSeartchcount(PartsDTO partsDTO);

	List<PartsDTO> getpartsSearchList(PartsDTO partsDTO);

	PartsDTO findbyID(int parts_no);

	void updateParts(Parts parts);

	void deleteParts(int parts_no);

}
