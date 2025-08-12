package com.WiseForce.AssemERP.dao.sh;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PerformenceDaoImpl implements PerformenceDao {

	private final SqlSession session;

	@Override
	public List<BigDecimal> getPurchaseData() {
		List<BigDecimal> PerChaseData = null;
		
		LocalDate date = LocalDate.now();
        int year = date.getYear();
        
		
		try {
			PerChaseData = session.selectList("com.WiseForce.AssemERP.sh.PerformenceMapper.shYearsPurchasePerformence",year);
			System.out.println("PerformenceDaoImpl getPurchaseData PerChaseData => "+PerChaseData);
		} catch (Exception e) {
			System.out.println("PerformenceDaoImpl getPerchaseData Exception => "+e.getMessage());
		}
		
		return PerChaseData;
	}
}
