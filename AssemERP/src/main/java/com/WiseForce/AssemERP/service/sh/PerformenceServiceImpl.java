package com.WiseForce.AssemERP.service.sh;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import com.WiseForce.AssemERP.dao.sh.PerformenceDao;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class PerformenceServiceImpl implements PerformenceService {

	private final PerformenceDao performenceDao;

	@Override
	public List<BigDecimal> getPurchaseData() {
		
		return performenceDao.getPurchaseData();
	}
	
	
}
