package com.WiseForce.AssemERP.dao.sh;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;

public interface PerformanceDao {

	List<BigDecimal> getPurchaseData();

	List<BigDecimal> getSaleData();

	List<ClientPerformanceDTO> getSalesClientPerform();
	
	List<ClientPerformanceDTO> getPurchaseClientPerform();

	List<YearsPerformDTO> searchProductById(int id);

	List<YearsPerformDTO> searchPartsById(int id);

	List<ClientPerformanceDTO> getSalesClient(String keyword);

	List<ClientPerformanceDTO> getPurchaseClient(String keyword);

	List<ClientPerformanceDTO> getSalesClientData(int id);

	List<ClientPerformanceDTO> getPurchaseClientData(int id);



}
