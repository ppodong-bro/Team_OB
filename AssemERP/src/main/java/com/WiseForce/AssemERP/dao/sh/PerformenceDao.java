package com.WiseForce.AssemERP.dao.sh;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;

public interface PerformenceDao {

	List<BigDecimal> getPurchaseData();

	List<BigDecimal> getSaleData();

	List<ClientPerformanceDTO> getClientPerform();



}
