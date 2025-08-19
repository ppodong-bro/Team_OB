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
	public List<ClientPerformanceDTO> getSalesClientPerform() {
		List<ClientPerformanceDTO> clientPerformanceDTOs = null;
		
		try {
			clientPerformanceDTOs = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shSalesClientPerform");
			System.out.println("PerformenceDaoImpl getSalesClientPerform clientPerformanceDTOs =>"+clientPerformanceDTOs);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getSalesClientPerform Exception => "+e.getMessage()); 
		}
		return clientPerformanceDTOs;
	}
	
	@Override
	public List<ClientPerformanceDTO> getPurchaseClientPerform() {
		List<ClientPerformanceDTO> clientPerformanceDTOs = null;
		
		try {
			clientPerformanceDTOs = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shPurchaseClientPerform");
			System.out.println("PerformenceDaoImpl getPurchaseClientPerform clientPerformanceDTOs =>"+clientPerformanceDTOs);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getPurchaseClientPerform Exception => "+e.getMessage()); 
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

	@Override
	public List<ClientPerformanceDTO> getSalesClient(String keyword) {
		List<ClientPerformanceDTO> result = null;
		
		try {
			result = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shGetSalesClient",keyword);
			System.out.println("PerformenceDaoImpl getSalesClient result => "+result);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getSalesClient Exception => "+e.getMessage()); 
		}
				
		
		return result;
	}

	@Override
	public List<ClientPerformanceDTO> getPurchaseClient(String keyword) {
		List<ClientPerformanceDTO> result = null;
		
		try {
			result = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shGetPurchaseClient",keyword);
			System.out.println("PerformenceDaoImpl getPurchaseClient result => "+result);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getPurchaseClient Exception => "+e.getMessage()); 
		}
		
		
		return result;
	}

	@Override
	public List<ClientPerformanceDTO> getSalesClientData(int id) {
		List<ClientPerformanceDTO> result = null;
		
		try {
			result = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shGetSalesClientData", id);
			System.out.println("PerformenceDaoImpl getSalesClientData result => "+result);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getSalesClientData Exception => "+e.getMessage()); 
		}
		return result;
	}

	@Override
	public List<ClientPerformanceDTO> getPurchaseClientData(int id) {
		List<ClientPerformanceDTO> result = null;
		
		try {
			result = session.selectList("com.WiseForce.AssemERP.sh.PerformanceMapper.shGetPurchaseClientData", id);
			System.out.println("PerformenceDaoImpl getPurchaseClientData result => "+result);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getPurchaseClientData Exception => "+e.getMessage()); 
		}
		return result;
	}


	

	
}
