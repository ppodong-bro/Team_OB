package com.WiseForce.AssemERP.dao.sh;

import java.util.List;

import com.WiseForce.AssemERP.dto.sh.PartsDTO;

public interface PartsDao {

	List<PartsDTO> findPageList(PartsDTO partsDTO);

	List<PartsDTO> findAllPartsList();

	int getSearchCount(PartsDTO partsDTO);

	List<PartsDTO> findSearchList(PartsDTO partsDTO);

	List<PartsDTO> findPartsByStatus(int status);

	void deleteParts(int parts_no);

}
