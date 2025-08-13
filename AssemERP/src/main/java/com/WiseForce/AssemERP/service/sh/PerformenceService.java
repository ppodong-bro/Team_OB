package com.WiseForce.AssemERP.service.sh;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface PerformenceService {

	List<BigDecimal> getPurchaseData();

	List<BigDecimal> getSaleData();

	List<Integer> getClientTotalCost();

	List<String> getClientName();


}
