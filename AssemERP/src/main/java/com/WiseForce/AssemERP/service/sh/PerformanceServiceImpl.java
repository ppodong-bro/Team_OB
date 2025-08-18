package com.WiseForce.AssemERP.service.sh;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.sh.PerformanceDao;
import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class PerformanceServiceImpl implements PerformanceService {

	private final PerformanceDao performanceDao;

	@Override
	public List<BigDecimal> getPurchaseData() {
		
		return performanceDao.getPurchaseData();
	}

	@Override
	public List<BigDecimal> getSaleData() {
		// TODO Auto-generated method stub
		return performanceDao.getSaleData();
	}

	@Override
	public List<Integer> getClientTotalCost() {
		List<ClientPerformanceDTO> clientPerformanceDTOs = performanceDao.getClientPerform();
		// DB값 없을경우 리턴
		if(clientPerformanceDTOs == null) return null;
		// 클라이언트 이름추출 
		List<Integer> totalcost = new ArrayList<>();
		for (ClientPerformanceDTO row : clientPerformanceDTOs) {
		    totalcost.add(row.getTotalcost());
		}
		return totalcost;
	}

	@Override
	public List<String> getClientName() {
		List<ClientPerformanceDTO> clientPerformanceDTOs = performanceDao.getClientPerform();
		// DB값 없을경우 리턴
		if(clientPerformanceDTOs == null) return null;
		// 클라이언트 총거래액추출
		List<String> client_name = new ArrayList<>();
		for (ClientPerformanceDTO row : clientPerformanceDTOs) {
			client_name.add(row.getClient_name());
		}
		return client_name;
	}

	@Override
	public List<YearsPerformDTO> searchProductById(int id) {
		
		return performanceDao.searchProductById(id);
	}

	@Override
	public List<YearsPerformDTO> searchPartsById(int id) {
		
		return performanceDao.searchPartsById(id);
	}

	
	
}
