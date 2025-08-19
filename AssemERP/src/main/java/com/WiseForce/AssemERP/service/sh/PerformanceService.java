package com.WiseForce.AssemERP.service.sh;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;

public interface PerformanceService {

	List<BigDecimal> getPurchaseData();

	List<BigDecimal> getSaleData();

	List<Integer> getClientTotalCost();

	List<String> getClientName();

	List<YearsPerformDTO> searchProductById(int id);

	List<YearsPerformDTO> searchPartsById(int id);

	List<ClientPerformanceDTO> getSalesClient(String keyword);

	List<ClientPerformanceDTO> getPurchaseClient(String keyword);

	List<ClientPerformanceDTO> getSalesClinetData(int id);

	List<ClientPerformanceDTO> getPurchaseClinetData(int id);


}
