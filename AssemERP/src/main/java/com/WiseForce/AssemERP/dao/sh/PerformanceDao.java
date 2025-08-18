package com.WiseForce.AssemERP.dao.sh;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;

public interface PerformanceDao {

	List<BigDecimal> getPurchaseData();

	List<BigDecimal> getSaleData();

	List<ClientPerformanceDTO> getClientPerform();

	List<YearsPerformDTO> searchProductById(int id);

	List<YearsPerformDTO> searchPartsById(int id);



}
