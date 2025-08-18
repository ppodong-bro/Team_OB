package com.WiseForce.AssemERP.dao.sh;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PerformenceDaoImpl implements PerformenceDao {

	private final SqlSession session;

	@Override
	public List<BigDecimal> getPurchaseData() {
		List<BigDecimal> perChaseData = null;
		
		LocalDate date = LocalDate.now();
        int year = date.getYear();
        
		
		try {
			perChaseData = session.selectList("com.WiseForce.AssemERP.sh.PerformenceMapper.shYearsPurchasePerformence",year);
			System.out.println("PerformenceDaoImpl getPurchaseData PerChaseData => "+perChaseData);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getPerchaseData Exception => "+e.getMessage());
		}
		
		return perChaseData;
	}

	@Override
	public List<BigDecimal> getSaleData() {
		List<BigDecimal>  saleData = null;
		
		LocalDate date = LocalDate.now();
		int year = date.getYear();
		
		try {
			saleData = session.selectList("com.WiseForce.AssemERP.sh.PerformenceMapper.shYearsSalePerformence", year);
			System.out.println("PerformenceDaoImpl getSaleData saleData => "+saleData);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getSaleData Exception => "+e.getMessage());
		}
		
		
		
		return saleData;
	}

	@Override
	public List<ClientPerformanceDTO> getClientPerform() {
		List<ClientPerformanceDTO> clientPerformanceDTOs = null;
		
		try {
			clientPerformanceDTOs = session.selectList("com.WiseForce.AssemERP.sh.PerformenceMapper.shClientPerform");
			System.out.println("PerformenceDaoImpl getClientPerform clientPerformanceDTOs =>"+clientPerformanceDTOs);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getClientPerform Exception => "+e.getMessage()); 
		}
		return clientPerformanceDTOs;
	}

	
}
