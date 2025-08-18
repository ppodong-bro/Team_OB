package com.WiseForce.AssemERP.dao.sh;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.sh.ClientPerformanceDTO;
import com.WiseForce.AssemERP.dto.sh.YearsPerformDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PerformanceDaoImpl implements PerformanceDao {

	private final SqlSession session;

	@Override
	public List<BigDecimal> getPurchaseData() {
		List<BigDecimal> perChaseData = null;
		
		LocalDate date = LocalDate.now();
        int year = date.getYear();
        
		
		try {
			perChaseData = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shYearsPurchasePerformance",year);
			System.out.println("PerformanceDaoImpl getPurchaseData PerChaseData => "+perChaseData);
		} catch (Exception e) {
			System.out.println("PerformanceDaoImpl getPerchaseData Exception => "+e.getMessage());
		}
		
		return perChaseData;
	}

	@Override
	public List<BigDecimal> getSaleData() {
		List<BigDecimal>  saleData = null;
		
		LocalDate date = LocalDate.now();
		int year = date.getYear();
		
		try {
			saleData = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shYearsSalePerformance", year);
			System.out.println("PerformanceDaoImpl getSaleData saleData => "+saleData);
		} catch (Exception e) {
			System.out.println("PerformanceDaoImpl getSaleData Exception => "+e.getMessage());
		}
		
		
		
		return saleData;
	}

	@Override
	public List<ClientPerformanceDTO> getClientPerform() {
		List<ClientPerformanceDTO> clientPerformanceDTOs = null;
		
		try {
			clientPerformanceDTOs = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shClientPerform");
			System.out.println("PerformenceDaoImpl getClientPerform clientPerformanceDTOs =>"+clientPerformanceDTOs);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getClientPerform Exception => "+e.getMessage()); 
		}
		return clientPerformanceDTOs;
	}

	@Override
	public List<YearsPerformDTO> searchProductById(int id) {
		List<YearsPerformDTO> result = null;
		
		
		try {
			result = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shProductPerform", id);
			System.out.println("PerformenceDaoImpl searchProductById result => "+result);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl searchProductById Exception => "+e.getMessage()); 
		}
		
		
		return result;
	}

	@Override
	public List<YearsPerformDTO> searchPartsById(int id) {
		List<YearsPerformDTO> result = null;
		
		try {
			result = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shPartsPerform", id);
			System.out.println("PerformenceDaoImpl searchPartsById result => "+result);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl searchPartsById Exception => "+e.getMessage()); 
		}
		
		
		return result;
	}

	
}
