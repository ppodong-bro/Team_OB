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
		// 판매거래처 실적가져오기
		List<ClientPerformanceDTO> salesclientPerformanceDTOs = performanceDao.getSalesClientPerform();
		// 구매거래처 실적가져오기
		List<ClientPerformanceDTO> purchaseclientPerformanceDTOs = performanceDao.getPurchaseClientPerform();
		
		// 판매+구매 통합
		List<ClientPerformanceDTO> result = new ArrayList<>();
		result.addAll(salesclientPerformanceDTOs);
		result.addAll(purchaseclientPerformanceDTOs);
		
		
  
		// 거래처 총거래액추출
		List<Integer> totalcost = new ArrayList<>();
		for (ClientPerformanceDTO row : result) {
		    totalcost.add(row.getTotalcost());
		}
		return totalcost;
	}

	@Override
	public List<String> getClientName() {
		// 판매거래처 실적가져오기
		List<ClientPerformanceDTO> salesclientPerformanceDTOs = performanceDao.getSalesClientPerform();
		// 구매거래처 실적가져오기
		List<ClientPerformanceDTO> purchaseclientPerformanceDTOs = performanceDao.getPurchaseClientPerform();
		
		// 판매+구매 통합
		List<ClientPerformanceDTO> result = new ArrayList<>();
		result.addAll(salesclientPerformanceDTOs);
		result.addAll(purchaseclientPerformanceDTOs);
		
		// 거래처 이름추출
		List<String> client_name = new ArrayList<>();
		for (ClientPerformanceDTO row : result) {
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

	@Override
	public List<ClientPerformanceDTO> getSalesClient(String keyword) {
		
		return performanceDao.getSalesClient(keyword);
	}

	@Override
	public List<ClientPerformanceDTO> getPurchaseClient(String keyword) {
		
		return performanceDao.getPurchaseClient(keyword);
	}

	@Override
	public List<ClientPerformanceDTO> getSalesClinetData(int id) {
		// TODO Auto-generated method stub
		return performanceDao.getSalesClientData(id);
	}

	@Override
	public List<ClientPerformanceDTO> getPurchaseClinetData(int id) {
		// TODO Auto-generated method stub
		return performanceDao.getPurchaseClientData(id);
	}

	@Override
	public List<YearsPerformDTO> getInitYearsperform(int product_no) {
		// TODO Auto-generated method stub
		return performanceDao.getInitYearsperform(product_no);
	}

	
	@Override
	public int getMostProductOfYears() {
		// TODO Auto-generated method stub
		return performanceDao.getMostProductOfYears();
	}

	@Override
	public int getMostClientOfYears() {
		
		return performanceDao.getMostClientOfYears();
	}

	
	
}
