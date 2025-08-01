package com.WiseForce.AssemERP.dao.dg;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.WiseForce.AssemERP.dto.dg.Real_InventoryDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InventoryDaoImpl implements InventoryDao {
	private final SqlSession session;

	// 이번 월 기말재고의 종류 수 조회
	@Override
	public int getLastestMonthInventoryCnt(Real_InventoryDTO real_InventoryDTO) {
		// 현재 재고 전체 조회 함수 실행
		int totalTypeCount = session
				.selectOne("com.WiseForce.AssemERP.dg.InventoryMapper.callCalcRealInventoryCnt", real_InventoryDTO);
		
		return totalTypeCount;
	}
	
	// 현재 재고 전체 조회 함수 실행
	@Override
	public List<Real_InventoryDTO> getRealInventory(Real_InventoryDTO real_InventoryDTO) {
		// 현재 재고 전체 조회 함수 실행
		List<Real_InventoryDTO> real_InventoryDTOs = session
				.selectList("com.WiseForce.AssemERP.dg.InventoryMapper.callCalcRealInventory", real_InventoryDTO);

		return real_InventoryDTOs;
	}

	// 월마감 패키지 실행
	@Override
	public void doMonthClose(String yearMonth, int empno) {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("yearMonth", yearMonth);
		paramMap.put("empno", empno);

//		session.selectOne("com.WiseForce.AssemERP.mapper.dg.InventoryMapper.callMonthClose", paramMap);
	}


}
