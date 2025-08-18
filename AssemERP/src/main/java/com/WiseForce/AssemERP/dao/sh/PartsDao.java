package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;
import com.WiseForce.AssemERP.dto.sh.ProductDTO;

public interface PartsDao {

	List<PartsDTO> findPageList(PartsDTO partsDTO);

	List<PartsDTO> findAllPartsList();

	int getSearchCount(PartsDTO partsDTO);

	List<PartsDTO> findSearchList(PartsDTO partsDTO);

	List<PartsDTO> findPartsByStatus(int status);

	void deleteParts(int parts_no);

	int getTotalParts();

	String partsNameFromPartno(Integer parts_no);

	List<PartsDTO> searchByName(String keyword);


}
 